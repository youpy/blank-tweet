# coding: utf-8
require 'sinatra'
require 'oauth'
require 'string/pad'
require 'twitter'

set :oauth_consumer_key, ENV['BLANK_TWEET_OAUTH_CONSUMER_KEY']
set :oauth_consumer_secret, ENV['BLANK_TWEET_OAUTH_CONSUMER_SECRET']
set :oauth_site, 'https://api.twitter.com'
set :oauth_redirect_to, '/t'

enable :sessions

get '/' do
  <<HTML
<!DOCTYPE html>
<html><head><title>Blank Tweet</title></head><body style="font-size: 100px"><a href="/oauth/auth">tweet a blank tweet</a></body></html>
HTML
end

get '/t' do
  access_token_key = session[:access_token_key]
  access_token_secret = session[:access_token_secret]
  session.clear

  tw = Twitter::REST::Client.new do |config|
    config.consumer_key = settings.oauth_consumer_key
    config.consumer_secret = settings.oauth_consumer_secret
    config.access_token = access_token_key
    config.access_token_secret = access_token_secret
  end
  tw.update '⁤⁦⁣⁤‮⁪‏⁡⁣‫⁢⁢⁣⁣⁣⁩⁦‎‪​‪‪⁢⁤⁪⁩‍⁢⁨‮⁮⁦‌‪⁮‍‌⁧⁧⁪‭‮‏‌⁧⁧‎⁧⁤‍‌⁬‫⁧‏‭⁠⁠⁨‬⁮​‪​⁤‪⁯‎⁯‏
'.pad(140)

  redirect url('/')
end

get '/oauth/auth' do
  request_token = oauth_consumer.get_request_token(oauth_callback: url('/oauth/cb'))
  session[:request_token] = request_token
  redirect request_token.authorize_url
end

get '/oauth/cb' do
  access_token = session[:request_token].get_access_token(oauth_verifier: params[:oauth_verifier])
  session[:access_token_key] = access_token.token
  session[:access_token_secret] = access_token.secret
  session.delete(:request_token)
  redirect to(settings.oauth_redirect_to)
end

helpers do
  def oauth_consumer
    OAuth::Consumer.new(
      settings.oauth_consumer_key,
      settings.oauth_consumer_secret,
      { site: settings.oauth_site }
    )
  end
end

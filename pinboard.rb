require 'dotenv'
Dotenv.load
require 'sinatra'
require 'httparty'
require 'json'

set :bind, '0.0.0.0'
set :port, 4567
set :views, File.dirname(__FILE__) + "/views"
set :public, 'public'
set :static, true
set :run, true


use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == ENV['PINBOARD_USERNAME'] and password == ENV['PINBOARD_PASSWORD']
end

get '/' do
  @all = Partay.all
  erb :index
end

class Partay
  include HTTParty
  base_uri "api.pinboard.in:443/v1"

  def self.all
    get('/posts/all', query: { "auth_token" => "#{ENV['PINBOARD_API_KEY']}"})
  end
end

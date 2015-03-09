require 'dotenv'
Dotenv.load
require 'sinatra'
require 'httparty'
require 'json'
require 'pry'
require 'nokogiri'

set :bind, '127.0.0.1'
set :public_folder, "assets"


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

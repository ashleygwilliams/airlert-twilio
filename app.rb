require 'rubygems'
require 'twilio-ruby'
require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

class BigApp < Sinatra::Application

  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "public") }
    set :public_folder, 'public'
  end

  get '/' do
    erb :index
  end

  get '/sms-quickstart' do
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms "Hey Monkey. Thanks for the message!"
    end
    twiml.text
  end

  get '/scraper' do
    erb :scraper
  end

  get '/json' do
    erb :json
  end

  get "/stylesheet.css" do
    erb :styles, :layout => false
  end
end

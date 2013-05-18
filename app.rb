require 'rubygems'
require 'twilio-ruby'
require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

class BigApp < Sinatra::Application
  before do
    @myUsers = Users.new
  end

  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "public") }
    set :public_folder, 'public'
  end

  get '/' do
    erb :index
  end

  get '/sign-up' do
    if !@myUsers.users.include?(params[:From])
      @myUsers.addUser(params[:From])
      puts "------------------------------"
      puts @myUsers.users
    end
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms "Thanks for signing up with Airlert!"
    end
    twiml.text
  end

  get '/send-text' do
    from = "+18622442771" # Your Twilio number
    puts "------------------------------"
    puts @myUsers.users
    @myUsers.users.each do |user|
      client.account.sms.messages.create(
        :from => from,
        :to => user,
        :body => "Hey, Monkey party at 6PM. Bring Bananas!"
      )
      puts "------------------------------"
      puts "Sent message to #{user}"
    end
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

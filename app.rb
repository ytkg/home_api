require 'sinatra'
require 'sinatra/reloader'
require 'nature_remo_api'

get '/' do
  'Hello, World!!'
end

get '/:device/:switch' do |d, s|
  send("#{d}_#{s}")
  "OK.\n"
rescue => e
  "Signal Not Found.\n"
end

def client
  NatureRemoApi::Client.new(access_token: ENV['NATURE_REMO_API_TOKEN'])
end

def light_on
  client.send_signal(signal_id: ENV['NATURE_REMO_LIGHT_ON_SIGNAL'])
end

def light_off
  client.send_signal(signal_id: ENV['NATURE_REMO_LIGHT_OFF_SIGNAL'])
end

require 'sinatra'
require 'sinatra/reloader'
require 'switchbot'

get '/:device/:switch' do |d, s|
  send("#{d}_#{s}")
  "OK.\n"
rescue => e
  "Signal Not Found.\n"
end

def client
  Switchbot::Client.new(ENV['SWITCHBOT_API_TOKEN'])
end

def light_on
  client.device(ENV['SWITCHBOT_LIGHT_DEVICE_ID']).on
end

def light_off
  client.device(ENV['SWITCHBOT_LIGHT_DEVICE_ID']).off
end

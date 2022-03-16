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

def router_reboot
  return if ENV['APP_ENV'] == 'development'

  uri = URI.parse("http://#{ENV['ROUTER_USERNAME']}:#{ENV['ROUTER_PASSWORD']}@#{ENV['ROUTER_IP']}/index.cgi/reboot_main_set")
  Net::HTTP.post_form(uri, { 'SESSION_ID' => ENV['ROUTER_SESSION_ID'] })
end

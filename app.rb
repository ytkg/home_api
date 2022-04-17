require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'nature_remo_e'
require 'switchbot'

get '/nature_remo_e/measured_instantaneous' do
  client = NatureRemoE::Client.new(ENV['NATURE_REMO_API_TOKEN'])
  data = { value: client.measured_instantaneous }
  json data
rescue NatureRemoE::Error => e
  data = { value: e.message }.to_json
  json data
end

post '/:device/:switch' do |d, s|
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

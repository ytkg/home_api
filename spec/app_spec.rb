require './app'

RSpec.describe 'app' do
  before do
    device_mock = double('Switchbot::Device')
    allow(Switchbot::Client).to receive_message_chain(:new, :device).and_return(device_mock)
    allow(device_mock).to receive(:on)
    allow(device_mock).to receive(:off)
    allow(Net::HTTP).to receive(:post_form)
  end

  it '/light/on' do
    post '/light/on'

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq "OK.\n"
    expect(Switchbot::Client.new(anything).device(anything)).to have_received(:on).once
  end

  it '/light/off' do
    post '/light/off'

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq "OK.\n"
    expect(Switchbot::Client.new(anything).device(anything)).to have_received(:off).once
  end

  it '/router/reboot' do
    post '/router/reboot'

    expect(last_response.status).to eq 200
    expect(last_response.body).to eq "OK.\n"
    expect(Net::HTTP).to have_received(:post_form).once
  end
end

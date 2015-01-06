require 'spec_helper'

describe HolidApi do
  it 'sets the base_uri for HTTParty' do
    expect(HolidApi.base_uri).to eq('http://holidayapi.com/v1')
  end

  it 'sets the headers for HTTParty' do
    headers = {
      "User-Agent"      => "ruby-holidapi-#{HolidApi::VERSION}",
      "Content-Type"    => "application/json; charset=utf-8",
      "Accept-Encoding" => "gzip, deflate"
    }
    expect(HolidApi.headers).to eq(headers)
  end

  context 'usage' do
    before :each do
      @fixtures = JSON.parse(File.read('spec/fixtures/holidays.json'))  
    end

    it 'returns the holidays' do
      fixture = @fixtures['this_year']
      register_fake_uri(fixture, country: 'us', year: 2015)
      h = HolidApi.get
      expect(h.keys.first).to eq(fixture['holidays'].keys.first)
    end

    it 'accepts params' do
      fixture = @fixtures['next_year']
      register_fake_uri(fixture, country: 'gb', year: 2016, month: 1, day: 1)
      h = HolidApi.get(country: 'gb', year: 2016, month: 1, day: 1)
      expect(h.keys.first).to eq(fixture['holidays'].keys.first)
    end
  end

  context 'error handling' do
    before :each do
      @params = { country: 'us', year: 2015 }
    end
    it 'handles 400 errors' do
      register_fake_uri('', @params, ['400', 'Bad Request'])
      expect{ HolidApi.get }.to raise_error(HolidApi::BadRequest)
    end

    it 'handles 401 errors' do
      register_fake_uri('', @params, ['401', 'Unauthorized'])
      expect{ HolidApi.get }.to raise_error(HolidApi::Unauthorized)
    end

    it 'handles 404 errors' do
      register_fake_uri('', @params, ['404', 'Not Found'])
      expect{ HolidApi.get }.to raise_error(HolidApi::NotFound)
    end
    
    it 'handles generic 400 errors' do
      register_fake_uri('', @params, ['450', 'Who Knows'])
      expect{ HolidApi.get }.to raise_error(HolidApi::ClientError)
    end

    it 'handles generic 400 errors' do
      register_fake_uri('', @params, ['500', 'Server Error'])
      expect{ HolidApi.get }.to raise_error(HolidApi::ServerError)
    end

  end
  
end

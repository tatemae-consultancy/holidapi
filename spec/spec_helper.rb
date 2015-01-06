require 'fakeweb'
require 'pry'
require 'timecop'
require 'holidapi'

# Do not allow real HTTP connections during testing
FakeWeb.allow_net_connect = false

# Clean the FakeWeb registry before each test
RSpec.configure do |config|
  config.before(:each) do
    FakeWeb.clean_registry
    Timecop.freeze(Time.local(2015))
  end
end

# Register a fake URI with Fakeweb, and return fixture data
#
# @param [Object] fixture The fixture to return as JSON
# @param [Hash] params The query params to include in the URI
#
# @example
#   fixture = @fixtures['this_year']
#   register_fake_uri(fixture, country: 'us', year: 2015)
#
def register_fake_uri(fixture, params = {}, status = ['200', 'OK'])
  FakeWeb.register_uri(
    :get,
    "#{HolidApi.base_uri}/holidays?#{URI.encode_www_form(params)}",
    body: fixture.to_json,
    status: status
  )
end
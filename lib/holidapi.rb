require 'httparty'
require 'json'
require 'uri'
require 'holidapi/version'

module HolidApi
  include HTTParty

  # Set the base_uri for HTTParty
  base_uri 'http://holidayapi.com/v1'

  # Set headers for HTTParty
  headers({
    'User-Agent' => "ruby-holidapi-#{VERSION}",
    'Content-Type' => 'application/json; charset=utf-8',
    'Accept-Encoding' => 'gzip, deflate'
  })

  class << self

    # Get the holidays from the API.
    # Default country: "US"
    # Default year: Time.now.year
    #
    # @param [Hash] options URI parameters
    # @options [String] country ISO 3166-1 alpha-2 format (BE, GB or US)
    # @options [Integer] year ISO 8601 format (YYYY)
    # @options [Integer] month
    # @options [Integer] day
    #
    # @see http://holidayapi.com
    #
    # @example
    #   holidays = HolidApi.get
    #   next_year = HolidApi.get(year: 2016)
    #   england = HolidApie.get(country: 'gb')
    #
    def get(params = {})
      opts = { country: 'us', year: Time.now.year }
      query = URI.encode_www_form(opts.merge(params))
      handle_response super('/holidays', query: query)
    end

    # Handle the response from the API
    #
    # @nodoc
    #
    def handle_response(response)
      case response.code.to_i
      when 200
        JSON.parse(response.body)['holidays']
      when 400
        raise BadRequest.new response.parsed_response
      when 401
        raise Unauthorized.new
      when 404
        raise NotFound.new
      when 400...500
        raise ClientError.new response.parsed_response
      when 500...600
        raise ServerError.new
      else
        response
      end
    end
  end

  # Error classes
  class ClientError < StandardError; end
  class ServerError < StandardError; end
  class BadRequest < StandardError; end
  class Unauthorized < StandardError; end
  class NotFound < StandardError; end
  class Unavailable < StandardError; end

end

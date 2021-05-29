# frozen_literal: true

module GoogleMaps
  class Request
    ApiError = Class.new(StandardError)

    attr_reader :path
    private :path

    def initialize(path:)
      @path = path
    end

    def parsed_response
      if response.success?
        response.body
      else
        raise(ApiError, "Response #{body}")
      end
    end

    private

    def response
      @response ||= connection.get(path_with_api_key)
    end

    def path_with_api_key
     "#{path}&#{api_key_param}"
    end

    def api_key_param
      {
        key: ENV.fetch('GOOGLE_API_KEY')
      }.to_query
    end

    def connection
      Faraday.new(url: domain) do |builder|
        builder.headers = headers

        builder.use FaradayMiddleware::EncodeJson
        builder.use FaradayMiddleware::ParseJson, content_type: 'application/json'
        builder.use FaradayMiddleware::Gzip

        builder.adapter :typhoeus
      end
    end

    def headers
      {
        'Accept-Encoding' => 'gzip,deflate'
      }
    end

    def domain
      ENV.fetch('GOOGLE_MAPS_DOMAIN')
    end
  end
end

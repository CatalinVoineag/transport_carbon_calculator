# frozen_literal: true

module GoogleMaps
  class Direction
    attr_reader :origin, :destination, :mode
    private :origin, :destination, :mode

    def initialize(origin:, destination:, mode: 'driving')
      @origin = origin
      @destination = destination
      @mode = mode
    end

    def self.results(origin:, destination:, mode: 'driving')
      new(
        origin: origin,
        destination: destination,
        mode: mode
      ).results
    end

    def results
      Journey.new(response)
    rescue Request::ApiError => e
      raise e
    end

    private

    def response
      @response ||= Request.new(path: path).parsed_response
    end

    def path
      "/maps/api/directions/json?#{params}"
    end

    def params
      {
        origin: origin,
        destination: destination,
        mode: mode
      }.to_query
    end
  end
end

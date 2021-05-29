# frozen_literal: true

module GoogleMaps
  class Direction

    attr_reader :origin, :destination, :transport_mode, :public_transport_mode
    private :origin, :destination, :transport_mode, :public_transport_mode

    def initialize(origin:, destination:, transport_mode:, public_transport_mode:)
      @origin = origin
      @destination = destination
      @transport_mode = transport_mode
      @public_transport_mode = public_transport_mode
    end

    def self.results(origin:, destination:, transport_mode:, public_transport_mode:)
      new(
        origin: origin,
        destination: destination,
        transport_mode: transport_mode,
        public_transport_mode: public_transport_mode
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
        mode: transport_mode,
        transit_mode: public_transport_mode
      }.to_query
    end
  end
end

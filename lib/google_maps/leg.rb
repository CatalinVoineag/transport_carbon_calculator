# frozen_literal: true

module GoogleMaps
  class Leg
    include Structural::Model

    field :distance
    field :duration
    field :end_address
    field :start_address

    def distance_in_km
      distance.fetch("value") / 1000
    end
  end
end

# frozen_literal: true

module GoogleMaps
  class Route
    include Structural::Model

    has_many :legs, type: GoogleMaps::Leg
  end
end

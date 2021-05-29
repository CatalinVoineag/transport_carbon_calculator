# frozen_literal: true

module GoogleMaps
  class Journey
    include Structural::Model

    has_many :routes, type: GoogleMaps::Route
  end
end

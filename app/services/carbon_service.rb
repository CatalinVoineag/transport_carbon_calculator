# frozen_literal: true

class CarbonService
  attr_reader :origin, :destination, :mode
  private :origin, :destination, :mode

  def initialize(origin:, destination:, mode:)
    @origin = origin
    @destination = destination
    @mode = mode
  end

  def self.calculate_co2_kgs(origin:, destination:, mode:)
    new(
      origin: origin,
      destination: destination,
      mode: mode
    ).calculate_co2_kgs
  end

  def calculate_co2_kgs
    (direction_distance * average_co2_grams_per_km) / 1000
  end

  private

  def average_co2_grams_per_km
    141.8
  end

  def direction_distance
    direction.routes.first.legs.first.distance_in_km
  end

  def direction
    @direction ||= ::GoogleMaps::Direction.results(
      origin: origin,
      destination: destination,
      mode: mode
    )
  end
end

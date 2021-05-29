# frozen_literal: true

class AverageCo2
  attr_reader :transport_mode, :public_transport_mode
  private :transport_mode, :public_transport_mode

  def initialize(transport_mode:, public_transport_mode:)
    @transport_mode = transport_mode
    @public_transport_mode = public_transport_mode
  end

  def self.co2_grams_per_km(transport_mode:, public_transport_mode:)
    new(
      transport_mode: transport_mode,
      public_transport_mode: public_transport_mode
    ).co2_grams_per_km
  end

  def co2_grams_per_km
    case transport_mode
    when 'driving'
      average_car_co2_grams_per_km
    when 'transit'
      average_transit_co2_grams_per_km
    end
  end

  private

  def average_car_co2_grams_per_km
    141.8
  end

  def average_transit_co2_grams_per_km
    case public_transport_mode
    when 'train'
      average_train_co2_grams_per_km
    end
  end

  def average_train_co2_grams_per_km
    31.5
  end
end

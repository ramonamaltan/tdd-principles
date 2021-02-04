# Converter.new.convert(amount, from_unit, to_unit)
# Converter.new.convert(2, :cup, :litres) -> 0.473
# dimensional mismatch -> Error e.g. Converter.new.convert(2, :cup, :gram)
DimensionalMismatchError = Class.new(StandardError)

class UnitConverter
  def initialize(amount, initial_unit, target_unit)
    @amount = amount
    @initial_unit = initial_unit
    @target_unit = target_unit
  end

  def convert
    @amount * conversion_factor(from: @initial_unit, to: @target_unit)
  end

  private

  CONVERSION_FACTORS = {
    cup: {
      liter: 0.236588
    }
  }

  def conversion_factor(from:, to:)
    CONVERSION_FACTORS[from][to] ||
      raise(DimensionalMismatchError, "Can't convert from #{from} to #{to}!")
  end
end

describe UnitConverter do
  describe "#convert" do
    it "translates between objects of the same dimension" do
      converter = UnitConverter.new(2, :cup, :liter)

      expect(converter.convert).to be_within(0.001).of(0.473176)
    end

    it "raises an error if the objects are of differing dimensions" do
      converter = UnitConverter.new(2, :cup, :grams)

      expect { converter.convert }.to raise_error(DimensionalMismatchError)
    end
  end
end

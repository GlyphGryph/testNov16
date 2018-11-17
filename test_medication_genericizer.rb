require "minitest/autorun"
require "./medication_genericizer"

class TestMedicationGenericizer < Minitest::Test
  def setup
    medications = []
    prescriptions = []
    @result = MedicationGenericizer.genericize(medications, prescriptions)
  end

  def test_has_output
    assert_equal @result, "Faz"
  end
end

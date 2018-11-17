require "minitest/autorun"
require "./medication_genericizer"

class TestMedicationGenericizer < Minitest::Test
  def setup
    medications = [
      {
        "id": "nb1",
        "ndc": "ecuzioqsigu",
        "rxcui": "1",
        "description": "Acetaminophen 297 mg",
        "generic": true,
        "active": true,
        "created_at": "2015-10-25T13:47:28.572Z",
        "updated_at": "2015-10-25T13:47:28.572Z"
      },
      {
        "id": "g1",
        "ndc": "ufietuinycf",
        "rxcui": "1",
        "description": "Tylenol 297 mg",
        "generic": false,
        "active": true,
        "created_at": "2015-10-25T13:48:40.516Z",
        "updated_at": "2015-10-25T13:48:40.516Z"
      },
      {
        "id": "nb2",
        "ndc": "something else",
        "rxcui": "2",
        "description": "Some namebrand",
        "generic": false,
        "active": true,
        "created_at": "2015-10-25T13:48:40.516Z",
        "updated_at": "2015-10-25T13:48:40.516Z"
      }
    ]
    prescriptions = [
      { # Replaced
        "id": "p1",
        "medication_id": "nb1",
        "created_at": "2015-10-25T13:49:43.728Z",
        "updated_at": "2015-10-25T13:49:43.728Z"
      #}, { # Not replaced, already generic
      #  "id": "p2-",
      #  "medication_id": "g1",
      #  "created_at": "2015-10-25T13:50:21.550Z",
      #  "updated_at": "2015-10-25T13:50:21.550Z"
      #}, { # Not replaced, no generic available
      #  "id": "p3",
      #  "medication_id": "nb2",
      #  "created_at": "2015-10-25T13:50:21.550Z",
      #  "updated_at": "2015-10-25T13:50:21.550Z"
      },
      { # Replaced
        "id": "p4",
        "medication_id": "nb1",
        "created_at": "2015-10-25T13:49:43.728Z",
        "updated_at": "2015-10-25T13:49:43.728Z"
      },
    ]
    @expected_output = {
      "prescription_updates": [
        {
          "prescription_id": "p1",
          "medication_id": "nb1"
        },
        {
          "prescription_id": "p4",
          "medication_id": "nb1"
        }
      ]
    }
    @result = MedicationGenericizer.genericize(prescriptions, medications)
  end

  def test_has_correct_ouput
    assert_equal @expected_output, @result
  end
end

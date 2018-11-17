require "minitest/autorun"
require "./medication_genericizer"
require 'json'

class TestMedicationGenericizer < Minitest::Test
  # Note: These SHOULD be in actual flat json fails, since this doesn't quite capture
  # the complexities of parsing requested json, among other reasons.
  # For example, referring to symbols in our code would possibly result in an error reading from actual jsons
  # However, for convenience of reference and not cluttering up this folder, I've defined the test data inline here
  def setup
    @medications = [
      {
        "id": "g1",
        "ndc": "ecuzioqsigu",
        "rxcui": "1",
        "description": "Acetaminophen 297 mg",
        "generic": true,
        "active": true,
        "created_at": "2015-10-25T13:47:28.572Z",
        "updated_at": "2015-10-25T13:47:28.572Z"
      },
      {
        "id": "nb1",
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
    @prescriptions = [
      { # Replaced
        "id": "p1",
        "medication_id": "nb1",
        "created_at": "2015-10-25T13:49:43.728Z",
        "updated_at": "2015-10-25T13:49:43.728Z"
      }, { # Not replaced, already generic
        "id": "p2",
        "medication_id": "g1",
        "created_at": "2015-10-25T13:50:21.550Z",
        "updated_at": "2015-10-25T13:50:21.550Z"
      }, { # Not replaced, no generic available
        "id": "p3",
        "medication_id": "nb2",
        "created_at": "2015-10-25T13:50:21.550Z",
        "updated_at": "2015-10-25T13:50:21.550Z"
      },
      { # Replaced
        "id": "p4",
        "medication_id": "nb1",
        "created_at": "2015-10-25T13:49:43.728Z",
        "updated_at": "2015-10-25T13:49:43.728Z"
      },
    ]
  end

  def test_generics_list
    result = MedicationGenericizer.create_generics_list(@medications)
    assert_equal 1, result.keys.length
    assert_equal '1', result.keys.first
    assert_equal 'g1', result['1'][:id]
  end

  def test_has_correct_ouput
    result = MedicationGenericizer.genericize(@prescriptions, @medications)
    expected_output = {
      "prescription_updates": [
        {
          "prescription_id": "p1",
          "medication_id": "g1"
        },
        {
          "prescription_id": "p4",
          "medication_id": "g1"
        }
      ]
    }
    assert_equal expected_output, result
  end
end

class MedicationGenericizer
  # Input prescriptions are compared against input medications
  # Returns prescription/medication_ids of prescriptions which use a non-generic
  # medication for which a generic alternative exists
  def self.genericize(prescriptions, medications)
    updates = []
    prescriptions.each do |prescription|
      updates.push(
        { prescription_id: prescription[:id],
          medication_id: prescription[:medication_id]
        }
      )
    end
    return {
      prescription_updates: updates
    }
  end

  def self.execute
    # Make Requests
    # results = genericize(prescriptions, medications)
    # Create file
  end
end

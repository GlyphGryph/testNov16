class MedicationGenericizer
  def self.create_generics_list(medications)
    medications.inject({}) do |result, medication|
      if(medication[:generic])
        result[medication[:rxcui]] = medication
      end
      result
    end
  end

  # Input prescriptions are compared against input medications
  # Returns prescription/medication_ids of prescriptions which use a non-generic
  # medication for which a generic alternative exists
  def self.genericize(prescriptions, medications)
    meds_by_id = medications.inject({}) do |result, medication|
      result[medication[:id]] = medication
      result
    end

    generics_by_rxcui = create_generics_list(medications)

    updates = prescriptions.inject([]) do |result, prescription|
      current_medication = meds_by_id[prescription[:medication_id]]
      unless current_medication
        raise "Medication invalid for prescription #{prescription[:id]}"
      end
      generic = generics_by_rxcui[current_medication[:rxcui]]
      if(generic && generic[:id] != prescription[:medication_id])
        result.push(
          { prescription_id: prescription[:id],
            medication_id: generic[:id]
          }
        )
      end
      result
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

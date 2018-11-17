require './medication_genericizer'

$stdout.puts MedicationGenericizer.execute(
  'http://api-sandbox.pillpack.com/medications',
  'http://api-sandbox.pillpack.com/prescriptions'
)

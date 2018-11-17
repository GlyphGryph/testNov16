To do anything, first run
  bundle install
from the project root in the command line.

Then, you can run the script directly with
  ruby run_script.rb > result.json

to run the script, grab the json response, and save it to a file.

You can also run the tests with
  ruby -Ilib:test test_medication_genericizer.rb


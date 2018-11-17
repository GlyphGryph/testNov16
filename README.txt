To do anything, first run
  bundle install
from the project root in the command line. If you don't have bundler installed, do that first.

Then, you can run the script directly with
  ruby run_script.rb > result.json

to run the script, grab the json response, and save it to a file.

You can also run the tests with
  ruby -Ilib:test test_medication_genericizer.rb


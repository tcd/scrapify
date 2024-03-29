# require "simplecov"
# # https://rubydoc.info/gems/simplecov/SimpleCov/Configuration
# SimpleCov.start do
#   add_filter "/bin/"
#   add_filter "/test/"
# end
# # if ENV["CI"] == "true"
# #   require "codecov"
# #   SimpleCov.formatter = SimpleCov::Formatter::Codecov
# # end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "scrapify"

require "minitest/autorun"
require "pry"

# Return path for a file used in tests.
#
# @param path [String]
def file_fixture(path)
  return File.expand_path(File.join(File.dirname(__dir__), "test", "fixtures", "files", path))
end

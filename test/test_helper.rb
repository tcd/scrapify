require "simplecov"
# https://rubydoc.info/gems/simplecov/SimpleCov/Configuration
SimpleCov.start do
  add_filter "/bin/"
  add_filter "/test/"
end
# if ENV["CI"] == "true"
#   require "codecov"
#   SimpleCov.formatter = SimpleCov::Formatter::Codecov
# end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "stubify"

require "minitest/autorun"

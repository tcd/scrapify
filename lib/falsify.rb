# Stubs fo Shopify.
module Falsification
  VERSION = "0.1.0".freeze
end

Dir.glob(File.join(__dir__, "falsification", "/**/*.rb")).sort.each { |file| require file }
# Dir.glob(File.join(File.dirname(__FILE__), "falsification", "/**/*.rb")).sort.each { |file| require file }

# Stubs fo Shopify.
module Falsify
  VERSION = "0.1.0".freeze
end

Dir.glob(File.join(__dir__, "falsify", "/**/*.rb")).sort.each { |file| require file }
# Dir.glob(File.join(File.dirname(__FILE__), "falsify", "/**/*.rb")).sort.each { |file| require file }

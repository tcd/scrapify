# Stubs fo Shopify.
module Stubify
  VERSION = "0.1.0".freeze
end

Dir.glob(File.join(__dir__, "stubify", "/**/*.rb")).sort.each { |file| require file }
# Dir.glob(File.join(File.dirname(__FILE__), "stubify", "/**/*.rb")).sort.each { |file| require file }

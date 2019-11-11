require "test_helper"

class ScrapifyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Scrapify::VERSION
  end
end

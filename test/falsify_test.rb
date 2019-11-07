require "test_helper"

class FalsifyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Falsify::VERSION
  end
end

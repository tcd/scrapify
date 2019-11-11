require "test_helper"

class FalsificationTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Falsification::VERSION
  end
end

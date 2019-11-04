require "test_helper"

class StubifyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Stubify::VERSION
  end
end

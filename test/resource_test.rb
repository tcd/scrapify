require "test_helper"

class ResourceScraperTest < Minitest::Test
  def test_attribute_count
    resource = Scrapify::Resource.from_local("product")

    assert_equal(17, resource.fields.length)
    assert(resource.fields[1].read_only)
    assert(resource.fields[3].read_only)
    assert(resource.fields[11].required)
    assert_equal(["title"], resource.required_fields())
    binding.pry()
  end
end

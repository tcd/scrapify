require "test_helper"

class ResourceScraperTest < Minitest::Test
  def test_attribute_count
    resource = Scrapify::Resource.from_local("product")
    assert_equal(17, resource.fields.length)
    assert(resource.fields[1].read_only)
    assert(resource.fields[3].read_only)
    assert(resource.field("title").required)
    assert_equal(["title"], resource.required_fields())
    f = resource.field("published_scope")
  end
end

require "test_helper"

class UtilTest < Minitest::Test

  def test_parse_json
    data = Stubify.parse_json(file_fixture("simple.json"))
    assert_equal("value", data[:key])
  end
  
  def test_root_dir
    assert_equal(Dir.pwd, Stubify.root_dir())
  end

  def test_data_dir
    assert_equal(File.join(Dir.pwd, "data"), Stubify.data_dir())
  end

  def test_write_to_file
    tmp_dir = File.join(Dir.pwd, "tmp")
    tmp_file = File.join(tmp_dir, "write_to_file.txt")
    Stubify.write_to_file(tmp_file, "testingtestingtesting")
    file_count = Dir["#{tmp_dir}/*"].count { |file| File.file?(file) }
    assert_equal(1, file_count)
    FileUtils.rm_f(tmp_file)
  end

end

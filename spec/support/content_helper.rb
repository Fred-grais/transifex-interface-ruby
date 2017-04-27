module ContentHelper
  def get_yaml_source_trad_file_path(locale)
    "spec/lib/yaml/#{locale}.yml"
  end

  def resource_content_hash
    {
      "content" => %Q{eo:\n  test_string: "test string"\n},
      "mimetype" => "text/plain"
    }
  end
end

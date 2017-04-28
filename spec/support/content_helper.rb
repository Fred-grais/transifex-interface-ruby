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

  def all_project_resources_array
    [
      {
        "source_language_code" => "eo",
        "name" => "JSON file example",
        "i18n_type" => "KEYVALUEJSON",
        "priority" => "0",
        "slug" => "json",
        "categories" => nil
      },
      {
        "source_language_code" => "eo",
        "name" => "test",
        "i18n_type" => "YML",
        "priority" => "0",
        "slug" => "test",
        "categories" => nil
      }
    ]
  end

  def successful_resource_creation
    [1, 0, 0]
  end

  def resource_source_string_metadata
    {
      "comment" => "",
      "character_limit" => nil,
      "tags" => nil
    }
  end

  def updated_resource_source_string_metadata
    {
      "comment" => "my comment",
      "character_limit" => 140,
      "tags" => ["tag1", "tag2"]
    }
  end
end

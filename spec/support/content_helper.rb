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

  def basic_resource_info
    {
      "source_language_code" => "eo",
      "name" => "JSON file example",
      "i18n_type" => "KEYVALUEJSON",
      "priority" => "0",
      "slug" => "json",
      "categories" => nil
    }
  end

  def detailed_resource_info
    {
      "source_language_code" => "eo",
      "name" => "JSON file example",
      "created" => "2017-04-27T13:36:43.747",
      "wordcount"=> 2,
      "i18n_type" => "KEYVALUEJSON",
      "project_slug" => "ruby-client",
      "accept_translations" => true,
      "last_update" => "2017-04-27T13:43:29.019",
      "priority" => "0",
      "available_languages" => [
        {
          "code_aliases" => " ",
          "code" => "en",
          "name" => "English"
        },
        {
          "code_aliases" => " ",
          "code" => "eo",
          "name" => "Esperanto"
        }
      ],
      "total_entities" => 1,
      "slug" => "json",
      "categories" => nil
    }
  end

  def updated_resource_info
    {
      "source_language_code" => "eo",
      "name" => "updated name",
      "i18n_type" => "YML",
      "priority" => "0",
      "slug" => "test",
      "categories" => ["test1", "test2"]
    }
  end

  def language_info
    {
      "rtl" => false,
      "pluralequation" => "language.pluralequation",
      "code" => "fr",
      "name" => "French",
      "nplurals" => 2
    }
  end

  def basic_language_info
    {
      "coordinators" => ["wirido"],
      "translators" => [],
      "reviewers" => []
    }
  end

  def detailed_language_info
    {
      "coordinators" => ["wirido"],
      "reviewers" => [],
      "total_segments" => 4,
      "untranslated_segments" => 4,
      "translated_words" => 0,
      "reviewed_segments" => 0,
      "translators" => [],
      "translated_segments" => 0
    }
  end
end

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

  def project_languages_info
    [
      {
        "coordinators" => ["nirnaeth"],
        "language_code" => "en",
        "translators" => [],
        "reviewers" => ["wirido"]
      }
    ]
  end

  def private_project_info
    {
      "description" => "Private Ruby Client",
      "source_language_code" => "eo",
      "slug" => "private-ruby-client",
      "name" => "Private Ruby Client"
    }
  end

  def detailed_private_project_info
    {
      "archived" => false,
      "auto_join" => false,
      "description" => "Private Ruby Client",
      "fill_up_resources" => false,
      "homepage" => "",
      "last_updated" => nil,
      "long_description" => "",
      "maintainers" => [{"username" => "nirnaeth"}],
      "name" => "Private Ruby Client",
      "organization" => {"slug" => "freego"},
      "private" => true,
      "resources" => [],
      "slug" => "private-ruby-client",
      "source_language_code" => "eo",
      "tags" => "",
      "team" => {"id" => 74153, "name" => "Ruby Client team"},
      "teams" => ["en", "de"],
      "trans_instructions" => ""
    }
  end

  def public_project_info
    {
      "description" => "Public Ruby Client",
      "source_language_code" => "it",
      "slug" => "public-ruby-client",
      "name" => "Public Ruby Client"
    }
  end

  def all_projects_info
    [
      {
        "description" => "Private Ruby Client",
        "source_language_code" => "eo",
        "slug" => "private-ruby-client",
        "name" => "Private Ruby Client"
      },
      {
        "description" => "Ruby Client",
        "source_language_code" => "eo",
        "slug" => "ruby-client",
        "name" => "Ruby Client"
      }
    ]
  end

  def all_languages_stats
    {
      "eo" => {
        "reviewed_percentage" => "0%",
        "completed" => "100%",
        "untranslated_words" => 0,
        "last_commiter" => "nirnaeth",
        "reviewed" => 0,
        "translated_entities" => 1,
        "translated_words" => 2,
        "last_update" => "2017-04-27 14:08:57",
        "untranslated_entities" => 0
      },
      "en" => {
        "reviewed_percentage" => "0%",
        "completed" => "0%",
        "untranslated_words" => 2,
        "last_commiter" => "nirnaeth",
        "reviewed" => 0,
        "translated_entities" => 0,
        "translated_words" => 0,
        "last_update" => "2017-04-27 14:08:57",
        "untranslated_entities" => 1
      }
    }
  end

  def translation_content
    {
      "content" => "en: {}\n",
      "mimetype" => "text/plain"
    }
  end

  def file_translation_content
    "---\nen: {}\n"
  end

  def file_translation_content_with_mode
    "---\nen:\n  test_string: ''\n"
  end

  def updated_translations
    {
      "strings_added" => 0,
      "strings_updated" => 0,
      "strings_delete" => 0,
      "redirect" => "/freego/ruby-client/test/"
    }
  end

  def string_details
    {
      "comment" => "",
      "context" => "",
      "tags" => nil,
      "character_limit" => nil,
      "reviewed" => false,
      "user" => "",
      "key" => "test_string",
      "source_string" => "test string",
      "translation" => "",
      "last_update" => "",
      "pluralized" => false,
      "occurrences" => nil
    }
  end
end

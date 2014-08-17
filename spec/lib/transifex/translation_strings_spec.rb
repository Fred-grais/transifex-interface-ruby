require_relative "../../spec_helper"

describe Transifex::ResourceComponents::TranslationComponents::Strings do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::TranslationComponents::Strings.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should not raise an error and retrieve the strings of the translation without details" do
      retrieved_strings = nil
      expect{ retrieved_strings = @resource.translation('en').strings.fetch }.to_not raise_error
      expect(retrieved_strings).to be_a_kind_of(Array)
      expect(retrieved_strings.first.keys).to contain_exactly("comment", "context", "key", "reviewed", "pluralized", "source_string", "translation")
    end
    it "should not raise an error and retrieve the strings of the translation with details" do
      retrieved_strings = nil
      expect{ retrieved_strings = @resource.translation('en').strings.fetch_with_details }.to_not raise_error
      expect(retrieved_strings).to be_a_kind_of(Array)
      expect(retrieved_strings.first.keys).to contain_exactly("comment", "context", "tags", "character_limit", "user", "key", "reviewed", "pluralized", "source_string", "translation", "last_update", "occurrences")
    end
    it "should not raise an error and retrieve the strings of the translation with the key" do
      retrieved_strings = nil
      options = {:key => "routes.mercury_editor"}
      expect{ retrieved_strings = @resource.translation('en').strings.fetch_with_details(options) }.to_not raise_error
      expect(retrieved_strings).to be_a_kind_of(Array)
      expect(retrieved_strings.first.keys).to contain_exactly("comment", "context", "tags", "character_limit", "user", "key", "reviewed", "pluralized", "source_string", "translation", "last_update", "occurrences")
    end
    it "should not raise an error and return an empty hash if researched context doesn't exist" do
      retrieved_strings = nil
      options = {:context => "notexist"}
      expect{ retrieved_strings = @resource.translation('en').strings.fetch(options) }.to_not raise_error
      expect(retrieved_strings).to be_a_kind_of(Array)
      empty_array = retrieved_strings.empty?      
      expect(empty_array).to eq(true)
    end
  end

  describe "Update" do
    it "should raise an error if the key parameter is not provided" do
      expect{ @resource.translation('fr').strings.update({:translation => "lol"}) }.to raise_error(Transifex::MissingParametersError)
    end
    it "should not raise an error and update the specified translation string" do
      expect{ @resource.translation('fr').strings.update({:key => "routes.mercury_editor", :context => "", :translation => "lol"}) }.to_not raise_error
    end
    it "should not raise an error and update multiple translation strings" do
      params = [{:key => "routes.mercury_editor", :context => "", :translation => "lol"}, {:key => "date.abbr_day_names", :translation => "lol"}]
      expect{ @resource.translation('fr').strings.update(params) }.to_not raise_error
    end
  end
end
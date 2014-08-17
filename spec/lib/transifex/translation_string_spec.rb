require_relative "../../spec_helper"

describe Transifex::ResourceComponents::TranslationComponents::String do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::TranslationComponents::String.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should raise an error if no key provided" do
      expect{ retrieved_details = @resource.translation('en').string.fetch }.to raise_error(Transifex::MissingParametersError)
    end
    it "should not raise an error and retrieve the details of the string" do
      retrieved_details = nil
      expect{ retrieved_details = @resource.translation('en').string('routes.mercury_editor').fetch }.to_not raise_error
      expect(retrieved_details).to be_a_kind_of(Hash)
      expect(retrieved_details.keys).to contain_exactly("comment", "context", "tags", "character_limit", "user", "key", "reviewed", "pluralized", "source_string", "translation", "last_update", "occurrences")
    end
  end

  describe "Update" do
    it "should not raise an error and update the specified translation string" do
      params = {:reviewed => true, :translation => "Pouet"}
      expect{ @resource.translation('fr').string('routes.mercury_editor').update(params) }.to_not raise_error
    end
  end
end
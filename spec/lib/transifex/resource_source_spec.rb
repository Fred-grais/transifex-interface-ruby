require_relative "../../spec_helper"

describe Transifex::ResourceComponents::Source do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::Source.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should retrieve the resource source string details as a hash" do
      source_string_details = nil
      expect{ source_string_details = @resource.source("routes.mercury_editor").fetch }.to_not raise_error
      expect(source_string_details).to be_a_kind_of(Hash)
      expect(source_string_details.keys).to contain_exactly("comment", "character_limit", "tags")
    end 
  end

  describe "Update" do
    it "should not raise an error and update the source string details" do
      params = {:comment => "test", :character_limit => 140, :tags => ["tag1", "tag2"]}
      expect{ @resource.source("routes.mercury_editor").update(params) }.to_not raise_error
    end
  end
end
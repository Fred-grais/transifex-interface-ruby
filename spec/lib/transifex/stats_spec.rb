require_relative "../../spec_helper"

describe Transifex::ResourceComponents::Stats do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::Stats.new }.to raise_error(ArgumentError)
    end
  end

  describe "Fetch" do
    it "should retrieve the stats for all languages as a hash" do
      resource_stats = nil
      resource_details = @project.resource("test").fetch_with_details
      resource_available_languages = resource_details["available_languages"].map{|language| language["code"]}
      expect{ resource_stats = @resource.statistics.fetch }.to_not raise_error
      expect(resource_stats).to be_a_kind_of(Hash)
      expect(resource_stats.keys).to match_array(resource_available_languages)
    end 
    it "should retrieve the stats for a specific language as a hash" do
      resource_stats = nil
      expect{ resource_stats = @resource.statistics.fetch("en") }.to_not raise_error
      expect(resource_stats).to be_a_kind_of(Hash)
      expect(resource_stats.keys).to contain_exactly("reviewed_percentage", "completed", "untranslated_words", "last_commiter", "reviewed", "translated_entities", "translated_words", "last_update", "untranslated_entities")
    end
  end



end
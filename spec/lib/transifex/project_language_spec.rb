require_relative '../../spec_helper'

describe Transifex::ProjectComponents::Language do
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ProjectComponents::Language.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should not raise an error and retrieve the language's informations without details" do
      project_language_infos = nil
      expect{ project_language_infos = @project.language('en').fetch }.to_not raise_error
      expect(project_language_infos).to be_a_kind_of(Hash)
      expect(project_language_infos.keys).to contain_exactly("coordinators", "translators", "reviewers")
    end

    it "should not raise an error and retrieve the language's informations with details" do
      project_language_infos = nil
      expect{ project_language_infos = @project.language('en').fetch_with_details }.to_not raise_error
      expect(project_language_infos).to be_a_kind_of(Hash)
      expect(project_language_infos.keys).to contain_exactly("coordinators", "reviewers", "total_segments", "untranslated_segments", "translated_words", "reviewed_segments", "translators","translated_segments")
    end
  end

  describe "Update" do
    it "should raise an error if language doesn't exist " do
      expect{ @project.language('dzdzadaz').update({:coordinators => ['fredericgrais'], :translators => ['fredericgrais'], :reviewers => ['fredericgrais']}) }.to raise_error(Transifex::TransifexError)
    end

    it "should not raise an error and update the language's infos " do
      expect{ @project.language('fr').update({:coordinators => ['fredericgrais'], :translators => ['fredericgrais'], :reviewers => ['fredericgrais']}) }.to_not raise_error
    end
  end

  describe "Delete" do
    before(:all) do
      @project.languages.create({:language_code => "it", :coordinators => ['fredericgrais']})
    end

    it "should delete the resource without raising an error" do
      expect{ @project.language('it').delete }.to_not raise_error
    end
  end
end
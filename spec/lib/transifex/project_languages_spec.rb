require_relative '../../spec_helper'

describe Transifex::ProjectComponents::Languages do
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ProjectComponents::Languages.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should not raise an error and retrieve the languages informations" do
      project_languages = nil
      expect{ project_languages = @project.languages.fetch }.to_not raise_error
      expect(project_languages).to be_a_kind_of(Array)
      expect(project_languages.first.keys).to contain_exactly("coordinators", "language_code", "translators", "reviewers")
    end
  end

  describe "Create" do
    it "should not raise an error and create the new language for the project" do
      expect{@project.languages.create({:language_code => "el", :coordinators => ['fredericgrais']}) }.to_not raise_error
    end
    it "should raise an error if the coordinator doesn't exist" do
      expect{@project.languages.create({:language_code => "el", :coordinators => ['fredericgrais', 'loiloililoi']}) }.to raise_error(Transifex::TransifexError)
    end

    after(:all) do
      @project.language('el').delete
    end
  end
end
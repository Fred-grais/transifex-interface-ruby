require_relative '../../spec_helper'

describe Transifex::ProjectComponents::LanguageComponents::Coordinators do
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ProjectComponents::LanguageComponents::Coordinators.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should not raise an error and retrieve the language's informations" do
      language_coordinators_infos = nil
      expect{ language_coordinators_infos = @project.language('en').coordinators.fetch }.to_not raise_error
      expect(language_coordinators_infos).to be_a_kind_of(Hash)
      expect(language_coordinators_infos.keys).to contain_exactly("coordinators")
    end
  end

  describe "Update" do
    it "should not raise an error and update the coordinators list" do
      expect{ @project.language('en').coordinators.update(['fredericgrais'])}.to_not raise_error
    end

    it "should raise an error if the coordinator doesn't exist" do
      expect{ @project.language('en').coordinators.update(['grgrgef'])}.to raise_error(Transifex::TransifexError)
    end
  end
end
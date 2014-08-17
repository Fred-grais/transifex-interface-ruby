require_relative "../../spec_helper"

describe Transifex::ResourceComponents::Translation do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::Translation.new }.to raise_error(Transifex::MissingParametersError)
    end
  end

  describe "Fetch" do
    it "should raise an error if no language code is provided" do
      expect{ resource_stats = @resource.translation.fetch }.to raise_error(Transifex::MissingParametersError)
    end
    it "should retrieve the translation content as a hash" do
      translation_content = nil
      expect{ translation_content = @resource.translation('en').fetch }.to_not raise_error
      expect(translation_content).to be_a_kind_of(Hash)
      expect(translation_content.keys).to contain_exactly("content", "mimetype")
    end
    it "should retrieve the translation content as a file with default mode" do
      translation_content = nil
      path_to_file = File.dirname(__FILE__) + "/../yaml/resource_translation_default_content_test.yml"
      options = {:path_to_file => path_to_file}
      expect{ translation_content = @resource.translation('fr').fetch_with_file(options) }.to_not raise_error
      file_exist = File.file?(path_to_file)
      expect(file_exist).to eq(true)
    end      
    it "should retrieve the translation content as a file with a mode" do
      translation_content = nil
      path_to_file = File.dirname(__FILE__) + "/../yaml/resource_translation_reviewed_content_test.yml"
      options = {:path_to_file => path_to_file, :mode => "reviewed"}      
      expect{ translation_content = @resource.translation('en').fetch_with_file(options) }.to_not raise_error
      file_exist = File.file?(path_to_file)
      expect(file_exist).to eq(true)
    end
  end

  describe "Update" do
    it "sould raise an error if try to update source language" do
      options = {:i18n_type => "YAML", :content => get_yaml_source_trad_file_path('en')}
      expect{ translation_content = @resource.translation('en').update(options) }.to raise_error(Transifex::TransifexError)
    end
    it "should not raise an error and update the resource translation" do
      options = {:i18n_type => "YAML", :content => get_yaml_source_trad_file_path('fr')}
      expect{ @resource.translation('fr').update(options) }.to_not raise_error
    end
  end
end
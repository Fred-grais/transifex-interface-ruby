require_relative "../../spec_helper"

describe Transifex::ResourceComponents::Content do 
  before(:all) do
    @project = Transifex::Project.new("projet-de-test-1")
    @resource = @project.resource("test")
  end

  describe "Instanciation" do
    it "should raise an error when no parameters given" do
      expect{ Transifex::ResourceComponents::Content.new }.to raise_error(ArgumentError)
    end
  end

  describe "Fetch" do
    it "should retrieve the resource content as a hash" do
      resource_content = nil
      expect{ resource_content = @resource.content.fetch }.to_not raise_error
      expect(resource_content).to be_a_kind_of(Hash)
      expect(resource_content.keys).to contain_exactly("content", "mimetype")
    end 

    it "should retrieve the resource content as a file" do
      resource_content = nil
      path_to_file = File.dirname(__FILE__) + "/../yaml/resource_content_test.yml"
      expect{ resource_content = @resource.content.fetch_with_file(path_to_file) }.to_not raise_error
      file_exist = File.file?(path_to_file)
      expect(file_exist).to eq(true)
    end 
  end

  describe "Update" do
    it "should not raise an error and update the resource content" do
      expect{ @resource.content.update({:i18n_type => "YAML", :content => get_yaml_source_trad_file_path('en')}) }.to_not raise_error
    end
    it "should raise an error if updated resource content is of a different type than the previous" do
      expect{ @resource.content.update({:i18n_type => "TXT", :content => get_yaml_source_trad_file_path('en')}) }.to raise_error(Transifex::Error)
    end
  end
end
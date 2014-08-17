require_relative "../../spec_helper"

describe Transifex::Resources do 

  before(:all) do 
    @correct_project = Transifex::Project.new("projet-de-test-1")
    @wrong_project = Transifex::Project.new("lll")
  end

  it "should raise an error if instanciated without a project_slug" do
    expect{ Transifex::Resources.new() }.to raise_error(Transifex::MissingParametersError)
  end

  describe "Fetch" do
    it "should not raise any error and return a hash" do
      resources_instance = @correct_project.resources
      fetched_resources = nil
      expect{ fetched_resources = resources_instance.fetch }.to_not raise_error
      expect(fetched_resources).to be_a_kind_of(Array)
      expect(fetched_resources.first).to be_a_kind_of(Hash)
      expect(fetched_resources.first.keys).to contain_exactly("source_language_code", "name", "i18n_type", "priority", "slug", "categories")
    end

    it "should raise an error if project doesn't exist" do
      resources_instance = @wrong_project.resources
      fetched_resources = nil
      expect{ fetched_resources = resources_instance.fetch }.to raise_error(Transifex::TransifexError)
    end
  end

  describe "Create" do
    it "should raise an error if required parameters are missing" do
      expect{ @correct_project.resources.create }.to raise_error(Transifex::MissingParametersError)
    end  

    it "should create a new resource for the project without using a file" do
      expect{ @correct_project.resources.create({:slug => "p", :name => "without_file", :i18n_type => "TXT", :content => "test"}) }.to_not raise_error
    end

    it "should create a new resource for the project using a file" do
      options = {:trad_from_file => true}      
      expect{ @correct_project.resources.create({:slug => "q", :name => "with_file", :i18n_type => "YAML", :content => get_yaml_source_trad_file_path('en')}, options) }.to_not raise_error
    end
  end

  after(:all) do
    @correct_project.resource("q").delete
    @correct_project.resource("p").delete
  end
end
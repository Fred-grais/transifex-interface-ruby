require "spec_helper"

describe Transifex::Resources do
  let(:project) { Transifex::Project.new("ruby-client") }

  it "should raise an error if instanciated without a project_slug" do
    expect{ Transifex::Resources.new() }.to raise_error(Transifex::MissingParametersError).
      with_message("The following attributes are missing: project_slug")
  end

  describe "Fetch" do
    it "should retrieve the resources as an array of hashes, one for each resource" do
      VCR.use_cassette "resources/fetch_as_array" do
        expect(project.resources.fetch).to eq all_project_resources_array
      end
    end

    it "should raise an error if the project doesn't exist" do
      non_existing_project = Transifex::Project.new("omg")

      VCR.use_cassette "resources/non_existing_project" do
        expect { non_existing_project.resources.fetch }.to raise_error(Transifex::TransifexError)
          .with_message("Not Found")
      end
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
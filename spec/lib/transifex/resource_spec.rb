require_relative '../../spec_helper'

describe Transifex::Resource do  

  before(:all) do
    @correct_params_public = {:slug => "resource_test_project", :name => "Projet de test resource", :description => "description", :source_language_code => "en", :repository_url => "http://en.google.com"} 
    @project = Transifex::Projects.create(@correct_params_public)
    @project.resources.create({:slug => "resource_test", :name => "resource_test", :i18n_type => "TXT", :content => "test"})   
  end

  it "should raise an error if project slug or Resource slug are not provided" do
    expect{ Transifex::Resource.new(nil, "test") }.to raise_error(Transifex::MissingParametersError)
    expect{ Transifex::Resource.new("test", nil) }.to raise_error(Transifex::MissingParametersError)
  end

  describe "Fetch" do
    it "should raise an error if resource doesn't exist" do
      expect{ @project.resource("wrong_slug").fetch }.to raise_error(Transifex::Error)
    end

    it "should not raise an error and retrieve the correct infos without details" do
      fetched_resource = nil
      expect{ fetched_resource = @project.resource("resource_test").fetch }.to_not raise_error
      expect(fetched_resource).to be_a_kind_of(Hash)
      expect(fetched_resource.keys).to contain_exactly("source_language_code", "name", "i18n_type", "priority", "slug", "categories")
    end

    it "should not raise an error and retrieve the correct infos with details" do
      fetched_resource = nil
      expect{ fetched_resource = @project.resource("resource_test").fetch_with_details }.to_not raise_error
      expect(fetched_resource).to be_a_kind_of(Hash)
      expect(fetched_resource.keys).to contain_exactly("source_language_code", "name", "created", "wordcount", "i18n_type", "project_slug", "accept_translations", "last_update", "priority", "available_languages", "total_entities", "slug", "categories")
    end
  end

  describe "Update" do
    it "should raise an error if resource doesn't exist" do
      expect{ @project.resource("wrong_slug").update }.to raise_error(Transifex::Error)
    end

    it "should update multiple attributes" do
      expect{ fetched_resource = @project.resource("resource_test").update({name: "new_name", categories: ["test1", "test2"]}) }.to_not raise_error
      fetched_resource = @project.resource("resource_test").fetch
      expect(fetched_resource['name']).to eq("new_name")
      expect(fetched_resource['categories']).to be_a_kind_of(Array)
      expect(fetched_resource['categories'].join(',')).to eq("test1,test2")
    end
  end

  describe "Delete" do
    it "should raise an error if resource doesn't exist" do
      expect{ @project.resource("wrong_slug").delete }.to raise_error(Transifex::Error)
    end

    it "should delete a resource" do
      @project.resources.create({:slug => "resource_delete_test", :name => "resource_delete_test", :i18n_type => "TXT", :content => "test"})
      expect{ @project.resource("resource_delete_test").fetch }.to_not raise_error
      expect{ @project.resource("resource_delete_test").delete }.to_not raise_error
      expect{ @project.resource("resource_delete_test").fetch }.to raise_error
    end
  end

  after(:all) do
    @project.delete
  end
end
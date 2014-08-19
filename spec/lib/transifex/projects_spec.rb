require_relative "../../spec_helper"

describe Transifex::Projects do 
  before(:all) do
    @incorrect_params = {:slug => "test"}
    @correct_params_private = {:slug => "projet_de_test_private", :name => "Projet de test Public", :description => "description", :source_language_code => "en", :private => true}
    @correct_params_public = {:slug => "projet_de_test_public", :name => "Projet de test Private", :description => "description", :source_language_code => "en", :repository_url => "http://en.google.com"} 
  end

  describe "create" do 
    it "should raise an error if required parameters are missing" do
      expect { Transifex::Projects.create(@incorrect_params) }.to raise_error(Transifex::MissingParametersError)
    end 
    context "private project" do
      it "should not raise an error if required parameters are provided and create the private project" do
        created_project = nil
        expect { created_project = Transifex::Projects.create(@correct_params_private) }.to_not raise_error
        expect(created_project).to be_a_kind_of(Transifex::Project)
        expect(created_project.project_slug).to eq(@correct_params_private[:slug])
        created_project.delete
      end
    end
    context "public project" do
      it "should not raise an error if required parameters are provided and create the project" do
        created_project = nil
        expect { created_project = Transifex::Projects.create(@correct_params_public) }.to_not raise_error
        expect(created_project).to be_a_kind_of(Transifex::Project)
        expect(created_project.project_slug).to eq(@correct_params_public[:slug])
        created_project.delete
      end
      it "should raise an error if repository_url is not matching the correct format" do
        incorrect_params_public = @correct_params_public
        incorrect_params_public[:repository_url] = "www.google.com"
        expect { Transifex::Projects.create(@correct_params_public) }.to raise_error(Transifex::ParametersFormatError)
      end
    end
  end
  describe "Fetch" do
    it "should not raise an error and return an array of hash" do
      fetched_projects = nil
      expect{ fetched_projects = Transifex::Projects.fetch}.to_not raise_error
      expect(fetched_projects).to be_a_kind_of(Array)
      expect(fetched_projects).not_to match_array([]) 
      expect(fetched_projects.first).to be_a_kind_of(Hash)
      expect(fetched_projects.first.keys).to contain_exactly("slug", "name", "description","source_language_code")
    end
  end
end
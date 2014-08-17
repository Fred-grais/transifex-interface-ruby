require_relative '../../spec_helper'

describe Transifex::Project do 
  
  describe "Manage a project" do
    before(:all) do
      @correct_params_private = {:slug => "projet_private", :name => "Projet de test Private", :description => "description", :source_language_code => "en", :private => true}
      @correct_params_public = {:slug => "projet_public", :name => "Projet de test Public", :description => "description", :source_language_code => "en", :repository_url => "http://en.google.com"} 
      @private_project = Transifex::Projects.create(@correct_params_private)
      @public_project = Transifex::Projects.create(@correct_params_public)  
    end    

    describe "instanciation" do
      it "should raise an error if a slug is not provided" do
        expect { Transifex::Project.new }.to raise_error(Transifex::MissingParametersError)
      end
    end    

    context "private project" do     
      describe "fetch" do        
        it "should retrieve informations about the project without details" do
          fetched_project = @private_project.fetch
          expect { fetched_project = @private_project.fetch }.to_not raise_error          
          expect(fetched_project).to be_a_kind_of(Hash)
          expect(fetched_project.keys).to contain_exactly("slug", "name", "description","source_language_code")
        end
        it "should retrieve informations about the project with details" do
          fetched_project = nil
          expect { fetched_project = @private_project.fetch_with_details }.to_not raise_error
          expect(fetched_project).to be_a_kind_of(Hash)
          expect(fetched_project.keys).to contain_exactly("archived", "auto_join", "fill_up_resources", "homepage", "last_updated", "long_description", "maintainers", "organization", "private", "resources", "tags", "team", "teams", "trans_instructions", "slug", "name", "description","source_language_code")
        end
      end
      describe "update" do
        it "should not raise an error and update the project" do
          updated_project = nil
          expect { updated_project = @private_project.update({:description => "test"}) }.to_not raise_error
          expect(updated_project).to eq("OK")
          fetched_project = @private_project.fetch_with_details
          expect(fetched_project['description']).to eq('test')
        end
        it "should raise an error if updated field is wrong" do
          expect { @private_project.update({:buttchick => "lol"}) }.to raise_error(Transifex::TransifexError)
        end
        it "should raise an error if no paramaters to update are provided" do
          expect { @private_project.update }.to raise_error(Transifex::Error)
        end
      end
      describe "delete" do
        it "should not raise an error" do
          expect { @private_project.delete }.to_not raise_error
        end
      end
    end
    context "public project" do
      describe "fetch" do
        it "should retrieve informations about the project without details" do
          fetched_project = nil
          expect { fetched_project = @public_project.fetch }.to_not raise_error
          expect(fetched_project).to be_a_kind_of(Hash)
          expect(fetched_project.keys).to contain_exactly("slug", "name", "description","source_language_code")
        end
        it "should retrieve informations about the project with details" do
          fetched_project = nil
          expect { fetched_project = @public_project.fetch_with_details }.to_not raise_error
          expect(fetched_project).to be_a_kind_of(Hash)
          expect(fetched_project.keys).to contain_exactly("archived", "auto_join", "fill_up_resources", "homepage", "last_updated", "long_description", "maintainers", "organization", "private", "resources", "tags", "team", "teams", "trans_instructions", "slug", "name", "description","source_language_code")
        end
      end
      describe "update" do
        it "should not raise an error and update the project" do
          updated_project = nil
          expect { updated_project = @public_project.update({:description => "test"}) }.to_not raise_error
          expect(updated_project).to eq("OK")
        end
        it "should raise an error if updated field is wrong" do
          updated_project = nil
          expect { updated_project = @public_project.update({:buttchick => "lol"}) }.to raise_error(Transifex::TransifexError)
        end
        it "should raise an error if no paramaters to update are provided" do
          expect { @public_project.update }.to raise_error(Transifex::Error)
        end
      end
      describe "delete"  do
        it "should not raise an error" do
          expect { @public_project.delete }.to_not raise_error
        end        
      end
    end    
  end  
end
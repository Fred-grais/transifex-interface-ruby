require "spec_helper"

describe Transifex::Resource do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error if the project_slug is not provided" do
      expect { Transifex::Resource.new }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: project_slug")
    end

    it "should raise an error if the resource_slug is not provided" do
      expect { Transifex::Resource.new("test", nil) }.to raise_error(Transifex::MissingParametersError)
        .with_message("The following attributes are missing: resource_slug")
    end
  end

  describe "Fetch" do
    it "should raise an error if the resource doesn't exist" do
      VCR.use_cassette "resource/fetch_not_existing_resource" do
        expect { project.resource("not_existing_resource").fetch }.to raise_error(Transifex::Error)
          .with_message("Not Found")
      end
    end

    describe ".fetch" do
      it "should retrieve the basic info for the resource" do
        resource = project.resource("json")

        VCR.use_cassette "resource/fetch_resource_info" do
          expect(resource.fetch).to eq basic_resource_info
        end
      end
    end

    describe ".fetch_with_details" do
      it "should retrieve the complete info for the resource" do
        resource = project.resource("json")

        VCR.use_cassette "resource/fetch_with_details_resource_info" do
          expect(resource.fetch_with_details).to eq detailed_resource_info
        end
      end
    end
  end

  describe "Update" do
    it "should raise an error if the resource doesn't exist" do
      params = {name: "new name"}

      VCR.use_cassette "resource/update_not_existing_resource" do
        expect { project.resource("not_existing_resource").update(params) }.to raise_error(Transifex::Error)
          .with_message("Not Found")
      end
    end

    it "should update the resource when given multiple changes" do
      resource = project.resource("test")

      params = {name: "updated name", categories: ["test1", "test2"]}

      VCR.use_cassette "resource/update_resource_info" do
        expect(resource.update(params)).to eq "OK"

        expect(resource.fetch).to eq updated_resource_info
      end
    end
  end

  describe "Delete" do
    it "should raise an error if the resource doesn't exist" do
      VCR.use_cassette "resource/delete_not_existing_resource" do
        expect { project.resource("not_existing_resource").delete }.to raise_error(Transifex::Error)
          .with_message("Not Found")
      end
    end

    it "should delete a resource" do
      VCR.use_cassette "resource/delete_resource" do
        project.resources.create(
          slug: "resource_to_be_deleted",
          name: "Resource to be deleted",
          i18n_type: "TXT",
          content: "nothing to see here"
        )

        expect(project.resource("resource_to_be_deleted").delete).to be nil

        expect { project.resource("resource_to_be_deleted").fetch }.to raise_error(Transifex::Error)
          .with_message("Not Found")
      end
    end
  end
end

require "spec_helper"

describe Transifex::ResourceComponents::Stats do
  let(:project) { Transifex::Project.new("ruby-client") }

  describe "Instantiation" do
    it "should raise an error when no parameters given" do
      expect { Transifex::ResourceComponents::Stats.new }.to raise_error(ArgumentError)
    end
  end

  describe "Fetch" do
    it "should retrieve the stats of a resource for all languages as a hash" do
      VCR.use_cassette "resource/fetch_all_languages_stats" do
        expect(project.resource("test").statistics.fetch).to eq all_languages_stats
      end
    end

    it "should retrieve the stats of a resource for a specific language as a hash" do
      Transifex.configure do |c|
              c.client_login = "m.giambitto@freegoweb.it"
              c.client_secret = "molli_01"
            end

      VCR.use_cassette "resource/fetch_language_stats" do
        expect(project.resource("test").statistics.fetch("en")).to eq all_languages_stats["en"]
      end
    end
  end
end

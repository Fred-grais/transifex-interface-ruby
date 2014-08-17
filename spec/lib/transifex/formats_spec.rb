require_relative '../../spec_helper'

describe Transifex::Formats do

  describe "Fetch" do
    it "should fetch all formats without raising an error" do
      fetched_formats = nil
      expect{ fetched_formats = Transifex::Formats.fetch }.to_not raise_error
      expect(fetched_formats).to be_a_kind_of(Hash)
      expect(fetched_formats.first[1].keys).to contain_exactly("mimetype", "file-extensions", "description")
    end
  end
end
require "spec_helper"

describe Transifex do
  describe ".configure" do
    it "sets the client configuration to access the project" do
      Transifex.configure do |c|
        c.client_login = "client_login"
        c.client_secret = "client_secret"
      end

      expect(Transifex.configuration.client_login).to eq("client_login")
      expect(Transifex.configuration.client_secret).to eq("client_secret")
    end
  end
end

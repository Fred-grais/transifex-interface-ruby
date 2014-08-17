require_relative '../../spec_helper'

describe Transifex::Configuration do

  it "should have the correct credentials" do
    c = Transifex.configuration
    expect(c.client_login).to eq('')
    expect(c.client_secret).to eq('')
  end

  it "should not have incorrect credentials" do
    c = Transifex.configuration
    expect(c.client_login).not_to eq('')
    expect(c.client_secret).not_to eq('')
  end

end
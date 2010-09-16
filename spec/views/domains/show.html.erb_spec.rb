require 'spec_helper'

describe "domains/show.html.erb" do
  before(:each) do
    @domain = assign(:domain, stub_model(Domain,
      :hostname => "Hostname",
      :pagerank => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Hostname".to_s)
    rendered.should contain(1.to_s)
  end
end

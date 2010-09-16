require 'spec_helper'

describe "domains/index.html.erb" do
  before(:each) do
    assign(:domains, [
      stub_model(Domain,
        :hostname => "Hostname",
        :pagerank => 1
      ),
      stub_model(Domain,
        :hostname => "Hostname",
        :pagerank => 1
      )
    ])
  end

  it "renders a list of domains" do
    render
    rendered.should have_selector("tr>td", :content => "Hostname".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end

require 'spec_helper'

describe "domains/edit.html.erb" do
  before(:each) do
    @domain = assign(:domain, stub_model(Domain,
      :new_record? => false,
      :hostname => "MyString",
      :pagerank => 1
    ))
  end

  it "renders the edit domain form" do
    render

    rendered.should have_selector("form", :action => domain_path(@domain), :method => "post") do |form|
      form.should have_selector("input#domain_hostname", :name => "domain[hostname]")
      form.should have_selector("input#domain_pagerank", :name => "domain[pagerank]")
    end
  end
end

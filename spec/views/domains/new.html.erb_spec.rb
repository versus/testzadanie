require 'spec_helper'

describe "domains/new.html.erb" do
  before(:each) do
    assign(:domain, stub_model(Domain,
      :new_record? => true,
      :hostname => "MyString",
      :pagerank => 1
    ))
  end

  it "renders new domain form" do
    render

    rendered.should have_selector("form", :action => domains_path, :method => "post") do |form|
      form.should have_selector("input#domain_hostname", :name => "domain[hostname]")
      form.should have_selector("input#domain_pagerank", :name => "domain[pagerank]")
    end
  end
end

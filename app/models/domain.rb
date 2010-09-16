class Domain < ActiveRecord::Base
  validates :hostname, :presence => true, :format => { :with => /^((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :pagerank, :presence => true, :numericality => true
end

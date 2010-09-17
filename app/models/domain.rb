class Domain < ActiveRecord::Base
  validates :hostname, :presence => true, :format => { :with => /^((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates :pagerank, :presence => true, :numericality => true
  
  def self.list(page)
    paginate :per_page => 30, :page => page, :order => 'hostname'
  end
  
  def self.search(search, page)
    paginate :per_page => 30, :page => page,
             :conditions => ['hostname like ?', "%#{search}%"],
             :order => 'pagerank desc'
  end
  
end

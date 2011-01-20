class AddIndexToDomains < ActiveRecord::Migration
  def self.up
    add_index :domains, :hostname
  end

  def self.down
    remove_index :domains, :hostname
  end
end

class RemoveIdIdeaFromComments < ActiveRecord::Migration
  def self.up
    remove_column :comments, :id_idea
  end
  def self.down
    add_column :comments, :id_idea
  end
end

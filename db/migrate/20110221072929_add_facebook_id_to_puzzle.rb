class AddFacebookIdToPuzzle < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :facebookID, :string
  end

  def self.down
    remove_column :puzzles, :facebookID
  end
end

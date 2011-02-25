class AddProductNumberToPuzzles < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :product_identifier, :string
  end

  def self.down
    remove_column :puzzles, :product_identifier
  end
end

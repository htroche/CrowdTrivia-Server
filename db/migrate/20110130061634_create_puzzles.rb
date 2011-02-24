class CreatePuzzles < ActiveRecord::Migration
  def self.up
    create_table :puzzles do |t|
      t.string :name
      t.string :icon
      t.float :price
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :puzzles
  end
end

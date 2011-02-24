class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :question
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.string :answer4
      t.integer :correct_answer
      t.integer :puzzle_id
      t.integer :difficulty

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end

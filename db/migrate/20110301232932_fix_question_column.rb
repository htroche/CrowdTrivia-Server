class FixQuestionColumn < ActiveRecord::Migration
  def self.up
    rename_column :questions, :question, :quiz_question
  end

  def self.down
  end
end

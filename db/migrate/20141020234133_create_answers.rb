class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id, :limit => 8
      t.references :token

      t.string :value
      t.timestamp :created_at
    end
  end
end

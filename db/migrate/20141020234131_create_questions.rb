class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, id: :bigserial do |t|
      t.string :frequency # how often
      t.string :format # which validation
      t.boolean :required

      t.integer :ordering
      t.text :question_text
      t.text :detailed_description
      t.text :options_for_select

      t.timestamps
    end
  end
end

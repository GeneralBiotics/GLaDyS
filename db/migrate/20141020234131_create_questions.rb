class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions, id: :bigserial do |t|
      t.string :kind
      t.boolean :required

      t.text :question_text
      t.text :detailed_description
      t.text :options_for_select

      t.timestamps
    end
  end
end

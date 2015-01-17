class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.integer :days
      t.string :halting_param

      t.timestamps
    end
  end
end

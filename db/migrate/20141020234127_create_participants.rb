class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_method
      t.string :email
      t.string :phone_number

      t.boolean :drop_out, default: false
      t.text :drop_out_reason

      t.timestamps
    end
  end
end

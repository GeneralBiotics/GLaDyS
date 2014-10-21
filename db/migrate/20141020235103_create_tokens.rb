class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :participant
      t.string :value
      t.timestamp :created_at
    end
  end
end

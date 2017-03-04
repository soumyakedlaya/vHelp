class CreateCharityReps < ActiveRecord::Migration
  def change
    create_table :charity_reps do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :charity_name
      t.text :charitable_cause
      t.integer :money_requested
      t.integer :money_raised

      t.timestamps
    end
  end
end

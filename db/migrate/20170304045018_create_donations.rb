class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :amount
      t.references :charity_rep, index: true
      t.references :donor, index: true

      t.timestamps
    end
  end
end

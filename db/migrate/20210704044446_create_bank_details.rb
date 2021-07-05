class CreateBankDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :bank_details do |t|
      t.string :ifsc
      t.integer :bank_id

      t.timestamps
    end
  end
end

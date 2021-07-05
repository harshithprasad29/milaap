class CreateAccountDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :account_details do |t|
      t.integer :user_id
      t.integer :bank_detail_id
      t.string	:number
      t.timestamps
    end
  end
end

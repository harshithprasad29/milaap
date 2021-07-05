class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.string :number
      t.integer :account_detail_id
      t.float :credit_limit
      t.float :emi
      t.integer :term
      t.integer :user_id
      t.integer :status
      t.timestamps
    end
  end
end

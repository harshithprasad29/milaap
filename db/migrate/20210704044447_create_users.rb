class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.blob :aadhar_number
      t.string :pan_number
      t.float :inflow
      t.float :outflow

      t.timestamps
    end
  end
end

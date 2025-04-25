class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name, index: true
      t.integer :age
      t.date :birthdate, null: false
      t.string :email, null: false, index: { unique: true }
      t.boolean :verified, default: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.date :birthdate
      t.boolean :admin

      t.timestamps
    end
  end
end

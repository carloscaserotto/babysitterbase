class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :username
      t.string :email
      t.text :description
      
      t.timestamps
    end
  end
end

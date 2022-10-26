class AddNannyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nanny, :boolean, default: false
  end
end

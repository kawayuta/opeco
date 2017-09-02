class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :viewname, :string
    add_column :users, :image, :string
  end
end

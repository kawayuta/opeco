class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :viewname, :string
    add_column :users, :image, :string
    add_column :users, :gender, :integer
    add_column :users, :birthday, :string
  end
end

class CreateShares < ActiveRecord::Migration[5.1]
  def change
    create_table :shares do |t|
      t.references :user
      t.references :partner_user
      t.string :username
      t.boolean :share_flag, null: false, default: false
      t.timestamps
    end
  end
end

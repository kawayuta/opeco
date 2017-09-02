class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.integer :possibility
      t.timestamp :ovulation
      t.timestamp :menses

      t.timestamps
    end
  end
end

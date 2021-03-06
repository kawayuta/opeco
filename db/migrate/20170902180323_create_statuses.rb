class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.references :user
      t.boolean :seiri_period, null: false, default: false
      t.timestamp :seiri_period_start
      t.timestamp :seiri_period_end
      t.timestamp :next_seiri
      t.timestamp :next_hairan
      t.string :ninsin_possibility
      t.string :uranai
      t.string :notice

      t.timestamps
    end
  end
end

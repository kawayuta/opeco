class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.references :user, foreign_key: true
      t.integer :sex_type
      t.integer :feel_type
      t.integer :condition_type
      t.timestamp :ymd
      t.timestamps
    end
  end
end

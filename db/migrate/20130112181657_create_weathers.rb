class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :city
      t.string :state
      t.float :time_cached
      t.text :weather_data
      t.timestamps
    end
  end
end

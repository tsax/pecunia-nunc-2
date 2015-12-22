class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.boolean :art
      t.boolean :comics
      t.boolean :crafts
      t.boolean :dance
      t.boolean :design
      t.boolean :fashion
      t.boolean :filmvideo
      t.boolean :food
      t.boolean :games
      t.boolean :journalism
      t.boolean :music
      t.boolean :photography
      t.boolean :publishing
      t.boolean :technology
      t.boolean :theater
      t.boolean :allcategories
      
      t.timestamps null: false
    end
  end
end

class CreateShorts < ActiveRecord::Migration
  def change
    create_table :shorts do |t|
      t.string :longer
      t.string :shorter
      t.integer :firefox
      t.integer :opera
      t.integer :chrome
      t.integer :safari
      t.integer :ie
      t.integer :other

      t.timestamps
    end
  end
end

class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.references :short
      t.integer :chrome
      t.integer :firefox
      t.integer :ie
      t.integer :opera
      t.integer :safari
      t.integer :other

      t.timestamps
    end
    add_index :stats, :short_id
  end
end

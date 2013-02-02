class RemoveStatsFromShort < ActiveRecord::Migration
  def up
    remove_column :shorts, :firefox
    remove_column :shorts, :opera
    remove_column :shorts, :chrome
    remove_column :shorts, :safari
    remove_column :shorts, :ie
    remove_column :shorts, :other
  end

  def down
    add_column :shorts, :other, :integer
    add_column :shorts, :ie, :integer
    add_column :shorts, :safari, :integer
    add_column :shorts, :chrome, :integer
    add_column :shorts, :opera, :integer
    add_column :shorts, :firefox, :integer
  end
end

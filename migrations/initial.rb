require_relative '../config/environment'

class InitialMigration < ActiveRecord::Migration
  def up
    create_table :links do |t|
      t.string  :link
      t.string  :short
      t.time    :timestamp
    end
  end

  def down
    drop_table :links
  end
end
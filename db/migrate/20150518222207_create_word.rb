class CreateWord < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :source
      t.integer :year
      t.integer :month
      t.integer :mentions
    end
    add_index :words, :word
  end
end

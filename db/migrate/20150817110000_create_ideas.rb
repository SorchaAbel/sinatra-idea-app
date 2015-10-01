class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.string :picture

      t.timestamps null: false
    end
  end

  def down
    drop_table :ideas
  end

end

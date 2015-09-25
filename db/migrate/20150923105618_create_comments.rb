class CreateComments < ActiveRecord::Migration

    def change
      create_table :comments do |t|
        t.string :user_name
        t.text :body
        t.integer :id_idea

        t.timestamps null: false
      end
    end

    def down
      drop_table :comments
    end

  end

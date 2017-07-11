class CreateRequest < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :title, null: false, limit: 255
      t.text :body
      t.references :client, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end

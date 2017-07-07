class CreateClient < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name, null: false, limit: 255

      t.timestamps null: false
    end
  end
end

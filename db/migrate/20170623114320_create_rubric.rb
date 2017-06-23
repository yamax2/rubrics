class CreateRubric < ActiveRecord::Migration[5.1]
  def change
    create_table :rubrics do |t|
      t.string :title, null: false, limit: 255
      t.text :content
      t.references :rubric, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

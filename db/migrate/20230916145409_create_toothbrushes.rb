class CreateToothbrushes < ActiveRecord::Migration[7.0]
  def change
    create_table :toothbrushes do |t|
      t.string :name, null: false
      t.string :brush_material

      t.timestamps
    end
  end
end

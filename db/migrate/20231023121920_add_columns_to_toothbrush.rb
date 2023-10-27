class AddColumnsToToothbrush < ActiveRecord::Migration[7.0]
  def change
    add_column :toothbrushes, :state, :integer, null: false, default: 0
    add_column :toothbrushes, :brush_material, :integer, null: false, default: 0
    add_column :toothbrushes, :hardness, :integer, null: false, default: 0
    add_column :toothbrushes, :use_end_at, :time
  end
end

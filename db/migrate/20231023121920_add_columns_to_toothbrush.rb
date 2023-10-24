class AddColumnsToToothbrush < ActiveRecord::Migration[7.0]
  def change
    add_column :toothbrushes, :status, :integer, null: false, default: 0
    add_column :toothbrushes, :end_time, :datetime
  end
end

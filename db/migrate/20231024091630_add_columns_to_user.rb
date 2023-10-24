class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, null: false, default: 0
    add_column :users, :name, :string, null: false, default: 'ゲスト'
  end
end

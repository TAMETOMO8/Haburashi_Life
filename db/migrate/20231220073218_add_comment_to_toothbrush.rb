class AddCommentToToothbrush < ActiveRecord::Migration[7.0]
  def change
    add_column :toothbrushes, :comment, :string
  end
end

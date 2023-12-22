class AddCommentToToothbrush < ActiveRecord::Migration[7.0]
  def change
    add_column :toothbrushes, :comment, :string
    add_column :toothbrushes, :comment_notice, :string, default: 'false'
  end
end

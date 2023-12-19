class CreateImpressions < ActiveRecord::Migration[7.0]
  def change
    create_table :impressions do |t|
      t.string :body, null: false
      t.references :user, foreign_key: true
      t.references :toothbrush, foreign_key: true

      t.timestamps
    end
  end
end

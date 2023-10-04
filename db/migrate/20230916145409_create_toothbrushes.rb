class CreateToothbrushes < ActiveRecord::Migration[7.0]
  def change
    create_table :toothbrushes do |t|
      t.string :item_code
      t.string :item_name
      t.string :item_url
      t.string :item_image_urls
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

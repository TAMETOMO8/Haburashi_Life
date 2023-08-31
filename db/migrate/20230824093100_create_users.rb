class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :line_user_id, null: false, index: { unique: true }

      t.timestamps
    end
  end
end

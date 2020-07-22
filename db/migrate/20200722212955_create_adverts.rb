class CreateAdverts < ActiveRecord::Migration[6.0]
  def change
    create_table :adverts do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.string :country
      t.string :url

      t.timestamps
    end
  end
end

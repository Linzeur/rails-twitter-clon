class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :content
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end
end

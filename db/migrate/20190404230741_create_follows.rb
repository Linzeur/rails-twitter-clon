class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :follower, :references => "user"
      t.references :followed, :references => "user"

      t.timestamps
    end
  end
end

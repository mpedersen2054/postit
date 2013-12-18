class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :user_id # for creator
      t.references :voteable, polymorphic: true

      t.timestamps
    end
  end
end

class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :tweet_text
      t.references :user

      t.timestamps
    end
  end
end

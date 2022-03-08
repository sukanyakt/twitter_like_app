class AddColumnUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, limit: 30
  end
end

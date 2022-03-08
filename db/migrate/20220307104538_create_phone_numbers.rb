class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.integer :phonenumber, limit: 8
      t.references :user

      t.timestamps
    end
  end
end

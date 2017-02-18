class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :phone
      t.string :email
      t.string :dateOfBirth
      t.string :ssn
      t.string :address
      t.string :city
      t.string :region
      t.string :postalCode
      t.string :country
      t.timestamps
    end
  end
end

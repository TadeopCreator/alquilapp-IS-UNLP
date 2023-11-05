class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :lastname
      t.string :dni
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end

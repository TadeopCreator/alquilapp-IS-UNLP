class CreateGlobals < ActiveRecord::Migration[7.0]
  def change
    create_table :globals do |t|
      t.float :monto_auto
      t.float :monto_multa
      t.integer :cooldown
      t.integer :timepo_multa

      t.timestamps
    end
  end
end

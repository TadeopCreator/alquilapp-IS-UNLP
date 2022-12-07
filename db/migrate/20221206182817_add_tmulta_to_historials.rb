class AddTmultaToHistorials < ActiveRecord::Migration[7.0]
  def change
    add_column :historials, :tiempo_multa, :integer
  end
end

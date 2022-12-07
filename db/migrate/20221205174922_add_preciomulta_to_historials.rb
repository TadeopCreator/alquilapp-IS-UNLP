class AddPreciomultaToHistorials < ActiveRecord::Migration[7.0]
  def change
    add_column :historials, :precio_multa, :float
  end
end

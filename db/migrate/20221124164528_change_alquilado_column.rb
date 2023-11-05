class ChangeAlquiladoColumn < ActiveRecord::Migration[7.0]
  def change
    change_column(:autos, :alquilado, :boolean, default: false)
  end
end

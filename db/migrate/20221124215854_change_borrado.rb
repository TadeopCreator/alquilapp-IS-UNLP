class ChangeBorrado < ActiveRecord::Migration[7.0]
  def change
    change_column(:autos, :borrado, :boolean, default: false)
  end
end

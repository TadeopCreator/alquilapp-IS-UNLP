class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :description
      t.string :patente
      t.datetime :date

      t.timestamps
    end
  end
end

class AddSendlicenseToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :send_license, :integer
  end
end

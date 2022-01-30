class AddAddressVerificationDocToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address_verification_doc, :string
  end
end

class AddForeignToPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :payment_transactions, :user, index: true
  end
end

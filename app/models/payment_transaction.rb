class PaymentTransaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :user
  after_create :manage_balance


  def manage_balance
    sender_wallet = Wallet.find(wallet_id)
    new_balance = sender_wallet.balance - ammount
    sender_wallet.update(balance: new_balance)
    sender_wallet.save
    receiver_wallet = Wallet.find(to_whom)
    new_balance = receiver_wallet.balance + ammount
    receiver_wallet.update(balance: new_balance)
    receiver_wallet.save
  end
end

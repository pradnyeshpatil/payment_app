class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :wallet
  has_many :payment_transactions
  after_create :create_wallet
  has_many_attached :images, dependent: :destroy

  def create_wallet
    Wallet.create(balance: 500, user_id: self.id)
  end

  def admin?
    email == "shekhar@example.com"
  end
end

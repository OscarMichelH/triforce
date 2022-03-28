class User < ApplicationRecord
  validate :buyer_xor_seller
  has_many :books
  has_one :cart
  has_many :sales

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_buyer?
    role == 'BUYER'
  end

  def is_seller?
    role == 'SELLER'
  end

  private
  def buyer_xor_seller
    if !(phone.blank? ^ address.blank?)
      errors[:base] << "Specify an account type and fill empty fields"
    end
  end
end

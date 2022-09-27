class User < ApplicationRecord
  validates :email, uniqueness: true
  validate :buyer_xor_seller
  has_many :items
  has_one :cart
  has_many :sales, dependent: :delete_all

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

  def is_admin?
    role == 'ADMIN'
  end

  private
  def buyer_xor_seller
    if role != 'ADMIN'
      if !(phone.blank? ^ address.blank?)
        errors[:base] << "Specify an account type and fill empty fields"
      end
    end
  end
end

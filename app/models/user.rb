class User < ApplicationRecord
  
  has_one :cart, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders, dependent: :destroy
  has_many :addresses,dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:jwt_authenticatable, jwt_revocation_strategy: JwtDenylist


  def generate_jwt
    JWT.encode({id: id, exp: 2.hours.from_now.to_i}, ENV["devise_jwt_secret"])
  end

  VALID_USERS = ['merchant', 'customer']

   validates :user_type, inclusion: { in: VALID_USERS }

   validates :name, presence: true 

   validates :phone_number, numericality: true,  :length => { :is => 10 }, presence: true, uniqueness: true
   #validates_format_of :phone_number, :with =>  /\d[0-9]\)*\z/ 
   
   # validates_format_of :email, :with => /\A((?=.*\d)+[^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "email is not valid", presence: true

   validate :password_check 


   number_regex = /\d[0-9]\)*\z/
   validates_format_of :phone_number, :with =>  number_regex, :message => "Only numbers"

    def password_check
      if self.password.present?
        return if password&.match(/\A(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&+=])(?=.*\W)[^ ]{8,}\z/)
        errors.add :password, ' Password must contain 1 uppercasse , 1 lowercase, 1 Special character, 1 digit '
      end
    end

end




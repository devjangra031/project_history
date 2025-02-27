class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :calendar
  has_many :share


  validates_uniqueness_of :username
  validates_presence_of :username

  validates_presence_of :viewname

  enum gender: { male: 0, female: 1, other:2 }

end

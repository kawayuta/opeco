class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :calendar
  has_many :share
  has_one :status


  validates_uniqueness_of :username
  validates_presence_of :username

  enum gender: { male: 0, female: 1, other:2 }

  mount_uploader :image, ImageUploader

   def update_without_current_password(params, *options)
       params.delete(:current_password)

       if params[:password].blank? && params[:password_confirmation].blank?
          params.delete(:password)
          params.delete(:password_confirmation)
       end

       result = update_attributes(params, *options)
       clean_up_passwords
       result
   end

end

class User < ActiveRecord::Base
    has_many :goals
    has_secure_password

    validates_presence_of :name, :email
    validates :email, uniqueness: true
end
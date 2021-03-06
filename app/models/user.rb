class User < ActiveRecord::Base
    has_secure_password
    has_many :reviews

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates_uniqueness_of :email, case_sensitive:false
    validates :password, confirmation:true, length: {  minimum:6 }
    validates :password_confirmation, presence: true

    def self.authenticate_with_credentials(email,password)
        email = email.gsub(/\s+/,"")
        @user = User.where("lower(email) = ?", email.downcase).first
        if @user && @user.authenticate(password)
           @user
        else
            nil
        end
    end

end

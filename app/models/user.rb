class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :name, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :journals, :order=>"updated_at desc", :limit=>10
  
  def self.authenticate(username, password)
    user = User.find_for_authentication(:email => username)
    if user
      user.valid_password?(password) ? user : nil
    else
      return nil
    end
  end
    
end

class User < ActiveRecord::Base
  belogns_to: survey
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
end

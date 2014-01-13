class User < ActiveRecord::Base
  include DailyCount
  belongs_to :survey
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
  
  def self.random_code
    evezary = %w(e v e z a r y) * 3
    digit = %w(4 6 7 9) * 2
    code = "e" + evezary.shuffle.join[0..4] + "y_" + digit.shuffle.join[0..3]
    code
  end
  
end

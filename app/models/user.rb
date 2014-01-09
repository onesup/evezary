class User < ActiveRecord::Base
  belongs_to :survey
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
  
  def self.random_code
    coffee = %w(evezary) * 2
    letter = %w(inno) * 2
    digit = %w(4 6 7 9) * 2
    code = "c" + coffee.shuffle.join[0..5] + "e-l" + letter.shuffle.join[0..5] + "r-" + digit.shuffle.join[0..5]
    code
  end
  
end

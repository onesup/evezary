class HomeController < ApplicationController
  def index
    @user = User.new(blog_code: User.random_code)
  end

  def story
  end
  
  def download_image
    send_file Rails.root+"app/assets/images/blog_posting.jpg", :x_sendfile => true,
    :type=>"image/jpg", :filename => "blog_posting.jpg", :disposition => 'attachment'
  end  
end

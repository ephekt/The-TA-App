class User < ActiveRecord::Base
  belongs_to :course
  
  acts_as_authentic do |a|
    a.require_password_confirmation = false
  end
end

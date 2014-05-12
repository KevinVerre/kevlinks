class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts

  after_create do
    root = self.posts.build(ptype: FOLDER_TYPE, title: "My folder", body: "This is your root folder.")
    root.save
    logger.debug "DEBUG: user.rb after_create method."
  end

  def root
    self.posts.first.root
  end
end

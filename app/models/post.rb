class Post < ActiveRecord::Base
  has_ancestry(orphan_strategy: :destroy)
  belongs_to :user
  acts_as_list :scope => "ancestry"


  def icon
    case self.ptype
    when FOLDER_TYPE
      "glyphicon glyphicon-folder-open"
    when BLOG_TYPE
      "glyphicon glyphicon-comment"
    when LINK_TYPE
      "glyphicon glyphicon-bookmark"
    when TWEET_TYPE
      "glyphicon glyphicon-pushpin"
    end
  end

end

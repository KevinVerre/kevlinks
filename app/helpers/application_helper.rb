module ApplicationHelper

  def GetTypeString(p)
    case p.ptype
    when FOLDER_TYPE
      "folder"
    when BLOG_TYPE
      "blog"
    when TWEET_TYPE
      "note"
    when LINK_TYPE
      "link"
    end
  end

end

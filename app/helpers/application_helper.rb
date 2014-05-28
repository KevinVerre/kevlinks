module ApplicationHelper

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

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

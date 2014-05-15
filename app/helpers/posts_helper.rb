module PostsHelper

  def PrivacyIcon(p)
    if !p.private
      "glyphicon glyphicon-globe"
    else
      "glyphicon glyphicon-lock"
    end
  end

end

module PostsHelper

  def IsVisible?(p)
    p.user == current_user || p.private == false
  end

  def PrivacyIcon(p)
    if !p.private
      "glyphicon glyphicon-globe"
    else
      "glyphicon glyphicon-lock"
    end
  end

end

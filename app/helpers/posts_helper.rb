module PostsHelper

  def IsVisible?(p)
    p.private == false || p.user == current_user
  end

  def PrivacyIcon(p)
    if !p.private
      "glyphicon glyphicon-globe"
    else
      "glyphicon glyphicon-lock"
    end
  end

end

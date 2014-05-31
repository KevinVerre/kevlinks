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

  def GetPrivacyString(p)
    p.private ? "private" : "public"
  end

  def MovePostButton(p)
    str = "<span data-toggle='tooltip' data-placement='top' title='move this to a different Folder'>" + link_to('move', post_move_folder_path(p), class: 'btn btn-default btn-xs') + "</span>"
    str.html_safe
  end

end

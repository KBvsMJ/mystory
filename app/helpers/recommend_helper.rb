module RecommendHelper
  def recommend_etc(item)
    r = "&nbsp;"
    if controller_path == 'editor'
      if item.is_a?(Note)
        onclick = "javascript:cancel_recommend_note(" + item.id.to_s + ")"
      else
        onclick = "javascript:cancel_recommend_blog(" + item.id.to_s + ")"
      end
    else
      onclick = "javascript:recommend_note(" + item.id.to_s + ")"
    end
    if session[:id].nil?
      r += link_to t('recommend'), SITE_URL, :title => t('please_login')
    else
      if item.is_a?(Note)
        if Rnote.find_by_user_id_and_note_id(session[:id], item.id).nil?
          r += link_to t('recommend'), '#' + item.id.to_s, :id => 'recommend' + item.id.to_s, :onclick => onclick
        else
          r += link_to t('cancel_recommend'), '#' + item.id.to_s, :id => 'recommend' + item.id.to_s, :onclick => onclick
        end
      else
        r += link_to t('cancel_recommend'), '#' + item.id.to_s, :id => 'recommend-blog' + item.id.to_s, :onclick => onclick
      end
    end
    raw r += "&nbsp;"
  end
end
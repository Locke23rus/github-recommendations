module ApplicationHelper

  def icon_tag(tag_name)
    "<i class='icon-#{tag_name}'></i>".html_safe
  end

end

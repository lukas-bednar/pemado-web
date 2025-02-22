module CustomFilters

  def render_link(url, text)
    "<a href='#{url}'>#{text}</a>"
  end

  def render_phone_link(number)
    render_link_w_icon("fa fa-fw fa-phone", "tel:#{ number }", number)
  end

  def render_email_link(email)
    render_link_w_icon("fa fa-fw fa-envelope", "mailto:#{ email }", email)
  end

  def render_link_w_icon(icon, url, text)
    "<span><i class='#{ icon }'></i>&nbsp;&nbsp;<a href='#{ url }' target='_blank'>#{ text }</a></span>"
  end

  def render_facebook_link(url, text)
    render_link_w_icon("fab fa-facebook", url, text)
  end
end

Liquid::Template.register_filter(CustomFilters)

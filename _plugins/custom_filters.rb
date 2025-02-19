module CustomFilters

  def render_link(url, text)
    "<a href='#{url}'>#{text}</a>"
  end

  def render_phone_link(number)
    "📞 " + render_link("tel:" + number, number)
  end

  def render_email_link(email)
    "✉️ " + render_link("mailto:" + email, email)
  end

  def render_facebook_link(url, text)
    "<span><i class='fab fa-facebook'></i>&nbsp;&nbsp;<a href='#{ url }' target='_blank'>#{text}</a></span>"
  end
end

Liquid::Template.register_filter(CustomFilters)

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info ":site:after_init:", "Hooked Excerpt for #{site}"
  site.config["title"] = "PEMADO s.r.o"
end

def generate_footer(contact)
  links = []
  links.push({
    "label" => "Telefon",
    "icon"  => "fa fa-fw fa-phone",
    "url"   => "tel:#{contact['phone']['martina']}"
  })
  links.push({
    "label" => "E-Mail",
    "icon"  => "fa fa-fw fa-envelope",
    "url"   => "mailto:#{contact['email']['martina']}"
  })
  links.push({
    "label" => "Facebook",
    "icon"  => "fab fa-fw fa-facebook",
    "url"   => contact['facebook']['store']
  })
  return { "links" => links }
end

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll.logger.info ":site:post_read:", "Hooked Excerpt for #{site}"
  site.config["footer"] = generate_footer(site.data['contact'])
end

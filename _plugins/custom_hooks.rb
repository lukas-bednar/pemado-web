
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

def sanitize_default_headers(data)
  if data["header"] then
    data["header"] = data["header"].clone
  else
    data["header"] = {}
  end
end

def inject_products_data(collection)
  navigation = []
  for product in collection.docs do
    p_data = product.site.data["product"][product.data['p_id']]
    product.data["title"] = p_data["title"]
    product.data["excerpt"] = p_data["excerpt"]

    sanitize_default_headers(product.data)
    product.data["header"]["teaser"] = p_data["image"]["main"]
    product.data["header"]["overlay_image"] = p_data["image"]["main"]

    product.data["sidebar"] = [{ "nav" => "products"}]
    p_data["permalink"] = "/products/#{product.data['p_id']}/"
    product.data["permalink"] = p_data["permalink"]

    item = {
      "title" => p_data["title"],
      "url"   => p_data["permalink"]
    }
    if p_data["sections"] then
      item["children"] = []
      for sub in p_data["sections"] do
        item["children"] << {
          "title" => sub["name"],
          "url"   => p_data["permalink"] + sub["header"]
        }
      end
    end
    navigation << item
    Jekyll.logger.info ":inject_products_data:", "Hooked Excerpt for #{product.data}"
  end
  collection.site.data["navigation"]["products"] = navigation
end

def filter_item(item, filter)
  if !filter.empty? then
    if filter.include? item then
      return false
    end
  else
    return false
  end
  return true
end

def generate_products_gallery(products, filter: [])
  gallery = []
  for product in products do
    item = {
      "url"        => product[1]["image"]["main"],
      "image_path" => product[1]["image"]["main"],
      "title"      => product[1]["title"],
      "alt"        => product[1]["title"],
    }
    if !filter_item(product[0], filter) then
      gallery << item
    end
  end
  return gallery
end

def generate_products_feature_row(products, filter: [])
  feature_row = []
  for product in products do
    item = {
      "image_path" => product[1]["image"]["main"],
      "title"      => product[1]["title"],
      "url"        => product[1]["permalink"],
      "excerpt"    => product[1]["excerpt"]
    }
    if !filter_item(product[0], filter) then
      feature_row << item
    end
  end
  return feature_row
end

def generate_excerpt_for_main(site)
  excerpt = []
  for product in site.data['product'] do
    link = File.join(site.baseurl, product[1]['permalink'])
    excerpt << "<a href=\"#{link}\" class=\"btn btn--light-outline btn--large\">#{product[1]['title']} </a>"
  end
  return "<p class=\"our-highlights\">" + excerpt.join("<br>") + "</p>"
end

def generate_actions_main(site)
  actions = []
  for product in site.data['product'] do
    actions << {
      "label" => product[1]['title'],
      "url"   => File.join(site.baseurl, product[1]['permalink'])
    }
  end
  return actions
end

Jekyll::Hooks.register :site, :post_read do |site|
  Jekyll.logger.info ":site:post_read:", "Hooked Excerpt for #{site}"
  site.config["footer"] = generate_footer(site.data['contact'])
  inject_products_data(site.collections['products'])
  for page in site.pages do
    if page.name == "index.markdown" then
      page.data['excerpt'] = generate_excerpt_for_main(site)
      #sanitize_default_headers(page.data)
      #page.data['header']['actions'] = generate_actions_main(site)
    end
    if page.name == "products.markdown" then
      page.data['feature_row'] = generate_products_feature_row(site.data['product'])
    end
  end
end

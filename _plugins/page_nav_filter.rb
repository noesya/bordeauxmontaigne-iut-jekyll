require 'nokogiri'
module Jekyll::PageNavFilter
  def page_nav_links(html)
    doc = Nokogiri::HTML html
    nav = "<ul class='nav toc' id='nav-toc'>"
    doc.css('h2').each_with_index do |node, index|
      id = make_id index
      nav += "<li class='nav-item'><a class='nav-link' href=\"##{id}\">#{node.content}</a></li>"
    end
    nav += "</ul>"
    nav
  end

  def page_nav_text_with_ids(html)
    doc = Nokogiri::HTML html
    doc.css('h2').each_with_index do |node, index|
      node['id'] = make_id index
    end
    doc.to_s
  end

  def make_id(index)
    "title-#{index+1}"
  end
end

Liquid::Template.register_filter(Jekyll::PageNavFilter)

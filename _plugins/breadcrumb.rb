module Jekyll::BreadcrumbFilter
  def breadcrumb(page)
    Builder.new(page).to_s
  end

  class Analyzer
    def self.pages
      unless @pages
        @pages = {}
        site.documents.each do |document|
          path = clean_url document.url
          @pages[path] = document
        end
        site.pages.each do |page|
          path = clean_url page.url
          @pages[path] = page
        end
        # debugger
      end
      @pages
    end

    def self.find_page(url)
      pages[url]
    end

    def self.site
      @site ||= Jekyll.sites.first
    end

    def self.clean_url(url)
      url.gsub('/index.html', '')
         .gsub('.html', '')
    end

    def self.crumbs_to(page)
      crumbs = []
      crumbs << {
        url: '/',
        title: 'Accueil'
      }
      current_path = ''
      url = clean_url page['url']
      chunks = url[1..-1].split('/')
      chunks.each do |fragment|
        current_path = "#{current_path}/#{fragment}"
        current_page = find_page current_path
        if current_page
          crumb = {
            title: current_page.data['title'].to_s
          }
          crumb[:url] = current_path unless current_path == url
          crumbs << crumb
        end
      end
      crumbs
    end
  end

  class Builder
    attr_reader :page

    def initialize(page)
      @page = page
    end

    def to_s
      "#{opening_tag}#{crumbs_tag}#{closing_tag}"
    end

    protected

    def opening_tag
      '<nav aria-label="breadcrumb"><ol class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">'
    end

    def crumbs_tag
      html = ''
      crumbs.each_with_index do |crumb, index|
        html += crumb_tag(crumb, index)
      end
      html
    end

    def crumb_tag(crumb, index)
      html = '<li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">'
      if crumb[:url]
        html += "<a href=\"#{crumb[:url]}\" itemprop=\"item\">"
        html += "<span itemprop=\"name\">#{crumb[:title]}</span>"
        html += "<meta itemprop=\"position\" content=\"#{index+1}\" />"
        html += '</a>'
      else
        html += crumb[:title]
      end
      html += '</li>'
      html
    end

    def closing_tag
      '</ol></nav>'
    end

    def crumbs
      Analyzer.crumbs_to(page)
    end
  end
end

Liquid::Template.register_filter(Jekyll::BreadcrumbFilter)

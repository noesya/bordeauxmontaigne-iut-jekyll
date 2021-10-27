module Jekyll::BreadcrumbFilter
  def breadcrumb(page)
    Builder.new(page).to_s
  end

  class Builder
    attr_reader :page

    def self.pages
      unless @pages
        @pages = {}
        site.documents.each do |document|
          path = clean_url document.url
          @pages[path] = document
        end
      end
      @pages
    end

    def self.site
      @site ||= Jekyll.sites.first
    end

    def self.clean_url(url)
      url.gsub('.html', '')
    end

    def initialize(page)
      @page = page
    end

    def to_s
      html = '<nav aria-label="breadcrumb">'
      html += '<ol class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">'
      crumbs_to(page).each_with_index do |crumb, index|
         html += '<li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">'
         if crumb[:url]
           html += "<a href=\"#{crumb[:url]}\" itemprop=\"item\">"
           html += "<span itemprop=\"name\">#{crumb[:title]}</span>"
           html += "<meta itemprop=\"position\" content=\"#{index+1}\" />"
           html += '</a>'
         else
           html += crumb[:title]
         end
       html += '</li>'
      end
      html += '</ol>'
      html += '</nav>'
      html
    end

    protected

    def find_page(url)
      Jekyll::BreadcrumbFilter::Builder.pages[url]
    end

    def clean_url(url)
      Jekyll::BreadcrumbFilter::Builder.clean_url url
    end

    def crumbs_to(page)
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
            title: current_page.data['title']
          }
          crumb[:url] = current_path unless current_path == url
          crumbs << crumb
        end
      end
      crumbs
    end
  end
end

Liquid::Template.register_filter(Jekyll::BreadcrumbFilter)

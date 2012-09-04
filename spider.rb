require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'uri'
require 'image'

module ArtCrawl

class Spider  
  def initialize
    
  end
  
  def crawl(url, params, marked_list, content_list)
      if marked_list.nil?
        marked_list = Array.new()
      end
        
      if content_list.nil?
        content_list = Array.new()
      end  
        
      links = Array.new()
      image_nodes = Array.new()
      urls = Array.new()
      image_urls = Array.new()  
      doc = nil 
      
      begin  
        doc = Nokogiri::HTML(open(url))
      rescue
        #puts "could not open #{url}"
      end 
      
      unless doc.nil?
         puts "crawling #{url}..."
          doc.search( "a" ).each do |link|
            unless marked_list.include?( link["href"] )
              links << link
              marked_list <<  link["href"]
            end    
          end

          doc.search( "img" ).each do |image|
            unless content_list.include?( image["src"] )
              image_nodes << image
              content_list <<  image["src"]
            end    
          end

          links = filter( links, params["crawl_filter"] )  
          content_links = filter( content_links, params["image_filter"] )
          
          urls = get_attribute_list( links, "href" )
          content_urls = get_attribute_list( image_nodes, "src" )  
            
          content_urls.each do |c_url|
            image = download_image( c_url )
            ArtCrawl.save_image( image )
          end

          unless params["depth"] == 1
            crawl_deeper( urls, params, marked_list, content_list )
          end    
      end
  end

  def crawl_deeper( links, params, marked_list, content_list )
      links.each do |link|
        sub_spider = Spider.new()
        crawl_params = params.clone()
        crawl_params["depth"] = params["depth"] - 1 
        sub_spider.crawl( link, crawl_params, marked_list, content_list )
      end
  end
  
  def filter(link_list, filter_params)
    return link_list
  end
  
  def get_attribute_list(nodes, attribute)
    attributes = Array.new()
    nodes.each do |node|
      attributes << node[attribute].to_s
    end
    return attributes
  end
  
  def download_image( url )
    puts "downloading #{url}..." 
    system("cd images && curl -O -# #{url}")  
    parts = url.split('/')
    image_path = "images/" + parts[ parts.length-1 ].split('?')[0]; 
    image = Image.new( image_path )
  end  
  
end

end
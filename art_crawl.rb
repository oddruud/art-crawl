$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'art_crawl' ) ) 
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'art_crawl/models' ) ) 
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'art_crawl/utils' ) )
 
require 'rubygems'
require 'spider'
require 'art_crawl_data'

module ArtCrawl

  def ArtCrawl.show_info
      puts "Art Crawl 0.1"
  end 
   
  def ArtCrawl.start
    ArtCrawl.show_info    
    ArtCrawl::ArtCrawlData.start( "data/database.yml" )
    
    spider = Spider.new()
    sources = ArtCrawl.load_sources( "data/sources" )
    sources.each_index { |i| puts "#{i}: #{sources[i]}"}    
    parameters = Hash.new()
    
    parameters["image_filter"] = "img"
    parameters["crawl_filter"] = "a"  
    parameters["depth"] = 3
      
    sources.each do |source_url|
      spider.crawl(source_url, parameters, nil, nil)      
    end
    
  end  
  
  def ArtCrawl.load_sources( sources_file )
    sources = Array.new()
    File.open(sources_file) do |infile|
      while (line = infile.gets) do
        sources << line
      end
    end 
    return sources 
  end  

end 

ArtCrawl.start
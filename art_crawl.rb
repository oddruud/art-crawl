require 'rubygems'
require 'sqlite3'
require 'spider'

module ArtCrawl

  attr_reader :database

  def ArtCrawl.show_info
      puts "Art Crawl 0.1"
  end 
   
  def ArtCrawl.start
    ArtCrawl.show_info    
    spider = Spider.new()
    sources = ArtCrawl.load_sources( "sources" )
    @database = ArtCrawl.load_database( "artcrawl.db" )
    sources.each_index { |i| puts "#{i}: #{sources[i]}"}    
    parameters = Hash.new()
    
    parameters["image_filter"] = "img"
    parameters["crawl_filter"] = "a"  
    parameters["depth"] = 3
      
    sources.each do |source_url|
      spider.crawl(source_url, parameters, nil, nil)      
    end
    
  end  
  
  def ArtCrawl.save_image( image )
    puts "storing image in DB"
  end 
  
  def ArtCrawl.load_database( database_name )
    database = SQLite3::Database.new database_name
  
    return database 
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
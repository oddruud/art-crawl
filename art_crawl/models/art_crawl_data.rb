require 'sqlite3'
require 'active_record'
require 'yaml'
require 'logger'

module ArtCrawl
  module ArtCrawlData
    def ArtCrawlData.start db_config_filename 
      dbconfig = YAML::load(File.open(db_config_filename))
      puts "attempting connection with config: #{dbconfig.to_s}" 
      ActiveRecord::Base.establish_connection(dbconfig)
      ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
      
      puts "database connected: #{ActiveRecord::Base.connected?()}" 
      
    end
  end 
end
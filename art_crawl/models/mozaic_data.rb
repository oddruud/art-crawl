require 'art_crawl_data'

class MozaicData < ActiveRecord::Base
  
  def MozaicData.save( mozaic )
    mozaic_data = MozaicData.new( :image_list => mozaic.image_list,
                                  :columns => mozaic.columns,
                                  :rows => mozaic.rows
                                )
    puts "saving #{mozaic_data.to_s} to DB"
    mozaic_data.save()
  end
  
  def get_by_color( color )
    image_data = ImageData.where(:mean_color => color) 
  end
   
  def get_by_name( name )

  end
  
  
end
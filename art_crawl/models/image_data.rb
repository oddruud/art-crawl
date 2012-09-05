require 'art_crawl_data'

class ImageData < ActiveRecord::Base
  
  def ImageData.save( image )
    image_data = ImageData.new( :file_name=>    image.file_name , 
                                :mean_color =>  image.mean_color, 
                                :width =>       image.width(), 
                                :height =>      image.height())
    puts "saving #{image_data.to_s} to DB"
    image_data.save()
  end
  
  def get_by_color( color )
    image_data = ImageData.where(:mean_color => color) 
  end
   
  def get_by_name( name )

  end
  
  
end
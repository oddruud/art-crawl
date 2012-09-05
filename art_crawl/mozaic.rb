require 'image_data'
require 'image'

module ArtCrawl

class Mozaic 

  attr_reader :name
  attr_reader :image_list
  attr_reader :columns
  attr_reader :rows

  attr_reader :src_image
  attr_reader :result_image
  attr_reader :date
 
  def initialize( image_file_name, tile_size, tolerance )
    @src_img = Magick::Image.read( image_file_name )[0]  
    
    (0..@src_img.columns-1).each do |c|
      (0..@src_img.rows-1).each do |r|
        @src_img.get_pixel(c, r)
      end
    end
    
    
  end
    
end

end
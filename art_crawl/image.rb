require 'RMagick'
include Magick 

module ArtCrawl

class Image
  attr_reader :file_name
  attr_reader :img
  attr_reader :mean_color
   
  def initialize( file_name, quantize_value = 32 )
    @file_name = file_name
    
    puts "analyzing image #{file_name}..."
    begin 
      @img = Magick::Image.read( file_name )[0]
    rescue 
      return nil
    end  
    
    unless @img.nil?
      puts @img.to_s
      @img = @img.quantize( quantize_value )
      histogram = @img.color_histogram()
      @mean_color = get_mean_color( histogram )       
    end
  end
  
  def resolution 
    return @img.x_resolution, @img.y_resolution 
  end
  
  def width
    return @img.columns
  end
    
  def height
    return @img.rows
  end
  
  def quality 
    @img.quality
  end
  
  def high_quality_image? 
    return width() >= 200 
  end
  
  def get_mean_color( histogram )
    red = 0
    blue = 0
    green = 0
    count = 0
       
    histogram.each do |pixel, occurances|       
      count += occurances  
      red   += pixel.red    * occurances
      green += pixel.green  * occurances
      blue  += pixel.blue   * occurances
    end
    
    red   /= count 
    green /= count 
    blue  /= count  
    
    rgb = red;
    rgb = (rgb << 8) + green;
    rgb = (rgb << 8) + blue;
    
    return rgb
  end
  
  
end  
  
end
 
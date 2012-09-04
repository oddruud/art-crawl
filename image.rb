require 'RMagick'
include Magick 

module ArtCrawl

class Image

  attr_reader :img
  attr_reader :mean_color

  def initialize filename 
    puts "analyzing image #{filename}..." 
    begin 
      @img = Magick::Image.read( filename )[0]
    rescue 
    end  
    
    unless @img.nil?
      puts @img.to_s
      @img = @img.quantize( 16 )
      histogram = @img.color_histogram()
      @mean_color = get_mean_color( histogram )       
    end
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
    return {"red"=>red, "green"=>green, "blue"=>blue}
  end
  
  
end  
  
end
 
require 'RMagick'
include Magick 

module ArtCrawl

class Image

  attr_reader :img

  def initialize filename
    puts "analyzing image #{filename}..." 
    begin 
      @img = Magick::Image.read( filename )[0]
    rescue 
    end  
    
    unless @img.nil?
      puts @img.to_s
      @img = @img.quantize(16)
      histogram = @img.color_histogram()
      #puts histogram.to_a.to_s  
      
      histogram.each do |k,v|  
        puts "#{k} : #{v}"
      end
       
    end
  end
  
  def mean_color histogram
    color = Hash.new()
    color["red"] = 0 
    color["green"] = 0 
    color["blue"] = 0 
    
    count = 0    
    histogram.each do |k,v|      
      count += v  
      color["red"] += k["red"] 
      color["green"] += k["green"] 
      color["blue"] += k["blue"]     
    end
    
    color["red"] /= count 
    color["green"] /= count 
    color["blue"] /= count
    
    return color 
  end
  
  
end  
  
end
 
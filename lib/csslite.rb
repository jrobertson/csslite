#!/usr/bin/env ruby

# file: csslite.rb

require 'c32'


class CSSLite
  using ColouredText
  
  def initialize(s, debug: false, override: false)
    
    @debug, @override = debug, override

    # parse the CSS
    
    @a = s.strip.split(/}/).map do |entry|

      raw_selector,raw_styles = entry.split(/{/,2)

      h = raw_styles.strip.split(/;/).inject({}) do |r, x| 
        k, v = x.split(/:/,2).map(&:strip)
        r.merge(k.to_sym => v)
      end

      [raw_selector.split(/,\s*/).map(&:strip), h]
    end
    
    puts '@a: ' + @a.inspect if @debug    
    
  end

  def propagate(root_element)
    
    puts 'inside csslist#propagate'.info if @debug
    
    # add each CSS style attribute to the element
    # e.g. @a = [[['line'],{stroke: 'green'}]]

    @a.each do |x|

      selectors, style = x

      selectors.each do |selector|

        root_element.css(selector).each do |element|
          puts 'element: ' + element.inspect if @debug
          apply_style element, style
          
          # apply the CSS to all its children
          element.each_recursive {|x| apply_style x, style}
        end

      end
    end

  end
  
  private  
  
  def apply_style(e, new_h)
    
    h = e.style.to_h
    puts 'h: '  + h.inspect if @debug

    puts 'new_h: '  + new_h.inspect if @debug
    @override ? h.merge!(new_h) :  h = new_h.merge(h)
    
    puts 'after h: '  + h.inspect if @debug
    e.attributes[:style] = h.map{|x| x.join(':') }.join(';')
    
  end

end

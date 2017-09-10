#!/usr/bin/env ruby

# file: csslite.rb


class CSSLite

  
  def initialize(s)

    # parse the CSS
    
    @a = s.strip.split(/}/).map do |entry|

      raw_selector,raw_styles = entry.split(/{/,2)

      h = raw_styles.strip.split(/;/).inject({}) do |r, x| 
        k, v = x.split(/:/,2).map(&:strip)
        r.merge(k.to_sym => v)
      end

      [raw_selector.split(/,\s*/).map(&:strip), h]
    end
    
    @elements = {}
    
  end

  def propagate(root_element)

    # add each CSS style attribute to the element
    # e.g. @a = [[['line'],{stroke: 'green'}]]

    @a.each do |x|

      selectors, style = x

      selectors.each do |selector|

        style.each do |k,v|

          root_element.css(selector).each do |element|

            apply_style element, k, v
            
            # apply the CSS to all its children
            element.each_recursive {|x| apply_style x, k,v}
          end
        end

      end
    end

  end
  
  private
  
  
  def apply_style(e, k, v)
    
    id = e.object_id
    @elements[id] = e.style.to_h unless @elements.has_key? id
    e.style[k] = v unless @elements[id].has_key? k
    
  end

end
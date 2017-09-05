#!/usr/bin/env ruby

# file: csslite.rb


class CSSLite

  def initialize(s)

    # parse the CSS
    
    @a = s.split(/}/)[0..-2].map do |entry|

      raw_selector,raw_styles = entry.split(/{/,2)

      h = raw_styles.strip.split(/;/).inject({}) do |r, x| 
        k, v = x.split(/:/,2).map(&:strip)
        r.merge(k.to_sym => v)
      end

      [raw_selector.split(/,\s*/).map(&:strip), h]
    end      
    
  end

  def propagate(root_element)

    # add each CSS style attribute to the element
    # e.g. @a = [[['line'],{stroke: 'green'}]]

    @a.each do |x|

      selectors, style = x

      selectors.each do |selector|

        style.each do |k,v|

          root_element.css(selector).each do |element|

            element.style[k] = v unless override == false and element.style.has_key? k
          end
        end

      end
    end

  end

end

# Introducing the CSSLite gem

    require 'domle'
    require 'csslite'

    s = "b {background-color: #ff3322 }"
    xml = "<a><b>red</b><b2>green</b2><b>blue</b></a>"

    doc = Domle.new(xml)
    css = CSSLite.new s
    css.propagate doc.root

    puts doc.root.xml pretty: true


<pre>
&lt;a style=''&gt;
  &lt;b style='background-color:#ff3322'&gt;red&lt;/b&gt;
  &lt;b2 style=''&gt;green&lt;/b2&gt;
  &lt;b style='background-color:#ff3322'&gt;blue&lt;/b&gt;
&lt;/a&gt;
</pre>

## Resources

* csslite https://rubygems.org/gems/csslite

css csslite gem style stylesheet 


require 'rexml/document'

module WeatherHelper
  include REXML

  def parseWeatherHTML(html)
    # Well I have apparently chosen a very poorly formated xml since it won't parse straight.  There are several unclosed tags.
    body_start = html.index('<body')
    body_end = html.index('</body>')
    body = html[body_start..(body_end+7)]

    # Missing quotes on the attributes, so I am just getting the table I need.
    table_start_string = '<table border="0"  cellpadding=2 cellspacing=1 align="center" width="98%">'
    table_start = body.index table_start_string
    if table_start.nil?
      return {'error' => 'City and state combination not found, or missing.'}
    end
    table_end = body.index '</table>', table_start
    
    table = body[(table_start+table_start_string.length)..(table_end-1)]
    
    #And they didn't close the img tags, but I don't need them.
    table.gsub!(/<img[^<]+/, '')
    # the first <tr> is all out of order, and the second is just headers so I am deleting them.
    contents = table
    (1..2).to_a.each {
      contents = contents[(contents.index("</tr>")+5)..-1] 
    }
    #Remove unclosed <br>
    contents.gsub!(/<br>/, '')
    #Add in a root element
    contents = "<root>"+contents+"</root>"
    # Now it seems almost silly to make a document.
    doc = Document.new(contents)
    results = []
    row_map = {}
    index = 0
    # Go through and pull out the values that are meaningful.
    doc.root().each_element("/root/tr/td/span") do |row|
      case index
        when 0
          #Convert to 24 hour time
          day = Time.now.day
          row_map['time']=row.text.gsub(/\D\D\D..(#{day}|#{day+1})/, '')
        when 3
          row_map['temperature']=row.text.gsub(/&deg;F/, '')
        when 6
          row_map['humidity']=row.text.gsub(/%/, '')
      end
      if index==7
        results << row_map
        row_map = {}
        index=0
      else
        index+=1
      end
    end
    results
  end
end

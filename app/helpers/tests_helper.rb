module TestsHelper
  def format_html(html, col_class='col-md-8 col-md-offset-2')
    doc = Nokogiri::HTML(html)
    questions = doc.css('.question')
    questions.each do |question|
      question['class'] = question['class'] + ' tile-body'
    end
    questions.wrap("<div class='row'></div>")
    questions.wrap("<div class='" + col_class + "'></div>")
    questions.wrap("<div class='tile'></div>")
    doc.to_html
  end
end

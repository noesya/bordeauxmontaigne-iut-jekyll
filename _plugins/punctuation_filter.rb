module Jekyll::PunctuationFilter
  def correct_punctuation(string)
    correct = string.to_s
    space = '&#8239;'
    signs = [';', ':', '!', '?']
    signs.each do |sign|
      correct = correct.gsub " #{sign}", "#{space}#{sign}"
    end
    correct
  end
end

Liquid::Template.register_filter(Jekyll::PunctuationFilter)

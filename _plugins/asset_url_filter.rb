require 'uri'

module Jekyll::AssetUrlFilter
  WHITELISTED_CROP_VALUES = ['top', 'left', 'right', 'bottom', 'center']
  WHITELISTED_SCALE_VALUES = [2, 3]

  def img_url(base_url, size = '100x100', options = {})
    uri = URI.parse(base_url)
    path_parts = uri.path.split('/')

    filename = path_parts.pop
    new_file_basename = "#{File.basename(filename, '.*')}_#{size}"
    new_file_basename += "_crop_#{options['crop']}" if !options['crop'].nil? && WHITELISTED_CROP_VALUES.include?(options['crop'])
    new_file_basename += "@#{options['scale']}x" if !options['scale'].nil? && WHITELISTED_SCALE_VALUES.include?(options['scale'])
    path_parts << new_file_basename

    new_file_extension = ".#{options['format']}" if !options['format'].nil?
    new_file_extension ||= File.extname(filename)

    "#{uri.scheme}://#{uri.host}#{path_parts.join('/')}#{new_file_extension}"
  end
end

Liquid::Template.register_filter(Jekyll::AssetUrlFilter)

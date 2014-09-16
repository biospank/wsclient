module ReportsHelper
  
  FILE_EXTENSION_MAP = {
    'ppt' => 'Documents',
    'avi' => 'Videos',
    'txt' => 'Text',
    'doc' => 'Documents'
  }
  
  def group_by_type(files)
    grouped_items = []
    
    files.group_by { |element| FILE_EXTENSION_MAP[element["extension"]] }.each do |extension, items|
      grouped_items << [items.length, extension, items.sum {|element| element.size}.kilobytes()]
    end
    
    grouped_items
  end
end

module ReportsHelper
	
	module FILE
		
		DOC 	= 'Documents'
		VIDEO = 'Videos'
		SONG 	= 'Songs'
		TEXT 	= 'Texts'
		BIN		= 'binary'
		
		GRAVITY_MAP = {
			DOC 	=> 1.1,
			VIDEO => 1.4,
			SONG 	=> 1.2,
			TEXT	=> 1,
			BIN		=> 1
		}
		
		FIXED_GRAVITY_MAP = {
			TEXT	=> 100
		}

		EXTENSION_MAP = {
			'ppt' => DOC,
			'avi' => VIDEO,
			'txt' => TEXT,
			'doc' => DOC,
			'mp3' => SONG,
			'bin' => BIN
		}
	end
	
  def group_by_type(files)
    grouped_items = []
    
    files.group_by { |element| FILE::EXTENSION_MAP[element["extension"]] }.each do |extension, items|
      grouped_items << [items.length, extension, items.sum {|element| element.size}.kilobytes()]
    end
    
    grouped_items
  end
	
	def gravity_for(file)
		extension = FILE::EXTENSION_MAP[file["extension"]]
		gravity = FILE::GRAVITY_MAP[extension] || 1
		
		weight = file["size"].kilobytes() * gravity
		
		weight += (FILE::FIXED_GRAVITY_MAP[extension] || 0)
		
		weight
		
	end
end

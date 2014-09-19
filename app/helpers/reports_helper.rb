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
			'pdf' => DOC,
			'avi' => VIDEO,
			'txt' => TEXT,
			'doc' => DOC,
			'mp3' => SONG,
			'bin' => BIN,
			'mp4' => VIDEO
		}
	end
	
  def group_by_type(files)
    grouped_items = []
    
		# api doc mention file extension property but it doesn't return any such propergty
		# so i have to split 'file_name' property to access file extension
    files.group_by { |element| get_file_extension(element["file_name"]) }.each do |extension, items|
			size = items.sum {|element| element["size"]}
			gravity = gravity_for(extension, size)
			
      grouped_items << [
				items.length, 
				extension, 
				(size + gravity),
				gravity
			]
    end
    
    grouped_items
  end
	
	def gravity_for(extension, size)
		gravity = FILE::GRAVITY_MAP[extension] || 1
		
		weight = ((size / Numeric::KILOBYTE) * (gravity == 1 ? gravity : (gravity - 1))).round(2)
		
		weight += (FILE::FIXED_GRAVITY_MAP[extension] || 0)
		
	end
	
	def get_file_extension(file_name)
		FILE::EXTENSION_MAP[file_name.split('.').last] || "Uncategorized"
	end
end

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReportsHelper.

describe ReportsHelper do
	describe "group_by_type" do
		items = [
		 {"name" => 'file_1', "size" => 1601, "file_name" => 'file_1.ppt'},
		 {"name" => 'file_2', "size" => 3501, "file_name" => 'file_2.ppt'},
		 {"name" => 'file_3', "size" => 44156333, "file_name" => 'file_3.avi'},
		 {"name" => 'file_4', "size" => 83883772, "file_name" => 'file_4.avi'},
		 {"name" => 'file_5', "size" => 1928, "file_name" => 'file_5.txt'},
		 {"name" => 'file_6', "size" => 27665, "file_name" => 'file_6.doc'}
		]

		it "group array items by file type" do
			files_group = helper.group_by_type(items)
			expect(files_group.length).to eq(3)
		end
	end

	describe "gravity_for" do
		it "'Documents' to be its size in kilobytes * 1.1" do
			file = {"name" => 'file_1', "size" => 1601, "file_name" => 'file_1.ppt'}
			weight = helper.gravity_for ReportsHelper::FILE::EXTENSION_MAP[file["file_name"].split('.').last], file['size']
			expect(weight).to eq(((file["size"] / Numeric::KILOBYTE) * 0.1).round(2))
		end

		it "'Videos' to be its size in kilobytes * 1.4" do
			file = {"name" => 'video', "size" => 39938387, "file_name" => 'video.avi'}
			weight = helper.gravity_for ReportsHelper::FILE::EXTENSION_MAP[file["file_name"].split('.').last], file['size']
			expect(weight).to eq(((file["size"] / Numeric::KILOBYTE) * 0.4).round(2))
		end

		it "'Songs' to be its size in kilobytes * 1.2" do
			file = {"name" => 'song', "size" => 37736635, "file_name" => 'song.mp3'}
			weight = helper.gravity_for ReportsHelper::FILE::EXTENSION_MAP[file["file_name"].split('.').last], file['size']
			expect(weight).to eq(((file["size"] / Numeric::KILOBYTE) * 0.2).round(2))
		end

		it "'Text' to be its size in kilobytes + 100" do
			file = {"name" => 'text', "size" => 552442, "file_name" => 'text.txt'}
			weight = helper.gravity_for ReportsHelper::FILE::EXTENSION_MAP[file["file_name"].split('.').last], file['size']
			expect(weight).to eq(((file["size"] / Numeric::KILOBYTE) + 100).round(2))
		end

		it "'Others' to be its size in kilobytes * 1" do
			file = {"name" => 'unclassified', "size" => 37726235, "file_name" => 'unclassified.rb'}
			weight = helper.gravity_for ReportsHelper::FILE::EXTENSION_MAP[file["file_name"].split('.').last], file['size']
			expect(weight).to eq(((file["size"] / Numeric::KILOBYTE) * 1).round(2))
		end
	end
end

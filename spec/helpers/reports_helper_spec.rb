require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReportsHelper.

describe ReportsHelper do
	describe "group_by_type" do
		items = [
		 {"name" => 'file_1', "size" => 1601, "extension" => 'ppt'},
		 {"name" => 'file_2', "size" => 3501, "extension" => 'ppt'},
		 {"name" => 'file_3', "size" => 44156333, "extension" => 'avi'},
		 {"name" => 'file_4', "size" => 83883772, "extension" => 'avi'},
		 {"name" => 'file_5', "size" => 1928, "extension" => 'txt'},
		 {"name" => 'file_6', "size" => 27665, "extension" => 'doc'}
		]

		it "group array items by file type" do
			files_group = helper.group_by_type(items)
			expect(files_group.length).to eq(3)
		end
	end

	describe "gravity_for" do
		it "'Documents' to be its size in kilobytes * 1.1" do
			file = {"name" => 'file_1', "size" => 1601, "extension" => 'ppt'}
			weight = helper.gravity_for file
			expect(weight).to be((file["size"].kilobytes() * 1.1))
		end

		it "'Videos' to be its size in kilobytes * 1.4" do
			file = {"name" => 'video', "size" => 39938387, "extension" => 'avi'}
			weight = helper.gravity_for file
			expect(weight).to be((file["size"].kilobytes() * 1.4))
		end

		it "'Songs' to be its size in kilobytes * 1.2" do
			file = {"name" => 'song', "size" => 37736635, "extension" => 'mp3'}
			weight = helper.gravity_for file
			expect(weight).to be((file["size"].kilobytes() * 1.2))
		end

		it "'Text' to be its size in kilobytes + 100" do
			file = {"name" => 'text', "size" => 552442, "extension" => 'txt'}
			weight = helper.gravity_for file
			expect(weight).to be((file["size"].kilobytes() + 100))
		end

		it "'Others' to be its size in kilobytes * 1" do
			file = {"name" => 'bin', "size" => 37726235, "extension" => 'rb'}
			weight = helper.gravity_for file
			expect(weight).to be((file["size"].kilobytes() * 1))
		end
	end
end

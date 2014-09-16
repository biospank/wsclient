require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ReportsHelper.

 describe ReportsHelper do
   describe "group_by_type" do
     it "group array items by file type" do
       items = [
         {"name" => 'file_1', "size" => 1601, "extension" => 'ppt'},
         {"name" => 'file_2', "size" => 3501, "extension" => 'ppt'},
         {"name" => 'file_3', "size" => 44156333, "extension" => 'avi'},
         {"name" => 'file_4', "size" => 83883772, "extension" => 'avi'},
         {"name" => 'file_5', "size" => 1928, "extension" => 'txt'},
         {"name" => 'file_6', "size" => 27665, "extension" => 'doc'}
       ]
       
       files_group = helper.group_by_type(items)
       expect(files_group.length).to eq(3)
     end
   end
 end

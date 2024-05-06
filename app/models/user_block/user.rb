class UserBlock::User < ApplicationRecord

	self.table_name = :user_block_users

	has_secure_password

	def self.get_session_data
		@logger = Logger.new(STDOUT)
		GoogleDrive::Session.from_service_account_key("config/google_sheet_key.json")
	end


	def self.create_sheet(file_name, type, role, sheet_name)
		session = get_session_data
		if session.spreadsheet_by_title(sheet_name)
			return {human_url: "file already present"}
		else
			folder = session.create_folder(file_name)
			folder.acl.push(type:type, role:role)
			folder_find = session.folder_by_url(folder.human_url)
			file = folder_find.create_spreadsheet(sheet_name)
			return file
		end
	end

	def self.enter_data(id, name, email, age, sheet_name)
		work_sheet = find_file(sheet_name)
		size = work_sheet.rows.size
		work_sheet.insert_rows(size+1,[[id,name,email,age]])
		work_sheet.save
		return @file
	end

	def self.update_user_data(id, name, email, age, sheet_name)
		work_sheet = find_file(sheet_name)
		data = get_all_data(id, work_sheet)
		work_sheet.update_cells(data[:row],1,[[id,name,email,age]])
		work_sheet.save
		return @file
	end


	def self.remove_user_data(id, sheet_name)
		work_sheet = find_file(sheet_name)
		data = get_all_data(id, work_sheet)
		work_sheet.delete_rows(data[:row],1)
		work_sheet.save
		return @file
	end

	def self.find_file(sheet_name)
		session = get_session_data
		@file = session.spreadsheet_by_title(sheet_name)

		return work_sheet = @file.worksheets.first
	end

	def self.get_all_data(id, work_sheet)
		data = {}
		rows = work_sheet.rows
		if rows.size > 0 && id.present?
    		count = 0
	    	rows.each_with_index do |row, index|
	      # Assuming the ID is in the first column (column index 0)
		      if row[0].to_i == id
		        data[:row] = index + 1  # Row number where the data is found
		        data[:id] = row[0]
		        data[:name] = row[1]
		        data[:email] = row[2]
		        data[:age] = row[3]
		        break  # Break loop once data is found
		      end
	    	end
    end
    return data
	end

end

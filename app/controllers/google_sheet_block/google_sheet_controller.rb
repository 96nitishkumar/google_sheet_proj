class GoogleSheetBlock::GoogleSheetController < ApplicationController

	def create_file
    file_name = params[:file_name]
    sheet_name = params[:sheet_name]
    type = params[:type] || "anyone"
    role = params[:role] || "reader"
    data = UserBlock::User.create_sheet(file_name, type, role, sheet_name)
    render json: {message: "file url #{data&.human_url}" }
  rescue => e
    render json: { message: "#{data[:human_url]}"}
  end 


#Country details api with all country data
  def country_details
    country_data = File.read("config/country_data.json")
    country = JSON.parse(country_data)
    render json: {country_data: country }
  end

end
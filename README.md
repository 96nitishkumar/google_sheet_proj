# README


# postman collection 

1. creat file
 
 end_point:  {{base_url}}/google_sh/create_file
 method: post
 
 body: { 
		   	"file_name":"ext_new_sheet_first",
		    "role": "writer",
		    "sheet_name":"ext-3"
		}

2. create user 

 end_pont: {{base_url}}/user_block/users

 body: { 
		    "name":"nitish",
		    "email":"nitish123@gmail.com",
		    "password":"123456",
		    "age": 25,
		    "file_name":"ext-3" // sheet name
		}

3. country details data 

 end_point: {{base_url}}/google_sheet/country_details
 method: get


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

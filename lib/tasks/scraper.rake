namespace :scraper do
  desc "TODO"
  task scrape: :environment do
  	#scraper
  	#output json
  	
	require 'open-uri'
	require 'nokogiri'
	require 'rubygems'
	require 'csv'
	require 'json'

	#Takes in search parameters and returns webscraped data
	def scrapeAirBNB(location="", pmin="", pmax="", indate="", outdate="", bednum="")

		url = "https://www.airbnb.com/s/hong-kong/homes?hosting_amenities%5B%5D=6"
		if location != ""
			url = "https://www.airbnb.com/s/#{location}/homes?hosting_amenities%5B%5D=6"
		end
		if pmin != ""
			url << "&price_min=#{pmin}"
		end
		if pmax != ""
			url << "&price_max=#{pmax}"
		end
		if indate != ""
			url << "&checkin=#{indate}"
		end
		if outdate != ""
			url << "&checkout=#{outdate}"
		end
		if bednum != ""
			url << "&adults=#{bednum}"
		end	
		puts url

		title = []
		price = [] 
		roomtype = []
		bedno = []
		links = []

		rating = []
		location = [] #e.g. central, tst, mong kok, disneyland, etc	

		#information = [title, price, roomtype, bedno]


		page = Nokogiri::HTML(open(url))

		a_tag = page.at('a')
		link = a_tag.attributes["href"].value
		#handles title and price
		counter = 1
		page.css("span.text_5mbkop-o_O-size_small_1gg2mc-o_O-weight_bold_153t78d-o_O-inline_g86r3e").each do |line|
			if (counter+1) % 3 == 0
				price << line.text.strip.delete("Price")			
				counter += 1
			elsif (counter+0) % 3 == 0
				counter += 1
			elsif (counter-1) % 3 == 0
				title << line.text.strip
				counter += 1
			end
		end

		#Handles room type and number of beds
		counter = 1
		page.css("span.detailWithoutWrap_j1kt73").each do |line|
			if (counter) % 2 == 1
				roomtype << line.text.strip
				counter += 1
			elsif (counter) % 2 == 0
				bedno << line.text.strip
				counter += 1
			end
		end

		#handles links
		counter = 1
		page.css('a').each do |line|		
			if line.attributes["href"].value[0..3] == "/roo" && counter % 2 == 0
				links << "https://www.airbnb.com" + line.attributes["href"].value
				counter += 1
			else
				counter += 1
			end
		end

		#Creates CSV files
		CSV.open("airbnb_listings.csv", "w") do |file|
			file << ["Title", "Price", "Room Type", "No. Beds", "Link", "Location"]
			price.length.times do |i|
				file << [title[i], price[i], roomtype[i], bedno[i], links[i], location[i]]
			end
		end

		#Creates JSON
		extracted_data = CSV.table('airbnb_listings.csv')
		transformed_data = extracted_data.map { |row| row.to_hash }
		File.open('airbnb.json', 'w') do |file|
	  		file.puts JSON.pretty_generate(transformed_data)
		end
	end

	scrapeAirBNB("hong-kong", "50", "1200", "2017-05-08", "2017-05-10", "1")


	  	File.open('airbnb.json','w') do |file|
	  		puts JSON.pretty_generate result[] 
	  	@post = Post.new
	  	@post.heading = 
	  	@post.body = posting["body"]
	  	@post.price = posting["price"]
	  	@post
	  end

end

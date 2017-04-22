json.extract! post, :id, :heading, :description, :price, :location, :rating, :external_url, :timestamp, :created_at, :updated_at
json.url post_url(post, format: :json)

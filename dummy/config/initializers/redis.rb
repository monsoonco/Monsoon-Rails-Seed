if Rails.env.staging? || Rails.env.production?
  Redis.current = Redis.new url: ENV['REDISTOGO_URL']
else
  Redis.current = Redis.new
end

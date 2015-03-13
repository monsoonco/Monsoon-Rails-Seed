use_lfdr = yes?('Do you want to use "Lightning Fast Deployments With Rails"' \
              ' approach (more http://blog.abuiles.com/blog/2014/07/08/lightning' \
              '-fast-deployments-with-rails/), type "yes" or "no"?')

if use_lfdr
  landinng_controller_code = <<-CODE
class LandingController < ApplicationController

  def index
    render text: index_html
  end

  private

  def index_html
    html = redis.get "\#{deploy_key}:index.html"
    insert_csrf_meta(html)

    html
  end

  def deploy_key
    params[:version] ||= 'release'
    case params[:version]
    when 'release' then 'release'
    when 'canary' then redis.lindex('releases', 0)
    else
      params[:version]
    end
  end

  def redis
    Redis.current
  end

  def insert_csrf_meta(html)
    html.insert(head_pos(html), render_to_string(inline: '<%= csrf_meta_tags %>'))
  end

  def head_pos(html)
    head_open = html.index("<head")
    html.index(">", head_open) + 1
  end
end
  CODE

  file 'app/controllers/landing_controller.rb', landinng_controller_code

  redis_initializer_code = <<-CODE
if Rails.env.staging? || Rails.env.production?
  Redis.current = Redis.new url: ENV['REDISTOGO_URL']
else
  Redis.current = Redis.new
end
  CODE

  file 'config/initializers/redis.rb', redis_initializer_code

  route "root to: 'landing#index'"
end

# ----- Gems  --------------------------------------------------------------
puts
say_status "Rubygems", "Removing unnecessary gems...\n", :yellow

# TODO: figure out a better way to remove content from files
gsub_file 'Gemfile', %r{# Use SCSS for stylesheets\n}, ''
gsub_file 'Gemfile', %r{gem 'sass-rails(.+)'\n}, ''
gsub_file 'Gemfile', %r{# Turbolinks makes following(.+)rails/turbolinks\n}, ''
gsub_file 'Gemfile', %r{gem 'turbolinks'\n}, ''
gsub_file 'Gemfile', %r{# Use sqlite3 as the database for Active Record\n}, ''
gsub_file 'Gemfile', %r{gem 'sqlite3'\n}, ''
gsub_file 'Gemfile', %r{# Use Uglifier as compressor for JavaScript assets\n}, ''
gsub_file 'Gemfile', %r{gem 'uglifier(.+)'\n}, ''
gsub_file 'Gemfile', %r{# Use CoffeeScript for .js.coffee assets and views\n}, ''
gsub_file 'Gemfile', %r{gem 'coffee-rails(.+)'\n}, ''
gsub_file 'Gemfile', %r{# Use jquery as the JavaScript library\n}, ''
gsub_file 'Gemfile', %r{gem 'jquery-rails'\n}, ''

puts
say_status "Rubygems", "Adding libraries into Gemfile...\n", :yellow
puts        '-'*80, ''; sleep 0.75

gem 'redis'
gem 'pg'
gem 'redis-objects'
gem 'active_model_serializers'
gem_group :test do
  gem 'fakeredis', require: 'fakeredis/rspec'
end

# ----- Git  ---------------------------------------------------------------
git :init
git add:    "."
git commit: "-m 'Initial commit: Clean application'"

# ----- Success  -----------------------------------------------------------
puts 'Project successfully scaffolded'

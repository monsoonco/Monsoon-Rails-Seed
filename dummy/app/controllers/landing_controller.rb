class LandingController < ApplicationController

  def index
    render text: index_html
  end

  private

  def index_html
    html = redis.get "#{deploy_key}:index.html"
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

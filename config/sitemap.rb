require 'net/http'
require 'json'
SitemapGenerator::Sitemap.default_host = "https://www.wixenco.com"

def fetch_blog_urls
  uri = URI('https://api.wixenco.com/blogs')
  response = Net::HTTP.get(uri)
  blog_posts = JSON.parse(response)

  blog_posts.map { |post| "/blog/#{post['slug']}" }
end

blog_urls = fetch_blog_urls()

SitemapGenerator::Sitemap.create do
  # Add paths to your React app pages
  add '/', :changefreq => 'daily', :priority => 1.0
  add '/site-analysis', :changefreq => 'weekly'
  add '/blog', :changefreq => 'weekly'

  blog_urls.each do |blog_url|
    add blog_url, :changefreq => 'daily'
  end

  # You can add more paths here
end

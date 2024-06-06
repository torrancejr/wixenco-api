# config/sitemap.rb
SitemapGenerator::Sitemap.default_host = "https://www.wixenco.com"

SitemapGenerator::Sitemap.create do
  # Add paths to your React app pages
  add '/', :changefreq => 'daily', :priority => 1.0
  add '/site-analysis', :changefreq => 'weekly'
  add '/blog', :changefreq => 'weekly'

  # You can add more paths here
end
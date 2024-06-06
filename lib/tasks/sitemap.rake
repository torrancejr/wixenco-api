# lib/tasks/sitemap.rake
namespace :sitemap do
  desc "Generate sitemap"
  task generate: :environment do
    require 'sitemap_generator'
    SitemapGenerator::Sitemap.default_host = "https://www.wixenco.com"
    SitemapGenerator::Sitemap.create do
      add '/', :changefreq => 'daily', :priority => 1.0
      add '/site-analysis', :changefreq => 'weekly'
      add '/blog', :changefreq => 'weekly'

      # You can add more paths here
    end
  end
end

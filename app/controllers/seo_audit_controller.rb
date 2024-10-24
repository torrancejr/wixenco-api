class SeoAuditController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  # GET /seo_audit
  def index
    # Display the form to input the website URL for the SEO audit
  end

  # POST /seo_audit/analyze
  def analyze
    url = params[:url]

    if url.blank?
      render json: { error: "URL can't be blank" }, status: :bad_request
      return
    end

    begin
      # Fetch the HTML content of the website
      html = URI.open(url)
      document = Nokogiri::HTML(html)

      # Perform analysis
      analysis = {
        title: fetch_title(document),
        meta_description: fetch_meta_description(document),
        keyword_usage: analyze_keyword_usage(document),
        headings: analyze_headings(document),
        alt_texts: analyze_alt_texts(document),
        internal_links: analyze_internal_links(document)
      }

      render json: { data: analysis, message: 'SEO analysis completed successfully' }, status: :ok
    rescue StandardError => e
      render json: { error: "Failed to analyze the website. Error: #{e.message}" }, status: :unprocessable_entity
    end
  end

  private

  # Fetches the title tag
  def fetch_title(document)
    document.at('title')&.text || "No title tag found"
  end

  # Fetches the meta description
  def fetch_meta_description(document)
    meta = document.at('meta[name="description"]')
    meta ? meta['content'] : "No meta description found"
  end

  # Analyzes the keyword usage in the page content
  def analyze_keyword_usage(document)
    # Example: You can enhance this to analyze specific keywords or provide a keyword density analysis.
    text_content = document.text
    word_count = text_content.split.size
    keywords = ["example", "keyword"] # Replace with dynamic input or configuration
    keyword_counts = keywords.each_with_object({}) do |keyword, counts|
      counts[keyword] = text_content.scan(/\b#{keyword}\b/i).size
    end

    { word_count: word_count, keyword_counts: keyword_counts }
  end

  # Analyzes the heading structure (H1, H2, H3, etc.)
  def analyze_headings(document)
    headings = {}
    (1..6).each do |i|
      headings["h#{i}"] = document.css("h#{i}").map(&:text)
    end
    headings
  end

  # Checks for the presence of alt text in image tags
  def analyze_alt_texts(document)
    images = document.css('img')
    images_with_missing_alt = images.select { |img| img['alt'].blank? }

    {
      total_images: images.size,
      images_with_missing_alt: images_with_missing_alt.size,
      percentage_with_alt: ((images.size - images_with_missing_alt.size) / images.size.to_f * 100).round(2)
    }
  end

  # Analyzes internal links on the page
  def analyze_internal_links(document)
    links = document.css('a').map { |link| link['href'] }.compact
    internal_links = links.select { |link| link.start_with?('/') || link.include?(URI.parse(params[:url]).host) }

    {
      total_links: links.size,
      internal_links: internal_links.size,
      external_links: links.size - internal_links.size
    }
  end
end

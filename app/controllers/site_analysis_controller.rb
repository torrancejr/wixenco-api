class SiteAnalysisController < ApplicationController
  require 'httparty'

  def analyze
    url = params[:url]
    api_key = ENV['PAGESPEED_API']
    api_url = "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=#{url}&key=#{api_key}&category=performance&category=accessibility&category=best-practices&category=seo"

    begin
      response = HTTParty.get(api_url, timeout: 300)  # Set timeout to 300 seconds (5 minutes) # Log the response for debugging
      if response.success?
        render json: response.parsed_response
      else
        render json: { error: 'Error fetching data from PageSpeed Insights' }, status: :bad_request
      end
    rescue Net::ReadTimeout, Net::OpenTimeout
      render json: { error: 'Request timed out. Please try again later.' }, status: :request_timeout
    rescue => e
      render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
    end
  end
end



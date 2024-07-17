class RankingsController < ApplicationController
  require 'httparty'

  def fetch_rank
    domain = params[:domain]
    api_key = ENV["SERP_API"]
    query = "site:#{domain}"

    response = HTTParty.get("https://api.scaleserp.com/search", {
      query: {
        api_key: api_key,
        q: query
      }
    })

    if response.success?
      organic_results = response['organic_results']
      render json: { results: organic_results }
    else
      render json: { error: "Unable to fetch rank" }, status: :bad_request
    end
  end
end


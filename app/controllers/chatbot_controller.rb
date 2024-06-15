require 'open3'

class ChatbotController < ApplicationController
  skip_before_action :verify_authenticity_token

  def respond
    user_message = params[:message]
    response_message = get_response_from_model(user_message)
    Rails.logger.info("Response message: #{response_message}")
    render json: { response: response_message }
  end

  private

  def get_response_from_model(message)
    script_path = Rails.root.join('scripts', 'chatbot_openai.py')
    command = "python3 #{script_path} \"#{message}\""
    stdout, stderr, status = Open3.capture3(command)
    Rails.logger.info("Command: #{command}")
    Rails.logger.info("STDOUT: #{stdout}")
    Rails.logger.info("STDERR: #{stderr}")
    Rails.logger.info("Status: #{status}")

    if status.success?
      stdout.strip
    else
      "Error: #{stderr.strip}"
    end
  end
end







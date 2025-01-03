# scripts/chatbot_openai.py
from openai import OpenAI

client = OpenAI()
import sys
import logging
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()

# Configure logging
logging.basicConfig(filename='chatbot_openai.log', level=logging.DEBUG)


def get_response(prompt):
    if "located" in prompt.lower():
        return "West Chester, PA, but we cater to clients across all 50 states."

    if any(phrase in prompt.lower() for phrase in ["speak with someone", "contact you", "get in touch", "reach you", "talk to someone", "contact"]):
        return "You can reach us at 610-656-5293 or by email at ryan@wixenco.com and we will respond promptly."

    if any(phrase in prompt.lower() for phrase in ["business hours", "when are you open", "operating hours"]):
        return "Our business hours are Monday to Friday, 9 AM to 5 PM EST."

    if any(phrase in prompt.lower() for phrase in ["services do you offer", "tell me about your services", "services"]):
        return "We offer custom website design and development, advanced SEO, chatbot development and integration, and comprehensive Google services and analytics."

    if any(phrase in prompt.lower() for phrase in ["how much do your services cost", "what are your rates", "pricing information", "cost"]):
        return "Our pricing varies depending on the scope and complexity of the project. Please contact us for a detailed quote."

    if any(phrase in prompt.lower() for phrase in ["how long will it take", "turnaround time", "project completion time"]):
        return "The turnaround time depends on the project’s requirements. Typically, website design projects take 4-6 weeks from start to finish."

    if any(phrase in prompt.lower() for phrase in ["client testimonials", "reviews from your clients"]):
        return "Yes, you can read our client testimonials on our website's testimonials page."

    if any(phrase in prompt.lower() for phrase in ["refund policy", "do you offer refunds", "refund", "refunds"]):
        return "We offer a satisfaction guarantee. If you are not satisfied with our services, please contact us within 30 days, and we will address your concerns."

    # Use the correct OpenAI method
    response = client.chat.completions.create(model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": prompt},
    ],
    max_tokens=150)
    return response.choices[0].message.content.strip()


if __name__ == "__main__":
    prompt = sys.argv[1]
    logging.debug(f"Received prompt: {prompt}")
    response = get_response(prompt)
    logging.debug(f"Response: {response}")
    print(response)
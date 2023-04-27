class ShortenedUrlsController < ApplicationController
    # Encodes a URL to a shortened URL 
    def encode
      shortened_url = ShortenedUrl.create(original_url: params[:original_url], short_url: generate_short_url)
      render json: { short_url: shortened_url.short_url }
    end
    
    # Decodes a shortened URL to its original URL
    def decode
      shortened_url = ShortenedUrl.find_by(short_url: params[:short_url])
      render json: { original_url: shortened_url.original_url }
    end
    
    private
    
    # Generate a random short url
    def generate_short_url
      # Generate a random string of 6 characters for the short URL
      charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
      Array.new(6) { charset.sample }.join
    end
  end
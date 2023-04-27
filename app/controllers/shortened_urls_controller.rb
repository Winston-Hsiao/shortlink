class ShortenedUrlsController < ApplicationController
    # Encodes a URL to a shortened URL 
    def encode
      shortened_url = ShortenedUrl.create(original_url: params[:original_url], short_url: generate_short_url)
      render json: { short_url: shortened_url.short_url }
    end
    
    # Decodes a shortened URL to its original URL
    def decode
      shortened_url = ShortenedUrl.find_by(short_url: params[:short_url])
      if shortened_url # check if shortened URL exists in database and return if true
        render json: { original_url: shortened_url.original_url }
      else 
        render json: { error: "Invalid short link" }, status: :not_found
      end
    end
    
    private
    
    # Generate a random short URL
    def generate_short_url
      # Generate a random string of 6 characters for end of short URL 
      # Examples: short.li/AbcDEF
      url_characters = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
      path = (0...6).map { url_characters.sample }.join
      "http://short.li/#{path}"
    end
  end
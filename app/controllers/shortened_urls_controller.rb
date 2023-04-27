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
    # Generate a random short URL ( example: short.li/AbcDeF )
    def generate_short_url
      # Characters to choose from for path generation
      url_characters = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
      
      loop do
        # Generate a random path of 6 characters for the short URL 
        path = (0...6).map { url_characters.sample }.join
    
        # Check if the path already exists in the database
        existing_url = ShortenedUrl.find_by(short_url: "short.li/#{path}")
        return "https://short.li/#{path}" unless existing_url
    
        # If the path already exists, generate a new path and check again
      end
    end
  end
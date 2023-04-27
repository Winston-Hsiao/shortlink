# shortlink
By Winston Hsiao
April 2023
Built and Tested with Ruby v3.2.2 and Rails v7.0.4.3 on a 2021 M1 MacBook Pro

## Setup/How to Run
Instructions for Mac
1. Ensure that compatible versions of Ruby and Rails are installed on local device.
	- run `ruby -v` and `rails -v` in terminal to check versions.
	- [Link to Ruby on Rails Setup](https://guides.rubyonrails.org/v5.1/getting_started.html)
2. Clone the repository
3. Navigate to shortlink directory
4. run `rails server` to run shortlink on `http://localhost:3000`
5. Post requests can then be made via an API testing platform like [Postman](https://www.postman.com/)


## Testing
While application is running on `http://localhost:3000` by running  `rails server`,
open [Postman's Desktop Agent](https://www.postman.com/downloads/postman-agent/) and test by sending post requests to encode and decode endpoints.

### Testing Encode:
Send a POST request to encode endpoint `http://localhost:3000/encode` with a JSON body containing a link to be shortened. Example below:
```
{
	"original_url": "https://www.youtube.com"
}
```
A JSON response containing the shortened URL is returned. Example below:
```
{
	"short_url": "http://short.li/IcRLmw"
}
```

### Testing Decode:
Send a POST request to decode endpoint `http://localhost:3000/decode` with a JSON body containing shortened URL. Example below:
```
{
	"short_url": "http://short.li/IcRLmw"
}
```

### Tests performed/Design Choices
**Existing original url**
Expected behavior: 
- When making a POST request using an original url identical to one existing in the database, a new short link will be returned every time.

Reasoning: 
- If a user wants to create a shortened link they might want to track the number of clicks on that link. This value would be stored with the ShortenedURL object containing the original_url and the unique short_url. It would not make sense to prevent a user from creating a new short link for an original link that has already been shortened (would cause overlap and issues with analytics tracking if implemented)

**Duplicate Short Url Generation**
- Implementation will not allow for duplicate short URL's to be generated. If by chance during function runtime a short link is generated that matches an existing short link in the database, it will not be returned, and a new link will be generated with a different path.

**Invalid Short Url to be decoded**
- POST requests sent to the decode endpoint with a short link that does not exist in the database will return the below error.
```
{
	"error": "Invalid short link"
}
```

Example URL's tested:
```
{
	"short_url": "http://short.li/ABCDEF"
}
```

```
{
	"short_url": "ABCDEF"
}
```

If the "short_url": field is not present in the JSON body, a standard bad request error is thrown.
Example:
```
{
	"http://short.li/ABCDEF"
}
```



## Database
Database is hosted locally using SQLite3 but is interchangeable with other database options such as MySQL, PostgreSQL, etc.

The database consists of ShortenedURL objects containing 2 string entries "original_url" and "short_url".

To view URL's stored in the database:
1. run `rails console`
2. once in the Rails console run `ShortenedURL.all` to return all ShortenedURL objects
3. run `exit` to exit the rails console.

Below is an example entry in the database.
```
  id: 1,                                                                
  original_url: "https://www.youtube.com",                              
  short_url: "http://short.li/IcRLmw",                                  
  created_at: Thu, 27 Apr 2023 20:13:58.166492000 UTC +00:00,           
  updated_at: Thu, 27 Apr 2023 20:13:58.166492000 UTC +00:00
  ```

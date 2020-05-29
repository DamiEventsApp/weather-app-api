# Endpoints
There are 4 endpointsavailable controllers that intercept and handle requests:

### POST `/auth/login`
#### Required Parameters
* `email`(string)
* `password`(alphanumeric)


### POST `/events`
#### Required Parameters
* `title`(string)
* `date`(string)
* `location`(string)

### PUT `/events/:id`
#### Required Parameters
* `id`(int)

### GET `/events`
#### Required Parameters
* (none)

### DELETE `/events/:id`
#### Required Parameters
* `id`(int)(event id)


### GET `/search_events`
#### Required Parameters
* `date`(string)
* `term`(string)
* This endpoint requires either one of the to listed above. Date must be formatted as `Epoch Timestamp` *

* GET `/todays_events`
#### Required Parameters
* `today`(bool)

These endpoints are fully tested and can be verified using by running the `requests` test suite:
* Setup as described [here](../README.md)
* `cd` into the project directory(you should be here if you setup correctly)
* run `rspec spec/requests`

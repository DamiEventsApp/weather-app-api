# Authentication and Authorization
Authentication and Authorization is handled by JWT token validation. There are 3 custom singletons involved here:
* JsonWebToken
* AuthenticateUser
* Authorize API Request

These 3 singletons are fully tested and can be verified using by running the `auth` test suite:
* Setup as described [here](../README.md)
* `cd` into the project directory(you should be here if you setup correctly)
* run `rspec spec/auth`

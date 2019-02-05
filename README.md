# Hey Beach

Collection of the world's most beautiful beaches

## Project structure

The project follows MVP architecture pattern.

Network Layer is responsible for making API calls.

NetworkService is used as an access point to Network Layer.

Storage is an abstraction for kev-value data persistanse.

KeychainStorage is used to store auth token.  

## Getting Started

Projct has one scheme HeyBeach for testing and running.

Project has no external dependencies.

## Testing

Tests are presented in the main 'HeyBeach' scheme.

Network Layer is covered by 'NetworkService' Test.

Responses are mocked with .json files.

Update ImageListResponse.json to test against custom response.

# Rails Twitter Clon

## Team

- Cesar
- Carlos Sandoval
- Brayan
- Jefferson
- Angie

## Acceptant Criteria

- It should expose all resources in those applications.
- It should have tests.
- It shouldnt' be created using scaffold.
- It should only reply with JSON, not HTML.

## Resources

### Required resources:

- Users
- Tweets
- Replies

### Optional:

- Likes
- RT

### Routes:

<----MODEL----> | <----VERB----> | <----ROUTES----> |
USER GET /users
GET /users/id
GET /users/id/follows
POST /users
POST /users/id/follows
PATCH /users/id
PUT /users/id
DELETE /users/id
DELETE /users/id/follows/id
TWEET GET /tweets
GET /tweets/id
POST /tweets
PATCH /tweets/id
PUT /tweets/id
DELETE /tweets/id
LIKE GET /likes
GET /likes/id
POST /likes
DELETE /likes/id

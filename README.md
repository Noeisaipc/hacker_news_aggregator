# HackerNewsAggregator

To build project from source:

```bash
$ mix deps.get
$ mix compile
```

### Building phoenix.js

```bash
$ cd apps/hacker_news_web/assets
$ npm install
```

### Running Umbrella App

```bash
$ iex -S mix phx.server
```

# Pull request
Before send a pull request you must do the following steps
```bash
$ mix credo -a
$ mix format
```
> You should resolve warnings from credo before send a request

# Using Endpoints

You can test the endpoints with the following curl's

Or see documentation in the following url https://app.swaggerhub.com/apis/Noeisaipc/hacker-news_aggregator/1.0.0#/

```bash
curl -X 'GET' \
  'http://localhost:4000/api/news?page=1' \
  -H 'accept: application/json'

curl -X 'GET' \
  'http://localhost:4000/api/news/{id_story}' \
  -H 'accept: application/json'
```
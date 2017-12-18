#### Event Scoring is an app that attempts to satisfy [the requirements in this gist](https://gist.github.com/mattp88/19080bb098e549e862890f1cd5834339)

I'm attempting to show off basic implementations for various libs in the elixir ecosystem such as:

* GenStage - queue up webhook events for consumer(s) to then process
* Registry - allows for dynamic process creation so each "user" (event spawner) can hold their score in their own process
* Channels - basic websocket pushing for live updating clients when webhook events are recieved

#### To get this up and working

1. Get a temporary access token from github [here](https://github.com/blog/1509-personal-api-tokens) (that way you can avoid putting your real password anywhere in the config)
2. start up some sort of local tunnel or something so that you can give github a working URL for their callback trigger to send POST requests to.  I recommend using [ngrok](https://ngrok.com/)
3. create a `config/dev.secret.exs` - this is where you'll store your temporary api token from github:
```
# dev.secret.exs
Mix.Config
config :event_scoring, github_api_token: "this should be your access token"
```
4. configure your dev env with your callback url (this is what will be passed to github to tell them where to POST back events)
```
#config/dev.ex
...
config :event_scoring, callback_url_base: "https://a6214288.ngrok.io" # make this your callback url
...
```
5. compile your dependencies and start it up....you should now be able to hit `localhost:4000` and enter your account and a repo you own to create a webhook...then go do stuff to that repo (I suggest maybe making a test repo so you aren't blasting people who follow your real repo's with trash updates) if everything is setup properly you'll get live updates as to what's going on

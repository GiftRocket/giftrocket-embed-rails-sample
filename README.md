### GiftRocket Embed Rails Sample App
-----

This is a sample implementation of the GiftRocket Embed module within a Rails application.

[View the demo here](https://www.giftrocket.com/rewards/embed/demo)

### Getting Started

First, to receive your api keys, sign up through the [GiftRocket corporate rewards website](https://www.giftrocket.com/rewards/).

Within your account [API settings page](https://www.giftrocket.com/rewards/dashboard/settings/api/keys), you will be able to view your sandbox public key for the Embed SDK as well as the sandbox private key for the REST API.

### Configuration

Add an .env file within this project's root with the follow envvars:

```
GIFTROCKET_REST_API_HOST=https://testflight.giftrocket.com/api/v1/
GIFTROCKET_API_PRIVATE_KEY=YOUR_SANDBOX_API_PRIVATE_KEY
GIFTROCKET_EMBED_PUBLIC_KEY=YOUR_EMBED_SANDBOX_PUBLIC_KEY
```

### Build

```
bundle
rake db:migrate
rake catalog_update
```

### Run Server

`rails s`


### Getting Started

The heart of the integration is located in a combination of `rewards_controller.rb` and the associated rewards views.

At a high level, most of the reward data (amount, currency, etc.) is encrypted on the back-end as a [JWT](https://jwt.io/). The JWT is passed to the embed client SDK to create a reward from the client (see `new.html.erb` for an example).

### Additional Documentation

The Embed client documentation can be found [here](https://github.com/GiftRocket/embed)
The API REST documentation can be found [here](https://www.giftrocket.com/docs)

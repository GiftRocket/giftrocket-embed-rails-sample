### GiftRocket Embed Rails Sample App
-----

This is a simple implementation of the GiftRocket Embed module within a sample Rails application.
The intention here is to allow a Rails developer kick start their integration.

[View the demo here](https://www.giftrocket.com/rewards/embed/demo)

### Getting Started

First, to receive your api keys, sign up through the [GiftRocket corporate rewards website](https://www.giftrocket.com/rewards/).

Within your account [API settings page](https://www.giftrocket.com/rewards/dashboard/settings/api/keys), you will be able to view your sandbox public key for the Embed SDK as well as the sandbox private key for the REST API.

### Configuration

Add a .env file within this project's root with the follow envvars:

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


### Additional Documentation

The Embed client documentation can be found [here](https://github.com/GiftRocket/embed)

The API REST documentation can be found [here](https://www.giftrocket.com/docs)

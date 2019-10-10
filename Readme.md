ubuntu-truffleruby
------

The one-stop truffleruby docker image, partner.

![cowboy](https://media.giphy.com/media/cdNSp4L5vCU7aQrYnV/giphy.gif)

# Features:

* ubuntu 18.04 base image
* non-root `appuser` with rbenv installed in profile
* truffleruby installed via rbenv

## Installation

```bash
docker pull tlrasor/ubuntu-truffleruby
```

## Quickness

```bash
docker run -it tlrasor/ubuntu-truffleruby ruby
```

You will be placed into the home directory of the appuser. This is a safe place to put apps without having to deal with root permissions.

## Suggested Usage

Use this image as a base image and copy in your app to the home dir

```Dockerfile
FROM tlrasor/ubuntu-truffleruby
COPY . $HOME/app
WORKDIR $HOME/app

# need root for chown here, might not be necessary depending on your use case
USER root
RUN chown -R appuser:appgroup $HOME/app
USER appuser

RUN echo "truffleruby-19.2.0.1" > $HOME/app/.ruby-version
```

Now your project will run with truffle.

* See [rbenv documentation](https://github.com/rbenv/rbenv/blob/master/README.md) for how to install rubies
* See [truffleruby documentation](https://github.com/oracle/truffleruby/blob/master/README.md) for truffle knowledge

## Contributing

1. Fork it (<https://github.com/tlrasor/ubuntu-truffleruby/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

[Unlicense](https://unlicense.org/)

## Contributors

- [Travis Rasor](https://github.com/tlrasor) - creator and maintainer


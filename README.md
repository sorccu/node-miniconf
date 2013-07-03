# node-miniconf

**node-miniconf** is a simple configuration module for reading configuration files in a `NODE_ENV` friendly fashion. Conventions are enforced; the module itself is unconfigurable. This approach makes it very easy to use when your app consists of multiple smaller apps. While the configuration files remain separate, at the very least you don't need to configure your configuration loader in every project.

While the module itself is written in CoffeeScript, the NPM version is pure JavaScript.

## Rules

1. Your main configuration file will be loaded with a call to `require('<path>/config')`, where `<path>` is the folder your `package.json` resides in. The require will attempt to load `<path>/config.{js,json}` and `<path>/config/index.{js,json}` among others. For example, if you're using [CoffeeScript][coffeescript], `<path>/config.coffee` will also be checked.
    * When using a JSON file, the loaded object will be used as-is.
    * When using another type of file, it must export an object, which will then be used as-is.
2. If the `NODE_ENV` environment variable is set, one more call to `require('<path>/config/<env>')` will be made. Again, the same loading rules apply here.
3. The configuration values are recursively merged, with the `NODE_ENV` values taking precedence.
4. The merged object is returned. This is what you get when you require the module. As per the way `require()` works, the object will then stay cached in memory for future requires.

## Example

`config/index.json`

```json
{
  "redis": {
    "host": "127.0.0.1",
    "port": 6379
  }
}
```

`config/production.json`

```json
{
  "redis": {
    "host": "redis.example.org"
  }
}
```

```coffeescript
conf = require 'miniconf'

conf.redis.host is 'redis.example.org'
conf.redis.port is 6379
```

## License

MIT License. See `LICENSE` for more information.

[coffeescript]: <http://coffeescript.org/>

# node-miniconf

**node-miniconf** is a simple configuration module for reading configuration files in a `NODE_ENV` friendly fashion. Conventions are enforced; the module itself is unconfigurable. This approach makes it very easy to use when your app consists of multiple smaller apps. While the configuration files remain separate, at the very least you don't need to configure your configuration loader in every project.

While the module itself is written in CoffeeScript, the NPM version is pure JavaScript.

## Installation

Install from NPM. The NPM module name is `miniconf`:

```bash
npm install miniconf --save
```

## Rules

1. Your main configuration file will be loaded with a call to `require('<path>/config')`, where `<path>` is the folder your `package.json` resides in. The require will attempt to load `<path>/config.{js,json}` and `<path>/config/index.{js,json}` among others. For example, if you're using [CoffeeScript][coffeescript], `<path>/config.coffee` will also be checked.
    * When using a JSON file, the loaded object will be used as-is.
    * When using another type of file, it must export an object, which will then be used as-is.
2. If the `NODE_ENV` environment variable is set, one more call to `require('<path>/config/<env>')` will be made. Again, the same loading rules apply here.
3. The configuration values are recursively merged, with the `NODE_ENV` values taking precedence.
4. The merged object is returned. This is what you get when you require the module. As per the way `require()` works, the object will then stay cached in memory for future requires.

## Example

`config/index.json`:

```json
{
  "redis": {
    "host": "127.0.0.1",
    "port": 6379
  }
}
```

`config/production.json`:

```json
{
  "redis": {
    "host": "redis.example.org"
  }
}
```

`NODE_ENV=production coffee`:

```coffeescript
conf = require 'miniconf'

conf.redis.host is 'redis.example.org'
conf.redis.port is 6379
```

## License

### MIT License

Copyright (c) 2013 Simo Kinnunen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

[coffeescript]: <http://coffeescript.org/>

Path = require 'path'

module.exports = switch Path.extname __filename
  when '.coffee' then require './src/miniconf'
  else require './lib/miniconf'

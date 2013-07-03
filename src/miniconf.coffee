Path = require 'path'
findup = require 'findup-sync'

merge = require './util/merge'

module.exports = do ->
  base = Path.dirname findup('package.json')
  config = require Path.join(base, 'config')

  if process.env.NODE_ENV
    try
      merge config, require Path.join(base, 'config', process.env.NODE_ENV)
    catch err
      throw err unless err.code is 'MODULE_NOT_FOUND'

  return config

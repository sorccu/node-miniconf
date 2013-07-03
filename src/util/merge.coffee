merge = (a, b) ->
  for key, val of b
    if b.hasOwnProperty key
      if a.hasOwnProperty key
        if typeof val is 'object' and not Array.isArray val
          merge a[key], val
        else
          a[key] = val
      else
        a[key] = val
  return a

module.exports = merge

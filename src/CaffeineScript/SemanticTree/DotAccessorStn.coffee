Foundation = require 'art-foundation'

{log, a, w, m, defineModule, compactFlatten, present, isFunction, BaseObject} = Foundation

defineModule module, class DotAccessorStn extends require './BaseStn'

  constructor: (props, [@value, @identier]) ->
    super

  toJs: ->
    throw new Error "value and identier expected" unless @value and @identier
    "#{@value.toJsExpression()}.#{@identier.toJs()}"
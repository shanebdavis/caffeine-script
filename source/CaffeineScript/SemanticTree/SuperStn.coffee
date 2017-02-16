Foundation = require 'art-foundation'

{log, a, w, m, defineModule, compactFlatten, present, isFunction, BaseObject, merge} = Foundation

defineModule module, class SuperStn extends require './BaseStn'

  constructor: (props, @args) ->
    # collapse implicit arrays into parents
    if @args.length == 1 && @args[0].props.implicitArray
      @args = @args[0].children
    super

  needsParens: false

  transform: ->
    throw new Error "super must be used inside an object-literal value" unless propValue = @findParent "ObjectPropValue"
    # TODO: we should validate that propName has a legal value string

    methodName = propValue.labeledChildren.propName.props.value
    [__, methodName] = m if m = methodName.match /^@(.*)/
    new @class merge(@props, methodName: methodName), @transformChildren()

  toJs: ->
    {args} = @
    method = if @props.passArguments
      args = "arguments"
      "apply"
    else
      args = (a.toJsExpression() for a in args)
      "call"

    "Caf.getSuper().#{@props.methodName}.#{method}#{@applyRequiredParens ['this'].concat(args).join ', '}"
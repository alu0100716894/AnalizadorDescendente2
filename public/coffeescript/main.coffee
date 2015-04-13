(->
  main = undefined
  parse = undefined

  main = ->
    result = undefined
    source = undefined
    source = original.value
    try
      result = JSON.stringify(parse(source), null, 2)
    catch _error
      result = _error
      result = '<div class="error">' + result + '</div>'
    OUTPUT.innerHTML = result

  window.onload = ->
    PARSE.onclick = main
  
 
  Object.constructor::error = (message, t) ->
    t = t or this
    t.name = 'SyntaxError'
    t.message = message
    throw treturn
    return

  RegExp::bexec = (str) ->
    i = undefined
    m = undefined
    i = @lastIndex
    m = @exec(str)
    if m and m.index == i
      return m
    null

  String::tokens = ->
    RESERVED_WORD = undefined
    from = undefined
    getTok = undefined
    i = undefined
    key = undefined
    m = undefined
    make = undefined
    n = undefined
    result = undefined
    rw = undefined
    tokens = undefined
    value = undefined
    from = undefined
    i = 0
    n = undefined
    m = undefined
    result = []
    tokens =
      WHITES: /\s+/g
      ID: /[a-zA-Z_]\w*/g
      NUM: /\b\d+(\.\d*)?([eE][+-]?\d+)?\b/g
      STRING: /('(\\.|[^'])*'|"(\\.|[^"])*")/g
      ONELINECOMMENT: /\/\/.*/g
      MULTIPLELINECOMMENT: /\/[*](.|\n)*?[*]\//g
      COMPARISONOPERATOR: /[<>=!]=|[<>]/g
      ONECHAROPERATORS: /([-+*\/=()&|;:,{}[\]])/g
    RESERVED_WORD =
      p: 'P'
      'if': 'IF'
      then: 'THEN'

    make = (type, value) ->
      {
        type: type
        value: value
        from: from
        to: i
      }

    getTok = ->
      str = undefined
      str = m[0]
      i += str.length
      str

    if !this
      return
    while i < @length
      for key of tokens
        `key = key`
        value = tokens[key]
        value.lastIndex = i
      from = i
      if m = tokens.WHITES.bexec(this) or (m = tokens.ONELINECOMMENT.bexec(this)) or (m = tokens.MULTIPLELINECOMMENT.bexec(this))
        getTok()
      else if m = tokens.ID.bexec(this)
        rw = RESERVED_WORD[m[0]]
        if rw
          result.push make(rw, getTok())
        else
          result.push make('ID', getTok())
      else if m = tokens.NUM.bexec(this)
        n = +getTok()
        if isFinite(n)
          result.push make('NUM', n)
        else
          make('NUM', m[0]).error 'Bad number'
      else if m = tokens.STRING.bexec(this)
        result.push make('STRING', getTok().replace(/^["']|["']$/g, ''))
      else if m = tokens.COMPARISONOPERATOR.bexec(this)
        result.push make('COMPARISON', getTok())
      else if m = tokens.ONECHAROPERATORS.bexec(this)
        result.push make(m[0], getTok())
      else
        throw 'Syntax error near \'' + @substr(i) + '\''
    result

  parse = (input) ->
    condition = undefined
    expression = undefined
    factor = undefined
    lookahead = undefined
    match = undefined
    statement = undefined
    statements = undefined
    term = undefined
    tokens = undefined
    tree = undefined
    tokens = input.tokens()
    lookahead = tokens.shift()

    match = (t) ->
      if lookahead.type == t
        lookahead = tokens.shift()
        if typeof lookahead == 'undefined'
          lookahead = null
      else
        throw 'Syntax Error. Expected ' + t + ' found \'' + lookahead.value + '\' near \'' + input.substr(lookahead.from) + '\''
      return

    statements = ->
      result = undefined
      result = [ statement() ]
      while lookahead and lookahead.type == ';'
        match ';'
        result.push statement()
      if result.length == 1
        result[0]
      else
        result

    statement = ->
      left = undefined
      result = undefined
      right = undefined
      result = null
      if lookahead and lookahead.type == 'ID'
        left =
          type: 'ID'
          value: lookahead.value
        match 'ID'
        match '='
        right = expression()
        result =
          type: '='
          left: left
          right: right
      else if lookahead and lookahead.type == 'P'
        match 'P'
        right = expression()
        result =
          type: 'P'
          value: right
      else if lookahead and lookahead.type == 'IF'
        match 'IF'
        left = condition()
        match 'THEN'
        right = statement()
        result =
          type: 'IF'
          left: left
          right: right
      else
        throw 'Syntax Error. Expected identifier but found ' + (if lookahead then lookahead.value else 'end of input') + ' near \'' + input.substr(lookahead.from) + '\''
      result

    condition = ->
      left = undefined
      result = undefined
      right = undefined
      type = undefined
      left = expression()
      type = lookahead.value
      match 'COMPARISON'
      right = expression()
      result =
        type: type
        left: left
        right: right
      result

    expression = ->
      result = undefined
      right = undefined
      result = term()
      if lookahead and lookahead.type == '+'
        match '+'
        right = expression()
        result =
          type: '+'
          left: result
          right: right
      result

    term = ->
      result = undefined
      right = undefined
      result = factor()
      if lookahead and lookahead.type == '*'
        match '*'
        right = term()
        result =
          type: '*'
          left: result
          right: right
      result

    factor = ->
      result = undefined
      result = null
      if lookahead.type == 'NUM'
        result =
          type: 'NUM'
          value: lookahead.value
        match 'NUM'
      else if lookahead.type == 'ID'
        result =
          type: 'ID'
          value: lookahead.value
        match 'ID'
      else if lookahead.type == '('
        match '('
        result = expression()
        match ')'
      else
        throw 'Syntax Error. Expected number or identifier or \'(\' but found ' + (if lookahead then lookahead.value else 'end of input') + ' near \'' + input.substr(lookahead.from) + '\''
      result

    tree = statements(input)
    if lookahead != null
      throw 'Syntax Error parsing statements. ' + 'Expected \'end of input\' and found \'' + input.substr(lookahead.from) + '\''
    tree

  return
).call this

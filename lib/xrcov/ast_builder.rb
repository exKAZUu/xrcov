module AstBuilder
  def create_string(str, ldelim = "'", rdelim = "'")
    Ruby::String.new(Ruby::StringContent.new(str), 
        Ruby::Token.new(ldelim), Ruby::Token.new(rdelim))
  end

  def create_prolog(str)
    Ruby::Prolog.new(Ruby::Token.new(str))
  end

  def create_statements(target)
    Ruby::Statements.new(target, Ruby::Token.new('('), Ruby::Token.new(')'))
  end

  def create_argslist(args)
    delim = nil
    args = args.map { |a|
      arg = Ruby::Arg.new(a, delim)
      delim ||= Ruby::Token.new(',')
      arg
    }
    lpar = Ruby::Token.new('(')
    rpar = Ruby::Token.new(')')
    Ruby::ArgsList.new(args, lpar, rpar)
  end

  def create_call(args, name)
    args = create_argslist(args)
    ident = Ruby::Identifier.new(name)
    Ruby::Call.new(nil, nil, ident, args)
  end

  def create_call_for_replacing(target, args, name)
    call = create_call(args, name)
    call.position = target.position
    call.prolog = target.prolog
    call
  end
end

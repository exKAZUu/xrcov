module StatementCoverage
  def create_coverage_stmts(type, target, name, tag, child_range = (0...0))
    @info.elems << CoverageElement.new(type, @src_path, target.position, tag, child_range)
    args = [
      Ruby::Integer.new(next_id()),
      Ruby::Integer.new(type),
    ]
    call = create_call(args, name)
    stmts = create_statements([call, target])
    stmts.prolog = target.prolog
    stmts
  end

  def is_special_prolog?(p)
    !p.nil? && p.elements.size > 0 && p.elements[0].token == '::'
  end

  def insert_statement_coverage(cov_func_name)
    targets = @ast.select(Ruby::Statements)
    # must process nested targets before enclosing targets(revers) to treat :: correctly
    targets.reverse.each_with_index { |stmts, i|
      stmts.each_with_index { |stmt, j|
        next if stmt.class == Ruby::Statements
        stmts[j] = create_coverage_stmts(ElementType::STATEMENT, stmt, cov_func_name, "")
        if is_special_prolog?(stmt.prolog)
          stmts[j].prolog.elements[0].token = ''
          stmt.prolog = create_prolog(';::') # should be after inserting node into ast 
        else
          stmt.prolog = create_prolog(';') # should be after inserting node into ast 
        end
      }
    }
  end
end

## if you want "if true then end" to change to "if true then stmt_cov() end 
## deal with "if true then end"
#cov = create_coverage_func(Ruby::Nil.new('nil'), 'stmt_cov')
#cov.prolog = Ruby::Prolog.new(Ruby::Whitespace.new(' '))
#stmts << cov

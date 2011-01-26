module BranchCoverage
  CONDITIONAL_OPERATORS = [ '&&', '||', 'and', 'or' ]
  ALLOW_CLASS = [ Ruby::Binary, Ruby::Statements ] 

  def get_conds(root)
    ops = root.select(Ruby::Binary)
    ops.select { |op| is_cond?(op, root) }
  end
 
  def is_cond?(target, parent)
    # conditional node should have CONDITIONAL_OPERATORS
    return false unless CONDITIONAL_OPERATORS.include?(target.operator.token)
    target = target.parent
    until target.equal?(parent)
      # conditional node parent should belong to ALLOW_CLASS
      return false unless ALLOW_CLASS.include?(target.class)
      target = target.parent
    end
    true
  end
  
  def has_child_cond?(target, children, root)
    return children.any? { |child|
      until child.equal?(root)
        return true if target.equal?(child)
        child = child.parent
      end
      false
    }
  end

  def create_coverage_func(type, target, name, tag, child_range = (0...0))
    @info.elems << CoverageElement.new(type, @path, target.position, tag, child_range)
    args = [
      Ruby::Integer.new(next_id()),
      Ruby::Integer.new(type),
      create_statements(target),
    ]
    create_call_for_replacing(target, args, name)
  end

  def insert_branch_coverage(cov_func_name)
    @ast.select(Ruby::If).each { |e|
      conds = get_conds(e)
      istart = @info.elems.count()
      # insert cond_cov in conditions of branch
      conds.each { |cond|
        others = conds.reject{ |c| c.equal?(cond) }
        target = cond.left
        unless has_child_cond?(target, others, e)
          cond.left = create_coverage_func(ElementType::CONDITION, target, cov_func_name, "")
          # = operator is overrided so must not change target node in create_coverage_func
          target.prolog = nil # should do it after inserting node into ast
        end
    
        target = cond.right
        unless has_child_cond?(target, others, e)
          cond.right = create_coverage_func(ElementType::CONDITION, target, cov_func_name, "")
          target.prolog = nil # should do it after inserting node into ast
        end
      }
      # insert branch_cov in branch
      target = e.expression
      ilast = @info.elems.count() - 1
      type = unless conds.empty? then ElementType::BRANCH else ElementType::BRANCH_AND_CONDITION end
      e.expression = create_coverage_func(type, target, cov_func_name, "", (istart...ilast))
      target.prolog = nil # should do it after inserting node into ast
    }
  end
end


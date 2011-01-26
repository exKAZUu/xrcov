module EvalCoverage
  EVAL_NAMES = ['eval', 'instance_eval', 'class_eval']

  def create_eval_coverage_func(target, cov_func_name)
    args = [
      Ruby::Integer.new(next_id()),
      #create_string(@path),
      create_statements(target),
    ]
    create_call_for_replacing(target, args, cov_func_name)
  end

  def insert_eval_coverage(cov_func_name)
    @ast.select(Ruby::Call).each { |e|
      next unless EVAL_NAMES.include?(e.identifier.token)
      next unless e.arguments != nil
      target = e.arguments[0].arg
      e.arguments[0].arg = create_eval_coverage_func(target, cov_func_name)
      target.prolog = nil
    }
  end
end

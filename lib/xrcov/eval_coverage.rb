module EvalCoverage
  EVAL_NAMES = ['eval', 'instance_eval', 'class_eval']

  def create_eval_coverage_func(target, name, tag)
    @info.elems << CoverageElement.new(ElementType::EVAL, @src_path, target.position, tag, (0...0))
    args = [
      Ruby::Integer.new(next_id()),
      create_statements(target),
    ]
    create_call_for_replacing(target, args, name)
  end

  def insert_eval_coverage(cov_func_name)
    @ast.select(Ruby::Call).each { |e|
      next unless Ruby::Identifier === e.identifier
      next unless EVAL_NAMES.include?(e.identifier.token)
      next if e.arguments.nil?
      next if e.arguments[0].nil?
      next if e.arguments[0].arg.nil?
      target = e.arguments[0].arg
      e.arguments[0].arg = create_eval_coverage_func(target, cov_func_name, '')
      target.prolog = nil
    }
  end
end

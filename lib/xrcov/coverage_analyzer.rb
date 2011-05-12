module CoverageAnalyzer
  def analyze_static_stmt(info)
    analyze_cov(info.static_stmt_elems) { |e|
      e.state == CoverageState::BOTH
    }
  end

  def analyze_static_branch(info)
    analyze_cov(info.static_branch_elems) { |e|
      e.state == CoverageState::BOTH
    }
  end

  def analyze_static_cond(info)
    analyze_cov(info.static_branch_elems) { |e|
      e.children_or_self_state(info) == CoverageState::BOTH
    }
  end

  def analyze_static_branch_cond(info)
    analyze_cov(info.static_branch_elems) { |e|
      e.children_and_self_state(info) == CoverageState::BOTH
    }
  end

  def analyze_stmt(info)
    analyze_cov(info.stmt_elems) { |e|
      e.state == CoverageState::BOTH
    }
  end

  def analyze_branch(info)
    analyze_cov(info.branch_elems) { |e|
      e.state == CoverageState::BOTH
    }
  end

  def analyze_cond(info)
    analyze_cov(info.branch_elems) { |e|
      e.children_or_self_state(info) == CoverageState::BOTH
    }
  end

  def analyze_branch_cond(info)
    analyze_cov(info.branch_elems) { |e|
      e.children_and_self_state(info) == CoverageState::BOTH
    }
  end

  def analyze_cov(elems, &executed)
    all_count = cov_count = 0
    elems.each { |e|
      all_count += 1
      cov_count += 1 if executed.(e)
    }
    [cov_count, all_count]
  end
end

require 'xrcov'

class CoverageAnalyzer
  def analyze_stmt(info)
    analyze_cov(info.stmt_elems)
  end

  def analyze_branch(info)
    analyze_cov(info.branch_elems)
  end

  def analyze_cov(elems)
    all_count = cov_count = 0
    elems.each { |e|
      all_count += 1
      cov_count += 1 if e.state == CoverageState::BOTH
    }
    [cov_count, all_count]
    #result = cov_count.to_f / all_count
    #puts result.to_s + "%: " + cov_count.to_s + " / " + all_count.to_s
  end

  def analyze_cond(info)
    elems = info.branch_elems
    all_count = cov_count = 0
    elems.each { |e|
      all_count += 1
      cov_count += 1 if e.children_or_self_state(info) == CoverageState::BOTH
    }
    [cov_count, all_count]
  end

  def analyze_branch_cond(info)
    elems = info.branch_elems
    all_count = cov_count = 0
    elems.each { |e|
      all_count += 1
      cov_count += 1 if e.children_and_self_state(info) == CoverageState::BOTH
    }
    [cov_count, all_count]
  end
end


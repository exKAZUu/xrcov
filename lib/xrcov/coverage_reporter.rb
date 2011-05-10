class CoverageReporter

  include CoverageAnalyzer

  def read_info(dir_path)
    path = File.join(dir_path, ELEMENTS_NAME)
    File.open(path, 'r') { |f|
      CoverageInformation.read(f)
    }
  end

  def read_output(dir_path, info)
    path = File.join(dir_path, OUT_SUFFIX)
    File.open(path, 'rb') { |f|
      s = TsvStream.new(f)
      s.read_all { |id, type, value|
        info.elems[id.to_i].state |= value.to_i
      }
    }
  end

  def print_result(dir_path)
    info = read_info(dir_path)
    read_output(dir_path, info)
    stmt = analyze_stmt(info)
    branch = analyze_branch(info)
    cond = analyze_cond(info)
    br_cond = analyze_branch_cond(info)
    print_stmt(*stmt)
    print_branch(*branch)
    print_cond(*cond)
    print_branch_cond(*br_cond)
    [stmt, branch, cond, br_cond]
  end

  def print_stmt(executed, all)
    print "statement coverage: #{executed.to_f / all.to_f} (#{executed} / #{all})"
  end

  def print_branch(executed, all)
    print "branch coverage: #{executed.to_f / all.to_f} (#{executed} / #{all})"
  end

  def print_cond(executed, all)
    print "condition coverage: #{executed.to_f / all.to_f} (#{executed} / #{all})"
  end

  def print_branch_cond(executed, all)
    print "branch/condition coverage: #{executed.to_f / all.to_f} (#{executed} / #{all})"
  end
end

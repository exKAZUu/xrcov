require 'xrcov'

class CoverageAnalyzer
  #def initialize()
  #  read_info('coverage_info')
  #  read_extra_info('coverage_extra_info')
  #  read_output('coverage_output')
  #end

  #def read_info(path)
  #  File.open(path) { |f|
  #    @info = Marshal.load(f)
  #  }
  #end

  #def read_extra_info(path)
  #  return unless File.exist?(path)
  #  File.open(path) { |f|
  #    until f.eof?
  #      @info.merge(Marshal.load(f))
  #      puts 'read_extra_info: ' + @info.elems.length.to_s
  #    end
  #  }
  #end

  #def read_output(path)
  #  File.open(path, 'rb') { |f|
  #    until f.eof?
  #      arr = f.read(5).unpack('C*')
  #      id = (arr[0] << 24) + (arr[1] << 16) + (arr[2] << 8) + arr[3]
  #      value = arr[4] >> 6
  #      puts id.to_s + ', ' + value.to_s
  #      @info.elems[id].state |= value
  #    end
  #  }
  #end

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


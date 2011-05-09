class CoverageReporter

  include Consts

  def read_info()
    File.open(File.join(@out_path, ELEMENTS_NAME), 'r') { |f|
      CoverageInformation.read(f)
    }
  end

  def read_output(path, info)
    File.open(path, 'rb') { |f|
      until f.eof?
        arr = f.read(5).unpack('C*')
        id = (arr[0] << 24) + (arr[1] << 16) + (arr[2] << 8) + arr[3]
        value = arr[4] >> 6
        puts id.to_s + ', ' + value.to_s
        info.elems[id].state |= value
      end
    }
  end

  def show()
    path = ''
    info = read_info(path)
    read_output(path)
    CoverageAnalyzer.analyze_stmt(info)
    CoverageAnalyzer.analyze_branch(info)
    CoverageAnalyzer.analyze_cond(info)
    CoverageAnalyzer.analyze_branch_cond(info)
  end
end

if ARGV.count > 1 then
  ins = CoverageReporter.new()
  outdir = ARGV.shift
  ARGV.each { |arg| ins.insert_coverage_in_file(arg, outdir) }
end

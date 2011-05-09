require 'find'
require 'fileutils'

class CoverageInserter

  include AstBuilder
  include StatementCoverage
  include BranchCoverage
  include EvalCoverage

  attr_accessor :info

  def initialize(out_dir, first_id = 0)
    @out_dir = out_dir
    # measurement targets corresponding to ids (0, 1, 2, ...)
    @id = first_id - 1
    @info = CoverageInformation.new()
    @inserted = {}
  end

  def next_id()
    @id = @id + 1
  end

  def insert_coverage_in_string(src, src_path)
    @ast = Ripper::RubyBuilder.build(src)
    @src_path = src_path

    insert_statement_coverage('XrcovOut.stmt')
    insert_branch_coverage('XrcovOut.pred')
    insert_eval_coverage('XrcovOut.eval')

    @ast.to_ruby
  end

  def initialize_eval()
    File.open(File.join(@out_dir, ID_NAME), 'r') { |f|
      @id = f.read().to_i - 1
    }
    File.open(File.join(@out_dir, INSERTED_NAME), 'rb') { |f|
      @inserted = Marshal.load(f)
    }
    self
  end

  def insert_coverage_in_eval(id, src, src_path)
    return @inserted[[id, src]] if @inserted[[id, src]]
    insert_coverage_in_string(src, src_path)
  end

  def insert_coverage_in_file(src_path)
    src = File.open(src_path) { |f| f.read() }
    File.open(src_path + BACKUP_SUFFIX, 'w') { |f|
      f.write(src)
    }
    ret = <<-EOS
require 'xrcov'
$xrcov_out_dir ||= '#{@out_dir}'
require 'xrcov/coverage_fileout'
    EOS
    ret += insert_coverage_in_string(src, src_path)

    File.open(src_path, 'w') { |f|
      f.write(ret)
    }

    ret
  end

  def update_coverage_files()
    File.open(File.join(@out_dir, ID_NAME), 'w') { |f|
      f.write(next_id())
    }
    File.open(File.join(@out_dir, ELEMENTS_NAME), 'a') { |f|
      @info.append(f)
    }
    File.open(File.join(@out_dir, INSERTED_NAME), 'wb') { |f|
      Marshal.dump(@inserted, f)
    }
  end

  def write_coverage_files()
    File.open(File.join(@out_dir, ID_NAME), 'w') { |f|
      f.write(next_id())
    }
    File.open(File.join(@out_dir, ELEMENTS_NAME), 'w') { |f|
      @info.write(f)
    }
    File.open(File.join(@out_dir, INSERTED_NAME), 'wb') { |f|
      Marshal.dump(@inserted, f)
    }
  end
end

class << CoverageInserter
  def insert_coverage(path)
    if (File.file?(path))
      ins = CoverageInserter.new(File.dirname(path))
      ins.insert_coverage_in_file(path)
    elsif (File.directory?(path))
      ins = CoverageInserter.new(path)
      Dir['**/*.rb'].each { |p|
        ins.insert_coverage_in_file(p)
      }
    end
    ins.write_coverage_files()
  end

  def restore_original_sources(src_dir)
    Find.find(src_dir) { |back|
      if back.end_with?(BACKUP_SUFFIX)
        org = back[0...-BACKUP_SUFFIX.length]
        FileUtils.rm_f(org)
        FileUtils.mv(back, org)
      end
    }
  end
end

if ARGV.count > 1 then
  ARGV.each { |arg| CoverageInserter.insert_coverage(arg, outdir) }
end

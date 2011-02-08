class CoverageInformation
  attr_accessor :elems, :ieval

  def initialize()
    @elems = []
  end

  def ==(that)
    @elems == that.elems && @ieval == that.ieval
  end

  def append(f)
    TsvWriter.instance.file = f
    @elems.each { |e|
      e.write(TsvWriter.instance)
    }
  end

  def write(f)
    f.puts @ieval
    append(f)
  end

  def self.read(f)
    info = CoverageInformation.new
    info.ieval = f.readline().chomp.to_i
    until f.eof?
      ss = f.readline().split("\t")
      info.elems << CoverageElement.read(ss)
    end
    info
  end

  def read_coverage_data(f)
    until f.eof?
      id, type, value = f.readline.split(',')
      elems[id.to_i].state |= value.to_i
    end
  end

  def stmt_elems()
    @elems.select{ |e| e.type == ElementType::STATEMENT }
  end

  def branch_elems()
    @elems.select{ |e| (e.type & ElementType::BRANCH) != 0 }
  end
end

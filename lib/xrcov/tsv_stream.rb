class TsvStream
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def write(*record)
    delimiter = ''
    record.each { |item|
      @file.write(delimiter)
      @file.write(item)
      delimiter = "\t"
    }
    @file.write("\n")
  end

  def read()
    @file.readline().chomp.split("\t")
  end

  def read_all()
    until @file.eof?
      yield @file.readline().chomp.split("\t")
    end
  end

  def close()
    @file.close() if @file
    @file = nil
  end
end

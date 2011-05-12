class A
  def a()
    ::Syslog.close if ::Syslog.opened?
    ::Syslog.open( *args )
    return if !::Syslog.opened?
    ::Syslog.send(tag, *messages)
    ::Syslog.inspect
  end
end

require 'pg'

class Dbconnector
  def initialize
    @conn = PGconn.connect("localhost", 5432, '', '', "rforum_development", "postgres", "root")
  end

  def execute_query
    @conn.exec('select title from boards')
  end

end
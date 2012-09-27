require 'pg'

class Dbconnector
  def initialize
    @conn ||= PGconn.connect("localhost", 5432, '', '', "rforum_development", "postgres", "root")
  end

  def execute_query(selected, table)
    unless selected == "" || table == ""
      @conn.exec("select #{selected} from #{table}")
    else
      @conn.exec("select * from boards")
    end
  end

end
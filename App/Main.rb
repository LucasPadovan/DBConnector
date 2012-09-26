require 'fox16'
include Fox

require './dbconnector'

class Main < FXMainWindow
  def initialize(app)
      super(app, "Conector DB PGSQL", :width => 300, :height => 700)
      @vFrame = FXVerticalFrame.new(self, :opts => LAYOUT_FILL)
      label = FXLabel.new( @vFrame, "Estos son los foros que tengo en la base de datos: ")

      conn = Dbconnector.new
      conn.execute_query.each do |row|
      	row.each do |column|
      		self.add_label_bordered column[1]
      	end
      end

    end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def add_label_bordered(text)
    label = FXLabel.new(@vFrame, text, :opts => FRAME_LINE)
  end
end
app = FXApp.new
Main.new(app)
app.create
app.run



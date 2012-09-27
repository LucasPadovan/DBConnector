require 'fox16'
include Fox

require './dbconnector'

class Main < FXMainWindow
  def initialize(app, alto, ancho)
      super(app, "Conector DB PGSQL", :width => alto, :height => ancho)
      conn = Dbconnector.new
      @hFrame1 = FXHorizontalFrame.new(self)
      @hFrame2 = FXHorizontalFrame.new(self)
      @hFrame3 = FXHorizontalFrame.new(self)
      @hFrame4 = FXHorizontalFrame.new(self,LAYOUT_FILL)
      FXLabel.new(@hFrame1, "Select")
      select_field = FXTextField.new(@hFrame1, 40)
      select_field.text = "*"
      FXLabel.new(@hFrame2, "From")
      from_field = FXTextField.new(@hFrame2, 40)
      from_field.text = "boards"
      text_field = FXText.new(@hFrame4, :opts => TEXT_WORDWRAP|LAYOUT_FILL)
      text_field.editable = false

      button = FXButton.new(@hFrame3, "Buscar")
      button.connect(SEL_COMMAND) do
        text_field.text = ""

        query = conn.execute_query( select_field.text, from_field.text )
        keys = []
        query.first.each_key do |k|
          keys << k
        end

        query.each do |row|
          keys.each do |k|
            text = "#{k}: #{row[k]}"
            text_field.appendText("#{text}\n")
          end
          text_field.appendText("\n")
        end
      end

    end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

app = FXApp.new
Main.new(app, 600, 800)
app.create
app.run



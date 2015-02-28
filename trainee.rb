class Trainee < Person
  attr_accessor :preferred_text_editor

  def draw_questions
    super
    shoes.app.flow do
      shoes.app.caption "Preferred Text Editor"
      @preferred_text_editor_field = shoes.app.edit_line
    end
  end

  def save_values
    super
    @preferred_text_editor = @preferred_text_editor_field.text.strip.chomp
  end
end
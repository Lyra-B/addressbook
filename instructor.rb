class Instructor < Person
  attr_accessor :teaching_experience

  def draw_questions
    super
    shoes.app.flow do
      shoes.app.caption "Teaching Experience"
      @teaching_experience_field = shoes.app.edit_line
    end
  end

  def save_values
    super
    @teaching_experience = @teaching_experience_field.text.strip.chomp
  end
end
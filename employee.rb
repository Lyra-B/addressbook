class Employee < Person
  attr_accessor :work_experience

  def draw_questions
    super
    shoes.app.flow do
      shoes.app.caption "Work Experience"
      @work_experience_field = shoes.app.edit_line
    end
  end

  def save_values
    super
    @work_experience = @work_experience_field.text.strip.chomp
  end
end

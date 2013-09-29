require 'rubygems'
require 'yaml'

# We're using an Array as our data store. This the ONE AND ONLY TIME we'll use
# a global variable!
$address_book = []

# A Person represents an individual that we want to store contact information
# for, the superclass of Trainee and Instructor
#
class Person
  attr_accessor :shoes
  attr_accessor :first_name
  attr_accessor :last_name
  # TODO 1. Add more!

  def initialize(shoes)
    self.shoes = shoes
  end

  def draw
    shoes.clear
    shoes.append do
      # Show the questions on the screen
      draw_questions

      shoes.button "Save" do
        # Set the values from the boxes into the Object
        save_values

        # Append ourselves to our address_book Array
        $address_book << self

        # TODO: 6. Open a address_book.yml YAML file and write it out to disc
        shoes.debug self.to_yaml

        shoes.alert 'Saved'
      end
    end
  end

  # Renders some labels and textboxes to prompt the user for input
  #
  def draw_questions
    shoes.flow do
      shoes.caption "First name"
      @first_name_field = shoes.edit_line
    end

    shoes.flow do
      shoes.caption "Last name"
      @last_name_field = shoes.edit_line
    end

    # TODO 4. Add fields for the user to fill in, but only if they are
    # relevant to the given user type.
  end

  def save_values
    # Set the persons's name to the contents of the text box
    self.first_name = @first_name_field.text.strip.chomp
    self.last_name = @last_name_field.text.strip.chomp

    # TODO: 2. Finish the implementation to set the other fields.
  end
end

class Trainee < Person
  attr_accessor :preferred_text_editor
end

class Instructor < Person
  attr_accessor :teaching_experience
end

Shoes.app title: "Ruby Address Book", width: 520 do
  # The row of buttons to lookup Person objects in the address_book
  ('A'..'Z').each do |letter|
    flow width: 40 do
      button letter do
        @form.clear
        @form.append do
          # TODO 5. Show each of the Person objects in the address_book where the
          # last name matches.
        end
      end
    end
  end

  stack margin: 20 do
    flow do
      caption "Type"
      list_box :items => %w(Trainee Instructor) do |selected|
        debug selected.text

        # TODO 3. Create a Trainee or an Instructor using a Person factory method
        # and store the result in @person. Show the fields for the user to fill in
      end
    end

    # This reserves space for the form elements to be appended later by the
    # draw method
    @form = stack

    # Actually draw the form using Trainee as a default
    @person = Trainee.new(@form)
    @person.draw
  end

end
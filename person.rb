class Person
  attr_accessor :shoes
  attr_accessor :first_name
  attr_accessor :last_name
  attr_accessor :email
  attr_accessor :github
  attr_accessor :twitter
  attr_accessor :fun_fact
  # TODO 1. Add more!

  def initialize(shoes)
    @shoes = shoes
    @my_addressbook = File.open('address_book.yml')
    YAML.load_documents(@my_addressbook) do |entry|
        $address_book << entry
      $address_book
    end
  end

  def self.search_by_letter(l)
    last_array = []
    # binding.pry
    $address_book.each do |n|
      if n.last_name.start_with?(l)
        last_array << n
      end
    end
    last_array
  end

  def self.makePerson(type,stack)
    case type
    when "Trainee"
      person = Trainee.new(stack)
    when "Instructor"
      person = Instructor.new(stack)
    when "Employee"
      person = Employee.new(stack)
    end
  end

  # Displays the input form to the user
  #
  def draw
    shoes.clear
    shoes.append do

      # Show the questions on the screen
      draw_questions

      shoes.app.button "Save" do
        # Set the values from the boxes into the Object
        save_values

        # Append ourselves to our address_book Array

        # TODO: 6. Open a address_book.yml YAML file and write it out to disc
        no_duplicate = true
        $address_book.each do |c|
           no_duplicate = false if c.email == self.email
        end

        if no_duplicate
          File.open('address_book.yml', 'a') { |f| f.write(self.to_yaml) }
          shoes.app.debug self.to_yaml
          shoes.app.alert 'Saved'
        else
          shoes.app.alert 'Contact already exists!'
        end
      end
    end
  end

  # Renders some labels and textboxes to prompt the user for input

  def draw_questions
    shoes.app.flow do
      shoes.app.caption "First name"
      @first_name_field = shoes.app.edit_line
    end

    shoes.app.flow do
      shoes.app.caption "Last name"
      @last_name_field = shoes.app.edit_line
    end

    shoes.app.flow do
      shoes.app.caption "Email"
      @email_field = shoes.app.edit_line
    end

    shoes.app.flow do
      shoes.app.caption "Github"
      @github_field = shoes.app.edit_line
    end

    shoes.app.flow do
      shoes.app.caption "Twitter"
      @twitter_field = shoes.app.edit_line
    end

    shoes.app.flow do
      shoes.app.caption "Fun Fact"
      @fun_fact_field = shoes.app.edit_line
    end

    # TODO 4. Add fields for the user to fill in, but only if they are
    # relevant to the given user type.
  end

  # Set the persons's name to the contents of the text box

  def save_values
    self.first_name = @first_name_field.text.strip.chomp
    self.last_name = @last_name_field.text.strip.chomp
    self.email = @email_field.text.strip.chomp
    self.github = @github_field.text.strip.chomp
    self.twitter = @twitter_field.text.strip.chomp
    self.fun_fact = @fun_fact_field.text.strip.chomp

  #   # TODO: 2. Finish the implementation to set the other fields.
  end



  def to_yaml_properties
    #Add the fields that should be saved to the YAML file
   %w(@first_name @last_name @email @github @twitter @fun_fact @preferred_text_editor @teaching_experience @work_experience)
  end
end

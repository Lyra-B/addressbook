require 'rubygems'
require 'yaml'
require 'pry'
require_relative 'person.rb'
require_relative 'instructor.rb'
require_relative 'trainee.rb'
require_relative 'employee.rb'


# We're using an Array as our data store. This the ONE AND ONLY TIME we'll use
# a global variable!
$address_book = []

# A Person represents an individual that we want to store contact information
# for, the superclass of Trainee and Instructor

Shoes.app title: "Ruby Address Book", width: 520 do
  background rgb(240, 250, 208)
  # The row of buttons to lookup Person objects in the address_book
  # list = YAML.load_file('address_book.yml').to_a
  ('A'..'Z').each do |letter|
    flow width: 40 do
      button letter do
        @people = Person.search_by_letter(letter)
        # binding.pry
        stack margin: 20 do
          flow do
            @people.each do |person|
              caption "#{person.first_name} #{person.last_name} "
            end
          end
        end
        # TODO 5. Show each of the Person objects in the address_book where the
        # last name matches.
      end
    end
  end

  stack margin: 20 do
    flow do
      caption "Type"
      list_box items: %w(Trainee Instructor Employee) do |selected|
        debug selected.text
        @person = Person.makePerson(selected.text, @form).draw
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
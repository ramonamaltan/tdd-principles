# Use TDD principles to build out name functionality for a Person.
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.

class Person
  def initialize(first_name: 'mary', middle_name: nil, last_name: 'jons')
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # implement your behavior here
  def full_name(first_name, middle_name=nil, last_name)
    if middle_name.nil?
      "#{first_name} #{last_name}"
    else
      "#{first_name} #{middle_name} #{last_name}"
    end
  end

  def full_name_with_middle_initial(first_name, middle_name=nil, last_name)
    if middle_name.nil?
      "#{first_name} #{last_name}"
    else
      "#{first_name} #{middle_name[0]} #{last_name}"
    end
  end

  def initials(first_name, middle_name=nil, last_name)
    if middle_name.nil?
      "#{first_name[0]} #{last_name[0]}"
    else
      "#{first_name[0]} #{middle_name[0]} #{last_name[0]}"
    end
  end
end

RSpec.describe Person do
  describe '#full_name' do
    it 'concatenates first name, middle name, and last name with spaces' do
      person = Person.new
      expect(person.full_name('Marie', 'Louise', 'Musterfrau')).to eq('Marie Louise Musterfrau')
    end
    it 'does not add extra spaces if middle name is missing' do
      person = Person.new
      expect(person.full_name('Marie', 'Musterfrau')).to eq('Marie Musterfrau')
    end
  end

  describe '#full_name_with_middle_initial' do
    it 'concatenates first name, the initials of the middle name and last name with spaces' do
      person = Person.new
      expect(person.full_name_with_middle_initial('Marie', 'Louise', 'Musterfrau')).to eq('Marie L Musterfrau')
    end
    it 'should not have extra space when middle name is missing' do
      person = Person.new
      expect(person.full_name_with_middle_initial('Marie', 'Musterfrau')).to eq('Marie Musterfrau')
    end
  end

  describe '#initials' do
    it 'returns only a string of the initials of first middle and last name' do
      person = Person.new
      expect(person.initials('Marie', 'Louise', 'Musterfrau')).to eq('M L M')
    end
    it 'should not have extra space if the middle name is missing' do
      person = Person.new
      expect(person.initials('Marie', 'Musterfrau')).to eq('M M')
    end
  end
end

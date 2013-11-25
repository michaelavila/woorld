require 'colorize'

#
# Game Properties
#

game_over = false

# new player
player = {
  :name => '',
  :inventory => [],
}
puts 'What is your name?'.yellow
player[:name] = gets.chomp
puts

# new place
safe_room = {
  :name => 'Really Safe Stuff',
  :things => [
    {:id => 1, :name => 'safe', :takeable => false, :openable => true},
    {:id => 2, :name => 'safe key', :takeable => true, :openable => false},
  ]
}

# greet player
greeting = "Welcome to the adventure #{player[:name].light_red}..."
puts '='.black * greeting.length
puts greeting.black
puts '='.black * greeting.length
puts 'To win the game:'.green
puts '- Open the safe.'.light_green
puts

# set current_place
current_place = safe_room

#
# Game Loop
#

while not game_over do
  # wait for player action
  puts 'What do you want to do?'.yellow
  puts '"?" or "help" for a list of available actions'.black
  action = gets.chomp

  # react to action
  case action
  when 'look'
    puts
    puts "You're in \"#{current_place[:name]}\" and you see:".blue
    current_place[:things].each do |thing|
      puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
    end
    puts
  when /take \d+/
    thing_id = action.match(/take (\d+)/).captures.first.to_i
    thing = current_place[:things].find { |thing| thing[:id] == thing_id }
    unless thing
      puts
      puts "Thing with id #{thing_id} does not exist.".red
      puts
      next
    end
    unless thing[:takeable]
      puts
      puts "#{thing[:name]} cannot be taken.".red
      puts
      next
    end

    current_place[:things].delete thing
    player[:inventory] << thing

    puts
    puts "Added #{thing[:name]} to your inventory".light_green
    puts
  when /open \d+/
    thing_id = action.match(/open (\d+)/).captures.first.to_i
    thing = current_place[:things].find { |thing| thing[:id] == thing_id }
    unless thing
      puts
      puts "Thing with id #{thing_id} does not exist.".red
      puts
      next
    end
    unless thing[:openable]
      puts
      puts "#{thing[:name]} is not openable.".red
      puts
      next
    end
    unless player[:inventory].find { |thing| thing[:name] == 'safe key' }
      puts
      puts "(#{thing[:name]}) requires safe key".light_red
      puts
      next
    end

    # end the game
    game_over = true
    puts
    puts 'Congratulations! You have won!'.green
    puts
  when 'inventory'
    puts
    if player[:inventory].count == 0
      puts 'You have no things.'.red
    else
      player[:inventory].each do |thing|
        puts "  (#{thing[:id]}) #{thing[:name]}".light_blue
      end
    end
    puts
  when /help|\?/
    puts
    puts 'Here are the things you can do:'.light_cyan
    puts '  look - describe surroundings'.light_cyan
    puts '  take <thing #> - remove thing from place and add to inventory'.light_cyan
    puts '  open <thing #> - opens an openable thing'.light_cyan
    puts '  inventory - lists all of the things you have'.light_cyan
    puts '  help or ? - print this message'.light_cyan
    puts
  else
    puts "#{action} is an invalid action".red
    puts 'run help or ? for a list of available actions'.light_red
    puts
  end
end
Then  /the\s"?(.*)"?\sof\s"(.*)"\sshould be\s"(.*)"/ do |field, title, value|
  movie = Movie.find_by_title(title)
  assert(movie.director == value)
end   

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie_item|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #puts "Adding: " + movie_item[:title]
    Movie.create!(movie_item)  
    #found_movie = Movie.all
    #count = found_movie.count
    #puts "Count: " + count.to_s
    #puts "Element[Count - 1] = " + found_movie[count - 1].title.to_s     
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list_components = rating_list.split(/,?\s+/)
  rating_list_components.each do |rating|
    str_id = "ratings_" + rating
    strarg = ''
    if uncheck == "un" then
      strarg = 'I uncheck ' + '"' + str_id + '"'      
    else
      strarg = 'I check ' + '"' + str_id + '"'
    end
    step strarg
  end  
end

Then /I should(n't)? see movies with these ratings: (.*)/ do |undisplay, rating_list|
  rating_list_components = rating_list.split(/,?\s+/)
  sel_ratings = Array.new()
  i = 0
  rating_list_components.each do |rating|
    sel_ratings[i] = rating
    i = i + 1 
  end 
  db_movies = Movie.find_all_by_rating(sel_ratings)
  db_movies.each do |movie|
    if undisplay == "n't" then
      strarg = "I should not see " + '"' + movie.title + '"'
    else
      strarg = "I should see " + '"' + movie.title + '"'
    end         
    step strarg
  end
end

Then /I should see all of the movies/ do 
  db_movies = Movie.all
  db_movies.each do |movie|
    strarg = "I should see " + '"' + movie.title + '"'
    step strarg
  end
end

Then /I should see no movies/ do 
  db_movies = Movie.all
  db_movies.each do |movie|
    strarg = "I should not see " + '"' + movie.title + '"'
    step strarg
  end
end

# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    retval = '/'
    case page_name

    when /^the home\s?page$/
      retval = '/'
    when /.*RottenPotatoes.*\s?page$/i
      retval = '/movies'
    when /.*the edit page for\s"(.*)"/i
      movies = Movie.find_by_title $1
      movieid = movies.id.to_s
      retval = '/movies/' + movieid + '/edit'      
    when /.*the details page for\s"(.*)"/i
      movies = Movie.find_by_title $1
      movieid = movies.id.to_s
      retval = '/movies/' + movieid      
    when /.*the Similar Movies page for\s"(.*)"/i
      movies = Movie.find_by_title $1
      movieid = movies.id.to_s
      retval = '/movies/similar/' + movieid      
    else
      begin
        page_name =~ /^the (.*) page$/
        puts $1
        path_components = $1.split(/\s+/)
        puts path_components.to_s
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
    return retval
  end
end

World(NavigationHelpers)

# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)

  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string

  expect(page.body.index(e1)).to be < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(', ')
  if(uncheck == "un") 
    ratings.each do |r|
       
       step "I uncheck \"ratings_PG\""    if r == "PG"
       step "I uncheck \"ratings_R\""     if r == "R"
       step "I uncheck \"ratings_G\""     if r == "G"
       step "I uncheck \"ratings_PG-13\"" if r == "PG-13"
       step "I uncheck \"ratings_NC-17\"" if r == "NC-17"
    end
  else
     
    ratings.each do |r|
       
       step "I check \"ratings_PG\""    if r == "PG"
       step "I check \"ratings_R\""     if r == "R"
       step "I check \"ratings_G\""     if r == "G"
       step "I check \"ratings_PG-13\"" if r == "PG-13"
       step "I check \"ratings_NC-17\"" if r == "NC-17"
      
    end
  end

end

Then /I should see all the movies/ do

  expect(page.all("table#movies tbody tr").count).to equal(10)
end

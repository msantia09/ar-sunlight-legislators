require_relative 'db/config'
require_relative 'app/models/legislator'

puts "Results :"
# Question 1
#Legislator.where(state: "NY", title: "Rep")
#Legislator.quest1("NY")

# Question 2
#p Legislator.where(state: "NY", title: "Sen").order(:firstname).limit(2)
#Legislator.quest2("NY")

# Question 3
#p Legislator.where(party: "D", title: "Sen").order(:firstname)
#Legislator.quest3("D")

# Question 4
#p Legislator.where(party: "R", title: "Sen").order(:firstname)
#Legislator.quest4("R")

# Question 5
#Legislator.quest5("Sen", "Daniel")

# Question 6
#p Legislator.where(title: "Rep", firstname: "Robert")
#Legislator.quest6("Rep", "Robert")

#Legislator.ar_quest1("NY")
# Legislator.ar_quest2("M")

#Legislator.ar_quest3
#Legislator.ar_quest4
# Legislator.ar_quest5
puts "...................................."


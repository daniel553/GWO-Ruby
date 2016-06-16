# Grey Wolf Optimizer (GWO)
# Programmer : Luis Rodriguez
# Main Paper: S. Mirjalili, S. M. Mirjalili, A. Lewis, Grey Wolf Optimizer, Advances in Engineering

# Main File
require 'rubygems'
require 'gruff'
require_relative 'getFunctionsDetails'
require_relative 'GWO'

numSearchAgents = 20
functionName = 'F1'
maxIterarions = 300

# Get details of Benchmark Function
detailsBenchmarkFunction = getFunctionsDetails(functionName)

# Works the Algorithm
results = GWO(numSearchAgents, maxIterarions, detailsBenchmarkFunction)

# Print Best Individual
# puts results[:bestPosition]

# Print All Individuals
# puts results[:positions]

# Print Best Fitness of each Iterarion
# puts results[:curveGWO]

# Print Fitness of Best Individual
# puts results[:bestScore]

puts
puts "Best Fitnes: #{results[:bestScore]}"
puts

# Plot Results
label = maxIterarions/4
g = Gruff::Line.new
g.title = "GWO"
g.data("Best", results[:curveGWO])
g.labels = {0 => '0', label => label, label*2 => label*2, label*3 => label*3, maxIterarions-1 => maxIterarions}
g.write('GWO.png')
# Grey Wolf Optimizer (GWO)
# Programmer : Luis Rodriguez
# Main Paper: S. Mirjalili, S. M. Mirjalili, A. Lewis, Grey Wolf Optimizer, Advances in Engineering

require_relative 'initialization'
require_relative 'getFunctionsDetails'

#Grey Wolf Optimizer
def GWO(numSearchAgents, maxIterarions, details)
    # Parameters and initialization
	lb = details[:lb]
	ub = details[:ub]
	dim = details[:dim]
	nameFunction = details[:nameFunction]
    obj = details[:obj]
	alphaPos = Array.new(dim)
	betaPos = Array.new(dim)
	deltaPos = Array.new(dim)
	alphaScore = Float::INFINITY
	betaScore = Float::INFINITY
	deltaScore = Float::INFINITY
    convergenceCurve = Array.new(maxIterarions-1)
	for i in 0..dim -1
		alphaPos[i] = 0
		betaPos[i] = 0
		deltaPos[i] = 0
    end
    for i in 0..maxIterarions -1
        convergenceCurve[i] = 0
    end

	# Initialize the positions of search agents
	positions = initialization(numSearchAgents,lb,ub,dim)

    # Counter
    l = 0

    # Main loop
    while l < maxIterarions do
    	
    	# Return back the search agents that go beyond the bonduries of the search space
    	for i in 0..numSearchAgents -1
    		for j in 0..dim -1
    			if positions[i][j] > ub || positions[i][j] < lb
    				positions[i][j] = (lb + rand(ub - (lb)))
    			end
    		end

    		# Calculate objetive function for each search agent
    		fitness = fobj(nameFunction, positions[i])
            fitness = (obj - fitness).abs

            # Update Alpha, Beta and Delta
            if fitness < alphaScore
                alphaScore = fitness
                alphaPos = positions[i]
            end
            if (fitness > alphaScore && fitness < betaScore)
                betaScore = fitness
                betaPos = positions[i]
            end
            if (fitness > alphaScore && fitness > betaScore && fitness < deltaScore)
                deltaScore = fitness
                deltaPos = positions[i]
            end
    	end

    	# Update "a" parameter
    	a = 2-l*(2/maxIterarions)


    	# Update the positions of search agents
    	for i in 0..numSearchAgents -1
    		for j in 0..dim -1
    			# Update based on Alpha
    			r1 = rand
    			r2 = rand
    			a1 = 2*a*r1-a
    			c1 = 2*r2
    			dAlpha = (c1*alphaPos[j] - positions[i][j]).abs
    			x1 = (alphaPos[j] - (a1*dAlpha))
    	
    			# Update based on Beta
    			r1 = rand
    			r2 = rand
    			a2 = 2*a*r1-a
    			c2 = 2*r2
    			dBeta = (c2*betaPos[j] - positions[i][j]).abs
    			x2 = (betaPos[j] - (a2*dBeta))

       			# Update based on Delta
    			r1 = rand
    			r2 = rand
    			a3 = 2*a*r1-a
    			c3 = 2*r2
    			dDelta = (c3*deltaPos[j] - positions[i][j]).abs
    			x3 = (deltaPos[j] - (a3*dDelta))

    			positions[i][j] = ((x1+x2+x3)/3)
    		
    		end
    	end

        convergenceCurve[l] = alphaScore
    	l = l + 1
    	puts "Iteration #{l}: Best Fitness #{alphaScore}"
	end

	return {bestScore: alphaScore, bestPosition: alphaPos, curveGWO: convergenceCurve, positions: positions}

end
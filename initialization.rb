# Grey Wolf Optimizer (GWO)
# Programmer : Luis Rodriguez
# Main Paper: S. Mirjalili, S. M. Mirjalili, A. Lewis, Grey Wolf Optimizer, Advances in Engineering

# This function initialize the firts population of search agents
def initialization(numSearchAgents, lb, ub, dim)
	if instance_of? Array
		numBoundary = 2
	else
		numBoundary = 1
	end

	positions = []

	# If the boundaries of all variables are equal and user enter a single number for both ub and lb
	if numBoundary==1
    	for i in 0..numSearchAgents-1
    		wolf = []
    		for j in 0..dim-1
    			wolf.push(rand * (ub-lb) + lb)
    		end
    		positions.push(wolf)
    	end
	end

	#If each variable has a different lb and ub
	if numBoundary>1
		for i in 0..numSearchAgents -1
			wolf = []
    		for j in 0..dim -1
    			ub_i=ub[j]
        		lb_i=lb[j]
    			wolf.push(rand * (ub_i-lb_i) + lb_i)
    		end
    		positions.push(wolf)
    	end
	end

	return positions

end
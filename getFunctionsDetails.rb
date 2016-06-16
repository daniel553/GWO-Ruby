# Grey Wolf Optimizer (GWO)
# Programmer : Luis Rodriguez
# Main Paper: S. Mirjalili, S. M. Mirjalili, A. Lewis, Grey Wolf Optimizer, Advances in Engineering

# Get Functions Details

def getFunctionsDetails(function)
	case function
	when 'F1'
		details = {
			lb: -100,
			ub: 100,
			dim: 30,
			nameFunction: 'F1',
			obj: 0
		}
	end

	return details	
end

def fobj(function, x)
	case function
	when 'F1'
		o = x.inject{ |sum,y| sum + y**2 }
	end

	return o
end
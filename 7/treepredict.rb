@my_data = [['slashdot','USA','yes',18,'None'], 
        ['google','France','yes',23,'Premium'], 
        ['digg','USA','yes',24,'Basic'], 
        ['kiwitobes','France','yes',23,'Basic'], 
        ['google','UK','no',21,'Premium'], 
        ['(direct)','New Zealand','no',12,'None'], 
        ['(direct)','UK','no',21,'Basic'], 
        ['google','USA','no',24,'Premium'], 
        ['slashdot','France','yes',19,'None'], 
        ['digg','USA','no',18,'None'], 
        ['google','UK','no',18,'None'], 
        ['kiwitobes','UK','no',19,'None'], 
        ['digg','New Zealand','yes',12,'Basic'], 
        ['slashdot','UK','no',21,'None'], 
        ['google','UK','yes',18,'Basic'], 
        ['kiwitobes','France','yes',19,'Basic']] 

class DecisionNode

	def initialize
		@color = -1
		@value = nil
		@results = nil
		@tb = tb
		@fb = fb
	end

end

def divideset(rows, column, value)
	split_function = nil

	if value.is_a?(Fixnum) || value.is_a?(Float)
		split_function = lambda{|row| row[column] >= value}
	else
		split_function = lambda{|row| row[column] == value}
	end

	set1 = rows.select{|row| split_function.call(row)}
	set2 = rows.reject{|row| split_function.call(row)}
	[set1, set2]
end

def test_1
	divideset(@my_data, 2, 'yes')
end

def uniquecounts(rows)
	results = {}

	for row in rows
		r = row[row.length - 1]
		results[r] = 0 unless results[r]
		results[r] += 1
	end
	results
end

def giniimpurity(rows)
	total = rows.length

	counts = uniquecounts(rows)

	imp = 0
		
	counts.each do |key, value|
		p1 = value.to_f / total
		counts.each do |key2, value2|
			next if key == key2
			p2 = value2.to_f / total
			imp += p1 * p2
		end
	end

	imp
end

def entropy(rows)
	log2 = lambda{|x| Math.log(x) / Math.log(2)}
	results = uniquecounts(rows)
	ent = 0.0
	for r in results.keys
		p = results[r].to_f / rows.length
		ent = ent - p * log2.call(p)
	end

	ent
end

def test_2
	p giniimpurity(@my_data)
	
	p entropy(@my_data)

	set1, set2 = divideset(@my_data, 2, 'yes')

	p entropy(set1)
	p giniimpurity(set1)
	
end

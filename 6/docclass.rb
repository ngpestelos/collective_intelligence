def getwords(doc)
	words = doc.scan(/\w*/).map{|w| w.downcase if w.length > 2 && w.length < 20}.compact!
	words.uniq
end

class Classifier
	attr :fc
	attr :cc

	def initialize(getfeatures, filename=nil)
		@fc = Hash.new{|h,k| h[k] = Hash.new{|h1,k1| h1[k1] = 0}} #hash of hashes of 0
		@cc = Hash.new{|h,k| h[k] = 0}
		@getfeatures = getfeatures
	end

	def incf(f, cat)
		@fc[f][cat] += 1
	end

	def incc(cat)
		@cc[cat] += 1
	end

	def fcount(f, cat)
	#	return 0.0 unless @fc.keys.flatten.include?(f) && @fc[f].keys.include?(cat)

		@fc[f][cat].to_f
	end

	def catcount(cat)
	#	return 0 unless cc.keys.include?(cat)

		@cc[cat].to_f
	end

	def totalcount
		@cc.values.inject(0){|m,o| m += o; m}
	end

	def categories
		@cc.keys
	end

	def train(item, category)
		features = @getfeatures.call(item)
		pp features
		features.each {|f| incf(f, category)}

		incc(category)
	end
end

def test1
	getfeatures = lambda{|*args| getwords(*args)}
	cl = Classifier.new(getfeatures)

	cl.train('the quick brown fox jumps over the lazy dog', 'good')
	cl.train('make quick money in the online casino', 'bad')
	p cl.fcount('quick', 'good')
	puts "should be 1.0\n\n"
	p cl.fcount('quick', 'bad')
	puts "should be 1.0\n\n"
end

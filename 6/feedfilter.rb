require 'rubygems'
require 'rfeedparser'
require 'docclass'

def read(feed, classifier)

  feed = FeedParser.parse(feed)

  feed.entries.each do |e|
    puts ""
    puts "-----"
    puts 'Title:     ' + e.title
    puts 'Publisher: ' + e.publisher
    puts ""
    puts e.summary

    fulltext = e.title + "\n" + e.publisher + "\n" + e.summary

    print "Guess: ", classifier.classify(fulltext) + "\n"
    print "Category: "
    cl = gets
    classifier.train(fulltext, cl)
  end

end

def test
  @@getfeatures = lambda { |args| getwords(args) }
  cl = NaiveBayes.new(@@getfeatures)
  read('http://blogsearch.google.com/blogsearch_feeds?hl=en&q=python&ie=utf-8&num=10&output=rss', cl)
end

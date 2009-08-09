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

    fulltext = "%s\n%s\n%s", e.title, e.publisher, e.summary

    print "Guess: ", classifier.classify(fulltext)
    ans = gets('Category: ').chomp
  end

end

@@getfeatures = lambda { |*args| getwords(*args) }
cl = NaiveBayes.new(@@getfeatures)
read('http://blogsearch.google.com/blogsearch_feeds?hl=en&q=python&ie=utf-8&num=10&output=rss', cl)

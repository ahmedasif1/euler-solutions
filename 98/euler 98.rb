#!ruby
#finding anagram pairs
require 'set'

t1=Time.now
$max_number =-1
$inverted_hash={}
$set_of_squares = {}
$numbers = [0,1,2,3,4,5,6,7,8,9]
$hash_of_numbers={}
$max_word_length=-1

def apply_mapping string, mapping_char_to_digit
	mapping_char_to_digit.each do |char,digit|
		string = string.gsub(char,digit)
	end
	string
end

def generate_mapping word,square
	sq = square.to_s
	mapping_char_to_digit={}
	mapping_digit_to_char={}
	for i in 0..word.size-1
		if (!mapping_digit_to_char[sq[i]].nil? and mapping_digit_to_char[sq[i]]!=word[i]) or
		 (!mapping_char_to_digit[word[i]].nil? and mapping_char_to_digit[word[i]] != sq[i] )
		 return nil
		end
		mapping_digit_to_char[sq[i]] = word[i]
		mapping_char_to_digit[word[i]] = sq[i]
	end
	mapping_char_to_digit
end

def create_anagram_square_pairs key
	result = false
	word1 = $inverted_hash[key][0]
	word2 = $inverted_hash[key][1]
	puts "key: #{$set_of_squares[word1.length].size}"

	$set_of_squares[word1.length].each do |square|
		mapping = generate_mapping(word1,square)
		
		if !mapping.nil?
			#puts mapping.inspect
			word2_with_mapping = apply_mapping(word2,mapping)
			if word2_with_mapping[0]!='0' and $set_of_squares[word1.length].include? word2_with_mapping.to_i
				word1_with_mapping = apply_mapping(word1,mapping)
				puts "found square pair #{word1}: #{word1_with_mapping} #{word2} : #{word2_with_mapping}"
				$max_number = [word2_with_mapping.to_i,word1_with_mapping.to_i,$max_number].max
			end
		end
	end
end

def generate_squares
	limit = ($max_word_length+1)/2
	for i in 1..10**limit
		sq = i**2
		break if sq > 10**9
		len = sq.to_s.length
		$set_of_squares[len] = Set.new if $set_of_squares[len].nil?
		$set_of_squares[len].add(i**2)
	end
end


words_from_file=nil
File.open("p098_words.txt", "r") do |file| 
	string = file.read
	words_from_file = string.split(",").map { |word| word.delete('"') }
end

words2 = words_from_file.inject({}) do |hash,word| 
	hash[word] = word.chars.sort.join
	hash
end
words2.each do |word,sorted|
	$inverted_hash[sorted] = [] if $inverted_hash[sorted].nil?
	$inverted_hash[sorted].push word
end


$inverted_hash.each do |sorted,words_array|
	$inverted_hash.delete(sorted) if words_array.size<=1
end
$inverted_hash.each do |sorted,words_array|
	$max_word_length = sorted.squeeze.length if $max_word_length < sorted.squeeze.length
	#puts "#{sorted.squeeze} \t: #{words_array.inspect}"
end
puts "Possible anagrams #{$inverted_hash.size}"
generate_squares()
puts 'Squares generated'

puts "Going to find square anagrams"

 $inverted_hash.each do |sorted,words_array|
 	#puts "#{sorted.squeeze} \t: #{words_array.inspect}"
 	create_anagram_square_pairs(sorted) #if $max_number.to_s.length < words_array[0].length

 end
t2=Time.now

puts 'Time :' +'%0.2f'%((t2-t1)*1000) +' ms'
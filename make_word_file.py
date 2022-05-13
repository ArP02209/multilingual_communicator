import sys 

file1 = open(str(sys.argv[1]) , 'r')
file2 = open(str(sys.argv[2]) , 'w')

line = file1.readline()
punct = ['.' , ',' , '?' , '!' , ':' , ';' , '-' , '_']
word_count = 0

while line:
	if line[0].isalpha():
		words = line.split()
		
		word_count += len(words)
		
		for word in words:
			if word[-1] in punct:
				word = word[0:-1]
				
			file2.write(word+'\n')
			
	file2.write('------------------------\n')
	line = file1.readline()
			
print('word_count = ' , word_count)

file1.close()
file2.close()

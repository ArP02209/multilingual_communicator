import os
import sfst

CURR_DIR = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))
#print("SFST version " + sfst.__version__)
def gen_words():
	line = ger_words.readline()
	list1=list()
	while line:
		line = line.strip('\n')
		if '------------------------' in line:
			list1.append('.')
			list1.append('\n') 
		else:
			sfst.init(os.path.join(CURR_DIR+"/lib", 'smor.a'))
			analysis_results = sfst.analyse(line)
			#print(analysis_results)
			try:
				generate_results = sfst.generate(analysis_results[0])
				#print(generate_results)
			except IndexError:
				pass
			finally:
				list1.append(line)
			
		line = ger_words.readline()
	return list1
# Main code starts here
if __name__ == '__main__':
	ger_words=open('parallel_german_words','r')
	final_list=gen_words()
	#print(final_list)
	os.system("rm final_sent")
	#print("Generating sentence ...")
	for word in final_list:
		if '\n' not in word:
			open('final_sent', 'a').write(word+ ' ')
		else:
			open('final_sent', 'a').write(word)
		#print(line2)
		#os.system("echo {} >> final_sent".format(word))
	#print(".", file=open('final_sent','a'))
	#open('final_sent', 'a').write("\n")
ger_words.close()	
	

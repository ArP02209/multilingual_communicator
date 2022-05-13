import sys
import os
import re
import sfst

def make_dict():
	line = ger_analysis_file.readline()
	#German List
	list1=list()
	while line:
		line = line.strip('\n')
		if "new_word" not in line:
			words = line.split('<')
			#print(words)
			new_word=re.sub('[^a-zA-Z0-9 \n\.]', '', words[0])
			#print(new_word)
			if new_word!= "":
				if words[0] not in list1:
					list1.append(words[0])
		
		line= ger_analysis_file.readline()
	#print(list1)	
	return(list1)

def rep(ger_list, words):
	word= words[words.index("%")+1: -1]
	letter=word[0][0]
	for i in ger_list:
	    if i.startswith(letter):
	        words[words.index("%")+1]= i
	        break
	#print(words)
	return words   
# German dictionary

def new_dict(ger_list):
	os.system(" rm noun_dict")
	os.system(" touch noun_dict")
	os.system(" rm verb_dict")
	os.system(" touch verb_dict")
	line2 = sbn_file.readline()
	while line2:
		line2 = line2.strip()
		#print(line2)
		words = line2.split()
		#print(words)
		if line2.startswith("%%%"):
		    pass
		elif "company.n.01" in line2:
		    os.system("echo company:{} >> noun_dict".format(words[2]))
		elif "female.n.02" in line2: 
		    os.system("echo female:{} >> noun_dict".format(words[2]))
		elif "time.n." in line2:
		    pass
		elif "v." in line2:
		    repl_word= rep(ger_list,words)
		    #print(repl_word)
		    os.system("echo {},{} >> verb_dict".format(words[0][ : len(words[0]) - 5],repl_word[repl_word.index("%")+1]))

		    #re.sub('[^a-zA-Z0-9 \n\.]', '', words[0])
		line2 = sbn_file.readline()	
		
# Main code starts here
if __name__ == '__main__':
	sbn_file = open(str(sys.argv[1]) , 'r')
	#sbn_file= open('/home/adityap/MC2.0/sbn_test/pmb-4.0.0-de-gold_p00_d0712_de.drs.sbn', 'r+')
	"""
	if (os.system('bash trim.sh') == 0):
	  pass
	else:
	  os.system('cp sbn/pmb-4.0.0-de-gold_p00_d0712_de.drs.sbn sbn_test/pmb-4.0.0-de-gold_p00_d0712_de.drs.sbn')
	"""
	ger_analysis_file = open(str(sys.argv[2]) , 'r')
	ger_list= make_dict()
	print("Creating Dictionaries ..")
	new_dict(ger_list)

       
       		

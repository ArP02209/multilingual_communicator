import fileinput
import sys

print('formating file...')
flag = 0
i = 1
for line in fileinput.input(str(sys.argv[1]) , inplace = True):
	if 'analyze> ' in line:
		if 'no result for --' in line:
			i += 1
			#line = '\n-------------------------------------------------------\n' + str(i)
			line = '\n-------------------------------------------------------\n'
		if flag == 1:
			line = line.replace('analyze> ' , '\n')
		else:
			flag = 1
			line = line.replace('analyze> ' , '')
			
	if '<CAP>' in line:
		line = line.replace('<CAP>' , '')
		
	if 'generate> ' in line:
		line = line.replace('generate> ' , '')
		flag = 0
	if line.startswith('>') or 'no result' in line:
		if line.startswith('> ---'):
			i += 1
			#line = ('\n----------------------\n\n' + str(i) + '\n')
			line = ('\n----------------------\n\n' + '\n')
		elif line.startswith('no result'):
			line = ''
		else:
			line = 'new_word\n'
	
	print(line , end = '')

print('Formatting Finished.')

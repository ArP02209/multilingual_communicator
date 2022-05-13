# Multilingual_Communicator
This repository consists of project whose aim is to translate one language (English) into more than one language say German and Japenese. For now, it can translate english to german sentence by executing different files specified in this repository.

#How to create virtual environment in Ubuntu:
- >As a pre-requisite,on your system python and pip package manager for python should be pre-installed (which is there in versions of Ubuntu greater than 18.04). You can also check whether python is installed in your system or not using command-> "python3 -V"

- > Then follow the below steps in order to create virtual environment using python:-
'''
          pip install virtualenv #To install virtualenv library available in python
          virtualenv <env_name>  # To create virtual environment
          source <env_name>/bin/activate  # To activate virtual environment created in previous step
'''
- > After activating you will see environment name in braces in terminal. Python is installed automatically while creating environment along with pip package manager along with some libraries like, os, sys,wheel that you can check using command-> "pip list"

- > But, you require one package to be installed in your virtual environment for working of project called "sfst" that can be installed using command-> "pip install sfst". Then you can setup project in virtual environment.

- > To come out of virtual environment, we can use "deactivate" command.

#Files in package
- > IMP FILES
1. convert_v2.py: Python file to create dictiornary respectively according to their parts of speech.
2. parallel_german_words.txt: Parallel German words seperated in each line.
3. format_file.py: Python file to format the analysis obtained from SMOR and remove unwanted symbols.
4. ger_analysis: Text file in which german analysis (after formatting) will be stored.
5. german_sent: Text file containing german sentence that we will pass as input to our program.
6. make_word.py: Python file to convert german sentences into parallel german words as SMOR only accepts and give word by word analysis.
7. links.txt: Text file containing links of all the tools and softwares we have used in this project.
8. noun_dict: Dictionary obtained containing only proper nouns and its attributes.
9. pmb-4.0.0-en-de-gold.tgz: Zip file containing all english and german gold sentences we have used.
10. verb_dict: Dictionary obtained containing english root word and german root word forms of verb.
11. test.py: Python file used to generate the final german sentence.
12. final_sent: Text file in which final sentence output will be stored.
13. setup.sh: Bash file that can be used to do all this process in one go.

- > Other files present in this package are not so important and can be used as references.
------------------------------------------------------------------------------------------------------------
#How to run module:
- > NOTE: i)Before running this bash file, you might need to install one library of python that is used with SMOR in order to get german sentence as final output. This library is named "sfst" and can be installed using command->
"pip install sfst".
ii) Also, while running bash file, you might get directory path error as the path I have given in bash file for SMOR will be different from yours so change it accordingly.
iii) Also, there might be case that you can receive message as "permission denied" for some bin files of SMOR. This is because you don't have the permission to execute those files. In order to tackle this problem, you can change permission using command->  "chmod 777 <file_name> "


1. setup.sh: 
        sh setup.sh <German sentence file> <Parallel_German_words_seperated_in_each_line> <SBN file>
For e.g:
        sh setup.sh german_sent parallel_german_words sbn_test/pmb-4.0.0-de-gold_p00_d0712_de.drs.sbn
This will create the dictionaries (noun and verb) according to SBN notations and store output in "noun_dict" and "verb_dict" files and will also genrate german sentence from the german analysis and store output in "final_sent" file. (In my case, SBN file is there in "sbn_test" folder but you can directly give sbn file as input to this bash file).

#Run python codes seperately
1. convert_v2.py: 
		python3 convert_v2.py <SBN file> <german analysis file>
Output will be stored in two files according to SBN notations as "noun_dict" and "verb_dict".

2. format.py:
		python3 format.py <German analysis file>
Output will be stored in "ger_analysis" file.

3. make_word.py:
		python3 make_word.py <German sentence file> <parallel german words file>
Output will be stored in "parallel_german_words" file.

4. test.py:
		python3 test.py <parallel german words file>
Output will be stored in "final_sent" file.

#Understand the flow of program
The existing system present used was giving output using a dictionary containing two words i.e., English root word and their equivalent German word. But management and understanding wise it was not so precise method, so we created separate dictionaries for different parts of speech. For example, if sentence consists of noun as well as verb, then we have written code which will detect each word present in the sentence is noun or verb and accordingly create separate dictionaries for them. Now, we will be generating german words out of analysis stored in file in previous process using SMOR as a generator. This will be done by providing each analysis of word one by one to SMOR but one drawback of this method is that it can’t be used to generate multiple sentences at a time. For this, we require one compact transducer which is not present in SMOR package and one binary file in order to compile this transducer. As a pre requisite, we first have to install some of packages namely SFST, Flex, Bison and then we will generate transducer with their help. But this method is not much feasible and thus as an alternative to this, we have used one python library called “sfst” that can be downloaded using “pip” command. Using this module, we can easily generate german sentences from analysis of each word.

For the translation process, first we have created one bash file which will take german sentence file as an input and as an output we will get analysis of each german word of sentence stored in other file and for doing this we have used one transducer of SMOR called “smor-infl” that can be used to give analysis for multiple german sentences at the same time. But, SMOR only accepts input as parallel german words and thus, for converting german sentences into parallel german words we have written another python file but output that we get in form of analysis is also in raw format. Thus, in order to do proper formatting, we have written another python file and put all these files into one bash files so that all the process will be done at once we run this bash file. 
Now, as a next step we have to create dictionaries containing English and german root words of respective sentences. For doing this, we have created another code to which we will give SBN file and analysis file obtained in previous step as an input. As stated in introduction all these sentences we have taken from PMB but it also provides some extra information about sentences. One of its parts is Discourse Representation Structure of each sentence. They can be represented into 3 types:
i) Box Notation, ii) Clause Notation, iii) SBN Notation which can be seen using PMB Explorer.
 
We can also go to respective document folders of PMB and see these notations are stored in separate files.
Now, in this code first we will call one function which will extract all the german root words from german analysis file and store it inside one list. Then, we will call another function and in that pass this list of root words as an input and read SBN file that we have passed earlier as input to code. This SBN file will gives us some more information or description about each word of sentence as you can see in above fig.3. according to syntax of Verbnet. As you can see, we can easily get English root word from SBN file we have applied conditions such that if this particular word is say noun, then it will create one separate dictionary for noun and if it is a verb, then a one separate dictionary for verb will be created accordingly and, in that dictionary, the corresponding English and german root words will be written.
Now, coming to the last and most important part of generation of german sentence, we have written one separate code for this on which we are currently working on and in future might merge it with the previous code that we have used for creating dictionary.
 
NOTE: In order to avoid problem of running each code individually, we have created one bash file called "setup.sh" that can be used to do all this process in one single go and no need to run individual files.

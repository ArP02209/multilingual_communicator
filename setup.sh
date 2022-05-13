#German analysis
SMOR=/home/adityap/iiitmc/MC2.0
python3 make_word_file.py $1 $2
$SMOR/smor-infl < $2 > ger_analysis
python3 format_file.py ger_analysis
#cmd/rftagger-german  german_sent > annotated.txt
#python3 correct_analysis.py german_analysis annotated.txt $3

#English analysis
#python3 make_word_file.py eng_sentence.txt parallel_english_words
#lt-proc -ca eng_morph/en.morf.bin < parallel_english_words > eng_analysis
python3 convert_v2.py $3 ger_analysis

python3 test.py $2

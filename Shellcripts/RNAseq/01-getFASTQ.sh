echo "Checking for the right number of unique sample IDs for both R1 and R2"
countFASTQ(){
	awk -F '_' '{print $1}' | \
	sort -u | \
	wc -l
}
export -f countFASTQ

R1=`ls -1 *R1*.gz | countFASTQ`
R2=`ls -1 *R2*.gz | countFASTQ`

echo "Creating a file of unique IDs based on first string from underscore delimiter"
ls -1 *fastq.gz | \
awk -F '_' '{print $1"}' | \
sort -u > \
task_samples.txt

echo "Creating final directory"
mkdir ../../raw_sequences
mv task_samples.txt ../..
mv *.fastq.gz ../../raw_sequences

echo "Checking read pairs"
cd ../../raw_sequences
pairedReads=$(($(ls | wc -l)/2))
if [ ${pairedReads} = ${R1} ]
then
        echo "${pairedReads} will be aligned using STAR"
else
        echo "ERROR: Incorrect number of read pairs in raw_sequences"
        echo "There are ${pairedReads} but there should be ${R1}"
        exit 1
fi

echo "Done"
exit 0
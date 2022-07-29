### AWK
The basic function of awk is to search files for lines (or other units of text) that contain certain patterns. When a line matches one of the patterns, awk performs specified actions on that line. awk continues to process input lines in this way until it reaches the end of the input files. ​

Awk breaks each line of input passed to it into fields. By default, a field is a string of consecutive characters delimited by whitespace (can be changed via –F ). Awk parses and operates on each separate field. This makes it ideal for handling structured text files -- especially tables -- data organized into consistent chunks, such as rows and columns.​

When you run awk, you specify an awk program that tells awk what to do. If no file specified awk will read from stdout

# AWK cheatsheet https://catonmat.net/ftp/awk.cheat.sheet.pdf
awk [options] 'program' input-file1 input-file2 …


FS Input Field Separator, a space by default
OFS Output Field Separator, a space by default. 
NF The Number of Fields in the current input record.
NR The total Number of input Records seen so far.
RS Record Separator, a newline by default.
FNR Contains number of lines read, but is reset for each file read.
-F fs Use fs for the input field separator (the value of the FS predefined variable).

${n} n-colum number

print Prints the current record. The output record is terminated with the value of the ORS variable. 

 Examples:

• print every line that has at least one field. This is an easy way to delete blank lines from a file (or rather, to create a new file similar to the old file but from which the blank lines have been removed).​
awk 'NF > 0' data

• print a sorted list of the login names of all users.
awk -F: '{ print $1 }' /etc/passwd | sort​

• print the even-numbered lines in the data file.​
awk 'NR % 2 == 0' data

#Change shell user USER from `/usr/sbin/nologin` to `/bin/bash`  
awk -F':' -v OFS=':' ' $1=="{USER}"  { $7 = "/bin/bash"} {print}' ./src/passwd > $FILE

#Save only 1-st 3-th 5-th 7-th columns of each string based on : delimiter
awk -F':' -v OFS=':' '{print $1,$3,$5,$7}' $FILE >




### SED

A Stream EDitor is used to perform basic transformations on text read from a file or a pipe. The result is sent to standard output. The syntax for the sed command has no output file specification, but results can be saved to a file using output redirection. The editor does not modify the original input. The sed tool is often used to perform find-and-replace actions on lines containing a pattern.

sed OPTIONS... [SCRIPT] [INPUTFILE...]

replace all occurrences of `hello` to `world` in the file input.txt:
sed 's/hello/world/' input.txt > 

sed writes output to standard output. Use -i to edit files in-place instead of printing to standard output.​

Examples:

Replace bash login shell with false for all users:​
$ sudo sed -i 's/bash/false/g' /etc/passwd​

Set bash login shell back only for vagrant user:
$ sudo sed -i '/vagrant/s/false/bash/g' /etc/passwd​

#Change shell user `avahi` from `/usr/sbin/nologin` to `/bin/bash` 
sed -i '/avahi/s|/usr/sbin/nologin|/bin/bash|g' $FILE

#Remove all lines from file containing word daemon
sed -i '/daemon/d' $FILE

#Replace two or more of the character e in a row with the string alala
sed -ie  's/[e]\{2,\}/alala/g' $FILE

#Replace every period . at the end of a line with an exclamation point !
sed -ie 's/.$/!/g' $FILE 

#Remove empty lines
sed -ie '/^$/d' $FILE 

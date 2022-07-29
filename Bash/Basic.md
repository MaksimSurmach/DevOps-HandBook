### BASIC

in start of script 
#!/usr/bin/env bash


if [[ -z "$string" ]]; then
  echo "String is empty"
elif [[ -n "$string" ]]; then
  echo "String is not empty"
fi


get_name() {
  echo "John"
}

echo "You are $(get_name)"


name="John"
echo ${name:0:2}    #=> "Jo" (slicing) Substring (position, length)


## loops

for i in /etc/rc.*; do
  echo $i
done

for ((i = 0 ; i < 100 ; i++)); do
  echo $i
done

for i in {1..5}; do
    echo "Welcome $i"
done

cat file.txt | while read line; do
  echo $line
done

## ARGS

$#	Number of arguments
$*	All positional arguments (as a single word)
$@	All positional arguments (as separate strings)
$1	First argument
$_	Last argument of the previous command

## Conditions

[[ -e FILE ]]	Exists
[[ -r FILE ]]	Readable
[[ -h FILE ]]	Symlink
[[ -d FILE ]]	Directory
[[ -w FILE ]]	Writable
[[ -s FILE ]]	Size is > 0 bytes
[[ -f FILE ]]	File
[[ -x FILE ]]	Executable

## arrays

Fruits=('Apple' 'Banana' 'Orange')
Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"

for i in "${arrayName[@]}"; do
  echo $i
done

echo ${Fruits[0]}           # Element #0
echo ${Fruits[-1]}          # Last element
echo ${Fruits[@]}           # All elements, space-separated
echo ${#Fruits[@]}          # Number of elements
echo ${#Fruits}             # String length of the 1st element
echo ${#Fruits[3]}          # String length of the Nth element
echo ${Fruits[@]:3:2}       # Range (from position 3, length 2)
echo ${!Fruits[@]}          # Keys of all elements, space-separated

## HEREDOC

$ cat <<EOF > unit.file​

[Unit]​

Description=Raise network interfaces​

Documentation=man:interfaces(5)​

​

[Install]​

WantedBy=multi-user.target​

WantedBy=network-online.target​

​

[Service]​

Type=oneshot​

EnvironmentFile=-/etc/default/networking​

EOF


$?	Exit status of last task
$!	PID of last background task
$$	PID of shell
$0	Filename of the shell script
$_	Last argument of the previous command
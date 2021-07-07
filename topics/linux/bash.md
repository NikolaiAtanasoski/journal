# Bash/Shell #

## notes ##
`$ variable`

[what are the special dollar sign shell variables?](https://stackoverflow.com/questions/5163144/what-are-the-special-dollar-sign-shell-variables)

[what is $* and $# in Linux?](https://superuser.com/questions/247127/what-is-and-in-linux/247131)


## builtins/programs ##
### grep ###
`set -Eeuo pipefail` problems with subshell grep

if nothing is found -> return code = 1

### diff ###

```bash
diff file1 file2
diff -q report only when files differ
diff -r recursively compare any subdirectories found

diff -qr directory1 directory2 #see above
```

### parameter expansion ###
[gnu bash manual link on parameter expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion)

```bash
string=01234567890abcdefgh
$ echo ${string:7}
7890abcdefgh
$ echo ${string:7:0}

$ echo ${string:7:2}
78
$ echo ${string:7:-2}
7890abcdef
$ echo ${string: -7}
bcdefgh
```

## loops and logic ##
```bash
for file in some_folder*; do 
  echo $file
  diff -r $file other_folder/${file##*/}
done
```

## globbing ##
```bash
process_files() {
  #asterisk outside of Quotes to enable globbing
  for old_file in "${OUTPUT_FILE_DIR}/START_OF_NAME"*"${OTHER_VARIABLE}"*".END.OF.FILE"; do
      method_to_call()
  done 
}
```

## awk ##
```bash
# save only wordcount number to variable 
countOutput=$(wc -l ${outputFileFullPath} | awk '{ print $1 }') 1>/dev/null
```
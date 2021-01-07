#!/bin/bash
# var="reformatted /home/ricks/Development/personal/gh-actions/action-black-new/testdata/num_guess.py reformatted /home/ricks/Development/personal/gh-actions/action-black-new/testdata/subfolder/queen_problem.py All done! ✨ 🍰 ✨ 2 files reformatted."
var="reformatted /home/ricks/Development/personal/gh-actions/action-black-new/testdata/num_guess.py reformatted /home/ricks/Development/personal/gh-actions/action-black-new/testdata/subfolder/queen_problem.py All done! ✨ 🍰 ✨  1 file reformatted, 1 file left unchanged, 1 file failed to reformat."
echo "this is the string we are going to analyze:"
echo "$var"
echo "  "

regex='\s?[0-9]+\sfiles? reformatted(\.|,)\s?'
echo "This is the regex we will use to try analyzing the text:"
echo "$regex"
echo "  "

if [[ "$var" =~ $regex ]]
then
    echo "matched the following text:"
    echo ${BASH_REMATCH[0]}
    echo ${BASH_REMATCH[1]}
    echo ${BASH_REMATCH[2]}
else
    echo "didn't match!"
fi
echo "jan"
#################
#   Functions   #
#################

# Changes directory and lists the content inside
function cdl () {
     cd $1
     l
}

# Make directory and cd into it
mcd () { mkdir "$1" && cd "$1"; }

# Look in directory without cd into it
pk () {
    cd $1
    la
    cd ..
}

# goto *any folder* Added support for any computer user
goto () {
    GOTO_ROOT=$(echo ~)

    PRNAMES="opt usr"
    PRPATHS="$GOTO_ROOT/opt $GOTO_ROOT/usr $GOTO_ROOT/Library $GOTO_ROOT/.Trash $GOTO_ROOT/Music $GOTO_ROOT/Pictures $GOTO_ROOT/Applications $GOTO_ROOT/tmp $GOTO_ROOT/Public $GOTO_ROOT/.*"

    if [ "$OS" = "Darwin" ]; then
        updatedb --localpaths="$GOTO_ROOT" --prunepaths="$PRPATHS" --output="$GOTO_ROOT/.cache/goto.db"
    else
        # update the database
        updatedb --prunenames="$PRNAMES" -l 0 -U ~/ -o ~/.cache/goto.db
    fi

    # and then search it
    cd "$(locate -d ~/.cache/goto.db -i "$@" | awk '{print length(), $0 | "sort -n" }' | head -n 1 | cut -d " " -f2)";
}

# cd no matter what
cdmagic() {
    #!/bin/bash
    DIRECTORY=$1
    # backlslashes before command removes the alias
    \cd "$DIRECTORY" 2> /tmp/_cdmagic_result
    if [ "$DIRECTORY" == "" ]; then
        \cd ~
    fi
    RESULT=$(</tmp/_cdmagic_result)
    if [ "$RESULT" == "" ]; then
        return
    fi
    NEW_PATH="./"
    IFS="/"
    for folder in ${DIRECTORY[@]}; do
        dir_list=$(ls -1Fa "$NEW_PATH" | grep /)
        include_amt=${#folder}
        found="false"
        while [ "$include_amt" -gt 0 ]; do
            # grep the result
            RESULT=$(echo "$dir_list" | egrep -i "^(${folder:0:$include_amt})")
            if [ "$RESULT" != "" ]; then
                # set IFS to newline
                IFS=$'\n'
                RESULT=($RESULT)

                # only echo out the first result
                NEW_PATH="${NEW_PATH}${RESULT[0]}"

                # set it back
                IFS="/"
                found="true"
                break
            fi
            # subtract one from the include amount
            include_amt=$(($include_amt - 1))
        done
        if [ "$found" == "false" ]; then
            echo "couldn't find $DIRECTORY"
            return
        fi
    done
    \cd "$NEW_PATH"
}

# cd to the git root
cdgroot() {
    original_folder=$(pwd)
    while [ true ]; do
        git_folder=$(ls -1Fa . | grep ".git/")
        # if none found, go back to original folder
        if [ $(pwd) == "/" ]; then
            cd "$original_folder"
            return
        fi
        # keep cding out until you reach a dir with .git/ in it
        if [ "$git_folder" == "" ]; then
            cd ..
        else
            return
        fi
    done
}
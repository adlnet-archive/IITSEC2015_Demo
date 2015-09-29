#!/bin/bash

# root directory of the IITSEC repo (i.e. where this script is)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# find sqlite binary
if [ $OSTYPE = "linux-gnu" ]; then
	SQLITE=$( which sqlite3 )
else
	SQLITE="$DIR/sqlite3.exe"
fi


if [ ! -e "$DIR/.git/MERGE_HEAD" ]
then
	echo "No merge is underway! Run 'git merge' before this script."

else
	# get commit heads
	origHead=$( cat "$DIR/.git/ORIG_HEAD" )
	mergeHead=$( cat "$DIR/.git/MERGE_HEAD" )
	commonHead=$(git merge-base $origHead $mergeHead)

	# back up the working directory db
	if [ -e "$DIR/assets/database.sqlite" ]; then
		mv "$DIR/assets/database.sqlite" "$DIR/assets/database.sqlite.working"
	fi

	# check out the two versions of the db
	git checkout $origHead -- assets/database.sqlite
	mv "$DIR/assets/database.sqlite" "$DIR/assets/database.sqlite.ours"
	git checkout $mergeHead -- assets/database.sqlite
	mv "$DIR/assets/database.sqlite" "$DIR/assets/database.sqlite.theirs"
	git checkout $commonHead -- assets/database.sqlite
	mv "$DIR/assets/database.sqlite" "$DIR/assets/database.sqlite.common"
	
	# dump the two versions
	$SQLITE "$DIR/assets/database.sqlite.ours" .dump > "$DIR/dbdump.sql.ours"
	$SQLITE "$DIR/assets/database.sqlite.theirs" .dump > "$DIR/dbdump.sql.theirs"
	$SQLITE "$DIR/assets/database.sqlite.common" .dump > "$DIR/dbdump.sql.common"

	# clean up now-redundant db binaries
	rm "$DIR/assets/database.sqlite.ours" "$DIR/assets/database.sqlite.theirs" "$DIR/assets/database.sqlite.common"
	mv "$DIR/assets/database.sqlite.working" "$DIR/assets/database.sqlite"

	diff -u "$DIR/dbdump.sql.common" "$DIR/dbdump.sql.theirs" > "$DIR/diff.theirs"
	diff -u "$DIR/dbdump.sql.common" "$DIR/dbdump.sql.ours" > "$DIR/diff.ours"
fi

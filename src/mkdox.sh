#!/bin/bash

HTMLNAME=
DOXYFILE=doxygen.cfg

make-doxyfile() {
	if [[ ! $(which doxygen 2>/dev/null) ]]; then
		echo -e "ERROR: Doxygen is not installed !!!"
		return 1
	fi

	if [ -f $DOXYFILE ]; then
		echo -e "Doxyfile '$DOXYFILE' is already generated !!!"
		echo -e "Running 'doxygen $DOXYFILE' to generate documentaion ..."
		return 0
	fi

	# Read user inputs
	read -p 'Enter Project name     : ' PROJECTNAME
	if [ "$PROJECTNAME" == "" ]; then
		echo -e "\nERROR: Invalid Project name !!!"
		return 1
	fi

	read -p 'Enter Version number   : ' PROJECTVERSION
	if [ "$PROJECTVERSION" == "" ]; then
		echo -e "\nERROR: Invalid Project version !!!"
		return 1
	fi

	read -p "Enter URL name to append to 'localhost/<url>' : " HTMLNAME
	if [ "$HTMLNAME" == "" ]; then
		echo -e "\nERROR: Invalid URL !!!"
		return 1
	fi

	OUTPUTPATH=/var/www/html
	TABSIZE=2
	FILEPATTERNS=*
	EXCLUDEPATH='obj dist .git *-build __html __ktags'
	EXCLUDEPATTERNS='*.a *.d *.o *.so *.so.* *.out *.swo *.swp'

	read -p 'Enter Description      : ' PROJECTDESC
	read -p 'Enter Logo path        : ' LOGOPATH
	read -p 'Enter Mainpage path    : ' MAINPAGE
	#read -p 'Enter Destination path : ' OUTPUTPATH
	#read -p 'Enter HTML output name : ' HTMLNAME
	#read -p 'Enter TAB size         : ' TABSIZE
	#read -p 'Enter File patterns    : ' FILEPATTERNS
	#read -p 'Enter Path to include  : ' INCLUDEPATH
	#read -p 'Enter Path to exclude  : ' EXCLUDEPATH
	#read -p 'Enter Patterns to exclude : ' EXCLUDEPATTERNS

	# Write doxyfile
	cat <<-DOXYFILE_CONFIGS >> $DOXYFILE
	#---------------------------------------------------------
	# Project related configuration options
	#---------------------------------------------------------

	PROJECT_NAME           = $PROJECTNAME
	PROJECT_NUMBER         = $PROJECTVERSION
	PROJECT_BRIEF          = "$PROJECTDESC"
	PROJECT_LOGO           = $LOGOPATH
	USE_MDFILE_AS_MAINPAGE = $MAINPAGE
	OUTPUT_DIRECTORY       = $OUTPUTPATH
	HTML_OUTPUT            = $HTMLNAME
	TAB_SIZE               = $TABSIZE
	OPTIMIZE_OUTPUT_FOR_C  = YES
	INTERNAL_DOCS          = YES

	#---------------------------------------------------------
	# Configuration options related to source browsing
	#---------------------------------------------------------

	INLINE_SOURCES         = YES
	SOURCE_BROWSER         = YES
	FILE_PATTERNS          = $FILEPATTERNS
	RECURSIVE              = YES
	EXCLUDE                = $EXCLUDEPATH
	EXCLUDE_SYMLINKS       = YES
	EXCLUDE_PATTERNS       = $EXCLUDEPATTERNS
	EXTRACT_ALL            = YES
	EXTRACT_STATIC         = YES
	EXTRACT_ANON_NSPACES   = YES
	EXTRACT_LOCAL_CLASSES  = YES
	SHOW_INCLUDE_FILES     = YES

	#---------------------------------------------------------
	# Configuration options related to the preprocessor
	#---------------------------------------------------------

	ENABLE_PREPROCESSING   = YES
	MACRO_EXPANSION        = YES
	SKIP_FUNCTION_MACROS   = NO
	INCLUDE_PATH           = $INCLUDEPATH

	#---------------------------------------------------------
	# Configuration options related to the dot tool
	#---------------------------------------------------------

	CLASS_DIAGRAMS         = YES
	HAVE_DOT               = YES
	DOT_NUM_THREADS        = 4
	CLASS_GRAPH            = YES
	COLLABORATION_GRAPH    = YES
	GROUP_GRAPHS           = YES
	HIDE_UNDOC_RELATIONS   = NO
	INCLUDE_GRAPH          = NO
	INCLUDED_BY_GRAPH      = NO
	CALL_GRAPH             = YES
	CALLER_GRAPH           = YES

	#---------------------------------------------------------
	# Configuration options related to the HTML output
	#---------------------------------------------------------

	GENERATE_HTML          = YES
	HTML_TIMESTAMP         = YES
	GENERATE_TREEVIEW      = YES
	SEARCHENGINE           = YES
	GENERATE_LATEX         = NO

	#EOF
	DOXYFILE_CONFIGS

	echo "Done"
}

# Main procedure
make-doxyfile
if [ $? -ne 0 ]; then
	exit 1
fi

doxygen $DOXYFILE
if [ $? -eq 0 ]; then
	echo -e "\nExplore the project at localhost:9596/$HTMLNAME"
else
	echo "Doxygen command failed !!!"
	exit 1
fi

exit $?

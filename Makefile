#  This makefile generates the eBooks from the HTML files using Pandoc

#  Constants
DIR = _build
OUTPUT = lua5.2-manual
KINDLEGEN = /Users/ngn999/Downloads/KindleGen_Mac_i386_v2_9/kindlegen
# PDFOPTS = --chapters --smart --standalone --table-of-contents
PDFOPTS = --chapters --smart --standalone
# EPUBOPTS = --smart --standalone --table-of-contents
EPUBOPTS = --smart --standalone
HTML_FILES = index.html contents.html manual.html



#  ---------------------------------
#  Public targets
all: clean create_epub create_kindle remove_files

pdf: clean create_pdf remove_files

epub: clean create_epub remove_files

kindle: clean create_kindle remove_files

clean:
	if [ -d "${DIR}" ]; \
		then rm -r ./${DIR}; \
	fi

#  ---------------------------------
#  Private targets
#  If the build directory does not exist, create it
create_folder:
	if [ ! -d "${DIR}" ]; then \
		mkdir -p ${DIR}; \
		cp -r www.lua.org/* ${DIR}; \
	fi

#  Generate PDF
create_pdf: create_folder
	cd ${DIR}/manual/5.2/; \
	pandoc ${PDFOPTS} -o ${OUTPUT}.pdf ${HTML_FILES}

#  Generate EPUB
create_epub: create_folder
	cd ${DIR}/manual/5.2/; \
	pandoc ${EPUBOPTS} -o ${OUTPUT}.epub ${HTML_FILES}

#  Create Kindle version (ignoring the error that it outputs)
create_kindle: create_epub 
	cd ${DIR}/manual/5.2/; \
	${KINDLEGEN} ${OUTPUT}.epub

#  Clean up, so that only the product files remain
remove_files: create_folder
	#-rm -rf ./${DIR}/*

# wget -p -k -np -r http://www.lua.org/manual/5.2/

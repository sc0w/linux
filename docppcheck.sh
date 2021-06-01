#!/bin/sh

#dpkg-buildpackage -b -rfakeroot -us -uc -j$1 > log 2> log2
#curl -F file=@log -F expires=6m -F no_index=true https://api.anonymousfiles.io/ && echo
#curl -F file=@log2 -F expires=6m -F no_index=true https://api.anonymousfiles.io/ && echo

# send the long living command to background
#cppcheck --enable=$CHECKIDS --force -j $CPU_COUNT .
cppcheck --xml --output-file=cppcheck.xml --enable=warning,style,performance,portability,information,missingInclude --force -j 2 . &> /dev/null
#cppcheck-htmlreport --title=${REPO_NAME} --file=cppcheck.xml --report-dir=libhandy_cppcheck-htmlreport --source-encoding="iso8859-1" &> /dev/null
#tar -zcf libhandy_cppcheck-htmlreport.tar.gz libhandy_cppcheck-htmlreport

# Constants
RED='\033[0;31m'
minutes=0
limit=3

while kill -0 $! >/dev/null 2>&1; do
  echo -n -e " \b" # never leave evidences!

  if [ $minutes == $limit ]; then
    echo -e "\n"
    echo -e "${RED}Test has reached a ${minutes} minutes timeout limit"
    exit 1
  fi

  minutes=$((minutes+1))

  sleep 60
done

curl -F file=@log -F expires=6m -F no_index=true https://api.anonymousfiles.io/ && echo
curl -F file=@log2 -F expires=6m -F no_index=true https://api.anonymousfiles.io/ && echo

exit 0

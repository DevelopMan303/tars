#!/bin/sh

TEST_DIR="testdir"
TEST_FILE="$TEST_DIR/testtars.txt"
TEST_FILE_STR="test tars 1234567890"
TEST_FILE_MD5="94296a32c4da2e233"
TARS=../tars


# @brief  Creates folder and file to create later test archives
CreateTestDir()
{
  mkdir "$TEST_DIR"
  echo "$TEST_FILE_STR" > "$TEST_FILE"
}
# @brief  Create archives
CreateTestFiles(){
  tar cfv  test.tar    "$TEST_DIR"

  tar cfvz test.tar.gz "$TEST_DIR"

  # how to test gzip ????

  # *.tar.bz"
  tar cfvj test.tar.bz2 "$TEST_DIR"

  # *.zip"
  zip -r test.zip "$TEST_DIR"
}

# @brief  Do tars from the archives. Check the md5sum of file
# param $1 filename to extract
# todo: Check restul, actual only visual
CheckTestFile(){
  FILE_NAME="$1"

  rm -rf "$TEST_DIR"

  "$TARS" "$FILE_NAME" > /dev/null

  md5sum "$TEST_FILE" | grep -q -i "$TEST_FILE_MD5"
  if [ $? -ne 0 ] ; then
    echo "$FILE_NAME - NOK!" ;
    return -1
  fi

  echo "$FILE_NAME - ok" ;
}

TEST_CreateArchiveAndTest(){

  # Create a dir with a file and pack these files.
  # Then this files are extracect and md5 is checked.
  CreateTestDir > /dev/null
  CreateTestFiles > /dev/null

  CheckTestFile test.tar
  CheckTestFile test.tar.gz
  CheckTestFile test.tar.bz2
  CheckTestFile test.zip
}


TEST_CreateArchiveAndTest

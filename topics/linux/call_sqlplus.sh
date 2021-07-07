#!/bin/bash

set -Eeuo pipefail

rm -f $old_files

source .oracle_env_user
CONNECTION="$ORACLE_USERNAME/$ORACLE_PASSWORD@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=$ORACLE_HOST)(PORT=$ORACLE_PORT))(CONNECT_DATA=(SERVER=DEDICATED)(SID=$ORACLE_SID)))"

export WORK_DIR_BASE="/work-dir-base"

change_table() {
  program=$1

  echo "create synonym for ${program}"
  call_sqlplus_to_change_synonym "${program}"

}

call_sqlplus_to_change_synonym() {
  target_for_synonym="tableXYZ_${1}" #second argument is suffix for table change(java or cobol)
  echo "Synonym Target for tableXYZ: ${target_for_synonym}"

  echo -e "SELECT TABLE_NAME FROM USER_SYNONYMS WHERE SYNONYM_NAME = '$tableXYZ'\n-->"
  sqlplus -S -L $CONNECTION <<SQL
  whenever sqlerror exit sql.sqlcode;
  SET ECHO OFF;
  SET PAGESIZE 0;
  SET FEEDBACK OFF;
  SET SERVEROUTPUT ON;

  CREATE OR REPLACE SYNONYM tableXYZ
  FOR $target_for_synonym;

  SELECT TABLE_NAME 
  FROM USER_SYNONYMS 
  WHERE SYNONYM_NAME = 'tableXYZ';

  exit;
SQL
  #this SQL needs to be at the start of the line and no whitespaces after (only a newline is allowed) else it won't get recognized as the Here Document

}

print_rows_which_changed() {
  program=$1
  clause="123"
  
  sqlplus -S -L $CONNECTION <<SQL > $output_file
  SET ECHO OFF;
  SET FEEDBACK ON;
  SET SERVEROUTPUT OFF;
  SET LINESIZE 20000;
  SET TRIMSPOOL ON;
  SET TRIMOUT ON;
  SET PAGESIZE 0;

  SELECT *
  FROM tableXYZ
  WHERE clumn123 LIKE $clause;
  
  exit;
SQL
}

reset_table(){
  table="tableXYZ_${1}"

  sqlplus -S -L $CONNECTION <<SQL
  SET ECHO OFF;
  SET FEEDBACK OFF;
  
  TRUNCATE TABLE $table;

  INSERT INTO $table
  SELECT * FROM original_tableXYZ;
  COMMIT;
  exit;
SQL
}

drop_synonym() {
  sqlplus -S -L $CONNECTION <<SQL
  SET ECHO OFF;
  SET FEEDBACK OFF;

  DROP SYNONYM tableXYZ;
  
  exit;
SQL
}


start_java_batch() {

  export WORK_DIR="${WORK_DIR_BASE}/java"
  export DD_LOGFILE="${WORK_DIR}/logfile.log"
  
  PROG_PATH="${HOME}/java/programABC"
  LOG_PATH="file:${PROG_PATH}/log4j.xml"

  javaPfad="/path/to/java"
  javaDebug="-Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=58555,suspend=n"


  ${javaPfad} ${javaDebug} \
    "-Dlog4j.configuration=${LOG_PATH}" \
    "-DDD_LOGFILE=${DD_LOGFILE}" \
    -cp "${PROG_PATH}/lib/*" \
    "at.atanasoski.mainMethod" \
    -settings ${WORK_DIR_BASE}/batch.properties 2>&1
  
}

start_cobol_batch() {
  export WORK_DIR="${WORK_DIR_BASE}/daten"
  cd $WORK_DIR 
  # run cobol 
  cd -
}

compare_results() {
  echo "diff:"
  diff "java.output.txt" "cobol.output.txt"
  echo "DIFF RETURN: $?"
}

main() {
  #run_java
  #run_cobol
  #compare_results
}

cleanup_after_run() {
  drop_synonym
}

run_java() {
  change_table "java"
  start_java_batch
  print_rows_which_changed "java"
  #cat "java.output.txt"
  reset_table "java"
}

run_cobol() {
  change_table "cobol"
  start_cobol_batch
  print_rows_which_changed "cobol"
  # cat "cobol.output.txt"
  # reset_table "cobol"
}

# reset_table "java"
# reset_table "cobol"
# exit


main | tee java_cobol_comparison.log

echo "vor cleanup"
cleanup_after_run
exit 0

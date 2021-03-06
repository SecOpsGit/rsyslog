#!/bin/bash
# This file is part of the rsyslog project, released under GPLv3
echo ===============================================================================
echo \[mysql-basic.sh\]: basic test for mysql-basic functionality
. $srcdir/diag.sh init
mysql --user=rsyslog --password=testbench < testsuites/mysql-truncate.sql
. $srcdir/diag.sh startup mysql-basic-cnf6.conf
. $srcdir/diag.sh injectmsg  0 5000
. $srcdir/diag.sh shutdown-when-empty
. $srcdir/diag.sh wait-shutdown 
# note "-s" is requried to suppress the select "field header"
mysql -s --user=rsyslog --password=testbench < testsuites/mysql-select-msg.sql > rsyslog.out.log
. $srcdir/diag.sh seq-check  0 4999
. $srcdir/diag.sh exit

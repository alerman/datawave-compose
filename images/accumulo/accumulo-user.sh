#!/usr/bin/env bash

CFG_FILE=/tmp/accumulo.cfg
ACCUMULO_USER=datawave
ACCUMULO_PASS=datawave

echo "createuser $ACCUMULO_USER" > $CFG_FILE
echo "setauths -u $ACCUMULO_USER -s foo,bar,baz" >> $CFG_FILE
echo "config -s table.classpath.context=datawave" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.CREATE_TABLE" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.DROP_TABLE" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.ALTER_TABLE" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.CREATE_NAMESPACE" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.DROP_NAMESPACE" >> $CFG_FILE
echo "grant -u $ACCUMULO_USER -s System.ALTER_NAMESPACE" >> $CFG_FILE
echo "exit" >> $CFG_FILE

chmod 666 $CFG_FILE
echo -e "$ACCUMULO_USER\n$ACCUMULO_PASS\n" | /opt/accumulo/current/bin/accumulo shell -u root -p test -f $CFG_FILE | sed '/.*WARN: Found no client\.conf in default paths.*/d'
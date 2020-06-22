#!/bin/bash
export CATALINA_OPTS="$CATALINA_OPTS -server"
export CATALINA_OPTS="$CATALINA_OPTS -Xms2048m"
export CATALINA_OPTS="$CATALINA_OPTS -Xmx4096m"
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UseParallelGC"
export CATALINA_OPTS="$CATALINA_OPTS -Duser.timezone=GMT"
export JAVA_OPTS="$JAVA_OPTS -Xms2048m -Xmx4096m -XX:+UseParallelGC"

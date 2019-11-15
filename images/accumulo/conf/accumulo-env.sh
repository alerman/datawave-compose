if [ -z $HADOOP_HOME]
then
  test -z "$HADOOP_PREFIX" && export HADOOP_PREFIX=/usr/lib/hadoop
else
  HADOOP_PREFIX="$HADOOP_HOME"
  unset $HADOOP_HOME
fi

test -z "$HADOOP_CONF_DIR" && export HADOOP_CONF_DIR="$HADOOP_HADOOP_PREFIX/etc/hadoop"
test -z "$JAVA_HOME" && export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk/
test -z "$ACCUMULO_LOG_DIR" && export ACCUMULO_LOG_DIR=/srv/logs/accumulo
test -z "$ZOOKEEPER_HOME" && export ZOOKEEPER_HOME=/usr/lib/zookeeper

if [ -f ${ACCUMULO_CONF_DIR}/accumulo.policy ]
then
  POLICY="-Djava.security.manager -Djava.security.policy=${ACCUMULO_CONF_DIR/accumulo.policy}"
fi

test -z "$ACCUMULO_TSERVER_OPTS" && export ACCUMULO_TSERVER_OPTS="${POLICY} -Xmx4096m -Xms1024m -Djblocks.classification.markings=hdfs://namenode:8020/accumulo-datawave-classpath/ewh-markings.txt -Dzookeeper.sasl.client=false"
test -z "$ACCUMULO_MASTER_OPTS" && export ACCUMULO_MASTER_OPTS="${POLICY} -Xmx4096m -Xms1024m -Dzookeeper.sasl.client=false"
test -z "$ACCUMULO_MONITOR_OPTS" && export ACCUMULO_MONITOR_OPTS="${POLICY} -Xmx64m -Xms64m -Dzookeeper.sasl.client=false"
test -z "$ACCUMULO_GC_OPTS" && export ACCUMULO_GC_OPTS="-Xmx64m -Xms64m -Dzookeeper.sasl.client=false"
test -z "$ACCUMULO_GENERAL_OPTS" && export ACCUMULO_GENERAL_OPTS="-XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -Djava.net.preferIPv4Stack=true"
test -z "$ACCUMULO_OTHER_OPTS" && export ACCUMULO_OTHER_OPTS="-Xmx128m -Xms64m "

export ACCUMULO_KILL_CMD="kill -9 %p"

export NUM_TSERVERS=1
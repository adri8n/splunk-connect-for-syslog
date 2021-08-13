#!/usr/bin/env bash
set -e

echo publish $1 $2
docker pull ghcr.io/splunk/splunk-connect-for-syslog/splunk-connect-for-syslog:$1
docker save ghcr.io/splunk/splunk-connect-for-syslog/splunk-connect-for-syslog:$1 | gzip -c > /tmp/oci_container.tar.gz

tags=$(echo $CONTAINER_SOURCE_IMAGE |sed 's|ghcr.io/splunk/splunk-connect-for-syslog/splunk-connect-for-syslog|docker.io/splunk/scs|g')
/tmp/regctl image copy $CONTAINER_SOURCE_IMAGE docker.io/splunk/scs:$1
for line in $tags; do echo working on "$line"; /tmp/regctl image copy $CONTAINER_SOURCE_IMAGE $line; done

#!/bin/sh

# Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License.
# A copy of the License is located at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# or in the "license" file accompanying this file. This file is distributed
# on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
# express or implied. See the License for the specific language governing
# permissions and limitations under the License.


#Download opensourceversion
ES_VERSION=7.1.1
OD_VERSION=1.1.0
OD_PLUGINVERSION=$OD_VERSION.0
PACKAGE=opendistroforelasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-$ES_VERSION-linux-x86_64.tar.gz
#Untar
tar -xzf elasticsearch-oss-$ES_VERSION-linux-x86_64.tar.gz 

#Install Plugin
for plugin_path in  opendistro-sql/opendistro_sql-$OD_PLUGINVERSION.zip opendistro-alerting/opendistro_alerting-$OD_PLUGINVERSION.zip opendistro-job-scheduler/opendistro-job-scheduler-$OD_PLUGINVERSION.zip opendistro-security/opendistro_security-$OD_PLUGINVERSION.zip performance-analyzer/opendistro_performance_analyzer-$OD_PLUGINVERSION.zip; 
do
    elasticsearch-$ES_VERSION/bin/elasticsearch-plugin install --batch "https://d3g5vo6xdbdb9a.cloudfront.net/downloads/elasticsearch-plugins/$plugin_path"; \
done

cp opendistro-tar-install.sh elasticsearch-$ES_VERSION

mv elasticsearch-$ES_VERSION $PACKAGE-$OD_VERSION
tar -vczf $PACKAGE-$OD_VERSION.tar.gz $PACKAGE-$OD_VERSION
shasum -a 512 $PACKAGE-$OD_VERSION.tar.gz  > $PACKAGE-$OD_VERSION.tar.gz.sha512
shasum -a 512 -c $PACKAGE-$OD_VERSION.tar.gz.sha512
#!/bin/bash

java -Xms512m -Xmx4g -Xmn2g -Xss128m -jar /opt/codesearch/opengrok/latest/lib/opengrok.jar \
    -c /opt/bin/ctags -s /opt/codesearch/opengrok/project -d /opt/codesearch/opengrok/data \
    -H -P -S -G -W /opt/codesearch/opengrok/opengrok_etc/configuration.xml --depth 15


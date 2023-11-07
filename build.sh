#!bin/bash

TARGET=xml-questions

docker run --user $(id -u):$(id -g) \
       -v $(pwd):/src -w /src -it --rm \
       chrwahl/fop -xml $TARGET.xml -xsl $TARGET.xsl -pdf $TARGET.pdf

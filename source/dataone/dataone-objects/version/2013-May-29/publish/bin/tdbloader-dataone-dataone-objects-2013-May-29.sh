#!/bin/bash

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

delete=""
#if [ ! -e publish/dataone-dataone-objects-2013-May-29.nt ]; then
#  delete="publish/dataone-dataone-objects-2013-May-29.nt"
#  if [ -e publish/dataone-dataone-objects-2013-May-29.nt.gz ]; then
#    gunzip -c publish/dataone-dataone-objects-2013-May-29.nt.gz > publish/dataone-dataone-objects-2013-May-29.nt
#  elif [ -e publish/dataone-dataone-objects-2013-May-29.ttl ]; then
#    echo "cHuNking publish/dataone-dataone-objects-2013-May-29.ttl into publish/dataone-dataone-objects-2013-May-29.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/dataone-dataone-objects-2013-May-29.ttl > publish/dataone-dataone-objects-2013-May-29.nt
#  elif [ -e publish/dataone-dataone-objects-2013-May-29.ttl.gz ]; then
#    gunzip -c publish/dataone-dataone-objects-2013-May-29.ttl.gz > publish/dataone-dataone-objects-2013-May-29.ttl
#    echo "cHuNking publish/dataone-dataone-objects-2013-May-29.ttl into publish/dataone-dataone-objects-2013-May-29.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/dataone-dataone-objects-2013-May-29.ttl > publish/dataone-dataone-objects-2013-May-29.nt
#    rm publish/dataone-dataone-objects-2013-May-29.ttl
#  else
#    echo publish/dataone-dataone-objects-2013-May-29.nt, publish/dataone-dataone-objects-2013-May-29.nt.gz, publish/dataone-dataone-objects-2013-May-29.ttl, or publish/dataone-dataone-objects-2013-May-29.ttl.gz needed to lod-materialize.
#    delete=""
#    exit 1
#  fi
#fi
load_file=""
if [ -e     "publish/dataone-dataone-objects-2013-May-29.nt" ]; then
  load_file="publish/dataone-dataone-objects-2013-May-29.nt"
elif [ -e   "publish/dataone-dataone-objects-2013-May-29.ttl" ]; then
  load_file="publish/dataone-dataone-objects-2013-May-29.ttl"
elif [ -e   "publish/dataone-dataone-objects-2013-May-29.ttl.gz" ]; then
  load_file="publish/dataone-dataone-objects-2013-May-29.ttl"
  gunzip -c  publish/dataone-dataone-objects-2013-May-29.ttl.gz > publish/dataone-dataone-objects-2013-May-29.ttl
     delete="publish/dataone-dataone-objects-2013-May-29.ttl"
elif [ -e   "publish/dataone-dataone-objects-2013-May-29.nt.gz" ]; then
  load_file="publish/dataone-dataone-objects-2013-May-29.nt"
  gunzip -c  publish/dataone-dataone-objects-2013-May-29.nt.gz > publish/dataone-dataone-objects-2013-May-29.nt
     delete="publish/dataone-dataone-objects-2013-May-29.nt"
fi

mkdir publish/tdb                         &> /dev/null
rm    publish/tdb/*.dat publish/tdb/*.idn &> /dev/null

if [[ ${#load_file} -eq 0 ]]; then
   echo "[ERROR] `basename $0 `could not find dump file to load."
   exit 1
fi
echo `basename $load_file` into publish/tdb as https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD_BASE_URI#/source/dataone/dataset/dataone-objects/version/2013-May-29 >> publish/ng.info

#if [[ ! `which tdbloader` ]]; then
#   echo "ERROR: tdbloader not found."
#   exit
#fi
if [[ $load_file == "publish/dataone-dataone-objects-2013-May-29.ttl" && "`too-big-for-rapper.sh`" == "yes" ]]; then
  dir="publish"
  echo "cHuNking publish/dataone-dataone-objects-2013-May-29.ttl in $dir"
  rm $dir/cHuNk*.ttl &> /dev/null
  ${CSV2RDF4LOD_HOME}/bin/split_ttl.pl $load_file
  for cHuNk in $dir/cHuNk*.ttl; do
    echo giving $cHuNk to tdbloader
    tdbloader --loc=publish/tdb --graph=`cat publish/dataone-dataone-objects-2013-May-29.nt.graph` $cHuNk
    rm $cHuNk
  done
else
  tdbloader --loc=publish/tdb --graph=`cat publish/dataone-dataone-objects-2013-May-29.nt.graph` $load_file
fi

if [ ${#delete} -gt 0 ]; then
   rm $delete
fi

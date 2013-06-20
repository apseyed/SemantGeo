#!/bin/bash

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

delete=""
#if [ ! -e publish/aeap_nys-dfw_lake_samples-2013-April-24.nt ]; then
#  delete="publish/aeap_nys-dfw_lake_samples-2013-April-24.nt"
#  if [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz ]; then
#    gunzip -c publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
#  elif [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl ]; then
#    echo "cHuNking publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl into publish/aeap_nys-dfw_lake_samples-2013-April-24.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
#  elif [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz ]; then
#    gunzip -c publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz > publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl
#    echo "cHuNking publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl into publish/aeap_nys-dfw_lake_samples-2013-April-24.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
#    rm publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl
#  else
#    echo publish/aeap_nys-dfw_lake_samples-2013-April-24.nt, publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz, publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl, or publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz needed to lod-materialize.
#    delete=""
#    exit 1
#  fi
#fi
load_file=""
if [ -e     "publish/aeap_nys-dfw_lake_samples-2013-April-24.nt" ]; then
  load_file="publish/aeap_nys-dfw_lake_samples-2013-April-24.nt"
elif [ -e   "publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl" ]; then
  load_file="publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl"
elif [ -e   "publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz" ]; then
  load_file="publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl"
  gunzip -c  publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz > publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl
     delete="publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl"
elif [ -e   "publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz" ]; then
  load_file="publish/aeap_nys-dfw_lake_samples-2013-April-24.nt"
  gunzip -c  publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
     delete="publish/aeap_nys-dfw_lake_samples-2013-April-24.nt"
fi

mkdir publish/tdb                         &> /dev/null
rm    publish/tdb/*.dat publish/tdb/*.idn &> /dev/null

if [[ ${#load_file} -eq 0 ]]; then
   echo "[ERROR] `basename $0 `could not find dump file to load."
   exit 1
fi
echo `basename $load_file` into publish/tdb as http://purl.org/twc/semantgeo/source/aeap_nys/dataset/dfw_lake_samples/version/2013-April-24 >> publish/ng.info

#if [[ ! `which tdbloader` ]]; then
#   echo "ERROR: tdbloader not found."
#   exit
#fi
if [[ $load_file == "publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl" && "`too-big-for-rapper.sh`" == "yes" ]]; then
  dir="publish"
  echo "cHuNking publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl in $dir"
  rm $dir/cHuNk*.ttl &> /dev/null
  ${CSV2RDF4LOD_HOME}/bin/split_ttl.pl $load_file
  for cHuNk in $dir/cHuNk*.ttl; do
    echo giving $cHuNk to tdbloader
    tdbloader --loc=publish/tdb --graph=`cat publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.graph` $cHuNk
    rm $cHuNk
  done
else
  tdbloader --loc=publish/tdb --graph=`cat publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.graph` $load_file
fi

if [ ${#delete} -gt 0 ]; then
   rm $delete
fi

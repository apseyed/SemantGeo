#!/bin/bash
#
# run publish/bin/4store-aeap_nys-dfw_lake_samples-2013-April-24.sh
# from aeap_nys/dfw_lake_samples/version/2013-April-24/

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

allNT=publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
if [ ! -e $allNT ]; then
   echo "run from aeap_nys/dfw_lake_samples/version/2013-April-24/"
   exit 1
fi

if [ ! -e /var/lib/4store/csv2rdf4lod ]; then
   4s-backend-setup csv2rdf4lod
   4s-backend       csv2rdf4lod
fi

4s-import -v csv2rdf4lod --model `cat publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.graph` $allNT
echo "run '4s-backend csv2rdf4lod' if that didn't work"

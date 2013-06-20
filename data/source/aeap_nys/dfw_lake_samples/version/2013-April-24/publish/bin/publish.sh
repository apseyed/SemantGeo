#!/bin/bash

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}
#sourceID="aeap_nys"
#datasetID="dfw_lake_samples"
#versionID="2013-April-24"
eID="1"

#graph="http://purl.org/twc/semantgeo/source/aeap_nys/dataset/dfw_lake_samples/version/2013-April-24"

export CSV2RDF4LOD_FORCE_PUBLISH="true"
source $CSV2RDF4LOD_HOME/bin/convert-aggregate.sh
export CSV2RDF4LOD_FORCE_PUBLISH="false"

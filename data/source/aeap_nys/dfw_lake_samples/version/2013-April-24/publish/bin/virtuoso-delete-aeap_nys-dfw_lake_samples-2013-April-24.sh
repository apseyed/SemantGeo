#!/bin/bash
#
# run publish/bin/virtuoso-load-aeap_nys-dfw_lake_samples-2013-April-24.sh
# from source/aeap_nys/dfw_lake_samples/version/2013-April-24/
#
# graph was http://purl.org/twc/semantgeo/source/aeap_nys/dataset/dfw_lake_samples/version/2013-April-24 during conversion
# metadataset graph was auto during conversion
#
#        $CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME            # <---- Loads into this with param --as-metadatset
#
#
#                               AbstractDataset                  # <---- Loads into this with param --abstract
#                     (http://.org/source/sss/dataset/ddd)                                                         
#                                     |                   \                                                        
# Loads into this by default -> VersionedDataset           meta  # <---- Loads into this with param --meta
#              (http://.org/source/sss/dataset/ddd/version/vvv)                                                    
#                                     |                                                                            
#                                LayerDataset                                                                      
#                                   /    \                                                                         
# Never loads into this ----> [table]   DatasetSample            # <---- Loads into this with param --sample
#
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Aggregating-subsets-of-converted-datasets
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Named-graph-organization

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}
CSV2RDF4LOD_BASE_URI=${CSV2RDF4LOD_BASE_URI:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

if [ `is-pwd-a.sh cr:dev` == 'yes' ]; then
   echo "Refusing to publish; see 'cr:dev and refusing to publish' at"
   echo "  https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-environment-variables-%28considerations-for-a-distributed-workflow%29"
   exit 1
fi
if [ -e 'publish/bin/ln-to-www-root-aeap_nys-dfw_lake_samples-2013-April-24.sh' ]; then
   # Make sure that the file we will load from the web is published
   publish/bin/ln-to-www-root-aeap_nys-dfw_lake_samples-2013-April-24.sh
fi

base="${CSV2RDF4LOD_BASE_URI_OVERRIDE:-$CSV2RDF4LOD_BASE_URI}"
graph="$base/source/aeap_nys/dataset/dfw_lake_samples/version/2013-April-24"
metaGraph="$graph"
if [ "$1" == "--sample" ]; then
   layerSlug="raw"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.raw.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/1"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.e1.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   exit 1
elif [[ "$1" == "--meta" && -e 'publish/aeap_nys-dfw_lake_samples-2013-April-24.void.ttl' ]]; then
   metaURL="$base/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.void.ttl"
   metaGraph="$base"/vocab/Dataset
   echo pvdelete.sh $metaGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $metaGraph
   exit 1
fi

# Change the target graph before continuing to load everything
if [[ "$1" == "--unversioned" || "$1" == "--abstract" ]]; then
   # strip off version
   graph="`echo $graph\ | perl -pe 's|/version/[^/]*$||'`"
   graph="$base/source/aeap_nys/dataset/dfw_lake_samples"
   echo populating abstract named graph \($graph\) instead of versioned named graph.
elif [[ "$1" == "--meta" ]]; then
   metaGraph="$base/vocab/Dataset"
elif [[ "$1" == "--as-metadataset" ]]; then
   graph="${CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME:-'http://purl.org/twc/vocab/conversion/MetaDataset'}"
   metaGraph="$graph"
elif [ $# -gt 0 ]; then
   echo param not recognized: $1
   echo usage: `basename $0` with no parameters loads versioned dataset
   echo usage: `basename $0` --{sample, meta, abstract}
   exit 1
fi

# Load the metadata, either in the same named graph as the data or into a more global one.
metaURL="$base/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.void.ttl"
echo pvdelete.sh $metaGraph
${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $metaGraph
if [[ "$1" == "--meta" ]]; then
   exit 1
fi



dump='publish/aeap_nys-dfw_lake_samples-2013-April-24.nt'
url='http://purl.org/twc/semantgeo/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.nt'
if [ -e $dump ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi

dump='publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl'
url='http://purl.org/twc/semantgeo/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.ttl'
if [ -e $dump ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi

dump='publish/aeap_nys-dfw_lake_samples-2013-April-24.rdf'
url='http://purl.org/twc/semantgeo/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/aeap_nys-dfw_lake_samples-2013-April-24.rdf'
if [ -e $dump ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi
#3> <> prov:wasAttributedTo <http://purl.org/twc/semantgeo/id/csv2rdf4lod/3cc1b24f1600849e2a91c1f53648861e> .
#3> <> prov:generatedAtTime "2013-06-19T19:15:27-04:00"^^xsd:dateTime .
#3> <http://purl.org/twc/semantgeo/id/csv2rdf4lod/3cc1b24f1600849e2a91c1f53648861e> foaf:name "convert-dfw_lake_samples.sh" .

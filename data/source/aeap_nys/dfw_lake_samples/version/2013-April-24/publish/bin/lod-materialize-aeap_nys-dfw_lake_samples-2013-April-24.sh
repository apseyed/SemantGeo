#!/bin/bash
#
# run automatic/lod-materialize-aeap_nys-dfw_lake_samples-2013-April-24.sh
# from aeap_nys/dfw_lake_samples/version/2013-April-24/

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

delete=""
if [ ! -e publish/aeap_nys-dfw_lake_samples-2013-April-24.nt ]; then
  delete="publish/aeap_nys-dfw_lake_samples-2013-April-24.nt"
  if [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz ]; then
    gunzip -c $allNT.gz > $allNT
  elif [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl ]; then
    echo "cHuNking publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl into publish/aeap_nys-dfw_lake_samples-2013-April-24.nt; will delete when done lod-mat'ing"
    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
  elif [ -e publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz ]; then
    gunzip -c $allTTL.gz > $allTTL
    echo "cHuNking publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl into publish/aeap_nys-dfw_lake_samples-2013-April-24.nt; will delete when done lod-mat'ing"
    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl > publish/aeap_nys-dfw_lake_samples-2013-April-24.nt
    rm publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl
  else
    echo publish/aeap_nys-dfw_lake_samples-2013-April-24.nt, publish/aeap_nys-dfw_lake_samples-2013-April-24.nt.gz, publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl, or publish/aeap_nys-dfw_lake_samples-2013-April-24.ttl.gz needed to lod-materialize.
    delete=""
    exit 1
  fi
fi

                # The newer C version of lod-mat is faster.
c_lod_mat="c/"  # It is in the directory called 'c' within the lod-materialization project.
                # The C version silently passes some parameters that the native perl version used.
if [ ! -e $CSV2RDF4LOD_HOME/bin/lod-materialize/c/lod-materialize ]; then
   c_lod_mat="" # If it is not available, use the older perl version.
   echo "WARNING: REALLY SLOW lod-materialization going on. Run make in $CSV2RDF4LOD_HOME/bin/lod-materialize/c/"
fi

writeBuffer="--buffer-size=${CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WRITE_FREQUENCY:-"1000000"}"
humanReport="--progress=${CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_REPORT_FREQUENCY:-"10000"}"
concurrency="--concurrency=${CSV2RDF4LOD_CONCURRENCY:-"1"}"
freqParams=" $writeBuffer $humanReport $concurrency "

# -D namespace abbreviations, -p: print progress
perl $CSV2RDF4LOD_HOME/bin/lod-materialize/${c_lod_mat}lod-materialize.pl -i=ntriples -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/=. -D aeap_nys_vocab=http://purl.org/twc/semmdd/source/aeap_nys/vocab/ -D base_vocab=http://purl.org/twc/semantgeo/vocab/ -D base_vocab=http://purl.org/twc/semmdd/vocab/ -D bibo=http://purl.org/ontology/bibo/ -D coin=http://purl.org/court/def/2009/coin# -D con=http://www.w3.org/2000/10/swap/pim/contact# -D conv=../../../../../../../../vocab/conversion/ -D conversion=http://purl.org/twc/vocab/conversion/ -D dbpedia=http://dbpedia.org/resource/ -D dbpediaowl=http://dbpedia.org/ontology/ -D dbpediaprop=http://dbpedia.org/property/ -D dcat=http://www.w3.org/ns/dcat# -D dcterms=../../../../../../../../../dc/terms/ -D dcterms=http://purl.org/dc/terms/ -D dfw_lake_samples=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/ -D dfw_lake_samples_vocab=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/ -D dfwi-aeap-nyserda=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/version/2013-mar-22/ -D dfwi-aeap-nyserda_global_value=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/ -D dfwi-aeap-nyserda_vocab=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/ -D dgtwc=http://data-gov.tw.rpi.edu/2009/data-gov-twc.rdf# -D doap=http://usefulinc.com/ns/doap# -D e1=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/enhancement/1/ -D e1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/enhancement/1/ -D foaf=http://xmlns.com/foaf/0.1/ -D frbrcore=http://purl.org/vocab/frbr/core# -D geonames=http://www.geonames.org/ontology# -D geonamesid=http://sws.geonames.org/ -D govtrackusgov=http://www.rdfabout.com/rdf/usgov/geo/us/ -D hartigprov=../../../../../../../../../net/provenance/ns# -D irw=http://www.ontologydesignpatterns.org/ont/web/irw.owl# -D muo=http://purl.oclc.org/NET/muo/muo# -D nfo=http://www.semanticdesktop.org/ontologies/2007/03/22/nfo# -D nfo=http://www.semanticdesktop.org/ontologies/nfo/# -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/ -D oboro=http://obofoundry.org/ro/ro.owl# -D oprov=http://openprovenance.org/ontology# -D org=http://www.w3.org/ns/org# -D ov=http://open.vocab.org/terms/ -D owl=http://www.w3.org/2002/07/owl# -D pml=http://provenanceweb.org/ns/pml# -D pmlj=http://inference-web.org/2.0/pml-justification.owl# -D pmlp=http://inference-web.org/2.0/pml-provenance.owl# -D pollution=http://escience.rpi.edu/ontology/semanteco/2/0/pollution.owl# -D prov=http://www.w3.org/ns/prov# -D provenance_1=http://purl.org/twc/semantgeo/source/source/provenance/dfwi-aeap-nyserda/version/2013-mar-22/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/enhancement/1/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/raw/ -D qb=http://purl.org/linked-data/cube# -D query_ns=http://aquarius.tw.rpi.edu/projects/semantaqua/data-source/query-variable/ -D raw=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/raw/ -D raw=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/raw/ -D rdf=http://www.w3.org/1999/02/22-rdf-syntax-ns# -D rdfs=http://www.w3.org/2000/01/rdf-schema# -D scovo=http://purl.org/NET/scovo# -D sio=http://semanticscience.org/resource/ -D sioc=http://rdfs.org/sioc/ns# -D skos=http://www.w3.org/2004/02/skos/core# -D source_vocab=http://purl.org/twc/semantgeo/source/source/vocab/ -D time=http://www.w3.org/2006/time# -D tw_converter=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_converter=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_service=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/ -D tw_service=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/ -D vann=http://purl.org/vocab/vann/ -D void=http://rdfs.org/ns/void# -D vs=http://www.w3.org/2003/06/sw-vocab-status/ns# -D vsr=http://purl.org/twc/vocab/vsr# -D water_ns=http://escience.rpi.edu/ontology/semanteco/2/0/water.owl# -D wgs=http://www.w3.org/2003/01/geo/wgs84_pos# -D xsd2=http://www.w3.org/TR/xmlschema-2/# -D xsd=http://www.w3.org/2001/XMLSchema# --uripattern="/source/([^/]+)/dataset/(.*)" --filepattern="/source/\\1/file/\\2" $freqParams --directoryindex=CSV2RDF4LODINDEX publish/aeap_nys-dfw_lake_samples-2013-April-24.nt http://purl.org/twc/semmdd publish/lod-mat

perl $CSV2RDF4LOD_HOME/bin/lod-materialize/${c_lod_mat}lod-materialize.pl -i=ntriples -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/=. -D aeap_nys_vocab=http://purl.org/twc/semmdd/source/aeap_nys/vocab/ -D base_vocab=http://purl.org/twc/semantgeo/vocab/ -D base_vocab=http://purl.org/twc/semmdd/vocab/ -D bibo=http://purl.org/ontology/bibo/ -D coin=http://purl.org/court/def/2009/coin# -D con=http://www.w3.org/2000/10/swap/pim/contact# -D conv=../../../../../../../../vocab/conversion/ -D conversion=http://purl.org/twc/vocab/conversion/ -D dbpedia=http://dbpedia.org/resource/ -D dbpediaowl=http://dbpedia.org/ontology/ -D dbpediaprop=http://dbpedia.org/property/ -D dcat=http://www.w3.org/ns/dcat# -D dcterms=../../../../../../../../../dc/terms/ -D dcterms=http://purl.org/dc/terms/ -D dfw_lake_samples=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/ -D dfw_lake_samples_vocab=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/ -D dfwi-aeap-nyserda=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/version/2013-mar-22/ -D dfwi-aeap-nyserda_global_value=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/ -D dfwi-aeap-nyserda_vocab=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/ -D dgtwc=http://data-gov.tw.rpi.edu/2009/data-gov-twc.rdf# -D doap=http://usefulinc.com/ns/doap# -D e1=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/enhancement/1/ -D e1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/enhancement/1/ -D foaf=http://xmlns.com/foaf/0.1/ -D frbrcore=http://purl.org/vocab/frbr/core# -D geonames=http://www.geonames.org/ontology# -D geonamesid=http://sws.geonames.org/ -D govtrackusgov=http://www.rdfabout.com/rdf/usgov/geo/us/ -D hartigprov=../../../../../../../../../net/provenance/ns# -D irw=http://www.ontologydesignpatterns.org/ont/web/irw.owl# -D muo=http://purl.oclc.org/NET/muo/muo# -D nfo=http://www.semanticdesktop.org/ontologies/2007/03/22/nfo# -D nfo=http://www.semanticdesktop.org/ontologies/nfo/# -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/ -D oboro=http://obofoundry.org/ro/ro.owl# -D oprov=http://openprovenance.org/ontology# -D org=http://www.w3.org/ns/org# -D ov=http://open.vocab.org/terms/ -D owl=http://www.w3.org/2002/07/owl# -D pml=http://provenanceweb.org/ns/pml# -D pmlj=http://inference-web.org/2.0/pml-justification.owl# -D pmlp=http://inference-web.org/2.0/pml-provenance.owl# -D pollution=http://escience.rpi.edu/ontology/semanteco/2/0/pollution.owl# -D prov=http://www.w3.org/ns/prov# -D provenance_1=http://purl.org/twc/semantgeo/source/source/provenance/dfwi-aeap-nyserda/version/2013-mar-22/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/enhancement/1/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/raw/ -D qb=http://purl.org/linked-data/cube# -D query_ns=http://aquarius.tw.rpi.edu/projects/semantaqua/data-source/query-variable/ -D raw=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/raw/ -D raw=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/raw/ -D rdf=http://www.w3.org/1999/02/22-rdf-syntax-ns# -D rdfs=http://www.w3.org/2000/01/rdf-schema# -D scovo=http://purl.org/NET/scovo# -D sio=http://semanticscience.org/resource/ -D sioc=http://rdfs.org/sioc/ns# -D skos=http://www.w3.org/2004/02/skos/core# -D source_vocab=http://purl.org/twc/semantgeo/source/source/vocab/ -D time=http://www.w3.org/2006/time# -D tw_converter=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_converter=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_service=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/ -D tw_service=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/ -D vann=http://purl.org/vocab/vann/ -D void=http://rdfs.org/ns/void# -D vs=http://www.w3.org/2003/06/sw-vocab-status/ns# -D vsr=http://purl.org/twc/vocab/vsr# -D water_ns=http://escience.rpi.edu/ontology/semanteco/2/0/water.owl# -D wgs=http://www.w3.org/2003/01/geo/wgs84_pos# -D xsd2=http://www.w3.org/TR/xmlschema-2/# -D xsd=http://www.w3.org/2001/XMLSchema# --uripattern="/source/([^/]+)/vocab/(.*)" --filepattern="/source/\\1/vocab_file/\\2" $freqParams --directoryindex=CSV2RDF4LODINDEX publish/aeap_nys-dfw_lake_samples-2013-April-24.nt http://purl.org/twc/semmdd publish/lod-mat

perl $CSV2RDF4LOD_HOME/bin/lod-materialize/${c_lod_mat}lod-materialize.pl -i=ntriples -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/=. -D http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/=. -D aeap_nys_vocab=http://purl.org/twc/semmdd/source/aeap_nys/vocab/ -D base_vocab=http://purl.org/twc/semantgeo/vocab/ -D base_vocab=http://purl.org/twc/semmdd/vocab/ -D bibo=http://purl.org/ontology/bibo/ -D coin=http://purl.org/court/def/2009/coin# -D con=http://www.w3.org/2000/10/swap/pim/contact# -D conv=../../../../../../../../vocab/conversion/ -D conversion=http://purl.org/twc/vocab/conversion/ -D dbpedia=http://dbpedia.org/resource/ -D dbpediaowl=http://dbpedia.org/ontology/ -D dbpediaprop=http://dbpedia.org/property/ -D dcat=http://www.w3.org/ns/dcat# -D dcterms=../../../../../../../../../dc/terms/ -D dcterms=http://purl.org/dc/terms/ -D dfw_lake_samples=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/ -D dfw_lake_samples_vocab=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/ -D dfwi-aeap-nyserda=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/version/2013-mar-22/ -D dfwi-aeap-nyserda_global_value=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/ -D dfwi-aeap-nyserda_vocab=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/ -D dgtwc=http://data-gov.tw.rpi.edu/2009/data-gov-twc.rdf# -D doap=http://usefulinc.com/ns/doap# -D e1=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/enhancement/1/ -D e1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/enhancement/1/ -D foaf=http://xmlns.com/foaf/0.1/ -D frbrcore=http://purl.org/vocab/frbr/core# -D geonames=http://www.geonames.org/ontology# -D geonamesid=http://sws.geonames.org/ -D govtrackusgov=http://www.rdfabout.com/rdf/usgov/geo/us/ -D hartigprov=../../../../../../../../../net/provenance/ns# -D irw=http://www.ontologydesignpatterns.org/ont/web/irw.owl# -D muo=http://purl.oclc.org/NET/muo/muo# -D nfo=http://www.semanticdesktop.org/ontologies/2007/03/22/nfo# -D nfo=http://www.semanticdesktop.org/ontologies/nfo/# -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-crust-web-v3/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/ -D ns1=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/aeap-rotifers-web/ -D oboro=http://obofoundry.org/ro/ro.owl# -D oprov=http://openprovenance.org/ontology# -D org=http://www.w3.org/ns/org# -D ov=http://open.vocab.org/terms/ -D owl=http://www.w3.org/2002/07/owl# -D pml=http://provenanceweb.org/ns/pml# -D pmlj=http://inference-web.org/2.0/pml-justification.owl# -D pmlp=http://inference-web.org/2.0/pml-provenance.owl# -D pollution=http://escience.rpi.edu/ontology/semanteco/2/0/pollution.owl# -D prov=http://www.w3.org/ns/prov# -D provenance_1=http://purl.org/twc/semantgeo/source/source/provenance/dfwi-aeap-nyserda/version/2013-mar-22/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/enhancement/1/ -D provenance_1=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/enhancement/1/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-crust-web-v3/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-nyserda-chem-94-12-v9-web/version/2013-April-24/conversion/raw/ -D provenance_raw=http://purl.org/twc/semmdd/source/aeap_nys/provenance/dfw_lake_samples/aeap-rotifers-web/version/2013-April-24/conversion/raw/ -D qb=http://purl.org/linked-data/cube# -D query_ns=http://aquarius.tw.rpi.edu/projects/semantaqua/data-source/query-variable/ -D raw=http://purl.org/twc/semantgeo/source/source/dataset/dfwi-aeap-nyserda/vocab/raw/ -D raw=http://purl.org/twc/semmdd/source/aeap_nys/dataset/dfw_lake_samples/vocab/raw/ -D rdf=http://www.w3.org/1999/02/22-rdf-syntax-ns# -D rdfs=http://www.w3.org/2000/01/rdf-schema# -D scovo=http://purl.org/NET/scovo# -D sio=http://semanticscience.org/resource/ -D sioc=http://rdfs.org/sioc/ns# -D skos=http://www.w3.org/2004/02/skos/core# -D source_vocab=http://purl.org/twc/semantgeo/source/source/vocab/ -D time=http://www.w3.org/2006/time# -D tw_converter=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_converter=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/csv2rdf4lod/version/2013-Jan-16/ -D tw_service=http://purl.org/twc/semantgeo/source/tw-rpi-edu/service/ -D tw_service=http://purl.org/twc/semmdd/source/tw-rpi-edu/service/ -D vann=http://purl.org/vocab/vann/ -D void=http://rdfs.org/ns/void# -D vs=http://www.w3.org/2003/06/sw-vocab-status/ns# -D vsr=http://purl.org/twc/vocab/vsr# -D water_ns=http://escience.rpi.edu/ontology/semanteco/2/0/water.owl# -D wgs=http://www.w3.org/2003/01/geo/wgs84_pos# -D xsd2=http://www.w3.org/TR/xmlschema-2/# -D xsd=http://www.w3.org/2001/XMLSchema# --uripattern="/source/([^/]+)/provenance/(.*)" --filepattern="/source/\\1/file/\\2" $freqParams --directoryindex=CSV2RDF4LODINDEX publish/aeap_nys-dfw_lake_samples-2013-April-24.nt http://purl.org/twc/semmdd publish/lod-mat

if [ ${#delete} -gt 0 ]; then
   rm $delete
fi

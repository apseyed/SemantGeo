#!/bin/bash
#
# run from source/aeap_nys/dfw_lake_samples/version/2013-April-24
#
# CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
# was 
# 
# when this script was created. 

wwwroot=$CSV2RDF4LOD_PUBLISH_VARWWW_ROOT
if [ -z "$wwwroot" ]; then
  wwwroot=$CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
fi
if [ -z "$wwwroot" ]; then
  echo "wwwroot not defined."
  exit 1
fi

verbose="no"
if [[ "$1" == "-v" ]]; then
  verbose="yes"
  shift
fi

symbolic=""
pwd=""
if [[ "$1" == "-s" || "$CSV2RDF4LOD_PUBLISH_VARWWW_LINK_TYPE" == "soft" ]]; then
  symbolic="-sf "
  pwd=`pwd`/
  shift
fi

sudo="sudo"
if [ `whoami` == root ]; then
   sudo=""
elif [[ "`stat --format=%U "$wwwroot/source"`" == `whoami` ]]; then
   sudo=""
fi

file="file"

##################################################
# Link all original files from the /file/ directory structure to the web directory.
# (these are from source/)
##################################################
# Link all INPUT CSV files from the /file/ directory structure to the web directory.
# (this could be from manual/ or source/
if [ -e "manual/AEAP-Locations.csv" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP-Locations.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP-Locations.csv" "$wwwfile"
else
   echo "  -- manual/AEAP-Locations.csv omitted --"
fi

if [ -e "manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv" "$wwwfile"
else
   echo "  -- manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv omitted --"
fi

if [ -e "manual/AEAP_crust_web_v3.csv" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_crust_web_v3.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_crust_web_v3.csv" "$wwwfile"
else
   echo "  -- manual/AEAP_crust_web_v3.csv omitted --"
fi

if [ -e "manual/AEAP_phyto_web.csv" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_phyto_web.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_phyto_web.csv" "$wwwfile"
else
   echo "  -- manual/AEAP_phyto_web.csv omitted --"
fi

if [ -e "manual/AEAP_rotifers_web.csv" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_rotifers_web.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_rotifers_web.csv" "$wwwfile"
else
   echo "  -- manual/AEAP_rotifers_web.csv omitted --"
fi

##################################################
# Link all raw and enhancement PARAMETERS from the file directory structure to the web directory.
#
if [ -e "automatic/AEAP-Locations.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/automatic/AEAP-Locations.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/AEAP-Locations.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/AEAP-Locations.csv.raw.params.ttl omitted --"
fi

if [ -e "automatic/AEAP_crust_web_v3.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/automatic/AEAP_crust_web_v3.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/AEAP_crust_web_v3.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/AEAP_crust_web_v3.csv.raw.params.ttl omitted --"
fi

if [ -e "automatic/AEAP_NYSERDA_Chem_94-12_v9_web.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/automatic/AEAP_NYSERDA_Chem_94-12_v9_web.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/AEAP_NYSERDA_Chem_94-12_v9_web.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/AEAP_NYSERDA_Chem_94-12_v9_web.csv.raw.params.ttl omitted --"
fi

if [ -e "automatic/AEAP_phyto_web.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/automatic/AEAP_phyto_web.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/AEAP_phyto_web.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/AEAP_phyto_web.csv.raw.params.ttl omitted --"
fi

if [ -e "automatic/AEAP_rotifers_web.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/automatic/AEAP_rotifers_web.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/AEAP_rotifers_web.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/AEAP_rotifers_web.csv.raw.params.ttl omitted --"
fi

if [ -e "manual/AEAP-Locations.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP-Locations.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP-Locations.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP-Locations.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/AEAP_crust_web_v3.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_crust_web_v3.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_crust_web_v3.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP_crust_web_v3.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/AEAP_phyto_web.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_phyto_web.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_phyto_web.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP_phyto_web.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/AEAP_rotifers_web.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_rotifers_web.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_rotifers_web.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP_rotifers_web.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/phyto-class.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/phyto-class.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/phyto-class.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/phyto-class.csv.e1.params.ttl omitted --"
fi

##################################################
# Link all PROVENANCE files that describe how the input CSV files were obtained.
#
if [ -e "manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.pml.ttl" ]; then 
   wwwfile="$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.pml.ttl"
   if [ -e "$wwwfile" ]; then
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.pml.ttl" "$wwwfile"
else
   echo "  -- manual/AEAP_NYSERDA_Chem_94-12_v9_web.csv.pml.ttl omitted --"
fi

##################################################
# Link all bundled RDF output files from the source/.../file directory structure to the web directory.
#
dump=aeap_nys-dfw_lake_samples-2013-April-24.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full ttl omitted -- "
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full nt omitted -- "
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full rdf omitted -- "
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.sample.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.sample.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw rdf omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.raw.sample.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample rdf omitted --"
fi


dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.sample.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.sample.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 rdf omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.e1.sample.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e1 sample rdf omitted --"
fi


dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.sample.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.sample.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas rdf omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.sameas.sample.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample rdf omitted --"
fi


dump=aeap_nys-dfw_lake_samples-2013-April-24.void.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.void.sample.ttl
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample ttl omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.void.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.void.sample.nt
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample nt omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.void.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void rdf omitted --"
fi

dump=aeap_nys-dfw_lake_samples-2013-April-24.void.sample.rdf
wwwfile=$wwwroot/source/aeap_nys/file/dfw_lake_samples/version/2013-April-24/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample rdf omitted --"
fi



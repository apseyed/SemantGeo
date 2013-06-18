#!/bin/bash
#
# run from source/dataone/dataone-objects/version/2013-May-29
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
if [ -e "source/dataone.csv" ]; then 
   wwwfile="$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/source/dataone.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}source/dataone.csv" "$wwwfile"
else
   echo "  -- source/dataone.csv omitted --"
fi

##################################################
# Link all raw and enhancement PARAMETERS from the file directory structure to the web directory.
#
if [ -e "automatic/dataone.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/automatic/dataone.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/dataone.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/dataone.csv.raw.params.ttl omitted --"
fi

if [ -e "manual/dataone.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/manual/dataone.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/dataone.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/dataone.csv.e1.params.ttl omitted --"
fi

if [ -e "manual/simple.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/manual/simple.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/simple.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/simple.csv.e1.params.ttl omitted --"
fi

##################################################
# Link all PROVENANCE files that describe how the input CSV files were obtained.
#
##################################################
# Link all bundled RDF output files from the source/.../file directory structure to the web directory.
#
dump=dataone-dataone-objects-2013-May-29.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.sample.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.sample.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.raw.sample.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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


dump=dataone-dataone-objects-2013-May-29.e1.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.e1.sample.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.e1.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.e1.sample.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.e1.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.e1.sample.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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


dump=dataone-dataone-objects-2013-May-29.sameas.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.sameas.sample.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.sameas.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.sameas.sample.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.sameas.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.sameas.sample.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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


dump=dataone-dataone-objects-2013-May-29.void.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.void.sample.ttl
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.void.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.void.sample.nt
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.void.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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

dump=dataone-dataone-objects-2013-May-29.void.sample.rdf
wwwfile=$wwwroot/source/dataone/file/dataone-objects/version/2013-May-29/conversion/$dump
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



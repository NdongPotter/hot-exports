#!/bin/sh
#
#  testcde.sh
#

JOBID=foo
OSMFILE=bremen.osm.pbf

export CDE_FIELDS_NODES="amenity,shop"
export CDE_FIELDS_WAYS="highway,railway"
export CDE_FIELDS_AREAS="building"

mkdir -p out
PREFIX=out/cde.$JOBID

MASTERFILE=$PREFIX.sqlite
rm -f $MASTERFILE
#valgrind --leak-check=full --show-reachable=yes ./cde $OSMFILE  $MASTERFILE
./cde $OSMFILE $MASTERFILE
#gdb ./cde

mkdir -p ${PREFIX}_shp
rm -f ${PREFIX}_shp/*
ogr2ogr -overwrite -f "ESRI Shapefile" ${PREFIX}_shp $MASTERFILE
ogr2ogr -overwrite -f "PGDump" --config PG_USE_COPY YES ${PREFIX}.sql $MASTERFILE


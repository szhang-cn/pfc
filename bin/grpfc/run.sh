#!/bin/bash

# Define the graphene pfc directory
GRPFC="$HOME/bin/grpfc"

# MPI CORES
NP=44

# Width, unit: ang
W=100

# Height, unit: ang
H=100

# Number of grains
N=3

# Radius of seed
R=1.0

######################################
WW=`awk 'BEGIN{print int(1024/243*'$W')}'`
HH=`awk 'BEGIN{print int(1024/243*'$H')}'`
NN=$N
RR=$R

echo "WW=$WW, HH=$HH, NN=$NN RR=$RR"

cp source/step* ./
sed -i "s@WW@$WW@g" step1.in
sed -i "s@HH@$HH@g" step1.in
sed -i "s@NN@$NN@g" step1.in
sed -i "s@RR@$RR@g" step1.in

sed -i "s@WW@$WW@g" step2.in
sed -i "s@HH@$HH@g" step2.in

mpirun -np $NP $GRPFC/pfc step1
mpirun -np $NP $GRPFC/pfc step2
java -jar $GRPFC/coordinator.jar step2-t\:10000.dat $WW $HH 0.7 0.7 7.3 2.46 step2-t\:10000.xy step2-t\:10000.nh
java -jar $GRPFC/plotter.jar step2-t:# step2-t:# $WW $HH 0 1000 10000
awk '{print $1+1,1,$2,$3,0}' step2-t\:10000.xy > graphene.xyz
atomN=`tail -1 graphene.xyz |awk '{print $1}'`
sed -i "1i\ " graphene.xyz
sed -i "1i$atomN" graphene.xyz

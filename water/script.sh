#!/bin/bash

xyzfile=$1
fileroot=${xyzfile::-4}

charge=0	# $2 only neutral singlets for now
spin=1		# $3 only neutral singlets for now

cores=6
mem=2000

dry_run=0


### PBE0 OPT ###

input_root=${fileroot}_OPT

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! PBE0 def2-TZVP TightOPT Freq
! RIJCOSX def2/J

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
	cp ${input_root}.xyz ../$xyzfile
fi

cd ..

### DONE ###


### HF SP ###

input_root=${fileroot}_HF

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! HF aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### MP2 SP ###

input_root=${fileroot}_MP2

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! MP2 aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J aug-cc-pVTZ/C

%mp2
  density unrelaxed
end

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### PBE SP ###

input_root=${fileroot}_PBE

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! PBE aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### B3LYP SP ###

input_root=${fileroot}_B3LYP

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! B3LYP aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### CCSD SP ###

input_root=${fileroot}_CCSD

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! CCSD aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J aug-cc-pVTZ/C

%mdci
  density unrelaxed
end

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
#	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### CCSD(T) SP ###

input_root=${fileroot}_CCSDT

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! CCSD(T) aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J aug-cc-pVTZ/C

%mdci
  density unrelaxed
end

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
#	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


### DLPNO-CCSD SP ###

input_root=${fileroot}_DLPNO_CCSD

mkdir $input_root
cd $input_root

cat << EOF > ${input_root}.inp

%pal
  nprocs $cores
end
%maxcore $mem

! DLPNO-CCSD aug-cc-pVTZ VeryTightSCF
! RIJCOSX def2/J aug-cc-pVTZ/C
! TightPNO

%mdci
  density unrelaxed
end

* xyzfile $charge $spin $xyzfile

EOF

if [ $dry_run -eq 0 ]
then
	cp ../$xyzfile .
	$ORCADIR/orca ${input_root}.inp > ${input_root}.out
fi

cd ..

### DONE ###


exit

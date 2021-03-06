# bamaddrg

Adds read groups to input BAM files, streams BAM output on stdout.

This is intended for use "fixing up" RG tags on the fly so that they reflect
the source file from which the aligment originated from.  This allows the
"safe" merging of many files from many individuals into one stream, suitable
for input into downstream processing systems such as freebayes (a population
variant detector).

---

# Requirements

    g++
    
    BAMtools
    
    > lib/libbamtools.a

    > include/bamtools/api/BamMultiReader.h

    > include/bamtools/api/BamWriter.h

    > include/bamtools/api/SamReadGroup.h

---

# Install

## Install [BAMtools](https://github.com/pezmaster31/bamtools)

    cd $BamtoolsInstallDir

    git clone git://github.com/pezmaster31/bamtools.git
    
    cd bamtools
    
    mkdir build
    
    cd build
    
    cmake -DCMAKE_INSTALL_PREFIX=$PWD/../../x86_64 ..
    
    export BAMTOOLS_ROOT=$PWD/../../x86_64
    
    make
    
    make install
    
## Install bamaddrg
    
    cd $BamaddrgInstallDir
    
    git clone https://github.com/lufuhao/bamaddrg.git
    
    mv bamaddrg x86_64

    cd x86_64
    
    make
    
    #or
    
    make =/path/to/bamtools/root
    
> If make report error, replace following $BamtoolsInstallDir. and try again

    g++ -O3 -I$BAMTOOLS_ROOT/include/bamtools -L$BAMTOOLS_ROOT/lib  bamaddrg.cpp -o bamaddrg -lbamtools -lz

---

# Usage:

To tag multiple files simultaneously, use as such:

    % bamaddrg -b file1.bam -s jill -r group.s1.1 \
               -b file2.bam -s jill -r group.s1.2 \
               -b file3.bam -s bill \
               -b file4.bam \
       | freebayes ...

This would add the sample name "jill" to records from file1.bam and file2.bam,
while specifying that specific read group identify alignments from each file.
Alignments from file3.bam would be tagged with sample name "bill" and read
group id "bill", and samples from file4.bam would be tagged with sample name
"file4.bam" and read group id "file4.bam."

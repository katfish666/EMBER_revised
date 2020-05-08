#!/bin/sh
#$ -S /bin/bash
#$ -v PATH=/home/data/webcomp/RAMMCAP-ann/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#$ -v BLASTMAT=/home/data/webcomp/RAMMCAP-ann/blast/bin/data
#$ -v LD_LIBRARY_PATH=/home/data/webcomp/RAMMCAP-ann/gnuplot-install/lib
#$ -v PERL5LIB=/home/hying/programs/Perl_Lib
#$ -q cdhit_webserver.q,fast.q
#$ -pe orte 4
#$ -l h_rt=24:00:00


#$ -e /data5/data/webcomp/web-session/1588969899/1588969899.err
#$ -o /data5/data/webcomp/web-session/1588969899/1588969899.out
cd /data5/data/webcomp/web-session/1588969899
sed -i "s/\x0d/\n/g" 1588969899.fas.db1
sed -i "s/\x0d/\n/g" 1588969899.fas.db2

faa_stat.pl 1588969899.fas.db1
faa_stat.pl 1588969899.fas.db2
/data5/data/NGS-ann-project/apps/cd-hit/cd-hit-2d -i 1588969899.fas.db1 -i2 1588969899.fas.db2 -o 1588969899.fas.db2novel -c 0.4 -n 2  -G 1 -g 1 -b 15 -l 0 -s 0.0 -aL 0.0 -aS 0.0 -s2 1.0 -S2 0 -T 4 -M 32000
/data5/data/NGS-ann-project/apps/cd-hit/clstr_sort_by.pl no < 1588969899.fas.db2novel.clstr > 1588969899.fas.db2novel.clstr.sorted
/data5/data/NGS-ann-project/apps/cd-hit/clstr_list.pl 1588969899.fas.db2novel.clstr 1588969899.clstr.dump
/data5/data/NGS-ann-project/apps/cd-hit/clstr_list_sort.pl 1588969899.clstr.dump 1588969899.clstr_no.dump
/data5/data/NGS-ann-project/apps/cd-hit/clstr_list_sort.pl 1588969899.clstr.dump 1588969899.clstr_len.dump len
/data5/data/NGS-ann-project/apps/cd-hit/clstr_list_sort.pl 1588969899.clstr.dump 1588969899.clstr_des.dump des
gnuplot1.pl < 1588969899.fas.db2novel.clstr > 1588969899.fas.db2novel.clstr.1; gnuplot2.pl 1588969899.fas.db2novel.clstr.1 1588969899.fas.db2novel.clstr.1.png
tar -zcf 1588969899.result.tar.gz * --exclude=*.dump --exclude=*.env
echo hello > 1588969899.ok

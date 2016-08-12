#!/bin/bash
############## Define variables
gorilla="n"
rlmu="root"
#Password below
rlmp="changeme"
fndir=''$PWD'/'
pod="Pod number not currently used."
disk1="0c"
disk2="0a"
############## Define your functions before invoking them
fn_enterfilername () {
	echo
	echo "This is a script for MCC natehost modification by Copeland."
	echo "Please backup your natehost files before using this tool, as it may not always work as intended."
	echo -e "Warranty subject to change without notice, batteries not included. \n"
	echo -n "Please enter filer type: (ex: 6280) "
	read filername
	filername="sti$filername"
	echo -e "Filer type: $filername \n"
}
fn_enterbhostrange () {
	echo -n "Please enter beginning of host range: (ex: 001) "
	read hostbrange
	echo -e "Beginning of host range: $filername-$hostbrange \n"
}
fn_enterehostrange () {
	echo -n "Please enter end of host range: (ex: 008) "
	read hosterange
	echo -e "End of host range: $filername-$hosterange \n"
}
fn_enterpodinfo () {
	echo -n "Please enter Pod number: (ex: 30C) "
	read pod
	echo -e "Pod $pod \n"
}
fn_continue () {
	echo -n "Is this correct? (y/n) "
	read gorilla
	echo
}
fn_data1 () {
	echo -n "Please enter the data 1 port: (ex: e0d) "
	read data1
	echo -e "Data 1 port: $data1 \n"
}
fn_data2 () {
	echo -n "Please enter the data 2 port: (ex: e0f) "
	read data2
	echo -e "Data 2 port: $data2 \n"
}
fn_clus1 () {
	echo -n "Please enter the cluster 1 port: (ex: e0e) "
	read clus1
	echo -e "Cluster 1 port: $clus1 \n"
}
fn_clus2 () {
	echo -n "Please enter the cluster 2 port: (ex: e0c) "
	read clus2
	echo -e "Cluster 2 port: $clus2 \n"
}
fn_clusmgmt () {
	echo -n "Please enter the Cluster Management port: (ex: e0b) "
	read clusmgmt
	echo -e "Cluster Management port: $clusmgmt \n"
}
fn_interclus () {
	echo -n "Please enter the intercluster port: (ex: e0a) "
	read interclus
	echo -e "Intercluster port: $interclus \n"
}
fn_rlmuser () {
        echo -n "Please enter RLM username: "
        read rlmu
        echo -n "Please enter RLM password: "
        read rlmp
        echo
        echo "RLM Username: $rlmu"
        echo -e "RLM Password: $rlmp \n"
}
fn_dir () {
        echo -n "Please enter the directory in which the nate hosts reside: (ex: /x/eng/sti-testbeds/nate_hosts/hwqualify/) "
        read fndir
        echo -e "Directory entered: $fndir \n"
}
fn_summary () {
        echo "Pod information entered: "
	echo "Hostnames:"
        for i in $(seq -w $hostbrange $hosterange); do echo $filername-$i; done
        echo
        echo "Pod: $pod"
	echo "Data port 1: $data1"
	echo "Data port 2: $data2"
	echo "Cluster port 1: $clus1"
	echo "Cluster port 2: $clus2"
	echo "Cluster Management port: $clusmgmt"
	echo "Intercluster port: $interclus"
	echo "RLM User being used: $rlmu"
	echo "RLM Password being used: $rlmp"
	echo -e "Directory nate hosts reside in: $fndir \n"
}
fn_menu () {
	echo
	echo "*** Which variable would you like to modify? ***"
        echo "Choose one of the following: "
        echo -e "1 - Filer type"
        echo -e "2 - Beginning of host range"
        echo -e "3 - End of host range"
        echo -e "4 - Pod number (Not currently used)"
        echo -e "5 - Data port 1"
        echo -e "6 - Data port 2"
        echo -e "7 - Cluster port 1"
        echo -e "8 - Cluster port 2"
        echo -e "9 - Cluster Management port"
	echo -e "10 - Intercluster port"
	echo -e "11 - RLM User/Password"
	echo -e "12 - Directory for nate hosts"
	echo -e "13 - Write changes to nate host files!"
	echo -e "0 - Exit and discard any changes"
        echo
        echo -n "==> "
}
fn_readnate () {
for i in $(seq -w $hostbrange $hosterange); do echo "$Before DATA_PORT1 argument for $filername-$i"; cat $fndir$filername-$i | grep -i DATA_PORT1; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before DATA_PORT2 argument for $filername-$i"; cat $fndir$filername-$i | grep -i DATA_PORT2; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before CLUSTER_PORT1 argument for $filername-$i"; cat $fndir$filername-$i | grep -i CLUSTER_PORT1; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before CLUSTER_PORT2 argument for $filername-$i"; cat $fndir$filername-$i | grep -i CLUSTER_PORT2; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before CLUSTER_MGMT_PORT argument for $filername-$i"; cat $fndir$filername-$i | grep -i CLUSTER_MGMT_PORT; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before INTERCLUSTER_PORT1 argument for $filername-$i"; cat $fndir$filername-$i | grep -i INTERCLUSTER_PORT1; echo; done
for i in $(seq -w $hostbrange $hosterange); do echo "$Before username= argument for $filername-$i"; cat $fndir$filername-$i | grep -i username=; echo; done
#Disk channel, not currently implemented.
#for i in $(seq -w $hostbrange $hosterange); do echo "$Before DISK_CHANNEL argument for $filername-$i"; cat $fndir$filername-$i | grep DISK_CH; echo; done
}
fn_replacenate () {
Before="Before"
fn_readnate

for i in $(seq -w $hostbrange $hosterange); do sed -i 's/DATA_PORT1.*/DATA_PORT1='$data1'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/DATA_PORT2.*/DATA_PORT2='$data2'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/CLUSTER_PORT1.*/CLUSTER_PORT1='$clus1'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/CLUSTER_PORT2.*/CLUSTER_PORT2='$clus2'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/CLUSTER_MGMT_PORT.*/CLUSTER_MGMT_PORT='$clusmgmt'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/INTERCLUSTER_PORT1.*/INTERCLUSTER_PORT1='$interclus'/g' $fndir$filername-$i ; done
for i in $(seq -w $hostbrange $hosterange); do sed -i 's/username.*/username='$rlmu';password='$rlmp'}/g' $fndir$filername-$i ; done
#Disk channel, not currently implemented.
#for i in $(seq -w $hostbrange $hosterange){002..008..2}; do sed -i 's/DISK.*/DISK_CHANNELS=0c/' $filername-$i ; done
#for i in $(seq -w $hostbrange $hosterange){001..008..2}; do sed -i 's/DISK.*/DISK_CHANNELS=0a/' $filername-$i ; done

Before="After"
fn_readnate
}
fn_fail () {
        echo
        echo -e "Invalid option, you knew that wouldn't work! Try entering 1-12! \n"
}
fn_test1 () {
	echo
	echo "Script modification would start here"
}
############### Start script body
	fn_enterfilername
	fn_enterbhostrange
	fn_enterehostrange
	#fn_enterpodinfo
	fn_data1
	fn_data2
	fn_clus1
	fn_clus2
	fn_clusmgmt
	fn_interclus
until [ "$gorilla" != "n" ]; do
	fn_summary
	fn_menu
        read MONEY
        case $MONEY in
        1)
        fn_enterfilername
        ;;
        2)
        fn_enterbhostrange
        ;;
        3)
        fn_enterehostrange
        ;;
        4)
        fn_enterpodinfo
        ;;
	5)
	fn_data1
	;;
	6)
	fn_data2
	;;
	7)
	fn_clus1
	;;
	8)
	fn_clus2
	;;
	9)
	fn_clusmgmt
	;;
	10)
	fn_interclus
	;;
	11)
	fn_rlmuser
	;;
	12)
	fn_dir
	;;
	13)
	fn_replacenate
	break
	;;
	0)
	echo "OK, see you!"
	break
	;;	
        *)
        fn_fail
        esac
done
echo -e "Script written by Copeland \n"

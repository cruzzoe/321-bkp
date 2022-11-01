#!/bin/bash
#
#Test script to copy data to nas
#
#
# issue with sudo 
# ensure_dir_mounted () {
  # if findmnt $1 >/dev/null; then
    # echo "$1 already mounted"
  # else
    # mount -a
    #TODO must terminate if mount not successfull
  # fi
# }

export ip_addr=192.168.50.230
ping -c1 -W1 $ip_addr && echo 'server is up'  && host_up="True"|| echo 'server is down' 


  if [ "$host_up" == "True" ] 
  then
    echo 'Host is up. Continuing...'
  else
    echo 'Host is down, Giving up!'
    exit 1
  fi

declare -a dirs=(
	"/home/cruz/mnt/synology/Documents"
	"/home/cruz/mnt/synology/Music"
	"/home/cruz/mnt/synology/Books"
	"/home/cruz/mnt/synology/violin1208"
	"/home/cruz/mnt/synology/Photos"
	"/home/cruz/mnt/synology/video"
	)

	# Clone each directory. Add `--progress` for nicer (but more verbose) output.
	for i in "${dirs[@]}"
	do
  	  echo "Syncing Directory: $i . First checking if it's mounted...."
      # TODO if not mountpoint then dont copy!
      mountpoint $i
	  target=$(echo "$i" | sed -e 's/\/.*\///g')
          cmd="rsync -av $i/ /home/cruz/mnt/cruznas/$target --progress --delete"
	  echo $target
          echo $cmd 
	  eval "$cmd"
	  echo "Backup complete for $i"	
       done


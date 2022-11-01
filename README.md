Inspired by Jeff Geerling's youtube serries

Plan is to use 2 onsite backup servers with one remote cloud offering.

[https://rclone.org/](https://rclone.org/) is used to connect to cloud offering.

Daily cron job to run each night to rsync data from primary nas to secondary nas solution.

Note --delete flag for rysnc must be handled with care. --dry-run is your friend here to avoid large data loss :)

# Issues encountered

- Daylight saving impacts server startup but not cron run times
- mounts disappear when other nas is offline. This results in the rsync command copying to local drive instead of mounted drive
- mounting of drive. Would be ideal to do this via cron but requires sudo. Use ansible to elevate permissions?

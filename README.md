# Slurm Migration Scripts

We all know that forklifting a ton of data from filesystem to filesystem is a pain.  It's hard to saturate the network link, users don't organize files and folders in an optimal way, and you want to use the nice features of rsync but are limited by the fact its not parallelized in the way you would want.

If you find yourself in any or all of these situations hopefully these migration tools will be helpful.  The thought behind these tools is that if you have a cluster of compute nodes and a scheduler why not use them for moving data.  Who needs a special migration node if you have thousands of nodes ready to work at your beck and call, you just need to tell the cores what to do.  Who needs a special code when you can do poor mans parallelization.  After all rsync is a fine tool it just isn't designed for cluster environments.

A few warnings first:

   * These tools are intended for use with filesystems that can handle massive parallel I/O (i.e. Lustre).  As such please use with caution.
   * These tools are not complete.  That being that there is manual intervention and there will need be a final clean up rsync when finished.  These should though help you get 99% of the data there, in which case the clean up rsync should be quick.
   * Many of these tools run in --delete mode for rsync (meaning that existing data at the destination will be removed if it isn't at the source as well).  Be that your source and destination are correct.  Also be sure to change the rsync options to match what you actual need.  Same with the slurm options as well.

Contained in this repo are several scripts for this purpose.  Below is a brief description of each tool, more details are in their specific directories.

   * migrate: Have a filesystem that has many seperate folders and directory levels?  This is the script for you.
   * singledir: Have a single directory that has hundreds of thousands of files to move?  This is the script for you.

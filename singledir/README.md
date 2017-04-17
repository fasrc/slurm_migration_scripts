# singledir

The basic idea is that if you have thousands of files in a folder you don't want to wait for rsync to serially march through them all.  This instead segments the filelist and gives a subset of files to each job to move.  This is great for folders that has many files of any size.

To use this you just run the `launcher-dir.sh` script on the folder you want to move.  It will generate a filelist to move.  It will then iterate through that filelist, segmenting it in to a predefined number of files (currently set to 1000 but can be adjusted as needed).  It then submits that subset of files to be moved to slurm using `runscript-dir`.  Depending on how many files you have to move and what threshold you set for each segment this can generate a ton of slurm runs all moving data simultaneously.

## Warnings

Always be sure you have your source and destination set properly.  Keep an eye on your filesystems to ensure that they are not saturated or overload.  Also be sure you have the rsync options you want defined.

# migrate

The basic theory behind this set of scripts is that users tend to bin things in directories and this is a cheap way to parallelize rsync if we can just spawn an rsync for each subdirectory on a filesystem.  This consists of 2 scripts.  The first `migrate.sh` simply gets a directory list from the source system.  The second `runscript-migrate` is the slurm submission script for running the rsync on the subdirectory that is assigned by `migrate.sh`.  Obviously this parallelizes better the more directories you have.

## Workflow

I typically run this in stages.  I will start at the base directory for the filesystem move.  Run `migrate.sh` to generate jobs for each subdirectory and then wait for a bit.  Some directories will have more data than others.  After an appropriate amount of time (depends on how anxious you are to get the move done), you look at the jobs that are still running and kill those jobs.  You then run `migrate.sh` on those subdirectories to get rsyncs going for the subdirectories of the subdirectories.  Since you are parallelizing based on directory, this will further parallelize your copy.  Rinse and repeat until your transfer is complete.  Be sure to do a clean up rsync when you are done.

An example here should be instructive as to the intended workflow.  Let's say you have directory `dir` that has 4 subdirectories `dir1`, `dir2`, `dir3`, and `dir4`.  You fire off `migrate.sh` on `dir` and wait for a bit.  You come back and find out that the rsync for `dir1` and `dir4` are done but the other two are still going.  You terminate those two transfers then you run `migrate.sh` on `dir/dir2` and find out that it has 10 subdirectories in it.  Now you have 10 rsyncs going in parallel for those subdirectories.  You do the same for `dir/dir3' and it has a 1000 subdirectories, and now you have 1000 rsyncs in parallel for that transfer.  Thus you have taken what normally would be 1 rsync and made it into 4, and then 1010 which greatly enhances the throughput.

In summary this is a tree scheme for transferring data.  Directories that take longer you start to dive deeper into the directory structure, finding those directories that have the most data.  Theoretically one could write a script to automate this but I haven't taken the time to do that as it would take more advanced techniques.

## Warnings

Always be sure you have your source and destination set properly.  Keep an eye on your filesystems to ensure that they are not saturated or overload.  Also be sure you have the rsync options you want defined.

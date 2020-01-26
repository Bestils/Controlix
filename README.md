#                         Controlix
 
#  Features!
 
  -  Programm your own auto backuper, running whenever you want
  - Create a backup by hand using -execute
  - Chose beetwen incremental and full backup
 
 
You can also:
  
  - create jobs remotely
 
 
Main idea comming after this project is to allow in easy way managich Fast Data.
Every know that fast data is very valuable for Companies and Using Ride is high coster. Using this software there is cheap option to use smaller disc or even one for manny stations
 
> For secure and important data like databases there is always problem about hosting and recovering these data but using this backuer with incremental option you can save a real huge amount of space and resources. We recomend to set this for one minute interval for incrementall and one day for full backup.
 
 
 
### Tech
 
Dillinger uses a number of open source projects to work properly:
 
* [Bash] - Main core of whole application. Everything is based on pure Bash to run correctly on Linux, Mac and even on Windows with emulator
* [Cron] -  scheduler which check tasks
* [ncat] - online hoster , backdorer (OPTIONAL)
 
 
### Installation
Instalation is very easy. Just clone this repo and put this in $HOME/Bash ;)
 
### Commands
 
create
 
        --name='backup name'
 
        --full-interval='full backup option, place interval time in seconds'
       
        --inc-interval=' interval backup. Same as full
 
        --path=' root direction to data which will be backuped'
 
        --gzip'if you want gzip'
 
        --ext=' if you want to specify for only files with some exts
              use this in this form . --ext= '.sh,.txt,.doc'
 
        --backup-dir='destination of backups'
 
        -h lub --help help
 
        -v lub --version=  version
 
 
                        name_incr_rok_miesiąc_dzień_godzina_minuta.tar
 
        -execute this allows you to execute single tar quer wihout scheduling with tasks
 
 
read
 
        --name='name'
 
        --date='date of neares backup;
 
                        format datyof date: YEAR_MONYH_DAY_HOUR_MINUTE'
 
        --backup_dir='directory with backup'

        --out_dir='Destination of backup
 
cron
 

 #### cron 
To activate this you just need to add to cron
                * * * * * and path to autoBackup.sh

autoBackup.sh is executed by cron every minute . This script check task's list for any maching one. 

If you want to run this more frequently then every munute add 
                * * * * * ( sleep 30 ; /path/to/executable param1 param2 )
here time in sleep is delay

### Example usage
 
                ./Main.sh create --name= whatever --path= $HOME/Bash/PokazTuWyjdzie --backup-dir= $HOME/Bash/PokazStad --gzip --full-interval= 109
 
  this backup will be doing automaticly every 3 minutes.

 
and next to execute this you can add -execute 
like 
                ./Main.sh create -execute --name= whatever --path= $HOME/Bash/PokazTuWyjdzie --backup-dir= $HOME/Bash/PokazStad --gzip --full-interval= 109

Cron will just run file autoBackup.sh so if you want to test if it will work just write 
                $HOME/Bash/Controlix/autoBackup.sh
 
to read this you need usage
 
                ./Main.sh read --name= whatever --out_dir= /home/death/Bash/PokazTuWyjdzie --backup_dir= /home/death/Bash/PokazStad


###  PLUGINS 
Using ncat  you can host backups online and share task in backdore to use this
 HOW TO: 

>   C can also be used to copy the files from one system to another, though it is not recommended & mostly all systems have ssh/scp installed by default. But none the less if you have come across a system with no ssh/scp, you can also use nc as last ditch effort.

Start with machine on which data is to be received & start nc is listener mode,

                $ ncat -l  8080 > file.txt

Now on the machine from where data is to be copied, run the following command,

                $ ncat 192.168.1.100 8080 --send-only < data.txt

Here, data.txt is the file that has to be sent. –send-only option will close the connection once the file has been copied. If not using this option, than we will have press ctrl+c to close the connection manually.

We can also copy entire disk partitions using this method, but it should be done with caution.
###Example: 7) Create a backdoor via nc/nact

NC command can also be used to create backdoor to your systems & this technique is actually used by hackers a lot. We should know how it works in order to secure our system. To create a backdoor, the command is,

                $ ncat -l 10000 -e /bin/bash

‘e‘ flag attaches a bash to port 10000. Now a client can connect to port 10000 on server & will have complete access to our system via bash,

                $ ncat 192.168.1.100 1000

###Example: 8) Port forwarding via nc/ncat

We can also use NC for port forwarding with the help of option ‘c’ , syntax for accomplishing port forwarding is,

                $ ncat -u -l  80 -c  'ncat -u -l 8080'

Now all the connections for port 80 will be forwarded to port 8080.
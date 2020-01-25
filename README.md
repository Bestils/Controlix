#                         Controlix

#  Features!

  -  Programm your own auto backuper, running whenever you want
  - Create a backup by hand using -execute
  - Chose beetwen incremental and full backup


You can also:
  - Host files online by ncat
  - create jobs remotely
  

Main idea comming after this project is to allow in easy way managich Fast Data.
Every know that fast data is very valuable for Companies and Using Ride is high coster. Using this software there is cheap option to use smaller disc or even one for manny stations

> For secure and important data like databases there is always problem about hosting and recovering these data but using this backuer with incremental option you can save a real huge amount of space and resources. We recomend to set this for one minute interval for incrementall and one day for full backup.



### Tech

Dillinger uses a number of open source projects to work properly:

* [Bash] - Main core of whole application. Everything is based on pure Bash to run correctly on Linux, Mac and even on Windows with emulator
* [Cron] -  scheduler which check tasks
* [ncat] - online hoster , backdorer 


### Installation
Instalation is very easy. Just clone this repo ;)

### Usage

        --name='backup name'

        --full-interval='full backup option, place interval time in seconds'
        
        --inc-interval=' interval backup. Same as full

        --path=' root direction to data which will be backuped'

        --gzip='if you want gzip'

        --ext=' if you want to specify for only files with some exts
              use this in this form . --ext= '.sh,.txt,.doc'

        --backup-dir='destination of backups'

        -h lub --help help 

        -v lub --version=  version 


                        name_incr_rok_miesiąc_dzień_godzina_minuta.tar


restoring 

        --name='początek nazwy pliku z backupem'

        --date='czas, na który odtworzyć backup (lub najbliższy w przeszłości zawierający backup);

                        format daty: rok_miesiąc_dzień_godzina_minuta_sekunda'

        --backup-dir='położenie pliku z backupami'

        --out-dir='katalog, do którego wypakować backup'
```sh
$ cd dillinger
$ npm install -d
$ node app
```

For production environments...

```sh
$ npm install --production
$ NODE_ENV=production node app
```


        W wyniku działania w katalogu 'backup-dir' powstaną pełne

        i przyrostowe kopie plików z zadanego katalogu.

        Kopie będą plikami z rozszerzeniem 'tar' lub tgz, jeżeli użyto opcji --gzip.

        Nazwa pliku będzie miała następującą postać:

        - pełen backup:

                        name_full_rok_miesiąc_dzień_godzina_minuta.tar

        - backup przyrostowy:


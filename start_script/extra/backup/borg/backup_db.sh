#!/bin/bash
# BorgBackup NSF Backup Script

#LOGIFILE=/local/backup/log/backup_db.log

if [ "$LOGFILE" = "" ]; then
  OUTFILE=/dev/null
else
  OUTFILE=$LOGIFILE
fi

logfile()
{
  if [ "$LOGIFILE" = "" ]; then return 0; fi
  echo "$@" >> $LOGIFILE
}

logfile "--- BACKUP DB ---"
logfile "PhysicalFileName : $1"
logfile "FileName         : $2"
logfile "BackupReference  : $3"
logfile "BackupNode       : $4"
logfile "BackupName       : $5"
logfile "BackupMode       : $6"
logfile "BackupDateTime   : $7"
logfile "BackupTargetDir  : $8"
logfile "RetentionDays    : $9"

SOURCE="$1"

BORG_REPOSITORY="$8"
BORG_ARCHIV=$4#$6#$7$(echo "$SOURCE" | tr "/" "#" | tr " " "_")

BORG_RESTORE_MOUNT=/local/restore
BORG_LOCATION="$BORG_REPOSITORY::$BORG_ARCHIV"
BORG_BIN="borg"

logfile "borg create [$SOURCE] -> [$BORG_LOCATION]"

# create the archive (copy database)
$BORG_BIN create $BORG_LOCATION "$SOURCE"

BORG_RET=$?

if [ "$BORG_RET" = "0" ]; then
 echo "Return: PROCESSED ($1)"
  logfile "Return: PROCESSED ($1)"
else
  echo "Return: ERROR ($1)"
  logfile "Return: ERROR ($1)"
fi

logfile


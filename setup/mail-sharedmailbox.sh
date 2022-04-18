#!/bin/bash
#
# User Authentication and Destination Validation
# ----------------------------------------------
#
# This script configures user authentication for Dovecot
# and Postfix (which relies on Dovecot) and destination
# validation by quering an Sqlite3 database of mail users.

source setup/functions.sh # load our functions
source /etc/mailinabox.conf # load global vars

# ### User and Alias Database

# The database of mail users (i.e. authenticated users, who have mailboxes)
# and aliases (forwarders).

# Move create to new mysql file
# db_path=$STORAGE_ROOT/mail/users.sqlite

# Create an empty database if it doesn't yet exist.
# if [ ! -f $db_path ]; then
# 	echo Creating new user database: $db_path;
# 	echo "CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT NOT NULL UNIQUE, password TEXT NOT NULL, extra, privileges TEXT NOT NULL DEFAULT '');" | sqlite3 $db_path;
# 	echo "CREATE TABLE aliases (id INTEGER PRIMARY KEY AUTOINCREMENT, source TEXT NOT NULL UNIQUE, destination TEXT NOT NULL, permitted_senders TEXT);" | sqlite3 $db_path;
# 	echo "CREATE TABLE mfa (id INTEGER PRIMARY KEY AUTOINCREMENT, user_id INTEGER NOT NULL, type TEXT NOT NULL, secret TEXT NOT NULL, mru_token TEXT, label TEXT, FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE);" | sqlite3 $db_path;
# 	echo "CREATE TABLE auto_aliases (id INTEGER PRIMARY KEY AUTOINCREMENT, source TEXT NOT NULL UNIQUE, destination TEXT NOT NULL, permitted_senders TEXT);" | sqlite3 $db_path;
# fi

# ### User Authentication

# Have Dovecot query our database, and not system users, for authentication.
sed -i "s/#mail_plugins = .*/mail_plugins = acl/" /etc/dovecot/conf.d/10-mail.conf

cat >> /etc/dovecot/conf.d/10-master.conf << EOF;
service dict {
  # If dict proxy is used, mail processes should have access to its socket.
  # For example: mode=0660, group=vmail and global mail_access_groups=vmail
  unix_listener dict {
    mode = 0600
    user = mail
    group = mail
  }
}
EOF
cat >> /etc/dovecot/conf.d/10-mail.conf << EOF;
namespace {
  type = shared
  separator = /
  prefix = shared/%%u/
  location = maildir:${STORAGE_ROOT}/mail/mailboxes/%%d/%%n/Maildir:INDEXPVT=${STORAGE_ROOT}/mail/mailboxes/%d/%n/Maildir/shared/%%u
  subscriptions = no
  list = children
}
EOF

cat >> /etc/dovecot/conf.d/90-acl.conf << EOF;
plugin {
  acl = vfile
}

plugin {
  acl_shared_dict = proxy::acl
}

dict {
  acl = mysql:/etc/dovecot/dovecot-dict-sql.conf.ext
}
EOF

# Restart Services
##################

restart_service postfix
restart_service dovecot



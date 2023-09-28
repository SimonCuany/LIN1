#! /bin/bash

######################################################################################
# Create Base, Groups and Users

mkdir /etc/ldap/content

LDAP_FILE="/etc/ldap/content/base.ldif"
cat <<EOM >$LDAP_FILE

dn: ou=users,dc=lin1,dc=local
objectClass: organizationalUnit
objectClass: top
ou: users

dn: ou=groups,dc=lin1,dc=local
objectClass: organizationalUnit
objectClass: top
ou: groups

EOM

LDAP_FILE="/etc/ldap/content/groups.ldif"
cat <<EOM >$LDAP_FILE

dn: cn=Managers,ou=groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20000

dn: cn=Ingenieurs,ou=groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20010

dn: cn=Devloppeurs,ou=groups,dc=lin1,dc=local
objectClass: top
objectClass: posixGroup
gidNumber: 20020

EOM

LDAP_FILE="/etc/ldap/content/users.ldif"
cat <<EOM >$LDAP_FILE

dn: uid=man1,ou=users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: man1
userPassword: {crypt}x
cn: Man 1
givenName: Man
sn: 1
loginShell: /bin/bash
uidNumber: 10000
gidNumber: 20000
displayName: Man 1
homeDirectory: /home/man1
mail: man1@$DOMAIN
description: Man 1 account

dn: uid=man2,ou=users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: man2
userPassword: {crypt}x
cn: Man 2
givenName: Man
sn: 2
loginShell: /bin/bash
uidNumber: 10001
gidNumber: 20000
displayName: Man 2
homeDirectory: /home/man1
mail: man2@$DOMAIN
description: Man 2 account

dn: uid=ing1,ou=users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: ing1
userPassword: {crypt}x
cn: Ing 1
givenName: Ing
sn: 1
loginShell: /bin/bash
uidNumber: 10010
gidNumber: 20010
displayName: Ing 1
homeDirectory: /home/man1
mail: ing1@$DOMAIN
description: Ing 1 account

dn: uid=ing2,ou=users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: ing2
userPassword: {crypt}x
cn: Ing 2
givenName: Ing
sn: 2
loginShell: /bin/bash
uidNumber: 10011
gidNumber: 20010
displayName: Ing 2
homeDirectory: /home/man1
mail: ing2@$DOMAIN
description: Ing 2 account

dn: uid=dev1,ou=users,dc=lin1,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
objectClass: person
uid: dev1
userPassword: {crypt}x
cn: Dev 1
givenName: Dev
sn: 1
loginShell: /bin/bash
uidNumber: 10020
gidNumber: 20020
displayName: Dev 1
homeDirectory: /home/man1
mail: dev1@$DOMAIN
description: Dev 1 account

EOM

LDAP_FILE="/etc/ldap/content/addtogroup.ldif"
cat <<EOM >$LDAP_FILE

dn: cn=Managers,ou=groups,dc=lin1,dc=local
changetype: modify
add: memberuid
memberuid: man1

dn: cn=Managers,ou=groups,dc=lin1,dc=local
changetype: modify
add: memberuid
memberuid: man2

dn: cn=Ingenieurs,ou=groups,dc=lin1,dc=local
changetype: modify
add: memberuid
memberuid: ing1

dn: cn=Ingenieurs,ou=groups,dc=lin1,dc=local
changetype: modify
add: memberuid
memberuid: ing2

dn: cn=Devloppeurs,ou=groups,dc=lin1,dc=local
changetype: modify
add: memberuid
memberuid: dev1

EOM

ldapadd -x -D "$LdapAdminCNString" -f /etc/ldap/content/base.ldif -w $LDAPPWD

ldapadd -x -D "$LdapAdminCNString" -f /etc/ldap/content/users.ldif -w $LDAPPWD

ldappasswd -s "$LDAPPWD" -D "$LdapAdminCNString" -x "uid=man1,ou=users,dc=lin1,dc=local" -w $LDAPPWD
ldappasswd -s "$LDAPPWD" -D "$LdapAdminCNString" -x "uid=man2,ou=users,dc=lin1,dc=local" -w $LDAPPWD
ldappasswd -s "$LDAPPWD" -D "$LdapAdminCNString" -x "uid=ing1,ou=users,dc=lin1,dc=local" -w $LDAPPWD
ldappasswd -s "$LDAPPWD" -D "$LdapAdminCNString" -x "uid=ing2,ou=users,dc=lin1,dc=local" -w $LDAPPWD
ldappasswd -s "$LDAPPWD" -D "$LdapAdminCNString" -x "uid=dev1,ou=users,dc=lin1,dc=local" -w $LDAPPWD

ldapadd -x -D "$LdapAdminCNString" -f /etc/ldap/content/groups.ldif -w $LDAPPWD

ldapmodify -x -D "$LdapAdminCNString" -f /etc/ldap/content/addtogroup.ldif -w $LDAPPWD

ldapsearch -x -D "$LdapAdminCNString" -b "$LdapDCString" "(objectclass=*)" -w $LDAPPWD
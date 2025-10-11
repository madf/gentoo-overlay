# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( mbe )
ACCT_USER_HOME="/etc/mbe"
ACCT_USER_HOME_OWNER="mbe:mbe"

acct-user_add_deps

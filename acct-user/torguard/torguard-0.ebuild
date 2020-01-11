# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="Torguard VPN client user"
ACCT_USER_ID=354
ACCT_USER_GROUPS=( torguard )

acct-user_add_deps

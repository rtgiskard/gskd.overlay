# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="KMS Emulator in C"
HOMEPAGE="https://github.com/Wind4/vlmcsd"
SRC_URI="https://github.com/Wind4/${PN}/archive/svn${PVR}.tar.gz -> ${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-svn${PVR}"

src_compile() {
	emake
	emake man
}

src_install() {
	dobin ./bin/vlmcs
	dobin ./bin/vlmcsd

	doman ./man/vlmcs.1
	doman ./man/vlmcsd-floppy.7
	doman ./man/vlmcsd.7
	doman ./man/vlmcsd.8
	doman ./man/vlmcsd.ini.5
	doman ./man/vlmcsdmulti.1

	insinto /etc/vlmcsd
	doins ./etc/vlmcsd.kmd
	newins "${FILESDIR}"/vlmcsd.ini vlmcsd.ini
	newins ./etc/vlmcsd.ini	vlmcsd.ini.sample

	systemd_dounit "${FILESDIR}"/vlmcsd.service
	systemd_newtmpfilesd "${FILESDIR}"/vlmcsd.tmpfiles.conf vlmcsd.conf
}

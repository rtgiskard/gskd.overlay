# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools unpacker

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DeaDBeeF-Player/deadbeef-mpris2-plugin.git"
else
	SRC_URI="https://mirror.rt/gskd.pkgs/deadbeef/deadbeef-mpris2.tar.zst -> ${PF}.tar.zst"
	S="${WORKDIR}/${PN}"
	KEYWORDS="amd64 arm64 riscv"
fi

DESCRIPTION="MPRISv2 plugin for the DeaDBeeF audio player"
HOMEPAGE="https://github.com/DeaDBeeF-Player/deadbeef-mpris2-plugin"

LICENSE="GPL-3"
SLOT="0"

DEPEND="media-sound/deadbeef"
RDEPEND="${DEPEND}"
BDEPEND="$(unpacker_src_uri_depends)"

src_prepare(){
	default

	eautoreconf --prefix=/usr
}

src_configure(){
	econf \
		--enable-static=no \
		--enable-shared=yes \
		--disable-dependency-tracking
}

src_install() {
	insinto /usr/$(get_libdir)/deadbeef
	doins .libs/mpris.so
}

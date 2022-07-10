# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/ddb_quick_search.git"
else
	SRC_URI="https://mirror.rt/gskd.pkgs/deadbeef/ddb_quick_search.tar.zst -> ${PF}.tar.zst"
	KEYWORDS="amd64 arm64 riscv"
fi

S="${WORKDIR}/ddb_quick_search"

DESCRIPTION="Quick Search Plugin for the DeaDBeeF audio player"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_quick_search"

LICENSE="GPL-2"
SLOT="0"

DEPEND="media-sound/deadbeef"
RDEPEND="${DEPEND}"
BDEPEND="$(unpacker_src_uri_depends)"

src_compile() {
	emake gtk3
}

src_install() {
	insinto /usr/$(get_libdir)/deadbeef
	doins gtk3/ddb_misc_quick_search_GTK3.so
}

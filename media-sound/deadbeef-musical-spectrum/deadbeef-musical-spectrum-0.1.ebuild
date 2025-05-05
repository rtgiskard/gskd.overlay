# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cboxdoerfer/ddb_musical_spectrum.git"
else
	SRC_URI="https://mirror.rt/gskd.pkgs/deadbeef/ddb_musical_spectrum.tar.zst -> ${PF}.tar.zst"
	KEYWORDS="amd64"
fi

DESCRIPTION="Musical Spectrum plugin for DeaDBeeF music player"
HOMEPAGE="https://github.com/cboxdoerfer/ddb_musical_spectrum"

S="${WORKDIR}/ddb_musical_spectrum"

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	sci-libs/fftw:3.0
	media-sound/deadbeef"
RDEPEND="${DEPEND}"
BDEPEND="$(unpacker_src_uri_depends)"

src_compile() {
	emake gtk3
}

src_install() {
	insinto /usr/$(get_libdir)/deadbeef
	doins gtk3/ddb_vis_musical_spectrum_GTK3.so
}

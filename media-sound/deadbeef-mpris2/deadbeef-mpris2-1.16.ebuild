# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/DeaDBeeF-Player/deadbeef-mpris2-plugin.git"
else
	SRC_URI="https://github.com/DeaDBeeF-Player/deadbeef-mpris2-plugin/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}"
	KEYWORDS="amd64"
fi

DESCRIPTION="MPRISv2 plugin for the DeaDBeeF music player"
HOMEPAGE="https://github.com/DeaDBeeF-Player/deadbeef-mpris2-plugin"

LICENSE="GPL-2"
SLOT="0"

IUSE="debug"

DEPEND="
	dev-libs/glib:2
	>=media-sound/deadbeef-1.8.0[cover]
"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user

	eautoreconf
}

src_configure() {
	econf $(use_enable debug)
}

src_install() {
	default

	# Remove static library
	find "${ED}" -name \*.la -delete || die
}

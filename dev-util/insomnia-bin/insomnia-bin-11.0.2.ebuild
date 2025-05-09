# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit desktop unpacker xdg

DESCRIPTION="HTTP and GraphQL client for developers"
HOMEPAGE="https://insomnia.rest"
SRC_URI="https://github.com/Kong/${MY_PN}/releases/download/core@${PV}/Insomnia.Core-${PV}.deb"

S="$WORKDIR"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/nss
	x11-libs/gtk+
	media-libs/mesa
"

src_install() {
	for size in 16x16 32x32 48x48 128x128 256x256 512x512; do
		doicon -s "${size}" usr/share/icons/hicolor/"${size}"/apps/insomnia.png
	done
	dosym ../icons/hicolor/512x512/apps/insomnia.png \
		/usr/share/pixmaps/insomnia.png

	domenu usr/share/applications/insomnia.desktop

	insinto /opt/Insomnia
	doins -r opt/Insomnia/.
	fperms +x /opt/Insomnia/insomnia
	fperms +x /opt/Insomnia/chrome_crashpad_handler
	dosym ../Insomnia/insomnia opt/bin/insomnia
}

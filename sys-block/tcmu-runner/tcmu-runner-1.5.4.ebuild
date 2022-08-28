# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake linux-info

DESCRIPTION="A daemon that handles the userspace side of the LIO TCM-User backstore"
HOMEPAGE="https://www.open-iscsi.com/"
SRC_URI="https://github.com/open-iscsi/${PN}/archive/v${PVR}.tar.gz -> ${PF}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+fbo -glfs +qcow -rbd +systemd +tcmalloc +zbc"

DEPEND="
	dev-libs/glib:2
	dev-libs/libnl:3
	glfs? ( sys-cluster/glusterfs )
	rbd? ( sys-cluster/ceph )
	sys-libs/zlib"
RDEPEND="${DEPEND}
	sys-apps/kmod
	systemd? ( sys-apps/systemd )"

S="${WORKDIR}/${PF}"

pkg_setup() {
	linux-info_pkg_setup

	CONFIG_CHECK_MODULES="TCM_USER2"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_module ${module} || \
				ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
	fi
}

src_configure() {
	local mycmakeargs

	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DSUPPORT_SYSTEMD=$(usex systemd)
		-Dwith-fbo=$(usex fbo)
		-Dwith-glfs=$(usex glfs)
		-Dwith-qcow=$(usex qcow)
		-Dwith-rbd=$(usex rbd)
		-Dwith-tcmalloc=$(usex tcmalloc)
		-Dwith-zbc=$(usex zbc)
	)

	cmake_src_configure
}

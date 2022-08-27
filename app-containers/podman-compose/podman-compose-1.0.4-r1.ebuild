# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="An implementation of Compose Spec with Podman backend"
HOMEPAGE="https://github.com/rtgiskard/podman-compose"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rtgiskard/podman-compose.git"
	EGIT_BRANCH="devel"
else
	SRC_URI="https://github.com/rtgiskard/podman-compose/archive/refs/tags/v${PVR}.tar.gz -> ${PF}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/${PF}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-python/python-dotenv
	dev-python/pyyaml"
RDEPEND="${DEPEND}
	app-containers/podman"

DOCS=( README.md )

distutils_enable_tests pytest

python_install() {
	distutils-r1_python_install

	dobashcomp completion/bash/*
}

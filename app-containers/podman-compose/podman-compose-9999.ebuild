# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit bash-completion-r1 distutils-r1

DESCRIPTION="An implementation of Compose Spec with Podman backend"
HOMEPAGE="https://github.com/containers/podman-compose"

if [[ ${PV} == 9999* ]] ; then
	BRANCH="devel"
	SRC_URI="https://github.com/containers/podman-compose/archive/${BRANCH}.tar.gz -> ${PF}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	S="${WORKDIR}/${PN}-${BRANCH}"
else
	SRC_URI="https://github.com/containers/podman-compose/archive/refs/tags/v${PV}.tar.gz -> ${PF}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
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

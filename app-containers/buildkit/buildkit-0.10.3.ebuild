# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

if [[ ${PV} == 9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/moby/buildkit.git"
else
	SRC_URI="https://github.com/moby/buildkit/archive/refs/tags/v${PV}.tar.gz -> ${PF}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
HOMEPAGE="https://github.com/moby/buildkit"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+seccomp"

DEPEND="app-containers/runc"
RDEPEND="${DEPEND}"
BDEPEND="
	seccomp? ( sys-libs/libseccomp )
	>=dev-lang/go-1.16"

src_compile() {
	local PKG="github.com/moby/buildkit"
	local LD_FLAGS="-X ${PKG}/version.Version=v${PV} -X ${PKG}/version.Package=${PKG}"
	local TAGS_BUILDKITD="osusergo netgo static_build $(usev seccomp)"

	mkdir build.out

	go build -ldflags "$LD_FLAGS" -o build.out/buildctl ./cmd/buildctl
	go build -ldflags "$LD_FLAGS -extldflags '-static'" -tags "$TAGS_BUILDKITD" -o build.out/buildkitd ./cmd/buildkitd
}

src_install() {
	exeinto /usr/bin
	doexe build.out/buildctl
	doexe build.out/buildkitd

	insinto /etc/buildkit
	doins "${FILESDIR}"/buildkitd.toml

	systemd_dounit "${FILESDIR}"/{buildkit.service,buildkit.socket}
}

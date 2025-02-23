# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Configuration and diagnostic tool for Mesa Electronics boards"
HOMEPAGE="https://github.com/LinuxCNC/mesaflash"
SRC_URI="https://github.com/LinuxCNC/mesaflash/archive/refs/tags/release/${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="sys-apps/pciutils"

S="${WORKDIR}/mesaflash-release-${PV}"

src_configure() {
	CFLAGS="-O0 -g -Wall -Wextra -Werror"
}

src_install() {
	default

	doman "mesaflash.1"

	rm -rf "${D}/share"
}

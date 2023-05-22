# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AMD Optimizing C/C++ and Fortran Compilers (AOCC)"
HOMEPAGE="https://developer.amd.com/amd-aocc/"
SRC_URI="${P}.tar"

LICENSE="|| ( all-rights-reserved Apache-2.0-with-LLVM-exceptions )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# AOCC must be downloaded directly from AMD:
# https://www.amd.com/en/developer/aocc.html
#
# Once finished and if you accept their EULA, place tarball in:
# /var/cache/distfiles

RESTRICT="bindist fetch mirror"

RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

src_prepare() {
	default

	# Purge i386 files due to unresolved deps (keep the others)
	find "${S}" -name "*i386*" -type f -delete
}

src_install() {
	dodir "/opt/aocc-compiler"

	cp -aR "${S}/bin" "${D}/opt/aocc-compiler/"
	cp -aR "${S}/lib" "${D}/opt/aocc-compiler/"
	cp -aR "${S}/libexec" "${D}/opt/aocc-compiler/"
	cp -aR "${S}/ompd" "${D}/opt/aocc-compiler/"
	cp -aR "${S}/include" "${D}/opt/aocc-compiler/"
	cp -aR "${S}/share" "${D}/opt/aocc-compiler/"

	# Licenses
	cp -aR "${S}/"*.TXT "${D}/opt/aocc-compiler/"
	cp -aR "${S}/"*.pdf "${D}/opt/aocc-compiler/"
}

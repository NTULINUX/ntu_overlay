# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A flexible GUI for LinuxCNC"
HOMEPAGE="https://gnipsel.com/linuxcnc/flexgui/index.html"
EGIT_REPO_URI="https://github.com/jethornton/flexgui.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/pyqt6[designer]
	sci-electronics/linuxcnc
"
DEPEND=""
BDEPEND=""

src_install() {
	dobin "${S}/flexgui/src/flexgui"
	dobin "${S}/flexgui/src/flexcopy"
	dobin "${S}/flexgui/src/flexqrc"

	dodir /usr/share/applications/flexgui
	cp -ar "${S}/flexgui/"*.desktop "${D}/usr/share/applications/flexgui"

	dodir /usr/lib/libflexgui
	cp -ar "${S}/flexgui/src/"*.ui "${D}/usr/lib/libflexgui/"
	cp -ar "${S}/flexgui/src/libflexgui/"*.ui "${D}/usr/lib/libflexgui/"
	cp -ar "${S}/flexgui/src/libflexgui/"*.qss "${D}/usr/lib/libflexgui/"

	dodir /usr/lib/python3/dist-packages/libflexgui
	cp -ar "${S}/flexgui/src/libflexgui/"*.py "${D}/usr/lib/python3/dist-packages/libflexgui/"

	dodir /usr/lib/libflexgui/examples
	cp -ar "${S}/examples/"* "usr/lib/libflexgui/examples/"

	dodoc flexgui/FlexGUI-blackbg.png
}

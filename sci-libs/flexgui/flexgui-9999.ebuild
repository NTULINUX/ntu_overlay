# Copyright 1999-2025 Gentoo Authors
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
	sci-electronics/linuxcnc
"

src_install() {
	dobin "${S}/flexgui/src/flexgui"
	dobin "${S}/flexgui/src/flexcopy"
	dobin "${S}/flexgui/src/flexqrc"
	dobin "${S}/flexgui/src/flexqss"
	dobin "${S}/flexgui/src/flexdocs"

	dodir /usr/share/applications/flexgui
	cp -ar "${S}/flexgui/"*.desktop "${D}/usr/share/applications/flexgui"

	dodir /usr/lib/libflexgui
	cp -ar "${S}/flexgui/src/"*.ui "${D}/usr/lib/libflexgui/"
	cp -ar "${S}/flexgui/src/libflexgui/"*.ui "${D}/usr/lib/libflexgui/"
	cp -ar "${S}/flexgui/src/libflexgui/"*.qss "${D}/usr/lib/libflexgui/"
	cp -ar "${S}/flexgui/src/libflexgui/"*.jpg "${D}/usr/lib/libflexgui/"

	dodir /usr/lib/python3/dist-packages/libflexgui
	cp -ar "${S}/flexgui/src/libflexgui/"*.py "${D}/usr/lib/python3/dist-packages/libflexgui/"

	dodir /usr/lib/libflexgui/examples
	cp -ar "${S}/examples/"* "${D}/usr/lib/libflexgui/examples/"

	dodoc flexgui/FlexGUI-blackbg.png
	dodoc flexgui/flexgui.pdf
}

pkg_postinst() {
	einfo "FlexGUI example configs are stored in:"
	einfo "/usr/lib/libflexgui/examples"
	einfo ""
	einfo "These may be copied into the LinuxCNC folder"
	einfo "in your home directory (assuming you have"
	einfo "already started a LinuxCNC sample config.)"
}

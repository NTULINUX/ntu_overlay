# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit desktop git-r3 python-single-r1 xdg-utils

DESCRIPTION="A flexible GUI for LinuxCNC"
HOMEPAGE="https://gnipsel.com/linuxcnc/flexgui/index.html"
EGIT_REPO_URI="https://github.com/jethornton/flexgui.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		sci-electronics/linuxcnc[${PYTHON_SINGLE_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

src_install() {
	dobin "${S}/flexgui/src/flexgui"
	dobin "${S}/flexgui/src/flexcopy"
	dobin "${S}/flexgui/src/flexqrc"
	dobin "${S}/flexgui/src/flexqss"
	dobin "${S}/flexgui/src/flexdocs"

	domenu "${S}/flexgui/"*.desktop

	insinto /usr/lib/libflexgui
	doins "${S}/flexgui/src/"*.ui
	doins "${S}/flexgui/src/libflexgui/"*.ui
	doins "${S}/flexgui/src/libflexgui/"*.qss
	doins "${S}/flexgui/src/libflexgui/"*.jpg

	insinto "$(python_get_sitedir)/libflexgui"
	doins "${S}/flexgui/src/libflexgui/"*.py

	insinto /usr/lib/libflexgui/examples
	doins -r "${S}/examples/"*

	dodoc flexgui/FlexGUI-blackbg.png
	dodoc flexgui/flexgui.pdf

	python_optimize
}

pkg_postinst() {
	einfo "FlexGUI example configs are stored in:"
	einfo "/usr/lib/libflexgui/examples"
	einfo ""
	einfo "These may be copied into the LinuxCNC folder"
	einfo "in your home directory (assuming you have"
	einfo "already started a LinuxCNC sample config.)"

	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

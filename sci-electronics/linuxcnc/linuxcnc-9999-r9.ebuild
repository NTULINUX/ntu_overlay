# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# FIXME: Documentation install directory (upstream bug?)

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit desktop git-r3 linux-info check-reqs python-single-r1 python-utils-r1 xdg-utils

DESCRIPTION="An open source CNC machine controller"
HOMEPAGE="https://www.linuxcnc.org/"
EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qtpyvcp-deps"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_impl_dep 'tk(+)')
	$(python_gen_cond_dep '
		dev-libs/boost[python,${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pyopengl[${PYTHON_USEDEP}]
		dev-python/python-xlib[${PYTHON_USEDEP}]
		dev-python/yapps2[${PYTHON_USEDEP}]
	')
	qtpyvcp-deps? (
		$(python_gen_cond_dep '
			dev-python/deepdiff[${PYTHON_USEDEP}]
			dev-python/docopt[${PYTHON_USEDEP}]
			dev-python/pip[${PYTHON_USEDEP}]
			dev-python/psutil[${PYTHON_USEDEP}]
			dev-python/pyqtgraph[${PYTHON_USEDEP}]
			dev-python/pyserial[${PYTHON_USEDEP}]
			dev-python/pyside[designer,uitools,widgets,${PYTHON_USEDEP}]
			dev-python/pyudev[${PYTHON_USEDEP}]
			dev-python/pyzmq[${PYTHON_USEDEP}]
			dev-python/qtpy[designer,pyqt6,widgets,${PYTHON_USEDEP}]
			dev-python/simpleeval[${PYTHON_USEDEP}]
			dev-python/sqlalchemy[${PYTHON_USEDEP}]
			sci-libs/vtk[qt6,python,${PYTHON_SINGLE_USEDEP}]
		')
	)
	dev-lang/tcl
	dev-lang/tk
	dev-libs/glib
	dev-libs/libmodbus
	dev-tcltk/blt
	dev-tcltk/bwidget
	dev-tcltk/tclx
	sys-devel/gettext
	sys-libs/ncurses
	sys-libs/readline
	sys-process/procps
	sys-process/psmisc
	virtual/libudev
	virtual/libusb:1
	virtual/opengl
	x11-base/xorg-server
	x11-libs/gtksourceview:4
	x11-libs/libXinerama
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}
	app-text/asciidoc
"

S_TOP="${S}"
S="${S}/src"

pkg_pretend() {
	CONFIG_CHECK+=" ~PREEMPT_RT"

	local CHECKREQS_DISK_BUILD=1G
	local CHECKREQS_DISK_USR=200M

	check_extra_config
	check-reqs_${EBUILD_PHASE_FUNC}
}

src_prepare() {
	default

	# Remove ldconfig from Makefile
	sed -i '/ldconfig/d' "${S}/Makefile"

	./autogen.sh || die
}

src_install()
{
	default

	python_optimize

	# Create environment required to start LinuxCNC
	local envd="${T}/99linuxcnc"
	cat > "${envd}" <<-EOF
		TCLLIBPATH="/usr/lib/tcltk/linuxcnc"
		PYTHONPATH="/usr/lib/python3/dist-packages"
	EOF

	doenvd "${envd}"

	# Install menus and icons (don't know how to make CNC category in menu)
	doicon "${S_TOP}/debian/extras/usr/share/icons/hicolor/scalable/apps/${PN}-logo.svg"
	doicon "${S_TOP}/debian/extras/usr/share/icons/hicolor/scalable/apps/${PN}icon.svg"
	domenu "${S_TOP}/share/applications/${PN}-latency.desktop"
	domenu "${S_TOP}/share/applications/${PN}-latency-histogram.desktop"
	domenu "${S_TOP}/share/applications/${PN}-pncconf.desktop"
	domenu "${S_TOP}/share/applications/${PN}-stepconf.desktop"
	domenu "${S_TOP}/share/applications/${PN}.desktop"

	# Do not compress documentation, .ini files need to be readily accessible
	docompress -x "/usr/share/doc/${PN}/examples"

	# Force install of nc_files directory to fix broken symlink
	cp -aL "${S_TOP}/nc_files" "${D}/usr/share/doc/${PN}/examples/"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

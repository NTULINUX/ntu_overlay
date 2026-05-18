# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit git-r3 python-single-r1 python-utils-r1

DESCRIPTION="Graphical halviewer for LinuxCNC"
HOMEPAGE="https://github.com/multigcs/halviewer"
EGIT_REPO_URI="https://github.com/multigcs/halviewer.git"

PATCHES=(
	"${FILESDIR}/${PN}-use-qt6.patch"
)

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/graphviz[${PYTHON_USEDEP}]
		sci-electronics/linuxcnc[${PYTHON_SINGLE_USEDEP}]
	')
"
DEPEND="${RDEPEND}"

src_compile() {
	return 0
}

src_install() {
	dobin "${S}/halviewer.py"
}

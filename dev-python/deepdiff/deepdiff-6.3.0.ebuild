# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1 pypi

DESCRIPTION="Deep Difference and Search of any Python object/data."
HOMEPAGE="https://github.com/seperman/deepdiff https://pypi.org/project/deepdiff/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS="README.md"

RDEPEND="dev-python/ordered-set[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

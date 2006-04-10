# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/openbeatbox/openbeatbox-0.7.1.ebuild,v 1.1 2006/04/10 15:09:26 gimpel Exp $

MY_PN="obb"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Drum sequencing software with impressive UI. Not in development
anymore"
HOMEPAGE="http://openbeatbox.org/"
SRC_URI="mirror://sourceforge/openbeatbox/${MY_P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4
		dev-python/pygame
		dev-python/PyQt
		media-sound/csound
		=x11-libs/qt-3*"
S="${WORDIR}/${MY_P}"


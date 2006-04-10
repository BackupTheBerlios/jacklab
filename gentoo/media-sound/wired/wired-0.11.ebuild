# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/wired/wired-0.11.ebuild,v 1.1 2006/04/10 10:33:56 gimpel Exp $

inherit wxwidgets

DESCRIPTION="Wired aims to be a professional music production and creation software running on the Linux operating system."
HOMEPAGE="http://bloodshed.net/wired/"
SRC_URI="mirror://sourceforge/wired/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86"
S=${WORKDIR}/${PN}

IUSE=""
DEPEND=">=x11-libs/wxGTK-2.5.3
		media-libs/alsa-lib
		x11-libs/gtk+
		>=media-libs/portaudio-19
		>=media-libs/libsoundtouch-1.2.1
		media-libs/libsndfile"

pkg_setup() {
	if ${WX_CONFIG} --version | grep 2.4 >& /dev/null ; then
                einfo "Compiling ${PN} against wxGTK2 2.4.x is not supported."
                einfo "You can upgrade wxGTK to development snapshot > 2.5.3"
	else
	        if ! use gtk2 >& /dev/null ; then
                        einfo "You need to compile wxGTK with USE='gtk2'"
                elif use unicode >& /dev/null ; then
                        need-wxwidgets unicode || die "You need to emerge wxGTK with USE='-unicode'"
                else
                        need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='gtk2'"
                fi
	fi
}

src_compile() {
	export WX_GTK_VER=2.6
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
}


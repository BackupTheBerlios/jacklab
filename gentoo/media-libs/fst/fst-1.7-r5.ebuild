# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-libs/fst/fst-1.7-r5.ebuild,v 1.1 2006/04/10 10:24:39 gimpel Exp $

RESTRICT="nomirror"

DESCRIPTION="FreeST audio plugin VST container library"
HOMEPAGE="http://joebutton.co.uk/fst/"
LICENSE="GPL-2"
IUSE=""

SRC_URI="http://galan.sf.net/${P}.tar.gz"
VST_SDK_VER="2.3"


KEYWORDS="x86"
DEPEND=">=app-emulation/wine-0.9.5
	>=media-sound/jack-audio-connection-kit-0.98.1
	=media-libs/vst-sdk-${VST_SDK_VER}*"
	

src_unpack() {
	unpack "${A}" || die
	einfo "Patch Makefile 0-5"
	sed -i  /test\ -n\ \$\(SDKDIR\)\ \&\&\ \$\(RM\)\ -rf\ \$\(SDKDIR\)/d "${S}"/Makefile || die
	einfo "Patch Makefile 1-5"
	sed -i /distclean:clean/d  "${S}"/Makefile || die
	einfo "Patch Makefile 2-5"
	sed -i  /^SDKDIR/d "${S}"/Makefile || die
	einfo "Patch Makefile 3-5"
	sed -i  /^SDKDIR/d "${S}"/Makefile || die
	einfo "Patch Makefile 4-5"
	sed -i  /^VSTDIR/d "${S}"/Makefile || die
	einfo "Patch Makefile 5-5"
	sed -i -e 1i'VSTDIR = /usr/include/vst'  "${S}"/Makefile || die
}

src_compile() {
	emake || die
}


src_install() {
	exeinto /usr/bin
	doexe fst fst.exe.so
	fperms 644 /usr/bin/fst.exe.so
	# object files are needed for eg. ardour with fst-support
	insinto /usr/lib/"${PN}"
	doins *.o
	# install lib, so gcc -lfst works
	insinto /usr/lib
	newins fst.exe.so libfst.so
	# install header-files
	insinto /usr/include
	doins fst.h
	insinto /usr/lib/pkgconfig
	doins "${FILESDIR}"/libfst.pc
}

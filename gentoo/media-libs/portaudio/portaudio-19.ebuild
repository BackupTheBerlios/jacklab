# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-libs/portaudio/portaudio-19.ebuild,v 1.1 2006/04/10 11:22:11 gimpel Exp $

inherit eutils

DESCRIPTION="An open-source cross platform audio API."
HOMEPAGE="http://www.portaudio.com"
SRC_URI="http://portaudio.com/archives/pa_snapshot_v19.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ~ppc ~ppc-macos ~mips"

IUSE=""

RDEPEND="virtual/libc"
DEPEND="app-arch/unzip"
S=${WORKDIR}/${PN}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	if ! use ppc-macos
	then
		dolib lib/*
		dosym /usr/$(get_libdir)/libportaudio.so.0.0.19 /usr/$(get_libdir)/libportaudio.so
	else
		dolib pa_mac_core/libportaudio.dylib
	fi

	insinto /usr/include
	doins pa_common/portaudio.h

	dodoc docs/*
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/wired/wired-0.9999.ebuild,v 1.1 2006/04/10 10:33:57 gimpel Exp $

inherit cvs eutils wxwidgets

DESCRIPTION="Wired aims to be a professional music production and creation software running on the Linux operating system."
HOMEPAGE="http://bloodshed.net/wired/?sid=1"
# SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/wired"
ECVS_MODULE="wired"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86"
IUSE="dssi nls pic static"

S=${WORKDIR}/${ECVS_MODULE}

DEPEND="media-libs/alsa-lib
	media-libs/libsndfile
	>=x11-libs/gtk+-2.0.0
	>=x11-libs/wxGTK-2.6.2
	=media-libs/portaudio-19
	=media-libs/libsoundtouch-1.2.1
	dssi? ( media-libs/dssi )"

src_unpack() {
	cvs_src_unpack
	# temporary fixes
	cd ${S}
	#cp src/audio/Makefile.in src/codec/Makefile.in 
	#cp src/audio/Makefile.in src/codec/wiredcodec/Makefile.in
	#cp src/audio/Makefile.in src/codec/wiredcodec/flac/Makefile.in
	#cp src/audio/Makefile.in src/codec/wiredcodec/mpeg/Makefile.in
	#cp src/audio/Makefile.in src/codec/wiredcodec/vorbis/Makefile.in
	libtoolize --copy --force
}

src_compile() {
	WX_GTK_VER=2.6
	if need-wxwidgets gtk2 && wx-config-2.6 --version | grep 2.6
	then
		econf \
		`use_with pic` \
		`use_enable static` \
		`use_enable dssi` \
		`use_enable nls` || die "configure failed"

		emake || die "make failed"
	else
		die "You need to emerge >=x11-libs/wxGTK-2.6.2 with USE=\"gtk2\""
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog README
}


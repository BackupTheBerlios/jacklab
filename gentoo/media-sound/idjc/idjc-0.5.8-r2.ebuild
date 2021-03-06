# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/idjc/idjc-0.5.8-r2.ebuild,v 1.1 2006/04/10 10:27:37 gimpel Exp $

inherit eutils

DESCRIPTION="Internet DJ Console"
HOMEPAGE="http://www.onlymeok.nildram.co.uk"
SRC_URI="http://www.onlymeok.nildram.co.uk/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="flac mp3 vorbis"
DEPEND=">=media-sound/jack-audio-connection-kit-0.100.7
		dev-python/eyeD3
		dev-python/pygtk
		>=media-libs/libshout-2.1
		flac? ( media-libs/flac )
		mp3? ( media-sound/lame )
		vorbis? ( media-sound/vorbis-tools )
		media-video/mplayer"

src_compile() {
	cd "${S}"
	epatch "${FILESDIR}"/"${P}"-fix_server.patch
	epatch "${FILESDIR}"/"${P}"-96kbit_ogg.patch
	epatch "${FILESDIR}"/"${P}"-locale_compat.patch
	epatch "${FILESDIR}"/"${P}"-dragndrop_unicode.patch
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
}

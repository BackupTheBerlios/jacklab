# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/netjack/Attic/netjack-0.11_rc1.ebuild,v 1.1 2006/04/10 10:32:20 gimpel Exp $

IUSE=""

inherit eutils

MY_P="${P/_/}"

#JACKVER=best_version media-sound/jack-audio-connection-kit
JACKSRC="jack-audio-connection-kit-0.100.7"
RESTRICT="nomirror"
DESCRIPTION="Realtime Audio Transport over a generic IP Network using jack"
HOMEPAGE="http://netjack.sourceforge.net"
SRC_URI="http://netjack.sourceforge.net/${MY_P}.tar.bz2
		mirror://sourceforge/jackit/${JACKSRC}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

DEPEND="media-libs/alsa-lib
		dev-util/scons"
S="${WORKDIR}/${MY_P}"

src_compile() {
	cd "${WORKDIR}/${JACKSRC}"
	econf \
		--disable-portaudio || die
	emake || die
	cd "${S}"
	scons jack_source_dir="${WORKDIR}/${JACKSRC}" || die
}

src_install() {
	dobin jacknet_client alsa_in alsa_out
	insinto /usr/lib/jack
	doins jack_net.so
}


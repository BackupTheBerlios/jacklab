# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/xubuntu/berlios_backup/github/tmp-cvs/jacklab/Repository/gentoo/media-sound/csound/csound-5.01.ebuild,v 1.1 2006/04/10 15:20:12 gimpel Exp $

DESCRIPTION="Csound is a sound and music synthesis system, providing facilities for composition and performance over a wide range of platforms."

HOMEPAGE="http://csounds.com"

RESTRICT="nomirror"
MY_P=${P/csound-/Csound}
SRC_URI="mirror://sourceforge/${PN}/${MY_P}_src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 x86"

# We default to using als, so no useflag for it ;)
IUSE="dssi java tcltk vst jack portaudio stk_opcodes osc_opcodes expensive_math doc amd64 ppc64 static altivec"


RDEPEND="
   media-libs/ladspa-sdk
   media-libs/alsa-lib
   >=media-libs/libsndfile-1.0.12-r1"

DEPEND="${RDEPEND}
   >=x11-libs/fltk-1.1*
   dev-util/scons
   =dev-lang/python-2.4*
   dev-lang/swig
   portaudio? (=media-libs/portaudio-19*)
   jack? (media-sound/jack)
   tcltk? (dev-lang/tcl)
   tcltk? (dev-lang/tk)
   java? (virtual/jdk)
   vst? (>=dev-libs/boost-1.32.1)
   osc_opcodes? (media-libs/liblo)
   doc? (app-doc/doxygen)
   dssi? (>=media-libs/dssi-0.9.1)"

S="${WORKDIR}/${MY_P}"

#src_unpack() {
#   unpack ${A}
#   cd ${S}
#}

src_compile() {
	local my_scons="CC=/usr/bin/gcc CXX=/usr/bin/g++ customCCFLAGS=-I/usr/include customCXXFLAGS=-I/usr/include prefix=/usr buildRelease=1 useCoreAudio=0 buildLoris=1 pythonVersion=2.4 buildPythonOpcodes=1"
	# Feed scons with use-enabled options
	use dssi && my_scons="buildDSSI=1 ${my_scons}" || \
		my_scons="buildDSSI=0 ${my_scons}"
	use expensive_math && my_scons="useDouble=1 ${my_scons}"
   use portaudio || my_scons="usePortAudio=0 ${my_scons}"
   use jack || my_scons="useJack=0 ${my_scons}"
   use vst && my_scons="buildCsoundVST=1 ${my_scons}"
   use doc && my_scons="generatePdf=1 ${my_scons}"
   use osc_opcodes && my_scons="useOSC=1 ${my_scons}"
   use static || my_scons="dynamicCsoundLibrary=1 ${my_scons}"
   use stk_opcodes && my_scons="buildStkOpcodes=1 ${my_scons}"
   use osc_opcodes && my_scons="useOSC=1 ${my_scons}"
   use tcltk && my_scons="buildTclcsound=0 ${my_scons}"
   use java && my_scons="buildJavaWrapper=1 ${my_scons}"
   ( use amd64 || use ppc64 )  && my_scons="Word64=1 ${my_scons}"
   use altivec && my_scons="useAltivec=1 ${my_scons}"

   # No sneaking here ;)
   einfo "configuring with following options:"
   einfo "${my_scons}"
   sleep 2

   # These addpredicts are to stop sandbox violation errors
   # addpredict in src_compile() alone does not stop sandbox
   # violation errors in src_install(()
   addpredict "/usr/include"
   addpredict "/usr/lib"

   # now let's pray it worx
   scons ${my_scons} || die "scons failed!"
}

src_install() {
#   addpredict "/usr/include"
#   dodir "/usr/bin"
#   scons prefix=${D}/usr install || die "scons install failed!"
	./install.py --prefix="/usr/" --instdir="${D}"
	cd ${D}/usr
	rm -f *.md5sums
}

pkg_postinst() {
   ewarn "This is only a template ebuild - build options and DEPENDS may be missing."
   ewarn "http://www.agnula.org/documentation/dp_tutorials/cs_beginner/"
   ewarn "http://csounds.com/"
   ewarn "http://www.csounds.com/ezine/"
}


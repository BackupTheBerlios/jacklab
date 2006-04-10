# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# install proprietary Steinberg VST SDK 2.3 to "/opt/${MY_P}"
# bug #61290

inherit eutils

RESTRICT="nostrip nofetch"

DESCRIPTION="Steinberg VST Plug-Ins SDK 2.3 - win32"
HOMEPAGE="http://www.steinberg.de/sdk_downloads/vst_29468"
IUSE="headers-only"

SRC_URI="x86? ( 
http://ygrabit.steinberg.de/users/ygrabit/public_html/vstsdk/Download/VST%20Plug-Ins%20SDK%202.3/vstsdk${PV}.zip )"

LICENSE="STEINBERG SOFT-UND HARDWARE GMBH"
SLOT="0"
KEYWORDS="x86"

DEPEND="${DEPEND}"

BASE="/opt"
S="${WORKDIR}/${MY_P}"
MY_P="${P//-/}"

pkg_nofetch() {
	einfo "Please go to ${HOMEPAGE}"
	einfo "and download the appropriate sdk zip archive for win32."
	einfo " "
	einfo "You may want to try google because and search for ${A}"
	einfo "if the above does not work for you."
	einfo " "
	einfo "Download ${A} and place it in :"
	einfo "${DISTDIR}"
	einfo " "
	ewarn "YOU MUST AGREE TO THE LICENSE TERMS LISTED AT HOMEPAGE"
	ewarn "${HOMEPAGE}"
}

src_unpack() {
	unpack ${MY_P}.zip || die
	find -type f -exec chmod 0644 {} \;
	find -type d -exec chmod 0755 {} \;
}

src_compile() {
	einfo "nothing to compile :)"
}

src_install() {
	header_path="source/common"
	include_path="/usr/include/vst"
		
	use !headers-only && dodir "${BASE}"
	dodir "${include_path}"
	mv ${S}/${header_path}/* ${D}/"${include_path}"
	rmdir "${header_path}"
	use !headers-only && mv "${S}/" "${D}/${BASE}"
	use !headers-only && dosym  "${include_path}" "${BASE}/${MY_P}/${header_path}"
	if use headers-only ;then
		dodir "${BASE}/${MY_P}"
		mv ${S}/*Licensing\ Agreement* "${D}/${BASE}/${MY_P}"
	fi
}

pkg_postinst() {
	echo
	einfo "Finished installing Steinberg VST Plug-Ins SDK  into"
	einfo "${BASE}/${MY_P}"
	einfo "DO NOT IGNORE THE IMPLICATIONS OF THIS LICENSE"
	einfo "and please *please* if you haven't already, READ THE LICENSE"
	einfo "${BASE}/${MY_P}/VST Licensing Agreement.html"
	einfo "${BASE}/${MY_P}/vst licensing agreement.rtf"
}

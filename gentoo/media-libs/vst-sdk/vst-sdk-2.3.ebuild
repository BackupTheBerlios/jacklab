# install proprietary Steinberg VST SDK 2.3 to "/opt/VST Plug-Ins SDK 2.3"
# bug #61290

inherit eutils

RESTRICT="nostrip"

DESCRIPTION="Steinberg VST Plug-Ins SDK 2.3 - win32"
HOMEPAGE="http://www.steinberg.de/Steinberg/ygrabit/index.html"

SRC_URI="x86? (
http://ygrabit.steinberg.de/users/ygrabit/public_html/vstsdk/Download/VST%20Plug-Ins%20SDK%202.3/vstsdk${PV}.zip )"

LICENSE="STEINBERG SOFT-UND HARDWARE GMBH"
SLOT="1"
KEYWORDS="x86"

DEPEND="${DEPEND}"

BASE="/opt/VST_Plug-Ins_SDK_2.3"
S=${WORKDIR}
MY_P="${P//-/}"

pkg_nofetch() {
	einfo "Please go to ${HOMEPAGE}"
	einfo "and download the appropriate sdk zip archive for win32."
	einfo " "
	einfo "You may want to try ftp://ext2asio:sdk1ext@ftp.pinnaclesys.com/SDK"
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

src_install() {
	dodir "${BASE}"
	mv "${S}/${MY_P}" "${D}/${BASE}"
}

pkg_postinst() {
	echo
	einfo "Finished installing Steinberg VST Plug-Ins SDK 2.3 into"
	einfo "${BASE}"
	einfo "DO NOT IGNORE THE IMPLICATIONS OF THIS LICENSE"
	einfo "and please *please* if you haven't already, READ THE LICENSE"
	einfo "${BASE}/vstsdk2/VST Licensing Agreement.html"
	einfo "${BASE}/vstsdk2/vst licensing agreement.rtf"
}


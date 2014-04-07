# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
SLOT="0"

DESCRIPTION="GTK3 passphrase dialog for SSH"
HOMEPAGE="http://undesktop.github.io/askpass/"
SRC_URI="https://github.com/undesktop/askpass/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="undesktop"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86"

DEPEND=">=dev-lang/vala-0.20.0
        dev-util/cmake
"
RDEPEND="dev-libs/glib:2
         x11-libs/gtk+:3
         x11-libs/cairo
"

S="${WORKDIR}/askpass-${PV}"

src_compile() {
	cd "${T}"
	cmake "${S}" -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	cd "${T}"
	emake DESTDIR="${D}" install || die "Install failed"

	exeinto /etc/profile.d
	newexe "${FILESDIR}/profile.d" "${PN}.sh" || die

	cd "${S}"
	dodoc README* || die
}

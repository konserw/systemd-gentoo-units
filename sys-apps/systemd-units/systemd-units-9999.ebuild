# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils systemd

DESCRIPTION="Service files for sys-apps/systemd"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/systemd http://en.gentoo-wiki.com/wiki/Systemd"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+basic +desktop server ingnome3"

RDEPEND=""
DEPEND=""

src_install() {
	if use basic; then
		systemd_dounit "${FILESDIR}"/services-basic/*
	fi

	if use server; then
		systemd_dounit "${FILESDIR}"/services-server/*
		systemd_dotmpfilesd "${FILESDIR}"/tmpfiles-server/*
	fi

	if use desktop; then
		systemd_dounit "${FILESDIR}"/services-desktop/*

		if ! use ingnome3; then
			rm -f "${D}/$(systemd_get_unitdir)"/gdm@.service
		fi
	fi

	# Files in portage cannot contain a literal '@' character. Therfore,
	# convert the code string "_at" into an '@' before installing.
	rename '_at' '@' "${D}/$(systemd_get_unitdir)"/*
}

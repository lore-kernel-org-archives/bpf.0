Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D7645C704
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863467; cv=none; b=Lwr/ZplBD2nTLybqvLTiLXTbKrhKfteVjOK7p9MBtJcaFv7ckJnPXAs8XIcZC43IEfff/QpDgrqrdalrC8JeqM1f9DP8OV0paIMHTWgAvr6+l5XG13fEQLR/LKvTgxyLxpW+1rGBtQNSmVy1l51jeAimbdT4iqZEWveVoO+Q38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863467; c=relaxed/simple;
	bh=VVy+xnuu1jLBHpINq3c8XPnQpik7A+ZvgUPasM+R92Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=UbhmRyXeFttvjBODMsnuPg8RLu+lneV2z4EcTD1z8CSyx3pE6Bg05QnLqJv+jIPumv8LnGtbFvJYEPJnAeISWDAIlw3OH1I1aANtegfOWU53HhdsHUTJVlPcAnrJLOjlkc7QwYUVRBinyhaTTgDJLdu6MTaKanMxkzmIWbWWLDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X3R/VSXi; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X3R/VSXi"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261001140422epoutp01571f7da82ff18cee9bd456fdc4b0b925~abNSQR3b62225622256epoutp01o
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:04:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261001140422epoutp01571f7da82ff18cee9bd456fdc4b0b925~abNSQR3b62225622256epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790863462;
	bh=VVy+xnuu1jLBHpINq3c8XPnQpik7A+ZvgUPasM+R92Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=X3R/VSXi8Ehh21H73wXXIsMhgW8p2z5FtJaF/Pz3ZIgo9vxxmSEzZAVFoTKP/Jdq1
	 +NXgYJ3BnOWV/XGE2Lv6r4kF+1oplPIbqLmQasj1sUu4MnB9O6hk4Bd8K010c5CwiE
	 PZzfl2WjWT9oX6ru+M3/T4pZdrOXBFUEgpLckzUM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261001140421epcas5p46ac4cfe89f234a54b8e2224df641ecd5~abNRpToK92219622196epcas5p4H;
	Thu,  1 Oct 2026 14:04:21 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hwYYw4dhZz3hhT3; Thu,  1 Oct
	2026 14:04:20 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261001140419epcas5p4883bdc79a0d8620448fd267ff1321f7f~abNQWKrJI2219622196epcas5p4D;
	Thu,  1 Oct 2026 14:04:19 +0000 (GMT)
Received: from SRIB8EG28RUQ1R (unknown [107.108.208.92]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261001140417epsmtip268affc96178f61ceb12ba7d0d9e9719d~abNOVwCsM2065720657epsmtip2J;
	Thu,  1 Oct 2026 14:04:17 +0000 (GMT)
From: "Irlanki Sandeep" <irlanki.s@samsung.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>, <lorenzo@google.com>, <maze@google.com>,
	<sporeba@google.com>, <motomuman@google.com>, <srihari.k@samsung.com>,
	<g.pokhra@samsung.com>, <r.kumawat@samsung.com>, <raj.kumars@samsung.com>,
	<ts413.lee@samsung.com>, <ramyashree.s@samsung.com>,
	<daeil2.hwang@samsung.com>, <netdev@vger.kernel.org>, <cpgs@samsung.com>,
	<irlanki.s@samsung.com>
In-Reply-To: <20261001102200.0BC711F000FF@smtp.kernel.org>
Subject: RE: [PATCH net-next v5] tcp: add TCP_ECN and TCP_ECN_OPTION kfuncs
Date: Thu, 1 Oct 2026 19:34:16 +0530
Message-ID: <00fc01dd51ad$c0c91aa0$425b4fe0$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLjFife5xwdJ2PIbdsgWyeyz0v32wItTLcrAkkv7Fe0uXd2QA==
Content-Language: en-in
X-CMS-MailID: 20261001140419epcas5p4883bdc79a0d8620448fd267ff1321f7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260930102144epcas5p419270301dba37c520277e6c6cff75def
References: <CGME20260930102144epcas5p419270301dba37c520277e6c6cff75def@epcas5p4.samsung.com>
	<20260930102308.197808-1-irlanki.s@samsung.com>
	<20261001102200.0BC711F000FF@smtp.kernel.org>

> =5BSeverity: High=5D
> Could this lead to an out-of-bounds write for non-TCP sockets?
>=20
> When a UDP socket requests hardware timestamping, the transmission skb ge=
ts
> SKBTX_HW_TSTAMP set, which implicitly sets SKBTX_BPF. When the timestamp
> is delivered, __skb_tstamp_tx() triggers bpf_skops_tx_timestamping(),
> invoking the CGROUP_SOCK_OPS BPF program for the UDP socket with
> is_fullsock set to 1.
>=20
> If the BPF program calls this kfunc, it bypasses the =21is_fullsock check=
.
> Since there is no verification that the socket protocol is IPPROTO_TCP, i=
t casts
> the smaller udp_sock to a tcp_sock. Writing to ecn_option would then
> corrupt memory past the end of the udp_sock structure.

Thanks for catching this. Fixed in v6 by adding a sk_is_tcp() check to
both bpf_sock_ops_set_ecn_mode() and bpf_sock_ops_set_accecn_option()
to reject non-TCP sockets.

> =5BSeverity: Medium=5D
> Will this assertion fail due to child sockets inadvertently inheriting th=
e
> listener's ECN overrides?
>=20
> When a passive connection is established, tcp_create_openreq_child() in
> net/ipv4/tcp_minisocks.c clones the listener socket via inet_csk_clone_lo=
ck().
> This copies the entire tcp_sock structure, including the new ecn_mode and
> ecn_option fields.
>=20
> Since these fields are not explicitly reset to TCP_ECN_MODE_UNSPEC during
> the initialization block in tcp_create_openreq_child(), the child socket =
seems
> to retain the listener's mode, breaking the intended design and causing t=
his
> test assertion to fail.

You are right, thanks. The v5 description and selftest wrongly assumed
accepted sockets go through tcp_init_sock(); they are cloned from the
listener via inet_csk_clone_lock() and inherit both fields.

Rather than reset them in tcp_create_openreq_child(), v6 keeps the
inheritance, since that is how every other tcp_sock setting behaves
(keepalive, TCP_NODELAY, tcp_tx_delay, and congestion control). A server-si=
de BPF program
that sets ecn_option on a listener expects the accepted sockets to
follow it without re-applying it on every PASSIVE_ESTABLISHED_CB.

The description, kernel-doc, comments, and selftest assertions are
updated accordingly in v6.

> =5BSeverity: Low=5D
> Does this multi-line comment violate the BPF subsystem style rules? The
> required style places the opening /* on its own line.

Fixed in v6 to conform to BPF comment formatting rules in both
selftest files.

v6 has been submitted here:
https://lore.kernel.org/all/20261001132759.1076145-1-irlanki.s=40samsung.co=
m/

Thanks,
Sandeep


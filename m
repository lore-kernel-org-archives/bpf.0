Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EA543DEC7
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122338; cv=none; b=QExkOQP9AfOdhJWm3EmFWBbnBCJErrwnopvntx2Iyns6ZH1zQuc3zmXtY9OHExmZmPsPIddAfW/Sp/kcV+IGLBXNd8bTV7ZZAioDfv/OJ9tuKKST7t9mHhovL+VBYnjc0G4nhJyhokD8gH8iWKbNbn2dTWjgGuwMFomESZfFk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122338; c=relaxed/simple;
	bh=i+Lc5tkEyufviIM0jGsAEeA07f9PVW0hutsFkGn5rX0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=IXrlaAo6/lT24VFfnogD5qdePrWIypqlnKBjtCivhdeCIOfw7jcAI7Z/zXqfZ1wYlKsfeaBiSzrZ9A3fDo6CirWjj+SyeGAHm8zxP2MDkCSX+DcHIPYPZ6nVs7VyJzgfy7WaHx2XNObBz9OTBp9LOx9QuuON8VQvVIEftbXY6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Jv5pUtTB; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jv5pUtTB"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260911102532epoutp0309aba4306a95384c6257748d1b9bd13a~UPUhXztR-2827628276epoutp03H
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 10:25:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260911102532epoutp0309aba4306a95384c6257748d1b9bd13a~UPUhXztR-2827628276epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789122332;
	bh=uBJvvC5Oh13J66pP9et6GEM9gPXl+p8Dp+kDY83wlok=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Jv5pUtTB/+ZOUngqOdbMcIB/NTjuuoJhl4Pf8Z1aMRxady8tn+GoAcuF6i5C7GG2Q
	 eSZ9Y+zft9InH4sggAlxV8mpbTAmS/STxCGug3bI/6dOGNIlN/UhCvLmmBSRBhVzYk
	 TewQnJ82jIdUH/C63Rr+j/ZxDDF0v8suMH1eg5Ms=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260911102532epcas5p450603ec23bb5577551dd62d446c6ca3f~UPUg6pONH2389723897epcas5p4c;
	Fri, 11 Sep 2026 10:25:32 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4hh9fg4KJgz6B9m6; Fri, 11 Sep
	2026 10:25:31 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260911102530epcas5p4995d3c7ac672cfa2df3521eb98bb9019~UPUflk_jo2629526295epcas5p48;
	Fri, 11 Sep 2026 10:25:30 +0000 (GMT)
Received: from SRIB8EG28RUQ1R (unknown [107.108.208.92]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260911102529epsmtip10ca203d0390a5e8e38efadf32ae9db36~UPUd_5XVS1268312683epsmtip1Y;
	Fri, 11 Sep 2026 10:25:29 +0000 (GMT)
From: "SandeepI" <irlanki.s@samsung.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <lorenzo@google.com>,
	<maze@google.com>, <sporeba@google.com>, <motomuman@google.com>,
	<srihari.k@samsung.com>, <g.pokhra@samsung.com>, <r.kumawat@samsung.com>,
	<irlanki.s@samsung.com>, <raj.kumars@samsung.com>, "'Taeseok Lee'"
	<ts413.lee@samsung.com>
In-Reply-To: <20260910144455.CA7751F00893@smtp.kernel.org>
Subject: RE: [PATCH net-next] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Date: Fri, 11 Sep 2026 15:55:27 +0530
Message-ID: <045c01dd41d7$df167d30$9d437790$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJgSB8NW/KS4Ewc4RaTtrZlfomIvQLHz9DYAS1y+Cm1o29WAA==
Content-Language: en-in
X-CMS-MailID: 20260911102530epcas5p4995d3c7ac672cfa2df3521eb98bb9019
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260909144437epcas5p282be513a761ca5aec3f2b0fefcd2ecfa
References: <CGME20260909144437epcas5p282be513a761ca5aec3f2b0fefcd2ecfa@epcas5p2.samsung.com>
	<20260909144557.800676-1-irlanki.s@samsung.com>
	<20260910144455.CA7751F00893@smtp.kernel.org>

> -----Original Message-----
> From: sashiko-bot=40kernel.org <sashiko-bot=40kernel.org>
> Sent: 10 September 2026 20:15
> To: Irlanki Sandeep <irlanki.s=40samsung.com>
> Cc: bpf=40vger.kernel.org
> Subject: Re: =5BPATCH net-next=5D tcp: add TCP_ECN and TCP_ECN_OPTION soc=
ket
> options
>=20
> Thank you for your contribution=21 Sashiko AI review found 2 potential is=
sue(s) to
> consider:
> - =5BHigh=5D Per-socket TCP_ECN configuration is ignored during SYN flood=
s because
> syncookies validation checks the global sysctl instead of the listener so=
cket's
> effective ECN mode.
> - =5BMedium=5D Missing READ_ONCE() when reading =60ecn_mode=60 and =60ecn=
_option=60
> introduces a data race and double-fetch vulnerability, leaking the UNSPEC
> placeholder (255) into TCP operational logic.
> --
>=20
> commit d87f9153f9de86df8e7de5798f8dffdac8f0e2fd
> Author: Irlanki Sandeep <irlanki.s=40samsung.com>
> Subject: tcp: add TCP_ECN and TCP_ECN_OPTION socket options
>=20
> This patch introduces granular, per-connection dynamic adaptation for ECN=
 and
> AccECN configurations. It adds two new socket options, TCP_ECN and
> TCP_ECN_OPTION, which override the system-wide sysctl settings to prevent
> connection failures or packet loss on paths with anomalous middleboxes.
>=20
> > diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h index
> > 865d5c5a7718d..931e0877176c7 100644
> > --- a/include/net/tcp_ecn.h
> > +++ b/include/net/tcp_ecn.h
> =5B ... =5D
> > =40=40 -30,8 +31,29 =40=40 enum tcp_accecn_option =7B
> >  	TCP_ACCECN_OPTION_MINIMUM =3D 1,
> >  	TCP_ACCECN_OPTION_FULL =3D 2,
> >  	TCP_ACCECN_OPTION_PERSIST =3D 3,
> > +	TCP_ACCECN_OPTION_UNSPEC =3D 255,	/* Use sysctl default (per-
> socket) */
> >  =7D;
> >
> > +/* Resolve the effective ECN mode: per-socket override or sysctl
> > +fallback */ static inline u8 tcp_ecn_mode_eff(const struct sock *sk)
> > +=7B
> > +	u8 mode =3D tcp_sk(sk)->ecn_mode;
> > +
> > +	if (mode =3D=3D TCP_ECN_MODE_UNSPEC)
> > +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> > +	return mode;
> > +=7D
>=20
> =5BSeverity: Medium=5D
> Is it possible for the compiler to double-fetch tcp_sk(sk)->ecn_mode here=
?
>=20
> Since the ecn_mode field is updated concurrently via WRITE_ONCE() (for
> example, during a setsockopt call while handling an incoming SYN packet i=
n
> softirq context), a lack of READ_ONCE() on the reader side could result i=
n the
> UNSPEC placeholder (255) leaking into the return evaluation.
>=20
> If that placeholder leaks, could it cause AccECN to be incorrectly enable=
d later in
> tcp_ecn_create_request(), where 255 >=3D 3 would evaluate to true?
>=20
> > +
> > +/* Resolve the effective AccECN option: per-socket override or sysctl
> > +fallback */ static inline u8 tcp_accecn_option_eff(const struct sock
> > +*sk) =7B
> > +	u8 opt =3D tcp_sk(sk)->ecn_option;
> > +
> > +	if (opt =3D=3D TCP_ACCECN_OPTION_UNSPEC)
> > +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
> > +	return opt;
> > +=7D
>=20
> =5BSeverity: Medium=5D
> Does tcp_sk(sk)->ecn_option also require a READ_ONCE() here to prevent a
> similar data race and double-fetch?
Yes, tcp_sk(sk)->ecn_mode and tcp_sk(sk)->ecn_option are updated
concurrently via WRITE_ONCE() in do_tcp_setsockopt(). Without READ_ONCE(),
a compiler double-fetch could leak the TCP_ECN_MODE_UNSPEC (255) sentinel
value into operational evaluations.

Both accessors (tcp_ecn_mode_eff and tcp_accecn_option_eff) have been updat=
ed
in V3 with READ_ONCE() to eliminate data races and prevent double-fetching.


> =5B ... =5D
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c index
> > 0f60a1dbf9274..b7dea787f8237 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > =40=40 -7463,7 +7463,7 =40=40 static void tcp_ecn_create_request(struct
> request_sock *req,
> >  	u32 ecn_ok_dst;
> >
> >  	if (tcp_accecn_syn_requested(th) &&
> > -	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >=3D 3 =7C=7C
> > +	    (tcp_ecn_mode_eff(listen_sk) >=3D 3 =7C=7C
> >  	     tcp_ca_needs_accecn(listen_sk))) =7B
> >  		inet_rsk(req)->ecn_ok =3D 1;
> >  		tcp_rsk(req)->accecn_ok =3D 1;
>=20
> =5BSeverity: High=5D
> Does the SYN cookies path also need to be updated to respect this new per=
-
> socket configuration?
>=20
> During a SYN flood, this standard tcp_ecn_create_request() path is bypass=
ed in
> favor of syncookies. Currently, cookie_v4_check() and cookie_v6_check()
> determine ECN support by calling cookie_ecn_ok(), which only checks the g=
lobal
> sysctl:
>=20
> static inline bool cookie_ecn_ok(const struct net *net, const struct dst_=
entry
> *dst) =7B
>         return READ_ONCE(net->ipv4.sysctl_tcp_ecn) =7C=7C
>                 dst_feature(dst, RTAX_FEATURE_ECN); =7D
>=20
> If the system has the global sysctl_tcp_ecn disabled but a service has en=
abled it
> locally via TCP_ECN on its listener socket, will established connections =
silently
> lose their ECN capability during a SYN flood?

Agreed. Under SYN flood conditions, cookie_v4_check() and cookie_v6_check()
must honor the listener socket's effective ECN configuration rather than
falling back exclusively to the global sysctl.

Moved cookie_ecn_ok() from include/net/tcp.h to include/net/tcp_ecn.h
to avoid circular header dependencies (since tcp_ecn_mode_eff() is defined
in tcp_ecn.h and tcp.h does not include tcp_ecn.h), and updated it to take
'const struct sock *sk' so it evaluates tcp_ecn_mode_eff(sk).

Both issues have been addressed in the =5BPATCH net-next v3=5D tcp: add TCP=
_ECN and TCP_ECN_OPTION socket options

Thanks,
Sandeep.



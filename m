Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F029419FCC
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747035; cv=fail; b=pq65Qa8GOn2ffapjl7nfZPkqHx+pCf31Nt2PQqFRFJI3PzFyD0YjOJklPH4N38t9eFgMjpSOL0eVEP8FvwoRhGq2WtAUFLm3TYcSl3SbcEFhnvzpaGG0jPJIaq/5fFsSg242o3fZrLzwHld0kjnHIYF+0jGFWYdwovmy2Ybo0QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747035; c=relaxed/simple;
	bh=2oZAFbc5Q5QCyiShnYJ0cse5su7b9Hzr256mnRoIK5c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uTGHG4P16U0NUBaMD3NbaoXNO8dkd5JQSlvgDapzfk/BABAvMg+sDppnr+W8o3H4SuhwgW16qL3tmtzX6m7pC9QezHe2Nz7gKWJ/8hIxzyIA1dK+poPw/C621j1SP2RMdVOF1MyS6UAeQSkKtiwfUm1gqXH+VXk8W/qh0WxoPXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O0hsePTu; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O0hsePTu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAYkZUmvOVFJxAhg4INu3QfPISvWrzSkCg+mbVccyS5lkoC+yb2tAod4+GrpBobxx//M5po5bpzZjghKfPDPKQSODY2HrUDqV6bqwKRY/OKsj1p7spyij6I7Z7GEzwoe7EVUHSarh+E5ACgJ4f+lJkYr9GaDELoZIr8Wo6Riwd0d0ToGCDb2FMZIqO60Ip9O798qUVDFaNzopH1+lftlBBkoROUP/ScG6vgNKEuUt4dW38abIRQStyyXgPb+fmDSjZIQDOGbAKME64rUVRoMcoGGiZMqUFBSX7fKbrhiRFjcy5McDVKZa9S/awdc2uPbESHWNo3Nd9tKI23ziUNH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yY9HVYqzaiX2M9j9R75QUO8p8x21+de33IHEPQ4w4fY=;
 b=l7sWoRMKgfEsCOpqsMdQ9xa9ub8bGRGcU/sE9/qUPjJq/3VGqK/R/UM54ES/i52UXHuX6HRt4FJh+crLD6xqT0WIKBzERqrcYttIbuj5qSzp6m2076jiXfFl2/st5XIM35uhtD1IsStqFO4ivO0Twam5sJFBhsqdnV/QetIcBfiLyx4OZdtLiQz/GsrMqY+1GyEXbnsYkqSpVbx8RrCOZKAGSsuXiNtt1XZfuix23RtczEQitITX8qU8H50z1KDdUJN2AEMf7iq8JObtcLK4IJx7N1uExkBrIThK7y4F/deN0vHbdcrDdj+eW3jMCHhNboyO5tjMh+30UWWuhtdBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yY9HVYqzaiX2M9j9R75QUO8p8x21+de33IHEPQ4w4fY=;
 b=O0hsePTu+YVO/AsECsP9DqFS4VVLTSyZp/kiC8ptQ0zzHrOcoFQ8Q4KXAWHkFBMdvhC+sTtiUAvHTJ+Y5P1cWWJ088Iu/xpHM0GgcAixmhm2RlC7yGW1EHIhoFfW8dQqX0VnmKo1bJ9YBBdEo20j0O1OYq8EFJ/9RgEEpVK6VdXf3+5Jrq9R0DaaP5baq87AjsWsZbzLcaYs/elWJ4BRtb3+Avg0UagXtaCb6wZZG9do4wC6eJngBxGDN3HPrS6r8K60UakEW62y9bGyYAcpOeBIuTf9mkpyXypvbkYdivJwZf9+WqOA10kqodGTfdObOzHd+1H2cY5SfGJcXAsCAQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB9828.eurprd07.prod.outlook.com (2603:10a6:800:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 12:23:47 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%2]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 12:23:47 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() available to
 BPF congestion controls
Thread-Topic: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() available
 to BPF congestion controls
Thread-Index: AQHdM+YQ+9QzSC/v9EW868Iw8eUgQbau9qyAgAE+TTA=
Date: Wed, 26 Aug 2026 12:23:47 +0000
Message-ID:
 <PAXPR07MB79849AAFDBAF75DE9011DAC9A3AE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
 <20260824163139.990734-3-chia-yu.chang@nokia-bell-labs.com>
 <20260825163153.D128E1F000E9@smtp.kernel.org>
In-Reply-To: <20260825163153.D128E1F000E9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB9828:EE_
x-ms-office365-filtering-correlation-id: 034d037f-b6ff-4cab-a25e-08df036ce0dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|4143699003|56012099006|6133799003|11063799006|18002099003|3023799007|22082099003|38070700021;
x-microsoft-antispam-message-info:
 FGOkogEGgY+gT+cc6vO3TC1wl/Xig/FyosM87a6uWCr7Wgp+RWOY60I5CPtdD7yPuYNViPMvJjeVvxLZPstn/ZioOSrNQo5JWloF4H1Je4Q2TmWJQFakI2cNq18zIOIoYltMpB06j4D4gIqUpH2iw5R0rINXLDgfSMhtHrdy8t0H6UeqC0mK2wskYAcvUeFlrmAVP4LaXDWMwspjNQlhrWdc08ehodW81YGpdW62uTxbiKgd42AWlwbVr0dRNdNwLwgfZSF+LWiM7MpI6BAK+TOQ+EiMC6xu/tfJmmFDdgv671RghVQfcNjsBce9O8oSx77vI+hlVmO9GFrOoSWpI0YZXkkvRBskRFHeTOtEMPw1zRGjiOe9NUv3n6yjEcgnRNTF2zx3AcI1DZT7ixvDivNIbrqCCtmkGiIqFSCRPkgrYN7R0TeZLcg5EYAxSpnUPuChPk/dV5Z8iKURi6faULFXPp5MSZJ9UiAl1e2Zqm/TGdj2aeVMzLSxc9vN4u2gYXIS8hgewq5RxIpnadUk4WfkrnsL148nyz/1aYjaJRal8rsTz7kYJEdwKPMvJRSbUnq/Sb+/+ymgywUpcUwFs0iwo6vXPvqO4E92ixFXn4iIBhyU9yxQgezp7OOOCVRf8iQAoNOHIectmILevEcjrbaqWzWbTVbOFsSoPv5hjRkOW8hOX+tod27plyxp6IiGRL0fOL/1JFKl/IBARnHyrNWn8qmZpBwN/EV/kgttOzY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(6133799003)(11063799006)(18002099003)(3023799007)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WX5XaqtijjuXLVMstowWcmD5y2Y6WCLNkKuUn7hN4dQdLwvV3mPdcfzgf/8E?=
 =?us-ascii?Q?FCbmTYOWriTMYhXC8rxzKT16B0I/dxmPa7pkuiCrY4ych9WJdAEgyZPTTUen?=
 =?us-ascii?Q?GdCx3siqGzM5yWKEKPXJ+6b9VSt0D58kIc73ujImslQzQ8K1PK0qQc2ZyPen?=
 =?us-ascii?Q?mA9TW8KFvULBGq7+uWy0sJk5hN6IcvTnGMyf+P+/L5P4mZIXZccUPEkFnLW1?=
 =?us-ascii?Q?4BE415mrKr2nsUl6lsWPGlaC4G8jsUwzXmbFBUVlHtV+V7fycHIzvnMJtdcc?=
 =?us-ascii?Q?rEtIMCmnrRESa02SFezXDHLX/FLPUeveWfVqsB9dwDG1G5GFqmFdO+sT0FwW?=
 =?us-ascii?Q?qpOvoJdkE7Ynac4kn3wokAKu+qDIwuAdVmjxImTeFOHBQi8T+huuzIK5QmR6?=
 =?us-ascii?Q?jdPzocbn9fjt+OCxhOzr5TjUAdRLY3ZyPz/5Xez4QD/QUPrLL5fXQ5B2zTUL?=
 =?us-ascii?Q?Hq6aiEcWOMUJBd0zyiF70MJKF18mw5HYTS8a0MfrIUAi2KZqed06UIP+G4K6?=
 =?us-ascii?Q?0iUhOCgKvK4C26wzlFY2w6To8Bj/M74jAG2/XFTtjElG1Cvb/xIMF4AWj/Wv?=
 =?us-ascii?Q?vhm/OjZxJ+FtTMV6Iogb3/86Nj1xyI/OJGbZzoJVYAeGjiVptJf1cNW7TX9/?=
 =?us-ascii?Q?Ko16W9dBdRZUgcy5sHxyHmmYSh90BtsS8EZqGjB59MGmAKy97JWTa78KTc4q?=
 =?us-ascii?Q?mGM3BTEuIXL6IM5C/kadqzA+hpKk/2zxMt86TXRpbCCXDRhX5cXezZK+0HHJ?=
 =?us-ascii?Q?B59YOISHAiofnJp00dA/E+Rwo+N5RudQ3PefyvQBug1Vs8go0eeE7zsTrEUq?=
 =?us-ascii?Q?jTeScvdY5oNjAnz5oYjUW3hOFAwJc81wFGmtmUC39pKm49rbaFvSs42EYHnW?=
 =?us-ascii?Q?TAmZ7PrqvAiwLFfPQlR+SRIKVK6LprzFtQmEwo5aFsg5mqumpuU2xBIjvoFk?=
 =?us-ascii?Q?djzuMyfGQ8ocZDN7nexZfFlFzvMwPjYkuUZkEqwUmR4CmmCY+V6le6vcmkZM?=
 =?us-ascii?Q?1BtlMsh2rSxMWPttvZl65osslDbHGqmGCF9K8OlSps2k5cZzZw8FYLblfoY8?=
 =?us-ascii?Q?rnz0Wp3uZHYHSbFB8Uu+owRVFME82UHHdggV1xh05yp46XwioFfNDlOsQ3EP?=
 =?us-ascii?Q?XhiNhcmSg5KLtMyZIFfwcn5u5aWIq3rD44cNmKG/EIL6WHAir5gsEPFvNRVX?=
 =?us-ascii?Q?xBC46wFQYbFASisK/74eUrBPqycLpzL2gS05OBErwbpJ1oqLPDx7aZLVLh50?=
 =?us-ascii?Q?IdU17EZivMqH1LpgrVHQrEbm+dpm73KJMDcIJt+clxhgL80ZM7WervoZxLzi?=
 =?us-ascii?Q?e8yrDYWUamWoGVxnHLLoWLDLreporxs9FjzO9z2XXoAZVOlspqjwrQhkvK0M?=
 =?us-ascii?Q?Cj2VaXkgY29pkFzquplZY1gA+Hu3ZNK2zbdtrIn5GS36JpbOBo1zDZhtFenh?=
 =?us-ascii?Q?8aNfAoNJfQcxLbEGALyYvoAuyFEYgNj4oVwkc2iFLlLhY+6ZEke+GngmW9BZ?=
 =?us-ascii?Q?divPpZ6IYyKr2o5hLWjpoby7kL6/C6wbn6NMv6Ng9hwsfMoRSjSK6Lxavivo?=
 =?us-ascii?Q?l36CxaTBTjbGQpyadWsl5VwZdNOV+SFAFMOLXnLGoW/R63AQDeoOzZ/7uLuQ?=
 =?us-ascii?Q?sVd5QcrnYYKyLoYpDFZ4rtVGKuI1UgVd7HaVUfwj6XZfujjbkly3iq6d/UQM?=
 =?us-ascii?Q?aLMmYF3JkSHlGrZSHLPK0ay38NJj91QsuLFfO9Kd1FBiDl93J8VD6GF6CGS/?=
 =?us-ascii?Q?WyVPrzagswuA8s7yEs+n68sV0ulMn7A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 034d037f-b6ff-4cab-a25e-08df036ce0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 12:23:47.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKJ6WDtUilZ62hXyg/XkJryMriV3e+tz5TjIzkSvwYEPOuwWRZYRz/KZimr6+4k6nkLyCzvkWGhDtlYDod+zj72SjR972Dqg9/dtDjIhwiFKEYswPpLulFrQe3NHGgpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9828

-----Original Message-----
From: sashiko-bot@kernel.org <sashiko-bot@kernel.org>=20
Sent: Tuesday, August 25, 2026 6:32 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() available=
 to BPF congestion controls


CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Type confusion in `tcp_tso_autosize` leading to out-of-bounds re=
ad when called with a non-TCP socket from BPF.
> --
>=20
> --- Patch [2]: [PATCH v8 net-next 2/2] bpf: make tcp_tso_autosize() avail=
able to BPF congestion controls --- commit 6f535d3aed5d0c1f1117963d858318f7=
f63354f5
> Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> bpf: make tcp_tso_autosize() available to BPF congestion controls
>=20
> Expose tcp_tso_autosize() as a BPF kfunc and register it in the TCP conge=
stion-control kfunc set. This allows BPF congestion controls to reuse the k=
ernel TSO autosizing logic while applying their own minimum TSO segment pol=
icy.
>=20
> > diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c index=20
> > ed4fea98dfde1..9deed2244c2de 100644
> > --- a/net/ipv4/bpf_tcp_ca.c
> > +++ b/net/ipv4/bpf_tcp_ca.c
>=20
> [ ... ]
>=20
> > @@ -194,6 +194,7 @@ BTF_ID_FLAGS(func, tcp_reno_cong_avoid) =20
> > BTF_ID_FLAGS(func, tcp_reno_undo_cwnd)  BTF_ID_FLAGS(func,=20
> > tcp_slow_start)  BTF_ID_FLAGS(func, tcp_cong_avoid_ai)
> > +BTF_ID_FLAGS(func, tcp_tso_autosize)
> >  BTF_KFUNCS_END(bpf_tcp_ca_check_kfunc_ids)
> >
> >  static const struct btf_kfunc_id_set bpf_tcp_ca_kfunc_set =3D {
>=20
> [Severity: High]
> Does this allow non-TCP struct_ops programs to call tcp_tso_autosize()?
>=20
> Because bpf_tcp_ca_kfunc_set lacks a .filter callback, it appears this kf=
unc becomes callable by any BPF program that can access a generic struct so=
ck, such as a bpf_qdisc program.
>=20
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c index=20
> > 7d3e0e715c4bf..a98036bcd987e 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
>=20
> [ ... ]
>=20
> > @@ -2252,13 +2252,21 @@ static bool tcp_nagle_check(bool partial, const=
 struct tcp_sock *tp,
> >   * in bigger TSO bursts. We we cut the RTT-based allowance in half
> >   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allow=
ance
> >   * is below 1500 bytes after 6 * ~500 usec =3D 3ms.
> > + *
> > + * The min_tso_segs is floored to 1 to avoid surprising conversion.=20
> > + Also,
> > + * BPF callers may pass mss_now =3D=3D 0. In that case the function=20
> > + returns the
> > + * sanitized min_tso_segs value and skips autosizing.
> >   */
> > -u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> > -                  int min_tso_segs)
> > +__bpf_kfunc u32 tcp_tso_autosize(const struct sock *sk, unsigned int m=
ss_now,
> > +                              int min_tso_segs)
> >  {
> > +     u32 min_tso =3D max(min_tso_segs, 1);
> >       unsigned long bytes;
> >       u32 r;
> >
> > +     if (unlikely(!mss_now))
> > +             return min_tso;
> > +
> >       bytes =3D READ_ONCE(sk->sk_pacing_rate) >>=20
> > READ_ONCE(sk->sk_pacing_shift);
> >
> >       r =3D tcp_min_rtt(tcp_sk(sk)) >>=20
> > READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);
>=20
> [Severity: High]
> If a non-TCP BPF program passes a generic struct sock to this kfunc, can =
this lead to an out-of-bounds read?
>=20
> The tcp_sk() macro casts the generic struct sock to a struct tcp_sock wit=
hout validating the socket type. If a smaller socket structure (like struct=
 udp_sock) is passed, accessing tp->rtt_min in tcp_min_rtt() could read pas=
t the end of the allocated socket structure.

Hi,

tcp_tso_autosize() is added to the same kfunc set as the existing TCP conge=
stion-control kfuncs (tcp_reno_ssthresh(), tcp_reno_cong_avoid(), etc.), al=
l of which already accept a struct sock* and use tcp_sk() without additiona=
l validation.
=20
If access to this kfunc set were possible from a non-TCP context, the same =
concern would already apply to the existing kfuncs.
In this case, this shall be the framework issue and an extra .filter shall =
be added into bpf_tcp_congestion_ops in other patch series

Thanks.
Chia-Yu


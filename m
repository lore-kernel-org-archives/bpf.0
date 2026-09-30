Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD04D0CC4
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770725; cv=none; b=HFOTGq+HfYOS0KrLSU9Sx8rW7wq29hV6totbyd35e87AWdc5/awbQlDhpDZ8iifMqrEzr3rxUSWC3hFwjTsHZ7I8BFHOXvGBEUjJcJBz0ADxFIl/KviD7YnUQYLZgSBCjVsboVtTuhvk0rjnwRq63sSyyZm26eLzbcHmFd0Aoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770725; c=relaxed/simple;
	bh=bSEktm9jrxFnvovCxVG8QToeJjkRVOM4SyexKupCay0=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=DiVuNxCl72U40/NclagxPT7g9ZOqU5D3xDZ8+TUuNP4tWujBMcKPixh1uH7nK/0/ecvOLJ/GDFirhswe2q42l8WymG6PXJCd6Hz6ARHTnBd8zziNxTMdbekZAS0sIWa3DyDKRCikRu0bfvZ/HVJzXy8R/GsRnrSo301GK7h2OIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WRq3mKw3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WRq3mKw3"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260930121839epoutp0396dc0e4b266e046c281d76134a55dae9~aGHtHDqnd2719227192epoutp03Z
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260930121839epoutp0396dc0e4b266e046c281d76134a55dae9~aGHtHDqnd2719227192epoutp03Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790770719;
	bh=pUP5VujhcG2YSUsnNskbW51OmDiU/TOQKq6NE0AKOTs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=WRq3mKw33bPWZMwayh25XLkcS34PXYGIisX6ql7NW6HzSmUGiN5flmozxm38NrxZb
	 n9/d1ySKdVGFNphwJa9c0kro+oMOhhCn1nZjGOeuWy5pxrax+uPzlvuS7NUwOd0JW5
	 efbazk/e2WOH/LCgDgRrX/XB8H2h36RLLWXCfivI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260930121838epcas5p282173e5c9e5baf54a9943d92bbc43abd~aGHsUkvob1539215392epcas5p26;
	Wed, 30 Sep 2026 12:18:38 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hvvGP6phGz6B9m4; Wed, 30 Sep
	2026 12:18:37 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260930121837epcas5p1e327cedf1172cb31e1f216806540d994~aGHqwpRZU2078520785epcas5p1O;
	Wed, 30 Sep 2026 12:18:37 +0000 (GMT)
Received: from SRIB8EG28RUQ1R (unknown [107.108.208.92]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260930121833epsmtip1a1ffe8e45fe58bfde6d8584a5b045a8b~aGHnrx-Lu1608216082epsmtip1I;
	Wed, 30 Sep 2026 12:18:33 +0000 (GMT)
From: "Irlanki Sandeep" <irlanki.s@samsung.com>
To: "'Eric Dumazet'" <edumazet@google.com>, "'Jakub Kicinski'"
	<kuba@kernel.org>
Cc: <ncardwell@google.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <corbet@lwn.net>,
	<linux-kernel@vger.kernel.org>, <lorenzo@google.com>, <maze@google.com>,
	<sporeba@google.com>, <motomuman@google.com>, <srihari.k@samsung.com>,
	<g.pokhra@samsung.com>, <r.kumawat@samsung.com>, <raj.kumars@samsung.com>,
	<ts413.lee@samsung.com>, <ramyashree.s@samsung.com>,
	<daeil2.hwang@samsung.com>, <cpgs@samsung.com>, <irlanki.s@samsung.com>
In-Reply-To: <CANn89iJgAXaoepX1uvUbYhnutjvOPknPFheThf-gRWV-PbZZxw@mail.gmail.com>
Subject: RE: [PATCH net-next v4] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Date: Wed, 30 Sep 2026 17:48:32 +0530
Message-ID: <000001dd50d5$d1c1fb70$7545f250$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJPEydXpeq+l5NzzjE296FzF95UZwKOft8YAodpJUkCC+fQo7XKWfjw
Content-Language: en-in
X-CMS-MailID: 20260930121837epcas5p1e327cedf1172cb31e1f216806540d994
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260916050144epcas5p3f7d6a44556baabd24027af8f4bce7893
References: <CGME20260916050144epcas5p3f7d6a44556baabd24027af8f4bce7893@epcas5p3.samsung.com>
	<20260916050255.1379192-1-irlanki.s@samsung.com>
	<20260921152604.2df7daaf@kernel.org>
	<CANn89iJgAXaoepX1uvUbYhnutjvOPknPFheThf-gRWV-PbZZxw@mail.gmail.com>

> On Mon, 21 Sep 2026 15:26:04 -0700, Jakub Kicinski <kuba=40kernel.org> wr=
ote:
> > My gut reaction is that we shouldn't be adding a setsockopt here.
> > This is a routing property, really, IIUC you're adding the setsockopt
> > because you want to use BPF, in which case isn't it better to add
> > a kfunc for this? Why go thru all the sockopt plumbing?
> >
> > TCP maintainers, WDYT?

Hi Jakub,

Agreed. Moving to BPF kfuncs avoids UAPI clutter while giving us the exact =
per-connection granularity we need.

I adopted your suggestion and transitioned the implementation to two kfuncs=
:
- bpf_sock_ops_set_ecn_mode()
- bpf_sock_ops_set_accecn_option()

v5 with the kfuncs and selftests has been submitted:
https://lore.kernel.org/all/20260930102308.197808-1-irlanki.s=40samsung.com=
/

> On Tue, 22 Sep 2026 02:48:10 +0200, Eric Dumazet <edumazet=40google.com> =
wrote:
> Speaking for myself, I also cannot see why we need to support so much
> flexibility.

Hi Eric,

Regarding the need for this flexibility:

In our testing on real-world networks across multiple interfaces (cellular,=
 Wi-Fi):
1. Certain legacy middleboxes blackhole ECN flags or drop data packets carr=
ying AccECN option headers. A global sysctl is all-or-nothing: disabling it=
 loses L4S benefits on compliant paths, while enabling it globally causes c=
onnection failures on broken paths.
2. Under heavy CE markings, we observed throughput drops when comparing Pra=
gue (out-of-tree) against Cubic/BIC. We need the ability to selectively ena=
ble AccECN for latency-sensitive applications while avoiding it for bulk th=
roughput-oriented traffic on paths showing throughput regressions.

This patch gives us this per-connection control dynamically without changin=
g global sysctls.

> BTW:
>=20
> I have on my plate a complete walk through of recent fields additions
> in tcp_sock, mostly from the AccECN support.
>=20
> ecn_mode and ecn_options have nothing to do in tcp_sock_write_tx group
> in any case.
> This patch  would hurt performance.

Thanks for pointing this out.

In v5, ecn_mode and ecn_option have been moved out of tcp_sock_write_tx and=
 placed into the cold section of struct tcp_sock (immediately after accecn_=
fail_mode, outside hot fastpath cachelines). We have also updated Documenta=
tion/networking/net_cachelines/tcp_sock.rst accordingly.

Please review v5 when you get a chance.

Thanks,
Sandeep


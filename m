Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790876;
	b=eAKsVYmIM39erFu9NT1Nx3rlDiJTd5ukCJeqspeyi2C6Mt5rOA5IM11x+aVIg3GJs0G4
	 NE/crU4hF3Ng800+2zcLkjB7TO/KYuVkSNhaxrdtVA5yQkTL+769J3aXc/Lebg4aYx6yA
	 seOQG2aSYIAWOweM8J6Tn5d+QArbItJk2c5Hy9j4icU3JxM/E6yFMlt1wsGfAw69dczuJ
	 DicOFoSsVEQGoqA8T7G1dFECly6Q96oYVxnGfS+5OYUviaoyISRZx4xZeqjxm8mKPv+uI
	 /7i9CFZcmpJhQYf1KMLs7xoQcg2FZwyvbOvCz/FQiRQuXS7tjPPHyDUeR2PeOEdm5+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790876;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:From:To:Cc:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:X-Mailer:Thread-Index:
	 Content-Language:X-CMS-MailID:X-Msg-Generator:Content-Type:CMS-TYPE:
	 X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=LigbDYHgFUyhETTkgekQg93P9iKK9kMEZK/QoESy0XE=;
	b=vpH+79mhLd52XdyXoXJLsd3+yw72JGOhG9Oaio5YYobkyyll93OMHZ0MwmCp8J1gxcx3
	 80Wkkt131YtAeLx10pOnDaQ8KgjqBu/hkH185IU61L7mdSH6qC5b0be0cCr0YmZB8V8uZ
	 EcntrBf5nSZslyWdzdLPdomZIRfJrZv4w89OQ/U4xRBgsPN2BD9QWabxbAwbbj5Igt2iy
	 f0b6GNe1CulDTlyLtwUjEUKhBJthpri30whFFdZh1VGNO7jm7PQjnznGEjuXf/3NOB9uT
	 sHvIATsma7SHb5mhk2/Kibf1OzBB8h0VWiyIlQywQHa4k/bWIiFd14UnuBnXYb9jdCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=sIbjzqZ6;
	arc=none smtp.remote-ip=203.254.224.25
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B593606A337
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 14:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B593606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=sIbjzqZ6
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261127144750epoutp029f25936c217d689f51bdd049738c3673~r7khK49Gp0300803008epoutp02Q
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 14:47:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261127144750epoutp029f25936c217d689f51bdd049738c3673~r7khK49Gp0300803008epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795790870;
	bh=LigbDYHgFUyhETTkgekQg93P9iKK9kMEZK/QoESy0XE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=sIbjzqZ641dRkba/PO0L2PZ/V2F+oqYTeIritnuJjc/vA9WhmIQjSJp3l60NRP5tQ
	 lv3vpu2MBtWR9tyz+7YyytgzzNwodVWAiZOGwirlprkZoWqyaARQqcFclSbHW5wU/Q
	 OPq/FJ/cvYwDi/yJfwmvMz+Ea3e8MG+YVt4KenJQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261127144749epcas5p49e7591462797aaed3ad3aebe6d3ce918~r7kfprcBC2671426714epcas5p4v;
	Fri, 27 Nov 2026 14:47:49 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jbbqm2VM4z6B9m5; Fri, 27 Nov
	2026 14:47:48 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261127144747epcas5p3ea5291d4421b9dd1c7b5bd9f689d7639~r7kd9qO0n2159821598epcas5p3p;
	Fri, 27 Nov 2026 14:47:47 +0000 (GMT)
Received: from SRIBCU13LG9P71 (unknown [107.108.208.92]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261127144743epsmtip11a938de5238cc75244ef9229b378d8a2~r7kaaIVkO2293022930epsmtip1S;
	Fri, 27 Nov 2026 14:47:43 +0000 (GMT)
From: "Irlanki Sandeep" <irlanki.s@samsung.com>
To: "'Kuniyuki Iwashima'" <kuniyu@google.com>, <ameryhung@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <kuba@kernel.org>,
	<cpgs@samsung.com>, <edumazet@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <ncardwell@google.com>, <ast@kernel.org>,
	<alexei.starovoitov@gmail.com>, <ameryhung@gmail.com>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <corbet@lwn.net>,
	<linux-kernel@vger.kernel.org>, <lorenzo@google.com>, <maze@google.com>,
	<sporeba@google.com>, <motomuman@google.com>, <madhan.raj@samsung.com>,
	<srihari.k@samsung.com>, <g.pokhra@samsung.com>, <r.kumawat@samsung.com>,
	<raj.kumars@samsung.com>, <ts413.lee@samsung.com>,
	<ramyashree.s@samsung.com>, <daeil2.hwang@samsung.com>,
	<sharmasagarika@google.com>, <irlanki.s@samsung.com>
In-Reply-To: <av8pip2n63ZBofcE@google.com>
Subject: RE: [PATCH bpf-next v9] bpf: tcp: add ecn_init callback to
 bpf_tcp_ops for per-connection ECN
Date: Fri, 27 Nov 2026 20:17:42 +0530
Message-ID: <000001dd7e7e$448c3000$cda49000$@samsung.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLz+NqzmYpujPtDh8x08WfmcH857AK2nUVDAsdHS6ECyy+hMbTSuHvQ
Content-Language: en-in
X-CMS-MailID: 20261127144747epcas5p3ea5291d4421b9dd1c7b5bd9f689d7639
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261116151200epcas5p4218c26338b3e9580a9e232be400aecc5
References: <DM6GLQVDXGWL.1ZV7PCL5B2B0K@gmail.com>
	<CGME20261116151200epcas5p4218c26338b3e9580a9e232be400aecc5@epcas5p4.samsung.com>
	<20261116151331.500313-1-irlanki.s@samsung.com>
	<av8pip2n63ZBofcE@google.com>

Hi Kuniyuki,

Thanks for the review. v10 is posted as 0/2, 1/2 and 2/2.

> Why can't ip-rule (or VRF) be used with a per-route attribute ?

Routes and rules select traffic by destination, interface, mark, uid
range, protocol and port, not by cgroup or application. A uid or mark
rule can separate apps, but the existing per-route ECN bit
(RTAX_FEATURE_ECN) only force-enables classic ECN, so selecting AccECN
would need a new route feature. VRF separates traffic by routing table
and interface, not by application on the same route.

> Also, a route attribute would work with syncookie.

Correct. Syncookie connections do not run the callback, so with this
series they use the sysctl; the route bit still applies via
cookie_ecn_ok(). ip-sysctl.rst documents this. An automated review of
v10 pointed out that the commit message is wrong about syncookies. It
says no request_sock is created, but a request_sock is allocated; it just
has no listener, so sk_to_full_sk() returns NULL and the program is
skipped. v11 will fix the commit message and add a comment at the call
site. I consider the fallback acceptable, since syncookies only come into
play under load. If you think the per-connection policy should also cover
the syncookie path, I'm happy to discuss options.

> This is simple, but one concern would be that we end up adding more
> single-purpose stateless callbacks during 3WHS, which could be more
> expensive than stateful solution.
>
> For stateful use case w/ per-socket field, rwnd_init() + kfunc would
> suffice (and we have such a use case).

The cost concern is valid. The callback runs at most once per side per
handshake, and since v10 on the passive side only for SYNs that request
ECN.

For the stateful alternative, rwnd_init() + kfunc works on the active
side, because rwnd_init() runs in tcp_connect_init() before
tcp_ecn_send_syn(). On the passive side it does not, because
tcp_ecn_create_request() decides the ECN bits before rwnd_init() runs,
so a field set there would not affect that SYN-ACK. If your per-socket
use case is active-side only, rwnd_init() + kfunc is viable for it, and
we can discuss it as a follow-up.

> nit: reverse xmas tree order

> Please avoid calling it if not needed,
> !tcp_accecn_syn_requested && !th_ecn
>
> also nit: reverse xmas tree

Done in v10. The declarations in tcp_ecn_send_syn() and
tcp_ecn_create_request() are reordered. tcp_ecn_create_request() now
returns before calling tcp_ecn_init_bpf() unless the SYN requests AccECN
or carries ECE+CWR.

> Please split selftest into a separate patch.

Done in v10. The selftests are in their own patch (2/2).

Thanks,
Sandeep


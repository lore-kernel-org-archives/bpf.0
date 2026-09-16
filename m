Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC73C8C68
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535871; cv=none; b=rWBu1TQxzgueR2fdSaaZxwHvuK3Mszxh2hDAkmkih0meU5zI17273yJiLdlJWtirMRkS/DY5gZpK2wmk732lzv+KTIyvgodCWIkc6M6HNHhiPpKCenO+1V9RY61TnuTxNCtd3toVwBj/Pj/N6ICW0xrggqI7Yo/jwGuM3MIAGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535871; c=relaxed/simple;
	bh=csuFMHNoSfXJUiEKRnyDG776nZLFpC8JOlXrzTUfBh8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=AURuaKdTy6dubN04z90IHUhCUDdiOsxSpfUxZhqi76QgXQlf/p+mm5GW2rzJE4UXGMcShcjnhEiTN9ahBNDxQtEQigHH1ghNUEHOQFHQsu4v7Rm7/0SUW1hAOjvlddKfLUnjRK8iOROEGxcHjitl4uZeYRglprSJ3i5iuagwiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jHblaReI; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jHblaReI"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260916051743epoutp02850bda16a842c8a05c8bb87ffd8ac90a~VtWMDsFA20115001150epoutp02q
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:17:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260916051743epoutp02850bda16a842c8a05c8bb87ffd8ac90a~VtWMDsFA20115001150epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789535863;
	bh=gKhZKzIlrc1a14bnjDxz+HDub4sbghbE452clME9/Og=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=jHblaReIb6KFmt2rUgPAuvo/nhlZaxyHzH7NvaRfdi2PvdIaJ1AkRwFwH/dAZJdJG
	 Sx0d6Q/MJAL5S2PBvK84MS+jnhmlPIUSwO77Az5RpL2Cbht0nzCyzjkmwhG9QN5cF8
	 A7AWIFFLvTAPyOuvo+4lNhh1x7lp0qSDO5afDkyE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260916051743epcas5p43ba39ba30628791762e72cdcbb3da84e~VtWLX9s860537105371epcas5p4i;
	Wed, 16 Sep 2026 05:17:43 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hl6bB2FhSz6B9mK; Wed, 16 Sep
	2026 05:17:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260916051741epcas5p4bfb1ebbc28556f987d535a280b2c8c83~VtWKO5PKF1868918689epcas5p4z;
	Wed, 16 Sep 2026 05:17:41 +0000 (GMT)
Received: from SRIB8EG28RUQ1R (unknown [107.108.208.92]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260916051738epsmtip295f8f4f370b9bbd7a2150a95daed677f~VtWHYrnh-0788707887epsmtip27;
	Wed, 16 Sep 2026 05:17:38 +0000 (GMT)
From: "SandeepI" <irlanki.s@samsung.com>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <ncardwell@google.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<corbet@lwn.net>, <linux-kernel@vger.kernel.org>, <lorenzo@google.com>,
	<maze@google.com>, <sporeba@google.com>, <motomuman@google.com>,
	<srihari.k@samsung.com>, <g.pokhra@samsung.com>, <r.kumawat@samsung.com>,
	<raj.kumars@samsung.com>, <ts413.lee@samsung.com>, "'Daeil	Hwang'"
	<daeil2.hwang@samsung.com>, <ramyashree.s@samsung.com>
In-Reply-To: <20260915165805.359302fe@kernel.org>
Subject: RE: [PATCH net-next v3] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Date: Wed, 16 Sep 2026 10:47:37 +0530
Message-ID: <09fd01dd459a$b2b5ec50$1821c4f0$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF4AsWRY+oGaIDuY7VKoCgi8Z06jgGdcOe2AS3TtgG3hNQBAA==
Content-Language: en-in
X-CMS-MailID: 20260916051741epcas5p4bfb1ebbc28556f987d535a280b2c8c83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056
References: <CGME20260911091026epcas5p35873551b66ec0a50e20ada6e26d2b056@epcas5p3.samsung.com>
	<20260911091148.456834-1-irlanki.s@samsung.com>
	<20260915165805.359302fe@kernel.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 16 September 2026 05:28
> To: Irlanki Sandeep <irlanki.s@samsung.com>
> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; davem@davemloft.net;
> edumazet@google.com; pabeni@redhat.com; ncardwell@google.com;
> ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org; corbet@lwn.net;
> linux-kernel@vger.kernel.org; lorenzo@google.com; maze@google.com;
> sporeba@google.com; motomuman@google.com; srihari.k@samsung.com;
> g.pokhra@samsung.com; r.kumawat@samsung.com;
> raj.kumars@samsung.com; ts413.lee@samsung.com
> Subject: Re: [PATCH net-next v3] tcp: add TCP_ECN and TCP_ECN_OPTION
> socket options
> 
> On Fri, 11 Sep 2026 14:41:48 +0530 Irlanki Sandeep wrote:
> > Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
> > kernel are controlled globally via the net.ipv4.tcp_ecn and
> > net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks
> > the granularity required for modern multi-application runtimes.
> 
> CI (bpf-ci) reports a failure to build tools/testing/selftests/bpf on all
tested
> toolchains/architectures (x86-64 gcc-15, x86-64 llvm-21, s390x gcc-15,
aarch64
> gcc-15) after this series. The build breaks in
> progs/setget_sockopt.c:
> 
>     progs/setget_sockopt.c:67:11: error: use of undeclared identifier
> 'TCP_ECN'
>             { .opt = TCP_ECN, .new = 3, .expected = 3, .restore = 255, },
>     progs/setget_sockopt.c:68:11: error: use of undeclared identifier
> 'TCP_ECN_OPTION'
>             { .opt = TCP_ECN_OPTION, .new = 2, .expected = 2, .restore =
255, },

Thanks for the report.

TCP_ECN and TCP_ECN_OPTION have been defined in
tools/testing/selftests/bpf/progs/bpf_tracing_net.h to resolve the
compilation failure in progs/setget_sockopt.c.

This has been addressed in v4:
https://lore.kernel.org/all/20260916050255.1379192-1-irlanki.s@samsung.com/

Thanks,
Sandeep.


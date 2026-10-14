Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E043612F3
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964188; cv=none; b=TDv75kkZEk5AcVuguPulcWstFLJu1547smxIvBJ4ic2z8tIGpa1j6PvVpNJ4laUWNPeA1+h+Tw7P/MFtL+3W/5ClD+S0aAy9bUdXyVBlsE+GL7FBPkJHRiGY9itQqW64Zfa9TCKjs9BecCWdZJEBrSo3ps4HRBaRBeBEiSzeKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964188; c=relaxed/simple;
	bh=dLWKEvruuD6C19bCQno+l/oa1P/6rO/VCYAXqdyytvk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=s2RADSZPOeI5dEcPUFcsyBa+upwMaIt6yo7HEGFJtYTI5Yxm3XGlPZ8UKcUBIYZdc2H1KM5ws9iqib1LwQQ9hbLATEcXwOlcoXMws/SoZ7cLkydXfMy6Lsh0Y6alO1Rl38oVYuWQXEzAZL38VasU21xRAxPqZKsNQPhqOkyyHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S7z+lnoE; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S7z+lnoE"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261014074938epoutp043232f609e6bcd92f80a993d0b8aee45e~eVe0VJ7m50520805208epoutp04Q
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 07:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261014074938epoutp043232f609e6bcd92f80a993d0b8aee45e~eVe0VJ7m50520805208epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791964178;
	bh=Gps2kTJ1Dkj1Dk3mpOjm9wB6BcS474HImd2/NbFl3IA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=S7z+lnoEr8J/ye3xlheFwBwhLSTamfQEJEjNadjjeWLzB3+BqTkImc+qpp/HPhD89
	 aWUBNHQAE4M6Bruk2knGxRBBsLPF4CjQ82xvLP1ix40x9IBoLZPiJdTKNcYFG1uKwz
	 XmcGH9azkUtexFE+BNHup7T5TUMf+GS0s5GYxsYE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261014074937epcas5p45bd5d2dddf765964da940e523c757410~eVezhxFcN0855408554epcas5p4h;
	Wed, 14 Oct 2026 07:49:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4j4NdX68w0z2SSKX; Wed, 14 Oct
	2026 07:49:36 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261014074936epcas5p3aa47693f3407c0f352943f02e1c112c3~eVeyaq0EQ0767107671epcas5p3R;
	Wed, 14 Oct 2026 07:49:36 +0000 (GMT)
Received: from SRIB8EG28RUQ1R (unknown [107.108.208.92]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261014074933epsmtip1687c42748145a71c8c4fb0c232d0e8f0~eVevVvOmT2972729727epsmtip1B;
	Wed, 14 Oct 2026 07:49:33 +0000 (GMT)
From: "Irlanki Sandeep" <irlanki.s@samsung.com>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <ncardwell@google.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<corbet@lwn.net>, <linux-kernel@vger.kernel.org>, <lorenzo@google.com>,
	<maze@google.com>, <sporeba@google.com>, <motomuman@google.com>,
	<madhan.raj@samsung.com>, <srihari.k@samsung.com>, <g.pokhra@samsung.com>,
	<r.kumawat@samsung.com>, <raj.kumars@samsung.com>, <ts413.lee@samsung.com>,
	<ramyashree.s@samsung.com>, <daeil2.hwang@samsung.com>, "'CPGS'"
	<cpgs@samsung.com>
In-Reply-To: <20261007170028.318acb6b@kernel.org>
Subject: RE: [PATCH net-next v6] tcp: add BPF kfuncs to set per-socket ECN
 mode and AccECN option
Date: Wed, 14 Oct 2026 13:19:31 +0530
Message-ID: <117401dd5bb0$8f05b2f0$ad1118d0$@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFiGh7FxEkrBp5pI+mpFK8IrUA4cQI/u/Z6AVCeO9O31pb6oA==
Content-Language: en-in
X-CMS-MailID: 20261014074936epcas5p3aa47693f3407c0f352943f02e1c112c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261001132701epcas5p2da9b0fa7ca3bcef1ff84a62f255bc573
References: <CGME20261001132701epcas5p2da9b0fa7ca3bcef1ff84a62f255bc573@epcas5p2.samsung.com>
	<20261001132759.1076145-1-irlanki.s@samsung.com>
	<20261007170028.318acb6b@kernel.org>

On Wed, 7 Oct 2026 17:00:28 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu,  1 Oct 2026 18:57:59 +0530 Irlanki Sandeep wrote:
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> 
> This needs an ACK from TCP maintainers. If you respin please make sure
> to drop this tag, this tag is for cases where someone suggested sending
> the patch as a whole. Not for changes requested during normal course of
> review.

Understood, thanks for clarifying the tag semantics. I will drop the
Suggested-by tag in v7 if a respin is needed.

> There was a false positive from sparse regarding the use of kfunc,
> I kicked off the AI review manually, please check the results here
> in an hour or so:
>
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001132759.1076145-1
-irlanki.s@samsung.com

Thanks for triggering the manual AI review. The results show 0 Critical,
0 High, 1 Medium, and 1 Low:

1. [Medium] SYN arrival race before LISTEN_CB completes:
   The review identifies that inet_csk_listen_start() hashes the socket
   before tcp_call_bpf(BPF_SOCK_OPS_TCP_LISTEN_CB) runs. A SYN arriving on
   another CPU in this window will see ecn_mode as UNSPEC and fall back to
   the sysctl. This is a preexisting limitation affecting any
   BPF_SOCK_OPS_TCP_LISTEN_CB program that configures listener behavior,
   not specific to this patch. I will document this fallback behavior in
   the kernel-doc and commit message for v7.

2. [Low] Selftest scope (API validation vs. packet inspection):
   The selftest validates the kfunc API layer: argument validation, return
   codes, verifier safety (sk_is_tcp() guard), and struct field
   mutation/inheritance. It does not include packet-level inspection. This
   is comparable in scope to progs/setget_sockopt.c, which similarly tests
   bpf_setsockopt/bpf_getsockopt round-trips without packet-level wire
   verification.

Awaiting feedback from Eric and the TCP maintainers.

Thanks,
Sandeep


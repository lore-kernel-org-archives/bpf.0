Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B233481FD6
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909222; cv=none; b=AaT4+AYSU8O3kUb4qcKbJL83p8OMAOJpC5FgDNULrvm1VrCwZLrTyWB55bQYBYZoMsI+3uFQYiBya9Ub7riZjVB/CWXOHUWpB+Ss57C3vxVYBwLdIXo/h9FPaKIH0Y469rZ4I+iRK+SsQqpY+c5rNbgJIi9hMbsPkuVU7l5bdBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909222; c=relaxed/simple;
	bh=dckliJA1HA+MBkavOMFC4q5qt055wBVp3m+q9tkwrLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G8UG/V05CCVK3xMdyDQz0MqaWGlDUFa7nFP/ioxsOaAMoMSeLEYoMIZ6gV/LUdITFDOrAww2/wjHlwnzIadIKlQGZF6ZbsS5lnca+s+iPT9QkYDqlmR3+yLS6c+QLCML3BxTvDObMYGSVWXOxypXiqKi27WbNn13abL79sZPS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGZ/YTCP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGZ/YTCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29A71F000E9;
	Wed,  1 Jul 2026 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909221;
	bh=iVojyTv/ag1c5CVdnY4Xv26HqgQDz9SNawO5LrHnIVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WGZ/YTCPk5XFeTCsatwwuhB+zsQIwk3hhKtFYeoto4PM0ly67Ooj4OjasQVI4tkim
	 ny3a9Fs6n3zujBP78oHtcyE48s+YsQawu7Z8uQgmiMRAvxThW4GokAz4zibY5xj7V+
	 wP7yAMOedlH5vOc9Ie/VA6KuV7dOPePMcHm2tk+M5cTOPM0LDMFQAbIqAhKx0Z10v4
	 6Ej3WUlV1Gj3SPTOxV273TzQrt5/mn7uO85tL5zzlrXhdh2h2B2nm95DWiEa0gtVTj
	 tpIoBou54DJX0MOpkBtFNvmOzHbnXuJ5VoGdICvGJsnAEXA2vOxAvs5BHALBoBoxLy
	 ZSELsBCgD0gjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260630123331.186840-3-daniel@iogearbox.net>
References: <20260630123331.186840-1-daniel@iogearbox.net>
 <20260630123331.186840-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 12:33:40 +0000
Message-Id: <20260701123340.D29A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing handling of TC_ACT_CONSUMED in qdisc filter chains lea=
ds to Use-After-Free.
--

commit 84137b5068cebac45a2a901c08e1d2f5e6d71111
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

When a TC filter attached to a qdisc filter chain returns TC_ACT_REDIRECT,
the redirect was silently lost and the packet fell through to the switch.
This patch adds a tcf_classify_qdisc wrapper to convert TC_ACT_REDIRECT to
TC_ACT_SHOT, preventing the packet from silently continuing.

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
[ ... ]
> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>  {
>  	return TC_ACT_UNSPEC;
>  }
> -
>  #endif
> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> +				     const struct tcf_proto *tp,
> +				     struct tcf_result *res, bool compat_mode)
> +{
> +	int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> +
> +	/* TC_ACT_REDIRECT from qdisc filter chains is not supported.
> +	 * Use BPF via tcx or mirred redirect instead.
> +	 */
> +	if (unlikely(ret =3D=3D TC_ACT_REDIRECT))
> +		ret =3D TC_ACT_SHOT;
> +	return ret;
> +}

[Severity: Critical]
This is a pre-existing issue, but missing handling of TC_ACT_CONSUMED in
this helper can lead to a use-after-free.

The tcf_classify_qdisc() wrapper intentionally intercepts TC_ACT_REDIRECT
to prevent it from falling through to the qdiscs. However, it fails to
intercept TC_ACT_CONSUMED, which suffers from the exact same fall-through
vulnerability.

If a user configures a qdisc filter with an action that returns
TC_ACT_CONSUMED (such as act_ct queueing an IPv4 fragment for defrag), the
action takes ownership of the skb.

Because TC_ACT_CONSUMED bypasses the switch statements in qdisc classify
functions like cake_classify(), the qdisc treats it as a successful match
and enqueues the already consumed skb into its internal queues.

Should TC_ACT_CONSUMED also be intercepted and handled here in
tcf_classify_qdisc() to prevent this use-after-free scenario?

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
[ ... ]
> @@ -1730,7 +1730,7 @@ static u32 cake_classify(struct Qdisc *sch, struct =
cake_tin_data **t,
>  		goto hash;
> =20
>  	*qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> -	result =3D tcf_classify(skb, NULL, filter, &res, false);
> +	result =3D tcf_classify_qdisc(skb, filter, &res, false);
> =20
>  	if (result >=3D 0) {
>  #ifdef CONFIG_NET_CLS_ACT

[Severity: Critical]
This is a pre-existing issue, but TC_ACT_CONSUMED bypasses the switch
statement that immediately follows this result check.

When tcf_classify_qdisc() returns TC_ACT_CONSUMED, it satisfies the
result >=3D 0 check but falls through the switch handling TC_ACT_STOLEN,
TC_ACT_QUEUED, and TC_ACT_TRAP. The qdisc then treats the consumed packet
as a successful match and enqueues it.

Could this be resolved by either adding TC_ACT_CONSUMED to the switch
cases here and in other qdiscs, or by having tcf_classify_qdisc() intercept
it alongside TC_ACT_REDIRECT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630123331.1868=
40-1-daniel@iogearbox.net?part=3D2

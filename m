Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C64317161
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579141; cv=none; b=KOdSfjTX6EfkWpzzmRnN4Jt3qU5E9HZgKXDNzwIY2J/Z63j3jXlgegpi0hjRkwuiifAJm8Ioqlj4qxV8B4oiRLHFNnlOQW46wdRR3z7VP0Ms5SghPSVemHnY2TCKxT4UVl1eMfo6MYR2pLBX4UxeeQB3kfTiz6v7ORJEI5fhVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579141; c=relaxed/simple;
	bh=yHaq+Ak4DGEloDAPLt86jCrijEHVZclvMTwnLLiVZgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WilOzOABZk4ChHv8hAZhqCd7xKUe6N+w2Hyh6+LY4oQPPPDz3NJsyIPXyTyWZGwF2zFelXCE9r23Hl2+QIsm/NaR4V5dHeUAq92JuDtaGNyJ+fc3j1r8dlXM8rS0VUkwrh+e6EYq9KdLf04ExA34X207++U8sv30mHhL09CYg3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k235obVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k235obVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B61F00A3A;
	Sat, 27 Jun 2026 16:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579140;
	bh=fHH9pEYau/b9GmcHWhMh38/FEQPZOuQToVtxKUVpmOI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k235obVGx7e6L1/Qeb5DTy+W7GnODWTuhuAmE/kuGQmrnG8RaCU5z6KSQN4eArtGf
	 0ZFi098AqvzpADvwoKholghmZ3oAjKRjXPhf5qZFKyVb2nX5KQ/9ylbnJWWrzE4ojy
	 CHVtVfKZuzKbbBLZ5ALbgRPdDvMvQqnQW8w0mL1OJnonFowiIeQxuVklCAXBYW+16I
	 eRN/YdO9OxNYuhueBHu+4U6MvFvBFr+cmrGuh3O+8wulHf2LEHZ5ANBx4ByezLt7mb
	 DEjbUIKkzig2Y4bfV7N3Z9lDBM6Zik1AzZtyozZRVTT850VmDLm0W4zhXOuQTOzk9J
	 NG44KCnBhEm9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626165156.169012-3-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
 <20260626165156.169012-3-jhs@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 16:52:18 +0000
Message-Id: <20260627165220.096B61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Removal of TC_ACT_REDIRECT support from qevents (tcf_qevent_handle=
) breaks existing eBPF redirect functionality.
- [Low] pr_warn_once() used inside a static inline function in a header fil=
e will print multiple times.
--

commit d96e142c03f9c1a1e9ac2e1d8c8fe26605053b10
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

When a TC filter attached to a qdisc filter chain returns TC_ACT_REDIRECT,
the redirect is silently lost. This patch adds a tcf_classify_qdisc()
wrapper to convert TC_ACT_REDIRECT to TC_ACT_SHOT and drops the packet.
It also removes the TC_ACT_REDIRECT case from tcf_qevent_handle() since
it is handled by the wrapper.

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 3bd08d7f39c18..3a542a72e9a55 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
[ ... ]
> @@ -159,6 +159,19 @@ static inline int tcf_classify(struct sk_buff *skb,
> =20
>  #endif
> =20
> +static inline int tcf_classify_qdisc(struct sk_buff *skb,
> +				     const struct tcf_proto *tp,
> +				     struct tcf_result *res, bool compat_mode)
> +{
> +	int ret =3D tcf_classify(skb, NULL, tp, res, compat_mode);
> +
> +	if (unlikely(ret =3D=3D TC_ACT_REDIRECT)) {
> +		pr_warn_once("TC_ACT_REDIRECT from qdisc filter chains is not supporte=
d; use eBPF with clsact or mirred redirect instead\n");

[Severity: Low]
Is this going to print multiple times instead of strictly once globally?

Because tcf_classify_qdisc() is a static inline function in a header file,
each C file including it (like the various qdisc modules) will create its o=
wn
local instance of the static __already_done variable used by pr_warn_once().

> +		ret =3D TC_ACT_SHOT;
> +	}
> +	return ret;
> +}
> +
>  static inline unsigned long
>  __cls_set_class(unsigned long *clp, unsigned long cl)
>  {
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 3e67600a4a1a1..3ca56d060e28f 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -4033,7 +4033,7 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qevent=
 *qe, struct Qdisc *sch, stru
> =20
>  	fl =3D rcu_dereference_bh(qe->filter_chain);
> =20
> -	switch (tcf_classify(skb, NULL, fl, &cl_res, false)) {
> +	switch (tcf_classify_qdisc(skb, fl, &cl_res, false)) {

[Severity: High]
Does this break existing eBPF redirect functionality for qevents?

Prior to this patch, tcf_qevent_handle() correctly handled TC_ACT_REDIRECT
by calling skb_do_redirect(skb). By using the tcf_classify_qdisc() wrapper
here, TC_ACT_REDIRECT is unconditionally converted to TC_ACT_SHOT. This
inadvertently drops packets that were legitimately redirecting from qevents.

>  	case TC_ACT_SHOT:
>  		qdisc_qstats_drop(sch);
>  		__qdisc_drop(skb, to_free);
> @@ -4045,10 +4045,6 @@ struct sk_buff *tcf_qevent_handle(struct tcf_qeven=
t *qe, struct Qdisc *sch, stru
>  		__qdisc_drop(skb, to_free);
>  		*ret =3D __NET_XMIT_STOLEN;
>  		return NULL;
> -	case TC_ACT_REDIRECT:
> -		skb_do_redirect(skb);
> -		*ret =3D __NET_XMIT_STOLEN;
> -		return NULL;
>  	case TC_ACT_CONSUMED:
>  		*ret =3D __NET_XMIT_STOLEN;
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626165156.1690=
12-1-jhs@mojatatu.com?part=3D2

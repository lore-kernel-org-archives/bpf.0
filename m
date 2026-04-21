Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55536AB56
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770001; cv=none; b=WUPQb0hYqu4A0saUFkJHEV3xhdqeHwB8HpnjTfq/SX/dVG0Ted0uevuWpyi3mbQnXKlmrs32FcV4MR3TRJ7Rbg5dOI5OKP/4bB8iXz1RumkShmP4JEKuYpQGvMSbfdnJM0GVQ+XCOvgv8pC4zpEW10LON2N8+LTkuvwbvdpxpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770001; c=relaxed/simple;
	bh=u1nI8KbeVUOVzNwPUOifiU0HciD/ObP0AAXgt+wpBCg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g80qYDNlelmdjCPgnyWY//pcwFJfIdkL8bOTLYIF3oSDYgKiTT4lHC8GeFjbuHDtbb/6BG2yyLDfsjRFUGS5fLY6Q6wCMdDX25mp8gnOqMgPmvMoJMqiWacKTytDKypBoZIraKCYOP+jzJpot5Xeqv4dukW3QO3+NPaLumwpT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez1+7VWU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez1+7VWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97D9C2BCB0;
	Tue, 21 Apr 2026 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770001;
	bh=u1nI8KbeVUOVzNwPUOifiU0HciD/ObP0AAXgt+wpBCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ez1+7VWUoyV1FgSXBy1BdGyg5GqoET6mJLsvC9NDK0Ze58lj01tYGZpaoX8qRMWWO
	 LLepWI3vc084Wm12E1epdoefD1ZuGJiKZ4ZyTV2Aza2/PTK01/RHNk4Mfeh29qfuGB
	 D1QVwSo4LVBDtXsVtkcTnK7JxRBd1XtZKcNv8z9twyFB1qnu0VMAXiCnCetEKGc9Gr
	 yrYlUWViZ/EayTELTG9opdXnhxYS8OpdoYTTROe2XVJ2XCZujnvbMKGp8p9/4usbOa
	 eAIY5FkimXs8+IUiwCQw9HLBOXQj1xmCywREXfFLaLUlSb79qA8jX8ZHn9xtEa1/mW
	 qrpkqhbuQ9VIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] net: move netfilter
 nf_reject_fill_skb_dst to core ipv4
Reply-To: sashiko@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420105816.72168-2-mahe.tardy@gmail.com>
References: <20260420105816.72168-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:13:20 +0000
Message-Id: <20260421111320.D97D9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] NULL Pointer Dereference on `skb->dev` in exported routing helper.
- [High] Missing Header Linearization and Bounds Check causing Out-of-Bound=
s Read.
- [Low] Misleading function name implies read-only operation while mutating=
 SKB state.
--

commit d9b5a7cd6924dc358237afb642ea1eb45a09213a
Author: Mahe Tardy <mahe.tardy@gmail.com>

net: move netfilter nf_reject_fill_skb_dst to core ipv4

This patch moves and renames nf_reject_fill_skb_dst to
ip_route_reply_fetch_dst in ipv4/route.c to allow reuse by BPF kfuncs.
It also inlines the nf_ip_route wrapper around ip_route_output_key.

[ ... ]

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index bc1296f0ea69b..7091ef9360737 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2945,6 +2945,21 @@ struct rtable *ip_route_output_flow(struct net *ne=
t, struct flowi4 *flp4,
>  }
>  EXPORT_SYMBOL_GPL(ip_route_output_flow);
> =20
> +int ip_route_reply_fetch_dst(struct sk_buff *skb)

This isn't a bug, but does the name ip_route_reply_fetch_dst imply a read-o=
nly
operation? Since it mutates the SKB by setting the destination via
skb_dst_set(), could this lead to callers accidentally overwriting and
leaking existing destinations?

Would a name like ip_route_reply_fill_skb_dst better reflect its side effec=
ts?

> +{
> +	struct rtable *rt;
> +	struct flowi4 fl4 =3D {
> +		.daddr =3D ip_hdr(skb)->saddr

Can this lead to an out-of-bounds read?

Now that this is exported for BPF kfuncs, it can be reached from early
hooks like TC ingress where the IPv4 header might not be linearized yet.

If a malformed packet contains less than sizeof(struct iphdr) bytes of
linear data, does accessing ->saddr require validation via
pskb_may_pull() or similar?

> +	};
> +
> +	rt =3D ip_route_output_key(dev_net(skb->dev), &fl4);

Can skb->dev be NULL here?

While safe in its original netfilter context, a BPF_PROG_TYPE_NETFILTER
program attached to the NF_INET_LOCAL_OUT hook will receive locally
generated SKBs before skb->dev is assigned (e.g., in __ip_local_out before
ip_output).

Does dev_net(skb->dev) need a check to prevent a kernel panic when called
from such contexts?

> +	if (IS_ERR(rt))
> +		return PTR_ERR(rt);
> +	skb_dst_set(skb, &rt->dst);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ip_route_reply_fetch_dst);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420105816.7216=
8-1-mahe.tardy@gmail.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1139281F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450583; cv=none; b=MwZjWkDHigtFgjoQ7xOojlDDubuIcxi8RUcXk61VXMlkAPVzLl4YiPX4hdGt3j6EiiGRPQeA7l2Q0lNG1SIBkeEIIn6qAW2U2oraJVy4UW2HHIXAAkbpsP6df539ahiiARZhINu/WXQq2SyKj50zEGexosCp7ycB1jSe6yXpreo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450583; c=relaxed/simple;
	bh=WXI3/r3G6i0L9gSlino03qNX9c8WSRjI76MXFfzuEKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RUXMg1E9hJ//8VdSjE0d+ZC0ItA4kl5AgG6EjvI0B9mglx5Rgq51wJrGt/t9PYzjs7otkM3EWXhck2gWJWoF6Me9kiOUlCocMFGhLK2GHkO3MSzJ6JMasvsYOFqLe0Sa6SKgym//b8wBBjDZrM3VT3GRKv2q9+V4dHIYM0FcXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPrvL3kv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPrvL3kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE25C1F000E9;
	Tue,  7 Jul 2026 18:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783450582;
	bh=JhXth6z3nXeAF4JXXZBnTXEkzXsj/2YFi8matOvGE/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPrvL3kvXGjG+I/hra7DUKeIkYas5awZuXvRpYuGbzxRDf9AbyZIrbt9DYSZJfXj0
	 sYbXd0qVEu3GQ1P/6ZFKkqyS9NHDoBtoi6S7uXH+5h0rjGX2MuzDs9loTS77lEfcbm
	 EtwrdSIbgwbglMs9pHEr2QvNflw9VscBXv/QenxNzgJMY/Tm6r7afZ1uNURMd6Lyh6
	 O2YTACOqZ+dtxj4p9Hk9QUmd0334DqMOssunHJ6yNYItHm6JI/9RlrhNYyr/BLZmM9
	 hBJXi8bN9P7a3eFx/63aiQYg2UU18Oojdq5Ot251TZsmWz7xJcC53rD5/fmp3CtxP9
	 78fbSaE96+KGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/3] net/sched: Handle TC_ACT_REDIRECT from qdisc
 filter chains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706185609.330006-3-daniel@iogearbox.net>
References: <20260706185609.330006-1-daniel@iogearbox.net>
 <20260706185609.330006-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 18:56:21 +0000
Message-Id: <20260707185621.EE25C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel stack memory in `struct bpf_net_context` can =
be leaked via eBPF program redirect.
--

commit 2f1907a4bebd712981a70b8c62353113ce365c7b
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: Handle TC_ACT_REDIRECT from qdisc filter chains

When a TC filter attached to a qdisc filter chain returns TC_ACT_REDIRECT,
the redirect was silently lost. This patch adds a tcf_classify_qdisc()
wrapper to convert TC_ACT_REDIRECT to TC_ACT_SHOT, ensuring the packet is
dropped rather than silently passed through.

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 3bd08d7f39c18..5f5cb36439fe2 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h

[ ... ]

> @@ -156,8 +156,20 @@ static inline int tcf_classify(struct sk_buff *skb,
>  {
>  	return TC_ACT_UNSPEC;
>  }
> -
> -#endif
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

[Severity: High]
This is a pre-existing issue, but since this patch explicitly discusses
handling TC_ACT_REDIRECT verdicts, does the current clsact fast path leak
uninitialized kernel stack memory?

If a user attaches a TC BPF program that simply returns TC_ACT_REDIRECT
without calling the bpf_redirect() helper, it appears we use uninitialized
stack data.

In net/core/dev.c:sch_handle_ingress(), the bpf_net_context is allocated on
the stack without initialization:

    struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
    ...
    bpf_net_ctx =3D bpf_net_ctx_set(&__bpf_net_ctx);

When include/linux/filter.h:bpf_net_ctx_set() is called, it only zeroes
kern_flags:

    bpf_net_ctx->ri.kern_flags =3D 0;

This leaves the rest of the redirect info (ri.tgt_index, ri.flags, and
ri.nh) uninitialized.=20

Later, when net/core/filter.c:skb_do_redirect() is called to process the
TC_ACT_REDIRECT verdict:

    struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
    ...
    u32 flags =3D ri->flags;
    dev =3D dev_get_by_index_rcu(net, ri->tgt_index);

It reads this uninitialized stack memory. If the flags happen to have
BPF_F_NEIGH set, the uninitialized ri->nh structure is used to generate an
ARP/NDP request, potentially leaking kernel stack memory on the network.

Should bpf_net_ctx_set() or sch_handle_ingress() zero out the entire
__bpf_net_ctx structure to prevent this leak?

> +		ret =3D TC_ACT_SHOT;
> +	return ret;
> +}
> =20
>  static inline unsigned long
>  __cls_set_class(unsigned long *clp, unsigned long cl)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706185609.3300=
06-1-daniel@iogearbox.net?part=3D2

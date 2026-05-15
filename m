Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817F39183C
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778876638; cv=none; b=T21Um/CF3CFQ5kUbFHPAnP2dA3H9Ry2qhBOMxyDW4IT0PnlozSjp1MaImwcWHRUpNNqhJBIYPH+Fk6i2LZvmYZh8KqZv9Mo3DtjCdYFfMOqk5atEXuDi+UMYqebHcrYRWy+FQy4Xv6rD7Kbh7pt6ip9xGbOywVGanFSGwbWtfNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778876638; c=relaxed/simple;
	bh=pAMAxiNF1i06sZdLJHR+M5sGApf0GBWh45QDraVZRKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ffMbHxciO/Q42LRAA+5UeepNXHOikWW4qSt4waoJvjcm3F54cX8Y/OIgkyENJGYhyc3RmCrDLpxraaysrvNhk62ZhfLzkDknDSbAz4aGztSmC/RwiwUHeTg8tDpEp/6s7QBeGCMyGPeJARE3pZzTO8bEs1NyKIgYdOnsdDCSXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0TwfX05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0TwfX05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20252C2BCB0;
	Fri, 15 May 2026 20:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778876638;
	bh=pAMAxiNF1i06sZdLJHR+M5sGApf0GBWh45QDraVZRKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o0TwfX05+LeGgs6Gpc98oLDPQG539neQJVw56h4n4SeOziyJbfvwRmexurSHWp2nr
	 n97wtdgtVcNsqNcsD2angmz/oTduCXp5eDWKQb6LpIztCwWq49BR9eALuDoDzyCtfv
	 Be+zjbGkxVudgSE1EXxtKPXXoVeuRW9EFJHionTpXMfk3w8U+IrGxyGWz1BmRSFzGQ
	 MAsslA4c4sANxIDlciLUfRffJFngXsuPE1jgzzGGVWlbs5B5bO2HYchGGFKx0siHPr
	 Qi6RFnPUvnN/XD4nfUDTsuIjGGd2E9mbu/lFZOa6iSUjdQJV40VoAeTT9TnrwhvLw9
	 arYzga7qYX1cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] bpf: add bpf_icmp_send kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260515194746.50920-2-mahe.tardy@gmail.com>
References: <20260515194746.50920-2-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:23:57 +0000
Message-Id: <20260515202358.20252C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Calling pskb_network_may_pull() on the original skb before clo=
ning modifies the SKB layout, causing BPF packet pointer Use-After-Free and=
 panicking on shared SKBs.
- [High] IPv4 ICMP generation fails silently in TC ingress due to a missing=
 routing table entry.
- [Medium] Unsafe use of a per-CPU recursion protection flag without disabl=
ing preemption or bottom-halves causes spurious failures.
--

commit a8e749b3f92e491c40d461bbeec717cff3d92cd2
Author: Mahe Tardy <mahe.tardy@gmail.com>
One line subject: bpf: add bpf_icmp_send kfunc

This commit adds the bpf_icmp_send kfunc, allowing cgroup_skb and tc
programs to generate ICMP error messages instead of silently dropping
packets. It clones the skb to preserve the original buffer, checks bounds
with pskb_network_may_pull, and relies on icmp_send or icmpv6_send to
transmit the error message.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..a1fe20b45f29a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12464,6 +12466,95 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md =
*x, u32 len)
>  	return 0;
>  }
> =20
> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supporte=
d)

[ ... ]

> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *__skb, int type, int cod=
e)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)__skb;
> +	struct sk_buff *nskb;
> +	bool *in_progress;
> +
> +	in_progress =3D this_cpu_ptr(&bpf_icmp_send_in_progress);
> +	if (*in_progress)
> +		return -EBUSY;

Since cgroup_skb egress programs execute in process context, they can be
interrupted by network RX softirqs on the same CPU.

If a task sets *in_progress to true and is immediately preempted by a softi=
rq
that runs a TC ingress program calling bpf_icmp_send(), will it read the sa=
me
per-CPU flag and spuriously fail with -EBUSY?

Does this critical section need to run with bottom-halves disabled?

> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
> +			return -EBADMSG;

Does calling pskb_network_may_pull() on the original skb before cloning mod=
ify
the packet layout? If the headers span into paged fragments, this could
trigger reallocation of the linear data buffer via pskb_expand_head().

Since this kfunc lacks flags like KF_INVALIDATE_PKT_PTRS, could the BPF
verifier allow programs to retain and dereference stale direct packet
pointers?

Additionally, if the original skb is shared (which is common in tc and
cgroup_skb), would pskb_expand_head() hit a BUG_ON(skb_shared(skb)) and pan=
ic
the kernel? Should the packet be cloned first before pulling headers?

> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		*in_progress =3D true;
> +		icmp_send(nskb, type, code, 0);

The commit message notes this is "mostly for tc ingress progs". Since TC
ingress happens before IP routing, skb_rtable(nskb) will be NULL here.

Looking at __icmp_send(), it checks for a routing entry and aborts early if
missing:

net/ipv4/icmp.c:__icmp_send() {
        ...
        rt =3D skb_rtable(skb_in);
        if (!rt)
                goto out;
        ...
}

Will this cause IPv4 ICMP generation to silently fail for TC ingress progra=
ms?

> +		*in_progress =3D false;
> +		kfree_skb(nskb);
> +		break;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515194746.5092=
0-1-mahe.tardy@gmail.com?part=3D1

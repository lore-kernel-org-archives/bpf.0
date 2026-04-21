Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47FB35C193
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770002; cv=none; b=mMrDOyOF9769YlI8JZdwuUwIaU8hCArz8czQlFlEzIvKXurCB25yPBts/dzU2yct49yFeSYe0vdv7AqHzT702b8atEQS64AAcZ6ezTSVqHk814ddwI6JQMfo83vXGossnc6GjaZrMCq1Hv6/Hqzppg45jKWigELV1v3uOJK1dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770002; c=relaxed/simple;
	bh=4l4u+eG8SEJKlzkZnb1orh6pDI8+rzByglXCdtCrte0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c+KRRSZKZa/w1Yw/Sky3SWTlNH84LAg6DouQ1SflYZTOXRVSLPRh+okWoXxC6MFHzUgRp4PYp6dO6sDzt6DfZSykHsIfRxF2m6BPLCkN1mZpsFOvWCsg3PCA26OntQRfoCcTvzgqo2cS8eUsiB/eV1FWwlK0V0OkKsYI6gKyObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4K/E+Wg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4K/E+Wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC9BC2BCB0;
	Tue, 21 Apr 2026 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770002;
	bh=4l4u+eG8SEJKlzkZnb1orh6pDI8+rzByglXCdtCrte0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=g4K/E+Wg7H8pYez06cMJoM3fjvbsliIfTAlcEUJ77AKk52ELKRMrLak1gx+smiQHb
	 6F7npe446PB7cZXCgufTsMQeGt5Sm0ZfBjRDoFE+9NGi6OkX/fyRubAgOY/RD7bzR/
	 tzfebcvGfUS18xv/LwOqm3XXxzSZj2PbKsY2+m9yqSU3DuUhzYxY/9w5iG07LBNnB/
	 sIbQKFhHe62+5unQyM5OipLfHapHXsWqHou/cg1+Eus81PveNo5whXRhMsZ/f/oA1f
	 9/Bl6ABcS7f3Hbn/kQm8EDMOuRfK5rrKD1ZXiVjXkYJyyp4TGOeUS8F6tHl20gxwMx
	 2lCDQ61qW0Dbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/6] bpf: add bpf_icmp_send_unreach kfunc
Reply-To: sashiko@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420105816.72168-4-mahe.tardy@gmail.com>
References: <20260420105816.72168-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 11:13:21 +0000
Message-Id: <20260421111322.6CC9BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] Unchecked `skb->dev` leads to a guaranteed NULL pointer derefe=
rence and kernel panic.
- [High] Missing SKB header linearization and bounds validation before acce=
ssing IP/IPv6 headers.
- [High] Uninitialized SKB control block (`skb->cb`) causes memory corrupti=
on and info leaks via IP options parsing.
- [High] Ad-hoc synchronization with the per-CPU flag `bpf_icmp_send_in_pro=
gress` causes false-positive failures and bypasses recursion protection und=
er preemption.
--

commit 26bc7aced36645f274275d44dc5bb1fd8f53f864
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: add bpf_icmp_send_unreach kfunc

This commit introduces the bpf_icmp_send_unreach kfunc to allow BPF programs
to send ICMP destination unreachable messages. It clones the original SKB to
ensure the packet can still proceed unmodified if desired, and includes a
per-CPU flag to prevent recursion.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send_unreach - Send ICMP destination unreachable error

[ ... ]

> +__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)__skb;
> +	struct sk_buff *nskb;
> +	bool *in_progress;
> +
> +	in_progress =3D this_cpu_ptr(&bpf_icmp_send_in_progress);
> +	if (*in_progress)
> +		return -EBUSY;

BPF programs can run in preemptible contexts, such as when running with
migrate_disable() and rcu_read_lock(). Is it possible for a task to be
preempted between checking and setting this flag, or while icmp_send() is
executing?

If another task runs on the same CPU while the flag is set, it might
incorrectly fail to send an ICMP message. Alternatively, could a race allow
the recursion protection to be bypassed entirely if tasks interleave their
reads and writes to this flag?

> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fetch_dst(nskb) < 0) {

This kfunc is registered in bpf_kfunc_check_set_skb, exposing it to program
types like SOCKET_FILTER or SK_SKB. In these contexts, socket buffers
frequently have neither a destination entry (skb_dst is NULL) nor an
assigned network device (skb->dev is NULL).

When ip_route_reply_fetch_dst() executes, it calls dev_net(skb->dev). Does
this lead to a NULL pointer dereference if the network device is not set?

Additionally, BPF programs can arbitrarily modify the SKB length, and the
network header might reside in the non-linear paged area. Does this code
need to call pskb_network_may_pull() or similar to ensure the headers are
linearized?

ip_route_reply_fetch_dst() blindly dereferences ip_hdr(skb)->saddr, which
might result in out-of-bounds reads if the header is not safely in the
linear data area.

> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		*in_progress =3D true;
> +		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);

skb_clone() copies the original SKB's control block (skb->cb) verbatim. In
hooks like TC, this area contains subsystem-specific data.

icmp_send() casts this control block to struct inet_skb_parm via IPCB().
If the copied control block data happens to set opt.optlen > 0, will
__ip_options_echo() attempt to parse IP options using arbitrary offsets?

Does the new SKB's control block need to be zeroed before passing it to
the ICMP send functions to prevent reading uninitialized values?

> +		*in_progress =3D false;
> +		kfree_skb(nskb);
> +		break;
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!skb_dst(nskb) && ip6_route_reply_fetch_dst(nskb) < 0) {

The same concerns about skb->dev being NULL and the need for IPv6 header
linearization apply here before calling ip6_route_reply_fetch_dst().

> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		*in_progress =3D true;
> +		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);

Similarly, does nskb->cb need to be zeroed before calling icmpv6_send()?

> +		*in_progress =3D false;
> +		kfree_skb(nskb);
> +		break;
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420105816.7216=
8-1-mahe.tardy@gmail.com?part=3D3

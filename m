Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D91FB1
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224386; cv=none; b=c9C88c55h92TtSHTAUoJufqRRvv5i8UJIMdeqn1vH2xQsVuGiHUvM1XrAhVdKImXnt58LFmoU7p/9SFsOxr+c+6aBxegWK+UOZNERIma8kQViNmVPgJw5ugU16cdnAvxmOPPj8K7bidRVNUhtsmEMKUKnD5DaSPCBI5zCc5UrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224386; c=relaxed/simple;
	bh=q16RQSA1VUs/5ZkvjDcPXnyolGa9IE2RlnUOxA5NMuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SClY5yp3Yn3h8fCeAU2bWk4lzU9z1CwmFBj5VdRUGcrNkvxQHIl+rfiEqTTJ3S9X68IF8pAEZMqdRkLlJP2sMwi5I2MLo3bHWdKarsqjWmnbrYafJTT+kBQQ+cWasfS/JPwJP7PBpd+GApfdLzMGBGoPoueG3aL+WW5kcyif9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfzRwRhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfzRwRhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D791F000E9;
	Fri, 12 Jun 2026 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224385;
	bh=npaQKP1eH6q8PTJDq2LfY5hT9xgVFWKRyd9jCD3Do94=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfzRwRhguDi+xB9hZzR0iv5FXU/bdw41KN9dTQOsg+g17LAWDi8Rxt6gKvbyownEO
	 4lsxgkLCfkDhEYTyMR1bzYtKGESmeXLkn85IBSm4+tGYlFKus/JqCQfV9dFAHcjplp
	 DiyGE2gmfPTiXd9X6mYJPaiYbat7qTNlSk+vDWCK5xnMg89UBk1geA1CjcZem6mRF3
	 ExSbtHzoKejc17LmAmbArmBImkr3cQPmidt8e76LjSxci0NlxFVUSqPP/emhc2V0a0
	 L6TzGHiQEZX9WBhWmS7xQ4HkUX2ubQsGGhV2z1iTH9v43qG0Zv397h+Q1NnURzl/Bk
	 yPrUBDtwHLSCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW
 Timestamp.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612001803.23341-5-kuniyu@google.com>
References: <20260612001803.23341-5-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 00:33:05 +0000
Message-Id: <20260612003305.53D791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The TC_ACT_ERRQUEUE action is unhandled in sch_handle_egress(), ca=
using packets to be silently transmitted instead of queued or dropped.

Pre-existing issues:
- [High] bpf_net_ctx_get_ri() will dereference a NULL pointer if bpf_skb_co=
mplete_tx_tstamp is called from a qdisc where bpf_net_ctx is not set.
--

commit 532ea1ea43e08b0ed268837eba11a8d463c7b97b
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: Add kfunc to proxy TX HW Timestamp.

This patch introduces two new kfuncs, bpf_skb_scrub_tx_tstamp() and
bpf_skb_complete_tx_tstamp(), to proxy TX hardware timestamps for socket
applications using SCM_TIMESTAMPING. It also introduces the TCX_ERRQUEUE
action to enqueue the modified packet to the socket's error queue.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0c6c270d9f7d1..a86d10659cbbc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
[ ... ]
> @@ -4504,6 +4539,10 @@ sch_handle_ingress(struct sk_buff *skb, struct pac=
ket_type **pt_prev, int *ret,
>  		*ret =3D NET_RX_DROP;
>  		bpf_net_ctx_clear(bpf_net_ctx);
>  		return NULL;
> +	case TC_ACT_ERRQUEUE:
> +		*ret =3D skb_do_completion(skb);
> +		bpf_net_ctx_clear(bpf_net_ctx);
> +		return NULL;

[Severity: High]
Does TC_ACT_ERRQUEUE also need to be handled in sch_handle_egress()?

If a BPF program returns TCX_ERRQUEUE on egress, the switch statement in
sch_handle_egress() will fall through. This clears the BPF network context
and returns the skb for transmission instead of queueing or dropping it,
which seems to bypass the intended error queue behavior.

[ ... ]
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ab7adef9c0159..0bb8122f9f2eb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> +__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> +					   struct bpf_tx_tstamp_cmpl *attrs,
> +					   int attrs__sz)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)s;
> +	struct bpf_redirect_info *ri;
> +	struct sock *sk =3D skb->sk;
> +	s32 delta;
> +
> +	if (attrs__sz !=3D sizeof(*attrs) || attrs->reserved)
> +		return -EINVAL;
> +
> +	if (!sk || !sk_fullsock(sk))
> +		return -EINVAL;

[Severity: High]
Should this function verify it is only called on ingress?

Without checking skb_at_tc_ingress(skb), bpf_skb_complete_tx_tstamp() could
be called on egress. If that happens and the program returns TCX_ERRQUEUE,
the completion state would be silently discarded and the packet transmitted
because sch_handle_egress() does not currently handle TC_ACT_ERRQUEUE.

> +
> +	if (attrs->payload_offset > skb->len)
> +		return -EINVAL;
> +
> +	delta =3D attrs->payload_offset - attrs->network_offset;
> +	switch (attrs->protocol) {
> +	case htons(ETH_P_IP):
> +		if (delta < (s32)sizeof(struct iphdr) || !sk_is_inet(sk))
> +			return -EINVAL;
> +		break;
> +	case htons(ETH_P_IPV6):
> +		if (delta < (s32)sizeof(struct ipv6hdr) || sk->sk_family !=3D AF_INET6)
> +			return -EINVAL;
> +		break;
> +	default:
> +		return -EAFNOSUPPORT;
> +	}
> +
> +	ri =3D bpf_net_ctx_get_ri();

[Severity: High]
This is a pre-existing issue, but can bpf_net_ctx_get_ri() trigger a NULL
pointer dereference here under certain conditions?

When a BPF program runs via tcf_classify() from a traditional classful qdisc
enqueue callback (like HTB), sch_handle_egress() has already cleared the
bpf_net_ctx. Calling this kfunc in that scenario would cause
bpf_net_ctx_get_ri() to dereference a NULL pointer.

> +	ri->kern_flags |=3D BPF_RI_F_TX_TS_CMPL;
> +	ri->txtscmpl =3D *attrs;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612001803.2334=
1-1-kuniyu@google.com?part=3D4

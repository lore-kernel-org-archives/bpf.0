Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A733DEFE
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115963; cv=none; b=XKXB2jXa2XaFh0brYxh1eNtzae9YKoc/j1Qr7hbvKU/UGcQtICuczuBcTwBP3DirgSghQ6r9O+vp3LdqEGbJBIbyhn2+3+F9KJZay/WtFUR/EUdBTPZiOT2DELRd1AUNpbtSJBwpPv7vTkvP2tvdv3zkX4uJ8CRaL0uHiVpgYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115963; c=relaxed/simple;
	bh=ibLXrhLC3cNS9hWz17IlledPi9iemtptvI3qpSX5I3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IMAGaQwK4ZhjavOXbv8fqOQbca8VNLKSE5Z50fJvRs4rlTsp4yDWyP55KW/9qfGfjdG4uqxy7M6ud219AxliVRUjz5bjKLV8q8SDLP7+Lb7j0HWLkw8HlTXPbUmREbjM8T8t0TQfuSbSfa64DRGm3/rpIog3DCPlbedmboVNlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsR9BhqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsR9BhqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426151F00A3D;
	Fri,  7 Aug 2026 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115962;
	bh=Dx38QiiERzdNLLOF3r+Mf5fMywQmafPVmbEi7K6gUuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsR9BhqPgZXkLPMQqtHp6PJxFEpjzmmKUpWXiyCzi1kggchIYjScwZu4e8IiYp8ls
	 xtIBwkNPTee19OOgmo+tBLUmxH3w85my+t59lWt3nUY7bu2x3x6fLglrBq8y45i5sg
	 mCdIuQK7lCQjQl1gN9yV50kozlOjgUamTnPz0xkjnJ9dPAxDqLTLSHE7Xh/RZE5dJM
	 kHugE9TOzgVgGxmJXSaVM0h3YtDSTn+Ik9I+h+lSng/iFuPx9nvdTG11lQ9q5RxffT
	 xHkbDrj9pqifByYOoT6ygufWm7zp4kuhY2Gb1i65v4CtG5yM5XxsZQ/WXZx5X4ilkx
	 D47OKaL5QQmjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 1/1] ip: orphan prefetched skbs before multicast
 forwarding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
References: <f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:19:21 +0000
Message-Id: <20260807151922.426151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free (UAF) of `struct sock` on bridging and TC redirect =
paths due to non-refcounted sockets.
--

--- Patch [1]: [PATCH net v2 1/1] ip: orphan prefetched skbs before multica=
st forwarding ---
commit 8d7ee5d5781c74533a99f0b7cf5fb3db935e55f5
Author: Zhiling Zou <zhilinz@nebusec.ai>

ip: orphan prefetched skbs before multicast forwarding

This patch adds skb_orphan() calls before multicast forwarding in both
IPv4 and IPv6 to clear non-refcounted sockets assigned by bpf_sk_assign().
This prevents a use-after-free when the socket is destroyed before the
forwarded skb is freed.

Link: https://lore.kernel.org/all/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.=
1785724784.git.zhilinz@nebusec.ai/

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 1d9a4ac14fcef..e5f2b1c6150d2 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
>  	if (IPCB(skb)->flags & IPSKB_FORWARDED)
>  		goto dont_forward;
> =20
> +	if (!local)
> +		skb_orphan(skb);
> +

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
use-after-free for multicast forwarding, do we have the exact same problem
in the TC redirect and bridge forwarding paths?

If a packet receives a non-refcounted socket via bpf_sk_assign() at TC
ingress, and the eBPF program returns TC_ACT_REDIRECT, it is redirected
to an egress qdisc:

net/core/filter.c:skb_do_redirect() {
    ...
    return __bpf_redirect(skb, dev, flags);
}

Alternatively, if it returns TC_ACT_OK and is processed by a bridge port,
it gets forwarded to an egress qdisc:

net/bridge/br_forward.c:br_forward() {
    ...
    dev_queue_xmit(skb);
}

In both paths, skb_orphan() is not called, so the SKB retains the socket
pointer while sitting asynchronously in the qdisc. If the socket's RCU grace
period expires while queued, wouldn't a later free cause the exact same
use-after-free when the destructor dereferences the freed skb->sk?

net/core/sock.c:sock_pfree() {
    struct sock *sk =3D skb->sk;

    if (!sk_is_refcounted(sk))
        return;
    ...
}

Should skb_orphan() be called before enqueuing to egress qdiscs in these
paths as well?

>  	mrt =3D ipmr_rt_fib_lookup(net, skb);
>  	if (IS_ERR(mrt)) {
>  		kfree_skb(skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f968f497251dedbd126=
3c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai?part=3D1

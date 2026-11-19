Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099931;
	b=UE9iTCZqGFqE0D/VMc3itsHLujuLsi+UmWD7Rye4GoyAVD5XuC26+lj2JLkEjsf6CuIl
	 CT7Mq+1nWdoVqcJxRTjAErDx60HPgC6zfwon/V2fAmU8fi/ECRv0+8JyYuBYNj0eAmPSh
	 WAU27YvaYZStkBa7OIvZUf0j+pJBXyrYGx8HcqalE8c7jk1Q7lCP/kKdc4JU5RG/Du8qd
	 14OuCItnxoXN+OstX6o6FTkNcJWmLAicQKw/ePtjceszTSTd6BkU08Bb+2Sad4rGj0fKB
	 ds9OYTHeks1fHlxBC5TwIY0Iu0loLXS3Aee8t80CyP9xuMBP2NBN7/ZclDZTTDdCZ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mg0K4exeuBTaT9Dn1HqWrgGmEV+EtrlkcIhMNn4wlic=;
	b=BZz/T4o6b5TPTsSoqQdR/2xLOihIZszkST+X0RScjJCbjOFpjqB2y2H/VzWCE3ATlKbo
	 eKGvd9h6uN89/4C5XUJdTtxZ6R+HHUkKC9e0C+rNXMqbCPWzpM/60EG1nRkiygYeu3CV6
	 X4CjATSa06QR7KWv22lyKMddE+KgfF22+UC1R8FdT8U1qcNGK5bNxDRGNEyg0B11KFIkJ
	 MWVEDsIm+bRpF3w6vQQMLD1P+srwiIVCw5KsuMEmtWWfF55dCHKg57OXp/9ZDhnlaziWi
	 olTnCMVcMZwtEs8FYObhu5mNc4gUm9nnU5qNxnOKWv1zbHhpoDW12i/tLQ07aZFmFIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJVMqpGH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F284606E889
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJVMqpGH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45C61F000D1;
	Thu, 19 Nov 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795099930;
	bh=Mg0K4exeuBTaT9Dn1HqWrgGmEV+EtrlkcIhMNn4wlic=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JJVMqpGH5abW+LIhGrzKpKfkx2y5BYfGyWepvaHTEG0x0OA4uTOu2C9pxBFr0HQN1
	 ad2NG/iibrFS91fyhtKZrrub/idVQr9Wj95FgmBzejO7+CgGg2nbHuLZUNzM48C+bI
	 LwN8q/Z9jUmhrjh6lLQt0OZKJRU8/we32nQ9XFskTl1dHH3iGcmIYpu5iKiDC45Ptk
	 OdEE8Xax8yJR8OeI4V4IL/yj4N3dgH9d8tkuELJ2cgssdSSzEvF5cmRHsdeGNNDwI9
	 hqEtf2UrMN8QDlxzmy/dsuZ4sjGb2WrKysCER6Pia91n3hAWhs3/guYENx65xPndSj
	 tuLUV5wHDN9UA==
Message-ID: <sashiko-outbox-223322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/8] bpf: Orphan prefetched sk on
 skb_do_redirect()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
In-Reply-To: <20261119142231.2612515-2-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
 <20261119142231.2612515-2-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:52:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: unorphaned prefetched sk on peer-ingress redirect in
  skb_do_redirect()
--

commit 49a586a8c784f9d116bbf62d9fbeea56cd7faa45
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Orphan prefetched sk on skb_do_redirect()

This commit orphans prefetched sockets in skb_do_redirect() before
redirects other than peer-ingress redirects, preventing RCU-borrowed
listener sockets from outliving their RCU read-side critical section.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 946b07a17fcec..1ad57a3715343 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2558,6 +2558,15 @@ int skb_do_redirect(struct sk_buff *skb)
>  	ri->flags =3D 0;
>  	if (unlikely(!dev))
>  		goto out_drop;
> +
> +	/*
> +	 * Prefetched sockets may borrow a listener under RCU. Orphan them
> +	 * before redirects that can outlive this section. Peer ingress
> +	 * stays in the same RCU section.
> +	 */
> +	if (skb_sk_is_prefetched(skb) &&
> +	    (!(flags & BPF_F_PEER) || (flags & BPF_F_EGRESS)))
> +		skb_orphan(skb);
>  	if (flags & BPF_F_PEER) {
>  		dev =3D skb_get_peer_dev(dev);
>  		if (unlikely(!dev ||

[Severity: High]
Should skb_orphan(skb) run unconditionally whenever
skb_sk_is_prefetched(skb) is true, including for peer-ingress redirects
(flags =3D=3D BPF_F_PEER)?

The BPF_F_PEER path below requires the target peer device to be in a
different network namespace (!net_eq(net, dev_net(dev))), whereas
bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() require sock_net(sk) to
match the pre-redirect device's namespace.  Skipping skb_orphan(skb) on
peer ingress leaves the source namespace's prefetched socket attached to
skb when skb_do_redirect() returns -EAGAIN to re-enter
__netif_receive_skb_core() on the peer device:

- During another_round on the peer device, a TC ingress act_mirred
  redirect (which sets dont_clone =3D true at TC ingress) or an rx_handler
  such as a bridge port or macvlan/ipvlan can queue skb to an egress
  qdisc, backlog, or workqueue without orphaning skb->sk.  An
  unreferenced RCU-borrowed listener then outlives the RCU section,
  leading to a use-after-free in sock_pfree() or skb_steal_sock().

- If the packet proceeds up the peer namespace's IP stack, ip_rcv_core()
  and ip6_rcv_core() preserve prefetched skb->sk.  Packets routed for
  forwarding in the peer namespace are then dropped by ip_forward() and
  ip6_forward() at if (unlikely(skb->sk)) goto drop, while local
  delivery via inet_steal_sock() steals skb->sk without checking
  net_eq(sock_net(sk), net), delivering the packet to the socket in the
  source namespace and caching a peer-namespace dst_entry in
  sk->sk_rx_dst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119142231.2612=
515-1-razor@blackwall.org?part=3D1

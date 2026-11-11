Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370284;
	b=YnaytxIjGiBecMw8eGrxzTLr97jGWYD5EwZPUwgwOu1m11ZoRqeUuW/AmjZJ4x+Crk7d
	 EtLa3F03cBbTw/8kLwtD8VxYaLQogdr9vu8kf0R0KbkMH+25+dcMAAt9fm3ZW6BUP0lje
	 sSwR54IbsgW5V82pWFQnFHs/RYLcJeMxSEJa2sRpOxuCpXHNeCWp4rwRxZWH6mYgeOyM0
	 GjsITe0rRRT8nLEf9qjQkXRSksTbV/ugycDepx3NhAGropW8tR81cMXvZ0o7CeeJPnEhI
	 ak4F/6FX2gNRBCsyTq9Ht8IRMCpf9kgxF5NUT8czC6A+MuEX5pcajeOVsyGGcXox0TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iBHPOQQehxzMlVnUfidaHHS+Q08GcedUh9f66DbuY+o=;
	b=Cz215sjdN/MALHGX0OqkdCll7ylzbRSiGDqZY8IXDBt6olg29yiq6SjmvchRFdnbc3nx
	 +Equ9FvoS9KCYrKz1gsnSuh0jATbN+PHYnGWPP33cBoXhPd0c9yZLjhqj0B9DSnVk3kQs
	 amnvoUQDLWxvjRArgDeP67Q5YFsbZQkOwA41bMs5gE3K/9mamEQdWclblLksyTSADIAH6
	 YVDQ7lly5QqSj/DfYimdMisc/fHwBfw4KW0Q8mBNXIYTdU1ahvCMBbfIZPwzH0E+zGmKz
	 OA9s7G0vHTID2zMslXeLFHVT9CAM0th2I+XEGt9+n5ikFND76Ntf0E2jaJuDU8kkuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2VzFHZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F38606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2VzFHZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6D01F0089F;
	Wed, 11 Nov 2026 04:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370284;
	bh=iBHPOQQehxzMlVnUfidaHHS+Q08GcedUh9f66DbuY+o=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=o2VzFHZVe1n+c95IoIbIrbA4ulsmWc8zAH3+kAfgGyRH8/ZgG1Wvo+K5eT49l9js3
	 eYsq1A5qLSDwIv1XYtTm15eQqR3YBodPY/ekK1Gg+k3dXRkLiEDL++6tUZbTvoPwS/
	 6XUHaeRbHQpNQwo9OrKXKeMDjcC9gsXiHsQhzATdIoASnN0/6tjMUziUs9vfR8AZ57
	 nqXSsr8nrfQvqaeH95lF8Rf8OaLn4U4/mRqyLy27I/wmgn2Qh210/EjpqaccQhF86s
	 ngdjXGPJfJmYf1B6/ObXOPyNExZ7HTEVNXGwm7aJi98L0lS7Ats1im99ng2rPL0pZK
	 uucDSSQRXGcyg==
Message-ID: <sashiko-outbox-208264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC bpf-next v3 2/3] bpf: Add PPPoE encap/decap kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: ThisSeanZhang <thisseanzhang@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261111032141.525444-3-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
 <20261111032141.525444-3-thisseanzhang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:11:23 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] bpf: stale skb->cb data pointers on bpf_skb_pppoe_encap() and
  decap() error
- [High] bpf: Signed-off-by trailer uses handle instead of real full
  name
- [Medium] bpf: missing skb_postpush_rcsum() in bpf_skb_pppoe_encap()
  corrupts csum
--

commit 41cc0bc50e47c52d87a2f024362b196725052585
Author: ThisSeanZhang <thisseanzhang@gmail.com>

> bpf: Add PPPoE encap/decap kfuncs
>
> Add bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap() kfuncs so that a
> TC BPF program can encapsulate an IPv4 or IPv6 packet into a PPPoE
> session frame, and decapsulate one again:
>
>         bpf_skb_pppoe_encap(skb, sid, flags);
>         bpf_skb_pppoe_decap(skb, flags);
>
> The kfuncs insert or remove the 8 byte PPPoE session header between
> the MAC header and the network header, and update the skb metadata to
> match: skb->protocol is set to ETH_P_PPP_SES on encapsulation, or
> restored from the PPP protocol field on decapsulation, mac_len is
> reset, and the GSO metadata is adjusted like bpf_skb_adjust_room()
> does (gso_size, gso_segs, SKB_GSO_DODGY).
>
> Both kfuncs accept BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size
> unchanged and only recompute gso_segs, reusing the existing flag
> instead of adding a new one; UDP GSO packets require it, as their
> gso_size is the datagram size. Unknown flags are rejected.
>
> Previously, a TC program could add or remove the header bytes
> manually, but the skb would keep a stale skb->protocol: forwarded GSO
> packets larger than the PPPoE MTU could not reach the PPPoE
> segmentation path registered for ETH_P_PPP_SES and could be dropped.
> bpf_skb_adjust_room() cannot be used for the decapsulation direction
> either, because it only accepts ETH_P_IP or ETH_P_IPV6 in
> skb->protocol.
>
> The encap kfunc fills in the PPPoE header itself from the session id:
> version 1, type 1, code 0, and the PPP protocol derived from
> skb->protocol, mirroring what pppoe_xmit() writes. The ethertype of
> the MAC header remains for the BPF program, like with the existing
> BPF_F_ADJ_ROOM_ENCAP_* flags. skb->encapsulation is deliberately left
> unset, like pppoe_xmit() does: PPPoE is not an IP tunnel, and setting
> it would narrow the device features to hw_enc_features in
> netif_skb_features(). The decap kfunc accepts only PPP_IP and PPP_IPV6
> payloads and requires a full inner L3 header to remain.
>
> The kfuncs are registered for SCHED_CLS and SCHED_ACT with the new
> KF_CHANGES_PKT flag, so the verifier invalidates packet pointers after
> a call, like it does for bpf_skb_adjust_room().
>
> PPPoE GRO/GSO support must be built in or loaded before this path is
> used; loading pppoe.ko is left to user space.
>
> Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>

[Severity: High]
The Signed-off-by trailer and Author header use a single-word handle
("ThisSeanZhang") rather than a full real name, which does not meet the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9245009d9f1eb..3d9143552f0d1 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> +__bpf_kfunc int bpf_skb_pppoe_encap(struct __sk_buff *skb_ctx, __be16 si=
d,
> +				    u64 flags)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	struct pppoe_hdr *ph;
> +	u16 ppp_proto;
> +	u32 off;
> +	int ret;
> +
> +	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
> +		return -EINVAL;
> +
> +	if (skb->protocol !=3D htons(ETH_P_IP) &&
> +	    skb->protocol !=3D htons(ETH_P_IPV6))
> +		return -ENOTSUPP;
> +
> +	if (skb->len + PPPOE_SES_HLEN > BPF_SKB_MAX_LEN && !skb_is_gso(skb))
> +		return -ENOTSUPP;
> +
> +	off =3D skb_mac_header_len(skb);
> +
> +	ret =3D bpf_skb_net_grow(skb, off, PPPOE_SES_HLEN, flags);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (skb->protocol =3D=3D htons(ETH_P_IP))
> +		ppp_proto =3D PPP_IP;
> +	else
> +		ppp_proto =3D PPP_IPV6;
> +
> +	ph =3D (struct pppoe_hdr *)(skb->data + off);
> +	ph->ver =3D 1;
> +	ph->type =3D 1;
> +	ph->code =3D 0;
> +	ph->sid =3D sid;
> +	ph->length =3D htons(skb->len - off - sizeof(*ph));
> +	put_unaligned_be16(ppp_proto, (u8 *)ph + sizeof(*ph));
> +
> +	skb->protocol =3D htons(ETH_P_PPP_SES);
> +	skb_reset_mac_len(skb);
> +	if (skb_valid_dst(skb))
> +		skb_dst_drop(skb);
> +
> +	__skb_reset_checksum_unnecessary(skb);
> +	bpf_compute_data_pointers(skb);
> +
> +	return 0;
> +}

[Severity: Medium]
Does writing the PPPoE header without calling
skb_postpush_rcsum(skb, ph, PPPOE_SES_HLEN) leave skb->csum stale on
CHECKSUM_COMPLETE packets?

bpf_skb_net_grow() -> bpf_skb_net_hdr_push() -> bpf_skb_generic_push()
zeroes the pushed 8 bytes and skips skb_postpush_rcsum() because zeroed
bytes do not change skb->csum, and __skb_reset_checksum_unnecessary() only
clears CHECKSUM_UNNECESSARY.  Writing non-zero PPPoE header fields at
skb_network_header(skb) without updating skb->csum corrupts the checksum on
ingress packets with hardware CHECKSUM_COMPLETE (and fails
BPF_PROG_TEST_RUN with BPF_F_TEST_SKB_CHECKSUM_COMPLETE), whereas
bpf_skb_pppoe_decap() and pppoe_rcv() subtract the 8-byte header from
skb->csum via skb_postpull_rcsum().

[ ... ]

> +__bpf_kfunc int bpf_skb_pppoe_decap(struct __sk_buff *skb_ctx, u64 flags)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	__be16 inner_proto;
> +	u32 inner_len, off;
> +	u16 ppp_proto;
> +	int ret;
> +
> +	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
> +		return -EINVAL;
> +
> +	if (skb->protocol !=3D htons(ETH_P_PPP_SES))
> +		return -ENOTSUPP;
> +
> +	off =3D skb_mac_header_len(skb);
> +
> +	if (skb->len < off + PPPOE_SES_HLEN)
> +		return -EINVAL;
> +
> +	if (!pskb_may_pull(skb, off + PPPOE_SES_HLEN))
> +		return -ENOMEM;
> +
> +	ppp_proto =3D get_unaligned_be16(skb->data + off +
> +				       sizeof(struct pppoe_hdr));
> +	switch (ppp_proto) {
> +	case PPP_IP:
> +		inner_proto =3D htons(ETH_P_IP);
> +		inner_len =3D sizeof(struct iphdr);
> +		break;
> +	case PPP_IPV6:
> +		inner_proto =3D htons(ETH_P_IPV6);
> +		inner_len =3D sizeof(struct ipv6hdr);
> +		break;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +
> +	/* A full inner L3 header must remain after decapsulation. */
> +	if (skb->len - off - PPPOE_SES_HLEN < inner_len)
> +		return -EINVAL;
> +
> +	ret =3D bpf_skb_net_shrink(skb, off, PPPOE_SES_HLEN, flags);
> +	if (ret < 0)
> +		return ret;

[Severity: High]
Can error returns in bpf_skb_pppoe_decap() and bpf_skb_pppoe_encap() leave
stale data_end and data_meta pointers in skb->cb after skb->head is
reallocated?

In bpf_skb_pppoe_decap(), pskb_may_pull() can reallocate skb->head via
pskb_expand_head() and free the old buffer when pulling bytes from
nonlinear fragments or expanding a cloned skb.  If ppp_proto is then
rejected as unsupported (for example, a PPP LCP/IPCP control frame),
inner_len is not met, or bpf_skb_net_shrink() fails, the function returns
without calling bpf_compute_data_pointers(skb).  Similarly, in
bpf_skb_pppoe_encap(), bpf_skb_net_grow() can reallocate skb->head in
skb_cow_head() and shift skb->data in bpf_skb_net_hdr_push() before failing
in pskb_may_pull() or skb_linearize().

Because TC programs read ctx->data from skb->data (now pointing to the new
buffer) while reading ctx->data_end and ctx->data_meta from skb->cb (still
pointing into the old freed buffer), a program that continues inspecting
the packet after an error return can pass verifier bounds checks and
trigger a kernel heap use-after-free or out-of-bounds access.  Calling
bpf_compute_data_pointers(skb) on the error paths after any potential
reallocation, as bpf_skb_adjust_room() does unconditionally, avoids leaving
dangling pointers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111032141.5254=
44-1-thisseanzhang@gmail.com?part=3D2

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842751;
	b=Q425RvtRL7AgofMtkyT+3UoeoBjBhj8YH6LMkWayZJspWw+OMipMQwalleRBt16rUpjO
	 qlzez10J6mKmEmISGu53ti5PUQaDuTr5R7MNALv1+HdN3X6qc9RZKkcQXTIW5hwXvJruH
	 xrRHYzzJAAD0pVkctWqHBihBkwWgv+vlHzHizxamC3sbcvQvdhwhvNLlexBIUfV0dcPw3
	 tYk84nPRw91I/VweFlknOni6Jy3ErHTWdM5G9VfjKIicgr/8iH9WQ2SFTIuNQxHt8eO0W
	 +VzwbwRly2lVzy1FAWpn24qEKy20oM6arpbW0iygCe7qiVKRIJ7htI6R10wdfV7Zl0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842751;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=coYmGyqn3W2sbPWx2GMfbYwCGxsifNHyu6iC/K2Vhz4=;
	b=f25zGdtCleFdT0jlsr5h4XnAWHSqrma1O3ZiAVUsLDsw11rXn7SGjgRZVliRizsStNTU
	 z4kKif1qJuNf7RttlcfGTc9a7ELj/Uu6ZhwppqjTyz7qwddh+fFLPSaWtTRlXDMbHYjqP
	 eR25Rq72C+FthGjyR0Km8CZQjm37CZCTmKH6Nw8yPLJ4qcbsKAKGTrGQGlzOu/2MQddc7
	 AO50S/4OjXj90DXjcake/0fVnsS1F4QT5gxmiy8qBFf0e9C38KJ4L6oLnHSCNUQE7+KSo
	 pWLHlTYYkWU7pmwpyXBTEOq5eunT3yvPi5pyYBUHVWs/BP+pgDInAAq/Levju0u5Jpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m69MbBCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED0606A882;
	Mon, 16 Nov 2026 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m69MbBCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB431F000C4;
	Mon, 16 Nov 2026 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842751;
	bh=coYmGyqn3W2sbPWx2GMfbYwCGxsifNHyu6iC/K2Vhz4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m69MbBCrYZ+1taSVT1fcOttETC+mWp9jOTimABeTKTtlavvNTArPbiOvXUbrhG3Kv
	 nFwKxLtKxWuOcGOBr8d0+mcOw8/Et0viNO7sc0X9M1iHEEOCjTu0LsMBFQVGrdK0lJ
	 Mb8mkSLT1OBzu+gbKPqvOeyHhJ1NboK/SCEdS4wY4q2nyiTo1BQ0W4QPX0g2Uwkd+h
	 OscGMSFqUBnig7ykZpctWM9wfbU5JofUE8N9RoNVlyFCJrYsKaUAJtw/xOty4+7jeq
	 bGkPIuF89PZqXsHRGGDHcWGqWcbXsXVgH9ANDsR5aZ4Msy2tz5h+Ifi8cgabLvTy1k
	 hrjDgmsCihdJQ==
Subject: Re: [PATCH net-next 1/3] tun: don't probe the transport header of
 packets written by userspace
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Date: Mon, 16 Nov 2026 15:25:49 +0000
Message-ID: <179484274982.3136.10527408814471189308@kernel.org>
In-Reply-To: <20261112150612.3866546-2-antonio@mandelbit.com>
References: <20261112150612.3866546-2-antonio@mandelbit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After the patch, a TAP packet that is neither GSO nor
  VIRTIO_NET_HDR_F_NEEDS_CSUM leaves tun_get_user() with…
- [Medium] On the default tun/tap receive path (no IFF_NAPI, so no GRO;
  delivery through tun_rx_batched()/netif_rx()), skb->transport_header…
- [Low] The patch removes skb_probe_transport_header() only from
  tun_get_user().

--

tun: don't probe the transport header of packets written by userspace

This commit removes the skb_probe_transport_header() call from
tun_get_user(). For NEEDS_CSUM and GSO packets it relies on
skb_partial_csum_set() and __virtio_net_hdr_to_skb() to set the transport
header, and for all other packets on the IPv4/IPv6 receive paths.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8920c797acfd7..9fc60a73fb963 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1960,7 +1960,6 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		net_zcopy_complete(NULL, msg_control, false);
>  
>  	skb_reset_network_header(skb);
> -	skb_probe_transport_header(skb);
>  	skb_record_rx_queue(skb, tfile->queue_index);
>  
>  	if (skb_xdp) {

[Severity: Medium]
Without the probe, a TAP frame that is neither GSO nor
VIRTIO_NET_HDR_F_NEEDS_CSUM reaches tun's own do_xdp_generic() call with
transport_header still at the unset value (~0). This happens before
__netif_receive_skb_core() gets a chance to reset it.

Can the generic XDP copy path turn that sentinel into an offset that looks
valid but is wrong?

skb_xdp starts at 1 in tun_get_user(). It stays 1 for blocking, zerocopy,
large and IFF_NAPI_FRAGS writes, because tun_can_build_skb() rejects those.
These skbs come from tun_alloc_skb() with only tun->align of headroom, or
they are nonlinear, so they always take this branch:

net/core/dev.c:netif_receive_generic_xdp() {
    ...
	if (skb_cloned(skb) || skb_is_nonlinear(skb) ||
	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
		if (netif_skb_check_for_xdp(pskb, xdp_prog))
    ...
}

That branch reallocates through skb_pp_cow_data() or pskb_expand_head().
Both of them end up here:

net/core/skbuff.c:skb_headers_offset_update() {
    ...
	skb->transport_header += off;
	skb->network_header   += off;
	if (skb_mac_header_was_set(skb))
		skb->mac_header += off;
    ...
}

Only mac_header gets a was_set check. 0xffff + off wraps in the u16 to
off - 1, which points into the new uninitialized headroom just before
skb->data. Because of that, skb_transport_header_was_set() returns true,
and the fallback in __netif_receive_skb_core() is skipped:

	if (!skb_transport_header_was_set(skb))
		skb_reset_transport_header(skb);

Anything that runs before L3 would then see this offset: tc ingress,
bridge or OVS forwarding into another device's xmit path, and
XDP_TX/XDP_REDIRECT through generic_xdp_tx(). ip_rcv_core() and ipv6_rcv()
overwrite it, so locally delivered IP traffic is not affected.

Before this patch, skb_probe_transport_header() had already set a valid L4
offset for dissectable IPv4/IPv6 frames, so the reallocation shifted a
valid value.

The missing sentinel check in skb_headers_offset_update() is older than
this patch. However, this patch exposes all well-formed tun frames to it,
not only the ones the dissector rejected. The commit message says these
packets are handled "as for packets from NICs". For NICs in non-DEBUG_NET
builds, __netif_receive_skb_core() resets the transport header before
generic XDP runs, and this tun-local XDP path skips that reset.

[Severity: Medium]
On the default receive path (no IFF_NAPI, delivery through
tun_rx_batched() or netif_rx()), will tc ematches that use layer transport
on a tun/tap ingress still match?

For non-GSO, non-NEEDS_CSUM packets, nothing sets the L4 offset before
__netif_receive_skb_core() anymore. In non-DEBUG_NET builds that function
resets transport_header to the network header before tc ingress runs. With
CONFIG_DEBUG_NET the reset is compiled out and the header stays unset.

em_cmp, em_nbyte and em_text get their base pointer from here:

include/net/pkt_cls.h:tcf_get_base_ptr() {
    ...
		case TCF_LAYER_TRANSPORT:
			if (!skb_transport_header_was_set(skb))
				break;
			return skb_transport_header(skb);
    ...
}

Take an existing filter like "cmp(u16 at 2 layer transport eq 80)". It
used to match the destination port. Now it would compare bytes of the IP
header, or never match at all on DEBUG_NET builds.

ip_rcv_core() and ipv6_rcv() only set the transport header after tc
ingress and bridge handling, so the commit message's "the IPv4/IPv6
receive paths set it" doesn't cover these users.

tun_xdp_one() still probes, so the same filter now classifies a packet
differently depending on whether it came in through write()/sendmsg or
vhost-net batched TX.

[Severity: Low]
Should tun_xdp_one() get the same change? It still has the probe:

drivers/net/tun.c:tun_xdp_one() {
    ...
	skb->protocol = eth_type_trans(skb, tun->dev);
	skb_reset_network_header(skb);
	skb_probe_transport_header(skb);
	skb_record_rx_queue(skb, tfile->queue_index);
    ...
}

That path also carries packets written by userspace: vhost-net batched
guest TX goes through tun_sendmsg() with TUN_MSG_PTR. It builds the skb the
same way and delivers it through netif_receive_skb() or the NAPI queue.
The argument for dropping the probe applies to it unchanged.

The subject says the probe is dropped for "packets written by userspace",
but the vhost-net batched path keeps it. The two receive paths of one tun
device now also set up the transport header differently. If this is
intentional, could the commit message mention it and give the reason?

The tap.c call sites in tap_get_user() and tap_get_user_xdp() are a
different case. Those packets go to dev_queue_xmit() on the lower device,
so the receive-path reasoning doesn't apply to them.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112150612.3866546-1-antonio%40mandelbit.com

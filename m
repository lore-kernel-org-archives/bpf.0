Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66C175A88;
	Mon,  7 Sep 2026 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754759; cv=none; b=S5FeIbCQlu6mAxD2rLhiuk7jmwJOQWAV4EtWzatm+6EMsd6870xbSoyiHita5k1Kk1xAjpKNhzNMq9pEvDcvGZRm6iijDC5kkPIgivGGTGSyothEGCLs5e1tsb8HQtokIay6i3abQkcvdog4ssKMtQlpQKBJRyF4FGk2b3o9fBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754759; c=relaxed/simple;
	bh=X7ob50GxsNExlRtO7+47oH5e56mIhItSu+x/ruMqFbM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KrzOA0PZyRL+u7PY7MxezmzqlwJ17AUunG6pDCVEQZmWh8BkaDRsso1S2YhFkkuCikOOmBHUB5ztwFkO/KZXhRVqkS5NwAgIF4PEvlzAz1/Y8hzuNdfaGKsNhKncly1T21baSi0CiA8O41QP6/p/xubZJBIFwsRYVU8gE5ybHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEN1lb2O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEN1lb2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C77F1F00A3A;
	Mon,  7 Sep 2026 04:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754757;
	bh=K73ocyhwjn+UzyzamrDuns2cfSQvyqrmg3JzSe/5iOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UEN1lb2OGLYZzAAD/BLGoBPglAi33vvN8oYJcOgTkAA3E8GpGMA664y/Owa6alSZM
	 WeoFGBdy6IPGGAGaKXpu/ImWPh+WxZ+7Txg721ZrMdR8SzHogDGmlpS4Pqu5WCxMT7
	 tn4jyqM0r9EF8d63zS64/LvEYlk/FNu1IIxDmH2MPL+rmgMQHJq9x39QoW1DYx0O+/
	 PBeQ4QMFwEsImmyKeIEk2Zn6CI5XzM44/Me5UExk98TtS9pjWsWFVLPsslcqUR4/nV
	 QGQ7sRK/ew1JCnjg/vMUVGaFJC9xVpH+gw5F9WDHyekxCMplEVgqEMOJ0E9s+G8tRW
	 dIv+jFF1uvmBg==
Subject: Re: [PATCH net v3] xsk: set network header on skb at generic transmit
From: netdev-bot+sashiko@kernel.org
To: kerneljasonxing@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com
Date: Mon, 07 Sep 2026 04:19:15 +0000
Message-ID: <178875475592.219967.3353530907347334836@kernel.org>
In-Reply-To: <20260902121028.74092-1-kerneljasonxing@gmail.com>
References: <20260902121028.74092-1-kerneljasonxing@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] net/xdp/xsk.c: xsk_skb_init_misc() (line 950) now does
  skb_reset_network_header(skb) unconditionally, i.e. it declares the…
- [Medium] By making skb_network_offset() valid (0), the patch makes
  tunnel ndo_start_xmit paths that were previously *always* rejected…

--

xsk: set network header on skb at generic transmit

This adds skb_reset_network_header() to xsk_skb_init_misc() so that
skb_network_offset() no longer returns -hr for skbs built by the XSK
generic transmit path.  The negative offset was promoted to unsigned in
pskb_may_pull_reason() and tripped the DEBUG_NET_WARN_ON_ONCE(len >
INT_MAX) check when such an skb reached a tunnel xmit routine.

Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
Link: https://lore.kernel.org/all/20260901083325.3445-1-kerneljasonxing@gmail.com/
Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..2077bb6299ca9 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  {
>  	int err;
>  
> +	skb_reset_network_header(skb);
> +

[Severity: Medium]
The changelog says:

    AF_PACKET only cares about the boundary because it can cook an L2 header
    itself (SOCK_DGRAM) and supports GSO/checksum offload; none of that
    applies here, where the frame is sent as-is via __dev_direct_xmit().

Is the checksum offload part of that accurate?  xsk_skb_metadata(), in this
same generic xmit path, does:

net/xdp/xsk.c:xsk_skb_metadata() {
	...
		skb->csum_start = hr + csum_start;
		skb->csum_offset = csum_offset;
		skb->ip_summed = CHECKSUM_PARTIAL;

		if (unlikely(pool->tx_sw_csum)) {
			err = skb_checksum_help(skb);
	...
}

So when the descriptor carries XDP_TX_METADATA with
XDP_TXMD_FLAGS_CHECKSUM and pool->tx_sw_csum is clear, the skb is handed to
the driver with CHECKSUM_PARTIAL, and hardware checksum offload does apply
to AF_XDP generic xmit.

With network_header now anchored at skb->data, on an ARPHRD_ETHER device
that offset points at the userspace-supplied struct ethhdr rather than the
L3 boundary, so skb_network_offset() is 0 where the drivers expect
ETH_HLEN.  Drivers derive descriptor geometry from it:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
	...
	vlan_macip_lens = skb_checksum_start_offset(skb) -
			  skb_network_offset(skb);
no_csum:
	vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
	...
}

That programs MACLEN as 0 and an L3 length that is ETH_HLEN too large
(igb_tx_csum() is the same shape, and i40e_tx_enable_csum() sets ip.hdr =
skb_network_header(skb) and then reads ip.v4->version, which now inspects
the destination MAC bytes).

For comparison, the AF_PACKET complete-frame path anchors both headers:

net/packet/af_packet.c:packet_parse_headers() {
	...
	/* On TX skb->data is the L2 header; anchor it for all socket types. */
	skb_reset_mac_header(skb);
	...
		skb_set_network_header(skb, depth);
	...
}

Could the changelog either drop the checksum offload claim and document the
remaining descriptor inaccuracy, or could the network header be set to the
real L3 boundary (mac header plus dev->hard_header_len / VLAN depth, or
consistently with csum_start when XDP_TXMD_FLAGS_CHECKSUM is requested)?
Note the pre-patch offset of -hr was worse, so this is not a regression
relative to current behaviour, but the value chosen is wrong for every
ARPHRD_ETHER device.

[Severity: Medium]
Does making skb_network_offset() valid also newly admit AF_XDP frames into
tunnel xmit code that parses the inner L2 header without any length check?

Before this change, erspan_xmit() dropped every AF_XDP skb at its first
statement, because pskb_inet_may_pull() -> pskb_network_may_pull_reason()
computed (unsigned)(-hr) + nhlen and failed the len > skb->len test:

net/ipv4/ip_gre.c:erspan_xmit() {
	...
	if (!pskb_inet_may_pull(skb))
		goto free_skb;
	...
}

skb->protocol is never assigned in net/xdp/xsk.c, so nhlen is 0 and after
this patch pskb_may_pull_reason(skb, 0) succeeds and the frame reaches
erspan_build_header() / erspan_build_header_v2():

include/net/erspan.h:erspan_build_header() {
	...
	tos = is_ipv4 ? ip_hdr(skb)->tos : ...
	if (eth->h_proto == htons(ETH_P_8021Q)) {
		qp = (struct qtag_prefix *)(skb->data + 2 * ETH_ALEN);
		vlan_tci = ntohs(qp->tci);
	...
}

Those read skb->data[1], skb->data[12..13] and skb->data[14..15] with no
validation, and the results end up in the transmitted header via
ershdr->cos = tos_to_cos(tos) and set_vlan(ershdr, vlan_tci).

Is there anything in the AF_XDP path that guarantees the frame is at least
16 bytes long?  Descriptor validation only rejects zero length:

net/xdp/xsk_queue.h:xp_aligned_validate_desc() {
	...
	if (!len)
		return false;
	...
}

and neither __xsk_generic_xmit() nor __dev_direct_xmit() enforces
dev->hard_header_len, unlike AF_PACKET:

net/packet/af_packet.c:packet_snd() {
	...
	if ((sock->type == SOCK_RAW &&
	     !dev_validate_header(dev, skb->data, len)) || !skb->len) {
		err = -EINVAL;
	...
}

For a descriptor with len between 1 and 15 those offsets are past skb->len
inside the non-zeroed head from sock_alloc_send_skb(hr + len + tr), so can
this copy a couple of bytes of uninitialized slab memory into the packet on
the wire (and produce a KMSAN use-of-uninitialized-value report)?  The
"complete, opaque blob from userspace" premise in the changelog is what
opens this, since nothing checks that the frame contains the device's link
layer header.

An approximately equivalent primitive already exists via AF_PACKET SOCK_RAW
with a 14-byte frame on the same device, so this mainly exposes the shorter
frame variant.  Would a minimum length or header check for AF_XDP generic
xmit be appropriate here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902121028.74092-1-kerneljasonxing%40gmail.com

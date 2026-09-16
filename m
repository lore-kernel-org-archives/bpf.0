Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3627501F4C;
	Wed, 16 Sep 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601758; cv=none; b=VfX6QlW3vf6M8O63k7jLp+/hYId+a9ybcoocLpnS6ptEEoHPBKOJi2YG4TQO3OxN0m8yOnvIBOzpLALQBLrLZSDRkWrcJSCeirf3r4fBeLm1W0bdz7++7Jh4ZqEg0KNWQ9mOzwXFNjhofFt/Lr4BLg2kl0QfVsJRjejaiymNWio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601758; c=relaxed/simple;
	bh=waA6Lph0lqXdrjxRNRmRj0+kTBpy90YvL8nCToEGt7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kTxxDJGtd1gC2LTlfE7RUNZLYVkVK825Md0hAKeQkwlfP3VSVLkcC4Qd+rIc1ul4ApKLLQWgpu9DdZ0PU9tfZKWN4gFrwF/SUdZCL0aHfZ81465xtS1LnnUuV70Hr2+4AU6v/j4bbQTL/A4XTsA93McJ76F+Plmr9saall0Fsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrlRer7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrlRer7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB321F000FF;
	Wed, 16 Sep 2026 23:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601757;
	bh=q2wTc0RNzc1mK+ms4Qo5GzhVrckM5yR9LNTGQMT3HdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NrlRer7pmwLgVXmXOkqTA3O1Qqh1R+wn67FjEhfJajGo70y2zI8o/Osxen79f8+hi
	 cX51dpfnYBo5yPQP+TZ9ElRuDx2fuBfiSHQneBn9gi+lbup36eOmjibUc9FRnjRENr
	 CBz6fdsMkjEPI8BahfcaJplAzNmALaUPSa7NhXhaEdj0MFseNCR5nlZs9SqJzY7Y/c
	 ZxakesoDug62hb+YRaQ7H0B2OFweod8sCgTE5qV1Y5OvIf14g468Oix8SH7aw0njhe
	 PuPsapCcyjtbfmEu/oPwhLJRJlDpXCtncWYMtToO8oRdhNle4ZP6JObpHoV0EmJMJT
	 PYaz3iWZhF/Pg==
Subject: Re: [PATCH v3 net 4/7] net: enetc: pad short frames in software
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:35:55 +0000
Message-ID: <178960175550.22033.10648880872141935672@kernel.org>
In-Reply-To: <20260915222735.1016937-5-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-5-vladimir.oltean@nxp.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0 (1)

- [High] enetc_xmit() (drivers/net/ethernet/freescale/enetc/enetc.c:1090)
  calls eth_skb_pad(skb) unconditionally, i.e. also for GSO skbs.

Pre-existing issues:
- [Low] Incomplete enforcement of the 16-byte TX BD minimum: at this
  commit the new ENETC_MIN_BUFF_SIZE check exists only in enetc_xmit()…

--

net: enetc: pad short frames in software

ENETC hardware rejects TX buffer descriptors whose FRM_LEN or first
BUFF_LEN is below 16 bytes, which leaves the TX ring consumer index
stuck and amplifies into an MSI-X interrupt storm. The patch linearizes
skbs with a short head and pads anything shorter than ETH_ZLEN in
enetc_xmit().

Closes: https://lore.kernel.org/netdev/b3d9136c-2803-4203-b1ea-1f9e62de80a1@gmail.com/

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 0216f7d08e197..bbad942041f5a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1077,6 +1077,19 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	u8 udp, msgtype, twostep;
>  	u16 offset1, offset2;
>  
> +	/* Hardware does not support transmit buffer descriptors with a total
> +	 * length of less than 16 bytes, or a first buffer size of less than
> +	 * 16 bytes.
> +	 */
> +	if (unlikely(skb_headlen(skb) < ENETC_MIN_BUFF_SIZE &&
> +		     skb_linearize(skb))) {
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +
> +	if (eth_skb_pad(skb))
> +		return NETDEV_TX_OK;

[Severity: High]
Should the pad be skipped for GSO skbs?

enetc advertises NETIF_F_GSO_UDP_L4 in enetc_pf_common.c and enetc_vf.c,
so a UDP segmentation skb reaches ndo_start_xmit still unsegmented, and
such an skb can have skb->len < ETH_ZLEN. udp_send_skb() marks the skb
SKB_GSO_UDP_L4 whenever datalen > cork->gso_size, and UDP_SEGMENT accepts
any value in 0..USHRT_MAX:

net/ipv4/udp.c:udp_send_skb() {
    ...
	if (datalen > cork->gso_size) {
		skb_shinfo(skb)->gso_size = cork->gso_size;
		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
    ...
}

With UDP_SEGMENT=1 and a 2-byte sendmsg(), skb->len is 14 + 20 + 8 + 2 =
44 with gso_size 1 and gso_segs 2. eth_skb_pad() -> skb_put_padto(skb,
ETH_ZLEN) then appends 16 zero bytes and sets skb->len to 60, but leaves
gso_size and gso_segs alone.

The skb is still GSO, so enetc_start_xmit() takes the skb_is_gso() branch,
and both segmentation back-ends derive the payload length from skb->len:

drivers/net/ethernet/freescale/enetc/enetc.c:enetc_lso_start() {
	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
    ...
	lso->total_len = skb->len - lso->hdr_len;
}

drivers/net/ethernet/freescale/enetc/enetc.c:enetc_map_tx_tso_buffs() {
	hdr_len = tso_start(skb, &tso);
	total_len = skb->len - hdr_len;
    ...
		data_len = min_t(int, skb_shinfo(skb)->gso_size, total_len);
}

Does that make the hardware LSO engine and the software TSO loop segment
18 bytes instead of 2, putting 18 one-byte UDP datagrams on the wire, 16
of them made up of pad zeros? tso_build_hdr() rewrites IP tot_len and UDP
len per segment, so the extra datagrams would look well formed to the
receiver, and nothing is reported back to the sender.

The software TSO path always emits header and data BDs of at least
hdr_len bytes, so the 16-byte first-BD and frame-length limits do not seem
to apply to GSO skbs. Would guarding the pad with !skb_is_gso(skb) work
here? This is still present at the end of the series (381447d90b1f), where
the pad in enetc_xmit() remains unconditional.

[Severity: Low]
This isn't a bug introduced by this patch, but the 16-byte minimum is
only enforced on the skb path here, while the XDP descriptor producers
still program the BD length verbatim:

enetc_xdp_xmit() -> enetc_xdp_frame_to_xdp_tx_swbd() {
	int len = xdp_frame->len;
    ...
	xdp_tx_swbd->len = len;
}

enetc_xdp_map_tx_buff() {
	txbd->buf_len = cpu_to_le16(tx_swbd->len);
	txbd->frm_len = cpu_to_le16(frm_len);
}

Can an XDP_REDIRECT of a 14 or 15-byte frame into ndo_xdp_xmit still
program an illegal first BD and reproduce the stuck TBaCIR / TBaSR[BUSY]
condition and the MSI-X re-arm storm described in the commit message?
bpf_xdp_adjust_tail() only enforces an ETH_HLEN floor.

The XDP_TX case does not look affected, since
enetc_rx_swbd_to_xdp_tx_swbd() copies rx_swbd->len, i.e. the length
recorded at reception.

This gap is closed by the next patch in the same series, "net: enetc: pad
short XDP frames coming from devmap", which adds the check in
enetc_xdp_xmit():

		if (unlikely(xdp_frame_pad(xdpf) ||
			     xdpf->len < ENETC_MIN_BUFF_SIZE)) {
			tx_ring->stats.xdp_tx_drops++;
			break;
		}

so nothing remains at the end of the series (381447d90b1f); the
underlying XDP exposure predates this patch (the follow-up carries Fixes:
9d2b68cc108d, "net: enetc: add support for XDP_REDIRECT"). Would it be
worth ordering the XDP patch first so the bisect window does not contain a
tree where only half of the constraint is enforced?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com

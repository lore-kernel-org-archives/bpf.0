Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD851FCB0;
	Wed, 16 Sep 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601762; cv=none; b=SlIdr0djygciZ5M0i+TpNM2pmhnzlAeIqtlhcKs6u1mg97ANxfLyLIJB+4FIOPTn5sa9kUw0gkpd1+7DDJBoALh0HRDpoavJTbcvE6DFCWAgpbsJP/f4naARnpW6n+v5kuoSou0Kwib1S7UN/IZ8UGlvSc3rr9xzOa8zqH2hx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601762; c=relaxed/simple;
	bh=UC6M/GEz2+eoJdqcXM/aaW1hRRaiUfLPoS/3oYDGLoo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jLFXtTDMS4YcH2Z/uZ/BjNcqfIMq6mF5BZUXb/+vYJsCPuTbQ+g/FQQQNdp9FKs9AbZh5W21TnF4mmAajpH22vOLO9UdYVb8GJf6zuSqOhPyNx7jeB4EeLJ457S29iqcSGeARQornkmm+WUXa1kxDCbpsdlW/7A6FMNW5UXjEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYO0q92s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYO0q92s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8384B1F000FF;
	Wed, 16 Sep 2026 23:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789601760;
	bh=PVoQFgUZBqQLCmcKfUWQh7apP0vLMdnb/4fqKzIs35o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aYO0q92sRvjsxsA/VvFiZj6AaGfz3oGiEntLrplttSNvqw6oabLiY8HB0zSmTeR4H
	 6A2YORRxngWf9mHpghaVsWkBmlAioMLvf6cRGi2nvm1vTlPi6H26HSx331fqlFBw8L
	 lkv3IuA4k8Rfj6wsVndZvw0EhAOd/NqfV9Ic8K84q0OIUYIvaHfVTQVuYAPxTnI1pa
	 ooGivuAvERXm5XxMhE6ymamO6t9PxjcoSY7vALMLdul+V4h7o62Bw1q4zgKfY8PdvP
	 S0yRoZgLOC8OwyGwon33RajuxLd+iOc/zgE8fEPDdAJTWEa8mPZxgeWbpUvD+/7J6w
	 EE4d2eiDNTApw==
Subject: Re: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with
 one-step TX timestamping
From: netdev-bot+sashiko@kernel.org
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, zefir.kurtisi@westermo.com, claudiu.manoil@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, horms@kernel.org,
 richardcochran@gmail.com, yangbo.lu@nxp.com, ioana.ciornei@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 16 Sep 2026 23:35:59 +0000
Message-ID: <178960175909.22033.583659760655482183@kernel.org>
In-Reply-To: <20260915222735.1016937-7-vladimir.oltean@nxp.com>
References: <20260915222735.1016937-7-vladimir.oltean@nxp.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] Incomplete fix / commit-message mismatch in enetc_xmit(): the
  patch adds plain skb_linearize() where skb_linearize_cow() is required.

Pre-existing issues:
- [Medium] Speculative / discarded as a pre-existing Medium: the 10-byte
  originTimestamp write in enetc_update_ptp_sync_msg() (enetc.c:336-338,…

--

net: enetc: linearize PTP event packets with one-step TX timestamping

The patch adds a linearization step in enetc_xmit() before
enetc_ptp_parse() is called for packets requesting one-step Sync TX
timestamping, so that ptp_parse_header() sees a linear header and so that
the later in-place write of originTimestamp operates on a buffer the
driver owns.

Link: https://sashiko.dev/#/patchset/20260401172246.1075883-1-vladimir.oltean%40nxp.com

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 8a9ba168eab1e..62cdcaab3f3fb 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1099,6 +1099,11 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct net_device *ndev)
>  
>  	/* Fall back to two-step timestamp if not one-step Sync packet */
>  	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		if (unlikely(skb_linearize(skb))) {
> +			dev_kfree_skb_any(skb);
> +			return NETDEV_TX_OK;
> +		}
> +

[Severity: High]
The commit message says:

    Actually skb_linearize_cow() kills both birds with one stone, as it
    ensures the skb is linear and writable.

and the v2->v3 changelog says "replace skb_linearize() with
skb_linearize_cow()", but the code added here calls skb_linearize().
Was the intended helper missed in this respin?

The two helpers differ exactly in the clone test:

include/linux/skbuff.h
    static inline int skb_linearize(struct sk_buff *skb)
    {
        return skb_is_nonlinear(skb) ? __skb_linearize(skb) : 0;
    }

    static inline int skb_linearize_cow(struct sk_buff *skb)
    {
        return skb_is_nonlinear(skb) || skb_cloned(skb) ?
               __skb_linearize(skb) : 0;
    }

So for an skb that is already linear but cloned, skb_linearize() returns 0
without doing anything, ENETC_F_TX_ONESTEP_SYNC_TSTAMP stays set, and the
packet reaches the write path:

enetc_start_xmit() -> enetc_map_tx_buffs() -> enetc_update_ptp_sync_msg()

where enetc_update_ptp_sync_msg() stores into the shared head buffer:

    *(__be16 *)(data + tstamp_off) = new_sec_h;
    *(__be32 *)(data + tstamp_off + 2) = new_sec_l;
    *(__be32 *)(data + tstamp_off + 6) = new_nsec;

and, in the UDP path without checksum offload, also rewrites
udp_hdr(skb)->check via inet_proto_csum_replace*().

Linear clones of a TX skb are ordinary: dev_queue_xmit_nit() does
skb_clone() for every AF_PACKET tap (tcpdump) before ndo_start_xmit(), and
tc mirred, bonding and team clone as well. With a tap running on the enetc
port, can these stores corrupt the frame bytes seen by the other holder of
the same data area, given that Documentation/networking/driver.rst states
"An ndo_start_xmit method must not modify the shared parts of a cloned
SKB"?

If skb_linearize_cow() is used instead, the clone case takes
__skb_linearize() and the write-side half of the problem described in the
commit message is covered too.

>  		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>  				    &offset1, &offset2) ||
>  		    msgtype != PTP_MSGTYPE_SYNC || twostep != 0) {

[Severity: Medium]
This is a pre-existing issue and not something this patch introduces, but
while looking at this acceptance test: is the length of the Sync message
body checked anywhere before the 10-byte originTimestamp write?

enetc_ptp_parse() computes the body offset as the byte just past the common
header:

    *body_offset = (u8 *)hdr + sizeof(struct ptp_header) - base;

and ptp_parse_header() only validates the common header:

net/core/ptp_classifier.c:ptp_parse_header() {
    ...
	/* Ensure that the entire header is present in this packet. */
	if (ptr + sizeof(struct ptp_header) > skb->data + skb->len)
		return NULL;
    ...
}

A UDP-encapsulated frame that ends exactly at the end of the PTP header
(14 + 20 + 8 + 34 = 76 bytes for IPv4, so above ETH_ZLEN and not padded by
eth_skb_pad()) passes ptp_classify_raw() and ptp_parse_header(), has
msgtype == PTP_MSGTYPE_SYNC and twostep == 0, and then
enetc_update_ptp_sync_msg() reads and writes bytes at
data + origin_tstamp_off .. + 9, past skb->len.

Note this appears to land in the skb's own unused tailroom for frames in
that 76..85 byte range, since __alloc_skb() rounds the allocation up, and
dma_map_single() uses skb_headlen(), so no case where the write crosses
skb->end into skb_shared_info was constructed; the visible effect is a
bogus UDP checksum on an already malformed frame. A body length check in
enetc_ptp_parse() before accepting the packet for one-step processing would
make this explicit.

>  			enetc_cb->flag = ENETC_F_TX_TSTAMP;
>  		} else {

Checked that no later commit in this series changes the added call; the
only other enetc change is the cancel_work_sync()/skb_queue_purge() hunk in
enetc_stop().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915222735.1016937-1-vladimir.oltean%40nxp.com

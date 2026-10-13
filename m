Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F54FD294;
	Tue, 13 Oct 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893138; cv=none; b=NtuRzfIy46DpBNTcn8T9osgLfn0lMH7GRxl6DoOA7KPhGMTZ6GI0rjPbVQeuUT+AYjnq+n/aAZQnYcBzbfKFXqG5nJ6fKxhIpGo5/WaVhFuwFODNerWDIKDUTq7baeArJvJtD9wpQOnc6yhW+hLKOKYjNKpzuHDdyBGwaMdAy3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893138; c=relaxed/simple;
	bh=RDMRTrW0f3C3n6sfr4GOtlMFWKPHFCkzDNSTMcYfzBA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HuzHBzXE97svt4uMJqxLwdsPa92KXqJVxcZRmsQmPcffmXgLOOAmMsnENgZjTVXno5C5CEAULEVsswGp/JyudWpGJV4df8a5SX8VTL/bPwagXqa+JAk5kw4y+NHPGHo0atQDS90+QSww5n7OxXkJcFQ6FWOo5c0VtqWaMNqUOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYUCUYBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYUCUYBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44081F000FF;
	Tue, 13 Oct 2026 12:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791893136;
	bh=eLuxRn0HI2+L+S6CnDQ4l8LJp0sYjVvvTXXp9+IBAHo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UYUCUYBuiyIaDPFtO253R/aGLmOqURdE9bx4Xmeo1IwU7pyr7f4mZy3waipQkeLq/
	 P02AKQBdjt9YhjniVh2YTLHsid5FRMGZMnFFM55Kebr/cm9w8HKONzxyJf1T1B2OeC
	 2gQ13mS8/xAyrBJwoxvSujWXqNKJ/w2YdCWXOQvNtX5m8BMPwo59louhBkl22ijTGr
	 ChosmSQtL38e8ayWUX0zBTCsz+ni6qxPuajw3nsC0n0wP7fEPS6HNb+x+pNwdinVnn
	 /sf8hoXfBa7j43AEvTkChC+7f3E/SMyAPw+flSv+r/518az5eHXiBaHDrH5kgy2JzU
	 dY+oou8JXsueA==
Subject: Re: [PATCH net-next v2 2/4] eth: mpnic: report per-queue stats
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, edumazet@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 12:05:35 +0000
Message-ID: <179189313526.434549.10762925482009523771@kernel.org>
In-Reply-To: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
References: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch reports the RCQ `rcq.packets` and `rcq.bytes`
  counters as the netdev qstats `rx-packets` and `rx-bytes` attributes.

--

eth: mpnic: report per-queue stats

This commit exposes the per-ring packet and byte counters through the
netdev queue stats API. Counters for deactivated rings are reported
through the base stats.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> index 5164475a0f943..c2f4a326a8f0f 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c

[ ... ]

> @@ -146,6 +147,77 @@ static const struct net_device_ops mpnic_netdev_ops = {
>  	.ndo_get_stats64	= mpnic_get_stats64,
>  };
>  
> +static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
> +				     struct netdev_queue_stats_rx *rx)
> +{
> +	struct mpnic_net *mpn = netdev_priv(dev);
> +	struct mpnic_ring *rxr = mpn->rx[idx];
> +	struct mpnic_queue_stats *stats;
> +	unsigned int start;
> +	u64 bytes, packets;
> +
> +	if (!rxr)
> +		return;
> +
> +	stats = &rxr->stats;
> +	do {
> +		start = u64_stats_fetch_begin(&stats->syncp);
> +		bytes = u64_stats_read(&stats->rcq.bytes);
> +		packets = u64_stats_read(&stats->rcq.packets);
> +	} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +	rx->bytes = bytes;
> +	rx->packets = packets;
> +}

[Severity: Medium]
Do rcq.packets and rcq.bytes match the qstats meaning of rx-packets and
rx-bytes?

The netdev.yaml spec defines rx-packets as "Number of wire packets
successfully received and passed to the stack". It defines rx-bytes as
"Successfully received bytes, see rx-packets".

In mpnic_clean_rcq() in mpnic_txrx.c, packets++ runs for every META
completion, including completions where the driver drops the packet:

drivers/net/ethernet/meta/mpnic/mpnic_txrx.c:mpnic_clean_rcq() {
    ...
			if (likely(!(rcd &
				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
				   !state->pkt.add_frag_failed)) {
				bytes += xdp_get_buff_len(&state->pkt.buff);
				skb = xdp_build_skb_from_buff(&state->pkt.buff);
			}

			if (likely(skb)) {
				napi_gro_receive(&nv->napi, skb);
			} else {
				mpnic_put_pkt_buff(&state->pkt, true);
				if (rcd & MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK)
					errors++;
				else
					dropped++;
			}

			state->pkt.buff.data_hard_start = NULL;
			packets++;
    ...
	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
    ...
}

Only errors are subtracted from packets. If add_frag_failed is set, or if
xdp_build_skb_from_buff() returns NULL, the packet is counted in dropped
and also in rx-packets.

The buffer length is also added to bytes before xdp_build_skb_from_buff()
runs. A failed skb build therefore still counts toward rx-bytes. An
add_frag_failed drop adds to packets but not to bytes, so the two
counters also disagree with each other.

mpnic_get_base_stats() reports the same values once
mpnic_aggregate_ring_rcq_counters() folds them into base->rx. The
miscount carries over after a ring is deactivated.

fbnic_clean_rcq() handles this by jumping to next_dont_count for dropped
packets, so they are counted in neither packets nor bytes. Could mpnic
do the same?

The counter semantics come from "eth: mpnic: count packets, bytes, and
drops per ring" earlier in this series. This patch is the one that
exposes them as qstats rx-packets and rx-bytes.

The later patch "eth: mpnic: count Rx allocation failures" also counts
skb build failures in alloc_failed. Those packets still stay in packets
and bytes.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-mpnic-counters3-v2-0-8afba81c2d5a%40gmail.com

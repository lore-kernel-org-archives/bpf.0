Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935B47AF65;
	Tue, 13 Oct 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893136; cv=none; b=UYrvnT9M1wO4mpZ8A8kpm8/JV9JwX/iP+ApDhHsb/RiQ6Sr3l2/aGZCZedunzk0HU00GuAaI2TLOq7uCwrWlt5LZHH6wqJflTlDINU+xUsfRvhWLzutRxnKoT6lKuIFrBXCpkPLstbPAXlIH9jSLQM+/Nm6MB6ZrQsIcoOdbe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893136; c=relaxed/simple;
	bh=PQ4II6nhtBvPDJ+3q4JAD1E8iUcjUCLSom5R1zpySmQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=umhp9a2bbEP00NNw5cLxfzcnAQVYiK7w83Q47krWWyrXH72tFwby7tnR7rZYG0Plti01S5G/rX3NEjkh9mqdkbX+RbaZZU/dMmO2rJSUC3iyxVW3BptmrHsvr9quOkmA115xsYTi89BImbtX4uDnxqYjXwgr5Eo6Oe6VvdJEIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luYjmTN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luYjmTN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBED1F00893;
	Tue, 13 Oct 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791893135;
	bh=qW5uF1ewgX9X0O+/dnLHI3k9D2+B1xbRg9LE/7VgIaU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=luYjmTN5XY6gBbuqKBAk4kN7gJ/zglLBqHXzan/9wV160NLvLGceS2E6KEXQ/erIP
	 m9rIL5KlyZBiERi0E8z9pG7upNJYe9ENjowoy7XQppSKgWVQAxAKIzq3u+eG5WrEMB
	 jUnVU3PKLATrCRtCMAgrJj2DYY7dXgn0p6V1FfG206CwkkwHUGvpxyiT9dwvn2N69s
	 5DJOy2d076712HHsEFNEtej22sJRdcA6psd2CBJCHHUpqVAXZSghqgtdWkNz9DC/6J
	 6ijXdNmYVjWmjGbHYpKx/8278eFHvWw1wRmOKupXazmBCokHynClYoKFx7h08OR3Sn
	 yjEv6TyAUdXAw==
Subject: Re: [PATCH net-next v2 1/4] eth: mpnic: count packets, bytes, and
 drops per ring
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, edumazet@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Tue, 13 Oct 2026 12:05:33 +0000
Message-ID: <179189313386.434549.472154311742280420@kernel.org>
In-Reply-To: <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
References: <20261012-mpnic-counters3-v2-1-8afba81c2d5a@gmail.com>
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

- [Medium] In mpnic_clean_rcq()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c), an Rx frame the driver…

--

eth: mpnic: count packets, bytes, and drops per ring

This commit adds packet, byte, drop and error counters to each Tx work,
Tx completion and Rx completion ring in the mpnic driver. The counters are
reported through ndo_get_stats64. An RCU-protected base snapshot holds the
totals folded in from rings that have been torn down.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 5495e9a9aa651..d5185e64f804c 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -594,13 +612,20 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
>  
>  			if (likely(!(rcd &
>  				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> -				   !state->pkt.add_frag_failed))
> +				   !state->pkt.add_frag_failed)) {
> +				bytes += xdp_get_buff_len(&state->pkt.buff);
>  				skb = xdp_build_skb_from_buff(&state->pkt.buff);
> +			}
>  
> -			if (likely(skb))
> +			if (likely(skb)) {
>  				napi_gro_receive(&nv->napi, skb);
> -			else
> +			} else {
>  				mpnic_put_pkt_buff(&state->pkt, true);
> +				if (rcd & MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK)
> +					errors++;
> +				else
> +					dropped++;
> +			}
>  
>  			state->pkt.buff.data_hard_start = NULL;
>  			packets++;

[Severity: Medium]
Is rx_bytes undercounted for frames that are dropped because
state->pkt.add_frag_failed is set?

mpnic_add_rx_frag() sets add_frag_failed when xdp_buff_add_frag() fails.
That happens once nr_frags reaches MAX_SKB_FRAGS and the fragment cannot
be coalesced:

mpnic_add_rx_frag() {
    ...
	if (!xdp_buff_add_frag(buff, page_to_netmem(page), pg_off, len,
			       truesz)) {
		state->payld.pagecnt_bias++;
		state->pkt.add_frag_failed = true;
	}
}

For such a frame the guarded branch above is skipped, so nothing is added
to bytes. skb stays NULL and the uncorrectable error bit is clear, so
dropped++ runs. packets++ runs unconditionally.

The frame is then counted in rcq.packets through packets - errors, but it
adds nothing to rcq.bytes:

> @@ -619,6 +644,13 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
>  
>  	rcq->head = head;
>  
> +	u64_stats_update_begin(&rcq->stats.syncp);
> +	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
> +	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
> +	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
> +	u64_stats_add(&rcq->stats.rcq.errors, errors);
> +	u64_stats_update_end(&rcq->stats.syncp);

mpnic_get_stats64() and mpnic_stats_fold_rings() report these values as
rx_packets and rx_bytes. The rtnl_link_stats64 kernel-doc says rx_packets
includes packets dropped by the driver, and that rx_bytes corresponds to
rx_packets.

The v2 changelog says:

  - count Rx frames dropped by the driver in rx_packets and rx_bytes

That seems true only for the xdp_build_skb_from_buff() failure path.

The same counters are used by mpnic_get_queue_stats_rx(), which is added
later in this series in "eth: mpnic: report per-queue stats". The code
looks the same at the end of the series, apart from the new alloc_failed
counter.

Moving the bytes += line out of the guarded branch might not be enough by
itself. __xdp_buff_add_frag() returns before it adds the rejected
fragment to xdp_frags_size:

	} else if (unlikely(nr_frags == MAX_SKB_FRAGS)) {
		return false;
	} else {
	...
	sinfo->xdp_frags_size += size;

Would it work to track the lengths reported by the descriptors separately
here? If not, should the changelog be reworded?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-mpnic-counters3-v2-0-8afba81c2d5a%40gmail.com

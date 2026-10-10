Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9684028D9;
	Sat, 10 Oct 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633148; cv=none; b=PhIan5Kmz6iBdaAFlCwRZcJ6adE1sDegzNzOkMc0gWjtVRVDAhcwFAkrQTW0WFeP4kS6Ua1SP5nd1ir0ZGv2oof+/pUFMUt2xET6FpY1qu5EOE6CdCVOcuQxH/qnvjPAhjt7lO49S7VNat2ZiM3rNHPlcLr/oT3qv6SKavs8ugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633148; c=relaxed/simple;
	bh=MPfz7UXawJvAlKN0D5zVrtiYn8GB9jVfK6PFAdC0+YE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YULLQcmutw/KmpH5zcUlB8/jb+UcDIXAk5w1N8pYtydbkDUGvXocsXW6mJp+sKvTuW0DbRGFrYU12QrYnPNuzyXTNXgJ78pD+8uXXkUCcejLeA+v2Ac7JNxvuLMjRsDq/qsyL9s1xHaKFW5L6YXvYh3rIhurRUOWCrsWWrLbDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/QQlVAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/QQlVAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250011F000FF;
	Sat, 10 Oct 2026 11:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633147;
	bh=0UnHjdZbRffEFDudD6M9Aq9lGUGekPcwrBtWUTJxgS0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U/QQlVAVidWOU6orwpMCjmpmrgaWQpVagBzz7+yxCdlzh/+JWZBeM74+DR6mmzEr5
	 0aPwKmHzqSAKiOFDmTKNZ2SwhmknpLw93JWZhiUSrGgXP/r2jmFr5LyX3gyUSyWUSh
	 LvsHStw31UIcBSiPaGajyIODbX6nHJXhUiq14BlvM9D71VINKAhRzTao3YIiNublPK
	 rFCMGCPZoTlrEGDscNpriDQ1X5UGEIeBvVwfXDLdsoIw7w51vwWMNAaYWNPbS/eHoq
	 EyODHPfKwNpaT85C7OFKtrAvWwSu3DJAefRIDaWWBt66WFqx9uqxPrIoLslTWHYbF1
	 mqhY/w6bA36ZQ==
Subject:
 Re: [PATCH net-next 1/4] eth: mpnic: count packets, bytes, and drops per ring
From: netdev-bot+sashiko@kernel.org
To: daniel.zahka@gmail.com
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, edumazet@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Date: Sat, 10 Oct 2026 11:52:25 +0000
Message-ID: <179163314562.434549.8676548639859788609@kernel.org>
In-Reply-To: <20261009-mpnic-counters3-v1-1-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-1-7dc7644cc500@gmail.com>
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

- [Medium] mpnic_clean_rcq()
  (drivers/net/ethernet/meta/mpnic/mpnic_txrx.c) leaves good Rx frames…

--

eth: mpnic: count packets, bytes, and drops per ring

This commit adds packet, byte and drop counters to the Tx work, Tx
completion and Rx completion rings, and reports them through
ndo_get_stats64. Rx frames that the device flagged with an uncorrectable
error count as errors, and any other Rx failure counts as a drop.

> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> index 5495e9a9aa651..4bf6404941158 100644
> --- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c

[ ... ]

> @@ -591,16 +609,25 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
>  			break;
>  		case MPNIC_RCD_TYPE_META: {
>  			struct sk_buff *skb = NULL;
> +			u32 pkt_bytes = 0;
>  
>  			if (likely(!(rcd &
>  				     MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK) &&
> -				   !state->pkt.add_frag_failed))
> +				   !state->pkt.add_frag_failed)) {
> +				pkt_bytes = xdp_get_buff_len(&state->pkt.buff);
>  				skb = xdp_build_skb_from_buff(&state->pkt.buff);
> +			}
>  
> -			if (likely(skb))
> +			if (likely(skb)) {
>  				napi_gro_receive(&nv->napi, skb);
> -			else
> +				bytes += pkt_bytes;
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

[ ... ]

> @@ -619,6 +646,13 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
>  
>  	rcq->head = head;
>  
> +	u64_stats_update_begin(&rcq->stats.syncp);
> +	u64_stats_add(&rcq->stats.rcq.packets, packets - dropped - errors);
> +	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
> +	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
> +	u64_stats_add(&rcq->stats.rcq.errors, errors);
> +	u64_stats_update_end(&rcq->stats.syncp);
> +

[Severity: Medium]
Should rx_packets and rx_bytes still count frames that the device
reported as good but the driver then dropped?

In the MPNIC_RCD_TYPE_META branch, two cases reach dropped++ while
MPNIC_RCD_META_UNCORRECTABLE_ERR_MASK is clear:

  - mpnic_add_rx_frag() set state->pkt.add_frag_failed
  - xdp_build_skb_from_buff() returned NULL

Subtracting dropped here takes those frames out of rcq.packets. Their
bytes are lost as well, because bytes += pkt_bytes only runs when an skb
was built. When xdp_build_skb_from_buff() fails, pkt_bytes has already
been computed and is then thrown away.

mpnic_get_stats64() and mpnic_aggregate_ring_rcq_counters() pass these
values directly into rx_packets and rx_bytes. The rtnl_link_stats64
kernel-doc in include/uapi/linux/if_link.h says:

 * @rx_packets: Number of good packets received by the interface.
 *   For hardware interfaces counts all good packets received from the device
 *   by the host, including packets which host had to drop at various stages
 *   of processing (even in the driver).
 ...
 * @rx_bytes: Number of good received bytes, corresponding to @rx_packets.

Leaving out frames the hardware flagged as uncorrectable matches this,
since they go to rx_errors. Good frames dropped for lack of resources go
to rx_dropped, but by this text they should also be counted in
rx_packets and rx_bytes.

Could this subtract only errors from packets, and add pkt_bytes in the
dropped case too?

The later commits in the series ("eth: mpnic: report per-queue stats",
"eth: mpnic: count Tx queue stops and wakes" and "eth: mpnic: count Rx
allocation failures") keep both the packets - dropped - errors
subtraction and the byte counting that only happens on success. So the
problem is still there at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-mpnic-counters3-v1-0-7dc7644cc500%40gmail.com

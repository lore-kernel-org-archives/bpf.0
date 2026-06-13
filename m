Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD91D95A3
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781339769; cv=none; b=EH7hAlLIFNS+jFWrA9xq0AwEg3nzfr55GBqEv36XRZBRdpbzyO3N1KxksBpkmIYOMl87HDf+wGXwrY6Qfvw6ReYMClh1C80drpYK58S7/ZTg7wB3QhaFGdhcPHHf2xZsUybCeYkOFxtySnpwO0Nmlxd6JgiWEbawWDRt6uxsZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781339769; c=relaxed/simple;
	bh=RwGXku+E6ei7XCtMxLdp/UtUtwxtjSBb0xvTW/uHNXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8Im34W5Cz9sWC5FbWCFmXuJqD98laH0EqiF0m8G7hh5QipdHyykKGcdEBFE8ZWi+hYYDGKEyGwNtBAAb0QXfo42i62F4yq74se1jk4nP6UwKk+fuOYioFCOB+7wlBjh72n3RdZUSbAvDpScdFBAgeZWPjm6QyjkDl7r331r4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5MtMSxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5MtMSxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A491F00A3A;
	Sat, 13 Jun 2026 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781339766;
	bh=2ruzKp9UsIUWWrxLXj+0QteJ7+JNbNBuFrYwj1bVxt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5MtMSxxUwDiel2h9WDFFUq8zwhcRRKzAFq19ZBhb0SsK1YO7gV4Kts63KaksAudC
	 ed3WPd/dYdDHTLRAhDTC2mnOogqupCQsuy6WjRutqUCXq/y1WljgH+5cKXPmxoYnLF
	 sE04PcJmo/Em3gnfES3yV+gR5/SOrAvNoe+ShoZiubgGD1KewDkF47tPREYhDZcXvn
	 yyR35HPUXLEBY7ciyedoXpnJnIm892ZXtfxcvSDGDAoWjFZ3yu8/t2pA3lIpj+PlIj
	 JBkuHciNx5Dz8PWP7tl/aKW/D0A6K+znCCOyajoZPXg59lx7OC1no9zWgHObcMpQh5
	 4bm7mLPENmxkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 5/5] veth: time-based BQL completion
 coalescing via ethtool tx-usecs
Reply-To: sashiko-reviews@lists.linux.dev
To: hawk@kernel.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612083530.1650245-6-hawk@kernel.org>
References: <20260612083530.1650245-6-hawk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 08:36:05 +0000
Message-Id: <20260613083606.A6A491F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] BQL completions are stranded when NAPI goes to sleep if the timer =
has not expired, artificially destroying DQL performance estimates.
- [Low] Direct access to `peer_txq->dql.limit` breaks compilation when CONF=
IG_BQL is disabled.
--

commit 7aba7f3c0951cf87cb2ef78e981e1f66a316a71d
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

veth: time-based BQL completion coalescing via ethtool tx-usecs

This patch accumulates BQL completions and flushes them when a configurable
time threshold (tx-usecs) is exceeded. This lets DQL discover a limit that
bounds actual queuing delay to the configured interval.

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 2473f730734b7..c62d87a8402cb 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c

[ ... ]

> @@ -969,13 +1029,54 @@ static struct sk_buff *veth_xdp_rcv_skb(struct vet=
h_rq *rq,
>  	return NULL;
>  }
> =20
> +static void veth_bql_maybe_complete(struct veth_bql_state *state,
> +				    struct netdev_queue *peer_txq,
> +				    u64 bql_flush_ns)
> +{
> +	u64 current_time;
> +
> +	/* There is no reason to complete with 0 and
> +	 * peer_txq could go away.
> +	 */
> +	if (!state->n_bql || !peer_txq)
> +		return;
> +
> +	current_time =3D sched_clock();
> +
> +	/* We complete if:
> +	 * 1. We reach bql_flush_ns.
> +	 * 2. We potentially have BQL starvation.
> +	 */
> +	if (state->time + bql_flush_ns <=3D current_time ||
> +	    state->n_bql > peer_txq->dql.limit) {

[Severity: Low]
Does this direct access to peer_txq->dql.limit cause compilation errors when
CONFIG_BQL is disabled? The dql member of struct netdev_queue is
conditionally compiled, so accessing it directly might break the build.

> +		netdev_tx_completed_queue(peer_txq, state->n_bql,
> +					  state->n_bql * VETH_BQL_UNIT);
> +		state->time =3D current_time;
> +		state->n_bql =3D 0;
> +	}
> +}
> +
>  static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats,
>  			struct netdev_queue *peer_txq)

[ ... ]

> @@ -1000,12 +1101,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int b=
udget,
>  			}
>  		} else {
>  			/* ndo_start_xmit */
> -			bool bql_charged =3D veth_ptr_is_bql(ptr);
>  			struct sk_buff *skb =3D veth_ptr_to_skb(ptr);
> =20
> +			if (veth_ptr_is_bql(ptr))
> +				state->n_bql++;
>  			stats->xdp_bytes +=3D skb->len;
> -			if (peer_txq && bql_charged)
> -				netdev_tx_completed_queue(peer_txq, 1, VETH_BQL_UNIT);
> =20
>  			skb =3D veth_xdp_rcv_skb(rq, skb, bq, stats);
>  			if (skb) {
> @@ -1015,6 +1115,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int bud=
get,
>  					napi_gro_receive(&rq->xdp_napi, skb);
>  			}
>  		}
> +		veth_bql_maybe_complete(state, peer_txq, bql_flush_ns);
>  		done++;
>  	}

[Severity: High]
If veth_xdp_rcv() finishes and returns a done count less than the budget,
NAPI will go to sleep in veth_poll(). Do we need to unconditionally flush
any stranded BQL completions in veth_poll() before sleeping?

If completions are left in rq->bql_state indefinitely across NAPI idle
periods, it might present an artificially massive delay to DQL. This could
cause DQL to mistakenly conclude the hardware is extremely slow and
aggressively shrink dql.limit to its minimum, crippling throughput on
subsequent bursts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612083530.1650=
245-1-hawk@kernel.org?part=3D5

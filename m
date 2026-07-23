Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9A134E777
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 22:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845009; cv=none; b=aL12ifmRxPrBhe0RomtdetaLYyjyeSGY46wUYTGsRPycRFHtlubZan9JjYW8ouzfiIhJmM6akBNx3sbWgz4175enS4QSB/94d+WuYDQLAMeRyhi3Y7IZQxjEAN2IJBVEBaFENkW7jjvKPvxTyhT+JSobeDd1DNQoPcmBQQLXJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845009; c=relaxed/simple;
	bh=l8cb+lowCf9Xf71NoRtLPptpsjJGhSwv5Nrz09A/DXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YU9q/MOFaX9vRIsZvcPUfEK/wdNiLWeBWMKmIVPeXJ6CA/AKguV/LBJ1OEeDGFarfaM6mTcUTDK4gE6/yu+EH/OaxgT0NlM66JEtSrgWJ7fdjlqCK7+plbIyGUBo5ebkb8XN1GVQFtnMXuM7zfMPPaySURAcqcOqkvBinidMUfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuwczDRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuwczDRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D511F000E9;
	Thu, 23 Jul 2026 22:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845007;
	bh=HYKAevnCPChAMvZMyJi4UWX9xL2Vso0kdeUuUnXnfqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iuwczDRiS2NCq+fxdDXamSrfaCNPkqOCpgyhQz/PNaKfDxe2haoNzizkx9+T8Q/Wh
	 h1Fd3b5WnDif/Pd63j7CzbUhBMTq+JB1eujXpDtepdB/99bazWZYWfRYU1s70Ks8Ns
	 73sztfqyljyBWOYvfuAEBSlBbk7JXdLG+WgxPWF9MV/zHl77+wFuGkCA5UNt0EtIPp
	 nhVwE8Hnj9sX8TyserGg2u5ULOOtZ19pvYOsWgclff4IlZn6iz9asMQmqX9i2XTQJx
	 oTLCwblVZJ5ZTflyDvyo5+IHvDkx/E/4ITeGYZ/y8bFWZC/6bMuOU1/NORzavd4e+1
	 yyhQwvdLSohvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for
 XDP_PASS case
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722221634.186886-2-joshwash@google.com>
References: <20260722221634.186886-1-joshwash@google.com>
 <20260722221634.186886-2-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:16:46 +0000
Message-Id: <20260723221647.20D511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Early return for `XDP_PASS` packets bypasses QPL copy-on-demand ch=
eck, leading to RX ring starvation.

Pre-existing issues:
- [High] Unconditional SKB overwriting in `gve_rx_xsk_dqo` for multi-fragme=
nt AF_XDP packets causes memory leaks and packet truncation.
- [High] Missing state tracking for dropped fragments in multi-descriptor D=
QO packets causes subsequent fragments to be treated as new packets.
--

--- Patch [1]: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for X=
DP_PASS case ---
commit 3d3251679ac8ebd21a150064685ec273582e184c
Author: Joshua Washington <joshwash@google.com>

gve: use xdp_build_skb methods for XDP_PASS case

Newer common methods have been introduced to construct SKBs in the
event of XDP_PASS because many drivers replicated very similar
functionality. Update GVE to use these common methods for copy mode and
zero-copy mode.

> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_rx_dqo.c
> index 02cba280d81a8..907a0c15bf302 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -736,8 +736,7 @@ static int gve_rx_xsk_dqo(struct napi_struct *napi, s=
truct gve_rx_ring *rx,
>  	}
> =20
>  	/* Copy the data to skb */
> -	rx->ctx.skb_head =3D gve_rx_copy_data(priv->dev, napi,
> -					    xdp->data, buf_len);
> +	rx->ctx.skb_head =3D xdp_build_skb_from_zc(xdp);

[Severity: High]
This isn't a bug introduced by this patch, but does this unconditionally
overwrite the SKB head on every fragment for multi-fragment packets?

If an AF_XDP enabled interface receives a jumbo frame (e.g., 9000 bytes),
the hardware splits the packet across multiple RX descriptors. For each
descriptor, gve_rx_xsk_dqo() allocates a new SKB here and assigns it to
rx->ctx.skb_head.

Since this ignores whether rx->ctx.skb_head is already populated from previ=
ous
fragments, does it leak the SKBs of prior fragments and truncate the delive=
red
packet?

[ ... ]

> @@ -894,14 +891,22 @@ static int gve_rx_dqo(struct napi_struct *napi, str=
uct gve_rx_ring *rx,
>  		buf_state->page_info.pad +=3D gve_xdp.xdp.data - old_data;
>  		buf_len =3D gve_xdp.xdp.data_end - gve_xdp.xdp.data;
>  		if (xdp_act !=3D XDP_PASS) {
>  			gve_xdp_done_dqo(priv, rx, &gve_xdp.xdp, xprog, xdp_act,
>  					 buf_state);
>  			return 0;
>  		}

[Severity: High]
This is a pre-existing issue, but if the first fragment of a multi-descript=
or
packet is dropped (e.g. XDP_DROP), does the driver fail to track that the r=
est
of the packet must be dropped?

When the next descriptor containing the middle of the payload arrives,
rx->ctx.skb_head will be NULL. Will the driver incorrectly treat this fragm=
ent
as a new Ethernet frame and run the XDP program on arbitrary payload data?

> =20
> +		rx->ctx.skb_head =3D xdp_build_skb_from_buff(&gve_xdp.xdp);
> +		if (unlikely(!rx->ctx.skb_head))
> +			goto error;
> +		rx->ctx.skb_tail =3D rx->ctx.skb_head;
> +
> +		gve_reuse_buffer(rx, buf_state);
> +
>  		u64_stats_update_begin(&rx->statss);
>  		rx->xdp_actions[XDP_PASS]++;
>  		u64_stats_update_end(&rx->statss);
> +		return 0;

[Severity: High]
Does returning 0 here bypass the copy-on-demand safety check for XDP_PASS
packets?

The gve_rx_should_trigger_copy_ondemand() check at the end of gve_rx_dqo()
appears to be skipped. By bypassing this check, could the networking stack
hold onto the QPL pages indefinitely?

This might drive used_buf_states_cnt to num_buf_states, exhausting the buff=
er
pool and preventing new RX buffers from being posted to hardware, ultimately
starving the RX ring.

>  	}
> =20
>  	if (eop && buf_len <=3D priv->rx_copybreak &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722221634.1868=
86-1-joshwash@google.com?part=3D1

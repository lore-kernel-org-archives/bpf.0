Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDC39183B
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837768; cv=none; b=dDGRPB8ENwqsG3qHp9J1gXQxdjWCUxJmjJpsaZS+ANldjVM6qDDm9a/fudrClb17gv65rjQs5/zySs+bwgzybCfd8P6RG1oAJ8dqMIkzGSAE++QDe5XKB2x5/PlNHF6H77AgJHGGTG31db+/Bio/IfePQG/811f+i0S7W19Ev9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837768; c=relaxed/simple;
	bh=+Mr1Th8IV3FCTXZyRTL+xX6th2qvOKE9FS/oEZr8GJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tg8JZmmDIzjJW/wJcFOP4xhGoI9psgzY6lHQY4fd0M4+dXWLBOoi4K0h7hN8AhYk6HKElAWqDl+yhGYvBgHdL8U7haToL3jK0nKDG7gcHUz31Fpljh8oW++QVGbOEzpgFs1LEa1be1eKQg+9tT3x7qfT/vSKaKETPBDWPp4xZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyrYMjCZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyrYMjCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6AB1F00A3D;
	Sat, 15 Aug 2026 23:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837766;
	bh=NOV4u9M7++ZHQ7j7A7I2FfTZt6Vgu3+e6KlgOJsTs0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EyrYMjCZ8/8ZhjH/7jvW1Rsko2yYE1EK2+m8HoddWj8/WxoxlQ51F3bPYX9YDM9lV
	 UwEQSinOvdApQzSUfZDo9FcBgXPE1K9YfOXAxyjpP8kth097N07Vdca7n+w5YVSdTi
	 2QBJYvVnqe0g8U/5USC9anmdtLvZx14/DDz2EZLZFKQKuAZRRAsCTrErpTE9ThksBK
	 z9mp9kBEv54xfOGo+IskbVs90ZNgSMEX6WMxBv9X8eYbVG8F/T2IO2imuU2r+DpTW+
	 hf8Gg4YbzM0fC/tFRtNVAdjZ6/rsHkvk9rxaPVThu3Ky14zJXbJ9eaKaV2VsYYbeqD
	 R3ZXw6Gw2kc+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 5/6] gve: fix napi_disable deadlock when attempting
 to disable XSK pools
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Washington" <joshwash@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814234845.773189-6-joshwash@google.com>
References: <20260814234845.773189-1-joshwash@google.com>
 <20260814234845.773189-6-joshwash@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:49:26 +0000
Message-Id: <20260815234926.AE6AB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] gve_xsk_pool_enable modifies XDP memory model and xsk_pool pointer=
s without disabling NAPI for QPL queues, leading to data races.
- [High] gve_xsk_pool_disable unconditionally unregisters the XDP RXQ memor=
y model but fails to register a fallback, leaving the active RX queue witho=
ut a valid memory model.
--

--- Patch [5]: [PATCH net 5/6] gve: fix napi_disable deadlock when attempti=
ng to disable XSK pools ---
commit 0d8b6f4e24c72240011374bd526d4eaa388afe39
Author: Joshua Washington <joshwash@google.com>

gve: fix napi_disable deadlock when attempting to disable XSK pools

This commit updates the unlocked napi_disable and napi_enable calls
in GVE's XSK pool disablement path to use the locked versions, preventing
a deadlock where the thread attempts to re-acquire the netdev lock.

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 453b304016b6f..e084b367a92dd 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
[ ... ]
> @@ -1706,17 +1706,17 @@ static int gve_xsk_pool_disable(struct net_device=
 *dev,
>  	}
> =20
>  	napi_rx =3D &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
> -	napi_disable(napi_rx); /* make sure current rx poll is done */
> +	napi_disable_locked(napi_rx); /* make sure current rx poll is done */
> =20
>  	tx_qid =3D gve_xdp_tx_queue_id(priv, qid);
>  	napi_tx =3D &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
> -	napi_disable(napi_tx); /* make sure current tx poll is done */
> +	napi_disable_locked(napi_tx); /* make sure current tx poll is done */
> =20
>  	gve_unreg_xsk_pool(priv, qid);

[Severity: High]
This is a pre-existing issue, but does this unconditional call to
gve_unreg_xsk_pool() leave the active RX queue without a valid memory model?

When an AF_XDP socket is closed, gve_xsk_pool_disable() is called. For RDA
queues, it first re-creates the rings, which registers MEM_TYPE_PAGE_POOL.
Then it unconditionally calls gve_unreg_xsk_pool(), which unregisters the
memory model by setting it to 0 without registering a fallback.

If the memory model type is left as MEM_TYPE_PAGE_ORDER0 (0), when XDP
drops or redirects packets, __xdp_return() will call put_page() instead of
page_pool_put_full_page() or page_frag_free(). Could this bypass the page
pool recycling mechanism and leak pages from the pool?

>  	smp_mb(); /* Make sure it is visible to the workers on datapath */

While reviewing the XSK pool changes, I noticed another pre-existing
issue in the related enable path:

[Severity: High]
This isn't a bug introduced by this patch, but does gve_xsk_pool_enable()
modify the XDP memory model locklessly for QPL queues without disabling NAP=
I?

When an XSK pool is enabled on a QPL queue, gve_xsk_pool_enable() calls
gve_reg_xsk_pool() directly without disabling NAPI:

gve_xsk_pool_enable() {
        ...
        err =3D gve_reg_xsk_pool(priv, dev, pool, qid);
        ...
}

gve_reg_xsk_pool() {
        ...
        err =3D xdp_rxq_info_reg_mem_model(&rx->xdp_rxq,
                                         MEM_TYPE_XSK_BUFF_POOL, pool);
        ...
}

Could this concurrent modification of the rx->xdp_rxq.mem.type and
rx->xsk_pool pointers while NAPI is actively running lead to data races or
memory corruption in the SoftIRQ context (such as inside xdp_return_frame
or gve_xsk_tx_poll)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814234845.7731=
89-1-joshwash@google.com?part=3D5

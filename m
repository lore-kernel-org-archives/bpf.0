Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC8126BF7
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290710; cv=none; b=nmQTy6y8Jp7aneCiT4avm6hUU9QGbmRnwcgZJA4tJEMQt0xqE598qDhiv3IHpTnLjifdrDmsRVbT7CNKOdz6lZpgmL8tvKgjlONoFlf5T4jD9XYQky601oDgx/Zcm67DfFO8vFbI039LA38IV9gZmA9eEheN1KGbb0l82XuLcJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290710; c=relaxed/simple;
	bh=lQAG1j8ZYd6mRYjr/t3YMDXlA5OdDATD12o1K3QyO/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GCFIAt3GwZbWgzelK3g7FD51V63XgQhLCFy6M83w0EeqfnI6RQC99dV0u90K+iYDXBIx80cBOzUKLvHxgTO6noBXuqBv6SoOuk3s5AvMG+om9H/4GaCPZGFSCMe4BxSK5pBin3Sw2su9xNiKkyHtNSmDYEW0dfaVhM1FUSwa3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSz3QYcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSz3QYcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407321F00A3A;
	Fri, 12 Jun 2026 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781290707;
	bh=71K//F/LbHBx1Jl7dVSJSbgajPQkYBIH5cR1ZmRolSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSz3QYclaYKTh600u7KvhqO0Il1fxFTfhg9gBYQheDJdktzxlo0RZ/evo6gxpAwzm
	 Cff7cYJaYzEV0iht5Qpf+3+6bMvXrzEs3XGNpEqOHzsQgH8Tu++PlqRqBVYJBJEgs3
	 F5+BLa9lWUsoe1/XP2Gd0GBri065e9tmC7Kwe6594iAgu5cWXUn+4g5fggkR1f2rGL
	 NTqrRHSxaxKzf43dG4OcUTMF6/SYzRYmu/yCib6hlmDYzVWlCjfqbYapiL55NK/6KD
	 pmEoRsF7cLuoT/1b4PVN0ECDjzXsD2SiNg32+pZeJo736o6DUIi4Uhb2+ufKJqwidb
	 Rn5GBIXQA+pZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/4] net: ti: icssg: Fix XSK zero copy TX during
 application wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Meghana Malladi" <m-malladi@ti.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611185744.2498070-5-m-malladi@ti.com>
References: <20260611185744.2498070-5-m-malladi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:58:26 +0000
Message-Id: <20260612185827.407321F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Removal of `xsk_tx_release()` prevents the AF_XDP TX ring consumer=
 pointer from being updated, permanently stalling zero-copy transmissions.
- [High] The TX queue's `trans_start` timestamp is unconditionally updated =
even if no packets are transmitted, defeating the netdev watchdog.
- [Low] The variable `num_tx` is initialized and incremented but never read.

Pre-existing issues:
- [High] AF_XDP descriptors and Completion Queue (CQ) slots are permanently=
 leaked on hardware allocation failure.
--

commit 569205869c791341578b147053176ec7b14de505
Author: Meghana Malladi <m-malladi@ti.com>

net: ti: icssg: Fix XSK zero copy TX during application wakeup
   =20
This patch modifies emac_xsk_xmit_zc() to handle zero-copy TX without retur=
ning
the number of packets transmitted. It removes the early return in
emac_tx_complete_packets() to allow application wakeups to initiate zero-co=
py
xmit traffic, and adds __netif_tx_lock() for queue protection.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/e=
thernet/ti/icssg/icssg_common.c
> index 82ddef9c17d54..c3f3cacdb28e7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -93,8 +93,8 @@ void prueth_ndev_del_tx_napi(struct prueth_emac *emac, =
int num)
>  }
>  EXPORT_SYMBOL_GPL(prueth_ndev_del_tx_napi);
> =20
> -static int emac_xsk_xmit_zc(struct prueth_emac *emac,
> -			    unsigned int q_idx)
> +static void emac_xsk_xmit_zc(struct prueth_emac *emac,
> +			     unsigned int q_idx)
>  {
>  	struct prueth_tx_chn *tx_chn =3D &emac->tx_chns[q_idx];
>  	struct xsk_buff_pool *pool =3D tx_chn->xsk_pool;
> @@ -115,7 +115,7 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
>  	 * necessary
>  	 */
>  	if (descs_avail <=3D MAX_SKB_FRAGS)
> -		return 0;
> +		return;
> =20
>  	descs_avail -=3D MAX_SKB_FRAGS;
> =20
> @@ -169,9 +169,6 @@ static int emac_xsk_xmit_zc(struct prueth_emac *emac,
> =20
>  		num_tx++;
>  	}

[Severity: High]
This is a pre-existing issue, but does early exit on hardware push failure
permanently leak the peeked AF_XDP descriptor?

If k3_udma_glue_push_tx_chn() fails, the driver breaks out of the loop right
before the num_tx increment shown above:

		if (ret) {
			ndev->stats.tx_errors++;
			k3_cppi_desc_pool_free(tx_chn->desc_pool, host_desc);
			break;
		}

At this point, xsk_tx_peek_desc() has already consumed the descriptor from
the user space TX ring. Because the packet is never pushed to hardware, it
will never trigger a TX completion interrupt, and xsk_tx_completed() will
never be called.

Does the driver need to manually submit the completion for dropped packets
here to prevent the memory from being permanently lost to the application?

> -
> -	xsk_tx_release(tx_chn->xsk_pool);
> -	return num_tx;

[Severity: High]
Does removing xsk_tx_release() prevent the AF_XDP TX ring consumer pointer
from being updated?=20

Since xsk_tx_peek_desc() only advances a local cached consumer pointer, it
seems xsk_tx_release() is required to publish this pointer to the shared
memory ring.=20

Without this, will userspace eventually observe the TX ring as completely
full and stop producing new packets, leading to a permanent traffic stall?

[Severity: Low]
Since the return of num_tx was removed and the function changed to void,
is the num_tx variable now unused?=20

It looks like it is initialized and incremented inside the loop but never
read.

>  }
> =20
>  void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
> @@ -279,9 +276,6 @@ int emac_tx_complete_packets(struct prueth_emac *emac=
, int chn,
>  		num_tx++;
>  	}
> =20
> -	if (!num_tx)
> -		return 0;
> -

[Severity: High]
Because this early return was removed, does the code now unconditionally
update the TX queue's trans_start timestamp on every NAPI poll?

Later in this function, if tx_chn->xsk_pool is set, the driver calls
txq_trans_cond_update(), which updates txq->trans_start to jiffies.=20

If the hardware stalls but NAPI is still being polled (e.g., due to userspa=
ce
wakeups or RX packets), trans_start will continually be pushed forward.

Will this mask genuine hardware TX stalls from the kernel and prevent the
netdev watchdog from triggering a recovery?

>  	netif_txq =3D netdev_get_tx_queue(ndev, chn);
>  	netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
> =20
> @@ -306,7 +300,9 @@ int emac_tx_complete_packets(struct prueth_emac *emac=
, int chn,
> =20
>  		netif_txq =3D netdev_get_tx_queue(ndev, chn);
>  		txq_trans_cond_update(netif_txq);
> +		__netif_tx_lock(netif_txq, smp_processor_id());
>  		emac_xsk_xmit_zc(emac, chn);
> +		__netif_tx_unlock(netif_txq);
>  	}
> =20
>  	return num_tx;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611185744.2498=
070-1-m-malladi@ti.com?part=3D4

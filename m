Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CC3A6B92
	for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781124352; cv=none; b=EaEjcWwIogTlz621Vwn9aLUOPpB+YHcecq6sMT83kSL7p30lZHxxHyaRa0DuUq3/2XJbBr6gWhVM2FvptninlESUWUitL8+8oxFhoGX9GJ4iFdMmfGFOol9cmp+/AMvW70jeP02vKvTLwx1a7fG3kKGeEEQ2WnwdLCMmoaUhEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781124352; c=relaxed/simple;
	bh=rfe8OxD4x6TFZjfqaNgA/K+/D6C2HHo1HQ8FDrvpvIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oc+jy/nDsJj8jwLcRwe0K4bxv8XSzHGyB74xSqIrE+6KHr5HiLAwX2zrsdmvvol/1wWJ+cL9KJgSGT+bnI56zdHyr+EDQ281xUes/2vdcgDHx+K8WQ2rRjk6ZGxzqFerIEv43nQluO9zyk8cL/+754KgwNJdBYM35WOuVYFKTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSzgdA4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSzgdA4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD751F00893;
	Wed, 10 Jun 2026 20:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781124349;
	bh=YBNfaeM6GYoO2V3Sy72enyaz7kdDQdbE+X00mOXNbnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NSzgdA4/eHIUJXBS0WSkg6AaYf0/ht+2y2Ys1K+rEVmPqbm5Zpo0XfMM8GugNp5p/
	 r8Xoh5oNl1Q8hmAKylwhRWcaruT3rAWv8dNVdaxr7qEtPbJVIFrV26lcwshNtvXqUm
	 hvFzIYFwURhX29PtWEQvDnb5eMjPSvXSdOAUGWDpnaQcumyV1YPV0P+690p3hWRB+5
	 Le7ReS0n1p1UYQkr8OET8yLEOvufldx5xqXkbXwEiEvkXF/lo19pZxCPJP+hUV66bm
	 +MYy0QDF0vWgdKKhoYoBoKAWa0/nVRSFMnWpvOiKatLPPxnZkkQasj5fHpyVjU2/mM
	 brNKE6vXazJpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] bnxt: fix head underflow on XDP head-grow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joe Damato" <joe@dama.to>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260609204458.2237787-2-joe@dama.to>
References: <20260609204458.2237787-2-joe@dama.to>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 20:45:48 +0000
Message-Id: <20260610204548.DAD751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `bp->rx_skb_func()` fails, `bnxt_rx_pkt()` skips aggregate buff=
er cleanup, permanently leaking `rx_agg_ring` hardware slots and `netmem` r=
eferences.
--

commit 374adfb9335a0a96705993cee5701e4d6ce2423c
Author: Joe Damato <joe@dama.to>

bnxt: fix head underflow on XDP head-grow

This commit fixes a head underflow bug in bnxt_rx_multi_page_skb() when
handling XDP adjust head grow cases. It accomplishes this by adding an offs=
et
field to struct bnxt_sw_rx_bd and using it to compute the correct fragment
start address.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 35e1f8f663c78..12e73ffff6c3d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -1185,13 +1191,13 @@ static struct sk_buff *bnxt_rx_multi_page_skb(str=
uct bnxt *bp,
>  	dma_addr -=3D bp->rx_dma_offset;
>  	dma_sync_single_for_cpu(&bp->pdev->dev, dma_addr, rxr->rx_page_size,
>  				bp->rx_dir);
> -	skb =3D napi_build_skb(data_ptr - bp->rx_offset, rxr->rx_page_size);
> +	skb =3D napi_build_skb(frag_start, rxr->rx_page_size);
>  	if (!skb) {
>  		page_pool_recycle_direct(rxr->page_pool, page);
>  		return NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does returning NULL here
leak aggregate buffers in bnxt_rx_pkt()?

Looking at bnxt_rx_pkt(), when bp->rx_skb_func() (which maps to
bnxt_rx_multi_page_skb() in page mode) returns NULL, the code jumps
to oom_next_rx:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:bnxt_rx_pkt()
	skb =3D bp->rx_skb_func(bp, rxr, cons, data, data_ptr, dma_addr,
			      payload | len);
	if (!skb)
		goto oom_next_rx;

If the packet had aggregate buffers (agg_bufs > 0), this bypasses the
cleanup block later in the function that would recycle these buffers via
bnxt_reuse_rx_agg_bufs().

Can this omission cause a permanent leak of hardware aggregate slots and
netmem references, eventually wedging the RX ring under memory pressure?

>  	}
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, bp->rx_offset);
> +	skb_reserve(skb, data_ptr - (u8 *)frag_start);
>  	__skb_put(skb, len);
> =20
>  	return skb;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609204458.2237=
787-2-joe@dama.to?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164F50255B;
	Mon, 28 Sep 2026 22:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632830; cv=none; b=QW1pcYe8HQ6t6zl5tJz/nSgaaO3mUin/lGOhABh1pqrR4kerWZi560ty/6mOXXiIYbvvc8PMBaPJpozA1TDk3H1PXLkOGkJaId2ORD1s8dD1bGsVUbsgJzcEHOVQr9KtQMlo4x6D4uIQEDAnblTiZLLqNBs2IEqg7YXJkOEu/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632830; c=relaxed/simple;
	bh=ooYmc3oHfur3PAffErEq2WsEDeTaYMncg7EWDZfoZk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKg3rfct5fjt40BdkmNLyyIykD1ltOZ3LD6Koey4CcRleNMCBol/s7MwrzeQUSI5p51l53XeCLEUjuB8uuucEUZGWuKiyTbWUjYD8d81g04iGn2itAOYZL3/itOLce/WScSPtDsGCWstBGuuY/N+eBXhc/FziAWXm5Hlan7xBM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adqBt4w+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adqBt4w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DC51F00893;
	Mon, 28 Sep 2026 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632829;
	bh=Jt391EH3T66sssvoIdP2vLmeH5sL2N0V0oGFubWO9uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=adqBt4w+jkFECnDVnGXqAUXij9JsOCN5EXb0VDCJRCC8I45zu291LrkVYX3OKdwUp
	 R1d24aPTFGo4CSJFSXHcXbxmzBCn7dh1p1QOYHA3y9uZ9jW3PyWQ759vQB9k6XE0xO
	 ddrY//W/+VcDu0on/IQTdg81sj+oUIvJIjKRcgHDChxaFYKRUM2crFhPyobM8fiOp/
	 OL/JzM2Nl5c8Owqyek7Ch7oc9S6bK5hSuUMoEWP5ccIk68kP6JBdmx2N4OqBHrXtwe
	 n+ul9QyX6IuJyrP3qGa9S9nDuwMI+EDCN5kUf0tProwCaf/D+hPE99/uGldsNO3Ao4
	 CmqP0yBiG0i3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 17/19] net: stmmac: retain DMA memory until
 hardware shutdown completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-sunxi@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-17-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-17-feec6c14dd06@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 22:00:28 +0000
Message-Id: <20260928220028.D0DC51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] stmmac: DMA ring bounds overflow due to missing END_RING bit
--

commit 36cb013886a764ed37b1ecca4a71af772e7620a5
Author: James Hilliard <james.hilliard1@gmail.com>

net: stmmac: retain DMA memory until hardware shutdown completes

This commit modifies the stmmac driver to retain DMA memory and configurati=
ons
until hardware shutdown completes. It adds idle wait checks for DMA engines
and defers error recovery to process context to prevent memory corruption
from in-flight frames after stop requests.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index f5060924dae86..98dbc873e1c81 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> +static int stmmac_reinit_dma_desc(struct stmmac_priv *priv)
> +{

[ ... ]

> +		/* Writeback format contains status, not buffer addresses. Rebuild
> +		 * read format from software ownership before publishing any OWN.
> +		 */
> +		memset(stmmac_get_rx_desc(priv, rx_q, 0), 0,
> +		       stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size);
> +		if (rx_q->xsk_pool) {
> +			dma_free_rx_xskbufs(priv, dma_conf, queue);
> +			/* Empty FILL rings are valid, including TX-only sockets. */
> +			stmmac_alloc_rx_buffers_zc(priv, dma_conf, queue);
> +		} else {

[ ... ]

> +		if (priv->descriptor_mode =3D=3D STMMAC_CHAIN_MODE)
> +			stmmac_mode_init(priv, stmmac_get_rx_desc(priv, rx_q, 0),
> +					 rx_q->dma_rx_phy, dma_conf->dma_rx_size,
> +					 priv->extend_desc);
> +
> +		dma_wmb();
> +		for (i =3D 0; i < rx_q->buf_alloc_num; i++)
> +			stmmac_init_rx_desc(priv, stmmac_get_rx_desc(priv, rx_q, i),
> +					    priv->use_riwt, priv->descriptor_mode,
> +					    i =3D=3D dma_conf->dma_rx_size - 1,
> +					    dma_conf->dma_buf_sz);

[Severity: High]
Does this loop leave the end-of-ring marker uninitialized if the ring is on=
ly
partially filled?

When stmmac_reinit_dma_desc() is called to rebuild descriptors, such as
during a suspend and resume cycle, and the interface uses AF_XDP sockets in
ring mode, the fill ring might be partially populated or empty.

Because the preceding memset() zeroes the entire descriptor array, any
previous end-of-ring bits are erased. Since this loop terminates at
buf_alloc_num instead of dma_rx_size, the final descriptor boundary marker
is never set when buf_alloc_num is less than dma_rx_size.

If the socket later refills the remainder of the ring via
stmmac_rx_refill_zc(), it sets the ownership bit but not the end-of-ring bi=
t.
Could this cause the hardware DMA engine to increment its ring pointer past
the end of the allocated ring buffer, leading to out-of-bounds memory
corruption?

> +	}
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927-submit-stm=
mac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com?part=3D17

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23DB382F2B
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777737376; cv=none; b=bovdJGcnnYQP3tsM+MoPppT9rKVOkXHAdGscoSDr5/vjZaMxYxqBUeqbTtPtBwQl5FxHygSNquMT1pyJsDYDpesrmzZNIMX8OMYTMxM4wIEzMdXNTKeOpFt1guzti+ctMMTb1XfVEUXC71Heqb+rVNbLy7DylClu3s2JcWHITQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777737376; c=relaxed/simple;
	bh=K/X9JDenG83+2FGxFcZgksyjcT9TnyvdqZvXbAjY57A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KdNPgEOQwgGQMokGU830IQOdbVGHUPUa2AJFJQXamcuSEHl11Y07JZH9gPRxG8JWi115CLK6RKTLssfHO/J9zh9mw+xgAveHokgskGVhXMCXNUXFFpdJ5IQsxfJICN4a2h7hiJ85ACmRUlwwi9iW/dy/y97wqrVSP9RYxCXXH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNpHK6pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNpHK6pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA3C19425;
	Sat,  2 May 2026 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777737376;
	bh=K/X9JDenG83+2FGxFcZgksyjcT9TnyvdqZvXbAjY57A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sNpHK6pMthlQHyh8ral5J1uCKt3qVtX4M2k3XoEI6R+UL90r+TsnktomM+Aqo1H48
	 X743WUkQxX4SXxfXG/Y1GbKKDRDWZ255WHgYUyVL976WQx6/rOk+cXVq3aH070eRVV
	 iTuH5WLv8EzblFGwrxHtwLAkqy/7qCeoIiT95Zh5aHydxNTXSX9z3xnnq4EZzO8BbZ
	 6HJhLnJTB2nRhpTRjh/3nEmuRQ+ZFse5D50hCuTJNHXBhEvd9fQrkIBnsj/QWPUTf+
	 TvvG8XnmxbY2Sb4uH2TZjjUhb20VoH7HODyp+l2o6+n54jURSIPKFpq/dyOVzULeav
	 LNQzkWTFEV9kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 04/12] net: stmmac: dma: create a separate
 dma_device pointer
Reply-To: sashiko@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260501155421.3329862-5-elder@riscstar.com>
References: <20260501155421.3329862-5-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 02 May 2026 15:56:15 +0000
Message-Id: <20260502155616.82EA3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] DMA mappings are permanently leaked if an error occurs mid-packet =
in `stmmac_xmit`, `stmmac_tso_xmit`, or `jumbo_frm`.
- [High] In `jumbo_frm()` (`chain_mode.c` and `ring_mode.c`), assigning a `=
dma_addr_t` to an `unsigned int` breaks `dma_mapping_error()` detection.
--

commit 152df859f4e94baeb0ca419c5b87bcb9e5f13d3d
Author: Alex Elder <elder@riscstar.com>

net: stmmac: dma: create a separate dma_device pointer

This commit adds a second dma_device pointer to the stmmac_priv structure.
The new pointer handles all DMA operations independently from the normal
device pointer, allowing better management of common internal IPs for
specialized Ethernet bridge chips.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/n=
et/ethernet/stmicro/stmmac/chain_mode.c
> index fc04a23342cf..331e6523ee01 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
> @@ -34,10 +34,10 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, st=
ruct sk_buff *skb,
>  	buf_len =3D min_t(unsigned int, nopaged_len, bmax);
>  	len =3D nopaged_len - buf_len;
> =20
> -	des2 =3D dma_map_single(priv->device, skb->data,
> +	des2 =3D dma_map_single(priv->dma_device, skb->data,
>  			      buf_len, DMA_TO_DEVICE);
>  	desc->des2 =3D cpu_to_le32(des2);
> -	if (dma_mapping_error(priv->device, des2))
> +	if (dma_mapping_error(priv->dma_device, des2))

This isn't a bug introduced by this patch, but since the patch modifies the=
se
DMA mapping calls, it brings up a potential issue.

Does the use of an unsigned int for des2 break error detection?

On 64-bit architectures, dma_map_single() returns a 64-bit dma_addr_t.
Assigning this to the unsigned int des2 truncates the upper 32 bits.

If the mapping fails, it returns an error code that becomes 0xFFFFFFFF after
truncation. When this truncated value is passed to dma_mapping_error(), it
is cast back to a 64-bit value, which no longer matches the expected error
code representation.

Will this bypass the error check and record an invalid physical address in
tx_q->tx_skbuff_dma[entry].buf? This same pattern also appears in the
jumbo_frm() function in ring_mode.c.

[ ... ]
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index ca68248dbc78..1104cf750295 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
[ ... ]
> @@ -4876,9 +4876,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb,=
 struct net_device *dev)
> =20
>  		desc =3D stmmac_get_tx_desc(priv, tx_q, entry);
> =20
> -		dma_addr =3D skb_frag_dma_map(priv->device, frag, 0, frag_size,
> -					    DMA_TO_DEVICE);
> -		if (dma_mapping_error(priv->device, dma_addr))
> +		dma_addr =3D skb_frag_dma_map(priv->dma_device, frag, 0,
> +					    frag_size, DMA_TO_DEVICE);
> +		if (dma_mapping_error(priv->dma_device, dma_addr))
>  			goto dma_map_err; /* should reuse desc w/o issues */

Similarly, can this leak DMA mappings if an error occurs mid-packet?

If skb_frag_dma_map() fails for a multi-fragment packet, the code jumps
to the dma_map_err label. However, tx_q->cur_tx is only updated at the very
end of the function upon complete success.

Because cur_tx is not advanced on the error path, stmmac_tx_clean() won't
unmap these partially filled descriptor entries. On the next transmission,
the driver will start at the unmodified cur_tx index and blindly overwrite
the tx_skbuff_dma entries.

Could this result in permanently leaking the previously successful DMA
mappings? The same concern appears to apply to stmmac_tso_xmit() and
jumbo_frm() where multiple fragments are mapped sequentially.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260501155421.3329=
862-1-elder@riscstar.com?part=3D4

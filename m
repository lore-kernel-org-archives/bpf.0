Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E3442397
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241331; cv=none; b=C0sZrMByGQ6JKPmKZmBMXc3BYVUYYtOkPsWD/YbUvk5DfSVJU7S6oOBb7jJNJVc9peY2un2gXeJjxzdlSNf3yMLvlLJdDi8eKKwiaDyT91UgjL+fZiXslJ7sTT1JBrVx9zQ8uxXPIVzBusVJexq3JHB6rzZZ1jcdxSZVrSZJIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241331; c=relaxed/simple;
	bh=RHDCCkVs8tDCGLl7VdbnSLmy7AOHiT7IxMoar3pGZTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3sRb6Nt30gFA6VFZpsz/SpGbyI36qwwAMdIMDJM6nSsS2ONW4DSYzl8L937F1rKzksmxSRBDrjkD/1AGlqOKKxXfTYqxYWyP2vm7pRt1zpR1aoNPL6fOEuyM+k9e+cLWBVatgLlH5Zbtr7tQeCvfHvr38w4g3Kk+Z+N3lo5SYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOSv2Z6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOSv2Z6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9131F000FF;
	Thu, 24 Sep 2026 09:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241330;
	bh=Q/AIhdNFIA82q4Ft2e+e3NKhPdXqvcnDww5ec9HB/SQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOSv2Z6UMo+4Mhutw3Eudc0/Up37fQ4ZaSNZvXF+N2Z6d8GGpryAkvPwWn+t8FtFD
	 GTWmmBr9golgF+yXlycm/OGj9y1vg+O7JJSZMgshyM+tcsraSQSpL+ZXvyOfSuxboJ
	 ZuEzkfZRXAU2RMPlToHlpGiMWtZBnHMNFXhnI3biGhDBQkt11+TybIU9BUsNlXAXV5
	 nsFT39tgQ6BD5vy8MDO1ITNKklb65rROggqnC1xBYD7YtUafB22H/wmO+GUcg+PDKS
	 Ey1rjt1r/rG7zbNZ2vFEf2f0XA2qZYJSqRW2RhWhCbmdkoGKFSrau2Fq2u9XSFJkyK
	 DPA0Mklq0EVpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net: stmmac: fix rx Scatter-Gather support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
References: <20260923-stmmac-rx-sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:15:29 +0000
Message-Id: <20260924091530.0D9131F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: stmmac: data corruption in multi-descriptor frames with XDP o=
n legacy MACs
--

commit bffa481d7cb386a04b24759408cee45add543fcd
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: fix rx Scatter-Gather support

This commit enables scatter-gather for non-SPH frames on GMAC4/XGMAC cores =
to
address an SMMU translation fault on oversized frames overflowing the buffe=
r. It
also updates FCS trimming to use pskb_trim() on the assembled skb instead of
subtracting it from individual buffers.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5809,24 +5814,25 @@ static int stmmac_rx(struct stmmac_priv *priv, in=
t limit, u32 queue)
>  		len +=3D buf2_len;
> =20
>  		/* ACS is disabled; strip manually. */
> -		if (likely(!(status & rx_not_ls))) {
> -			if (buf2_len) {
> -				buf2_len -=3D ETH_FCS_LEN;
> -				len -=3D ETH_FCS_LEN;
> -			} else if (buf1_len) {
> -				buf1_len -=3D ETH_FCS_LEN;
> -				len -=3D ETH_FCS_LEN;
> -			}
> -		}
> +		if (likely(!(status & rx_not_ls)))
> +			len -=3D ETH_FCS_LEN;
> =20
>  		if (!skb) {
>  			unsigned int pre_len, sync_len;
> =20
> +			/* Each frame starts here: reset the FCS handling */
> +			fcs_stripped =3D false;
> +
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
>  						buf1_len, dma_dir);
>  			net_prefetch(page_address(buf->page) +
>  				     buf->page_offset);
> =20
> +			if (stmmac_xdp_is_enabled(priv) && !buf2_len) {
> +				buf1_len -=3D ETH_FCS_LEN;
> +				fcs_stripped =3D true;
> +			}

[Severity: High]
Does this incorrectly strip the FCS from the first descriptor of a
multi-descriptor frame on legacy MACs?

On legacy MACs, buffer2 is not used, so buf2_len is always 0. When a scatte=
red
(multi-descriptor) frame is received with XDP enabled, this condition evalu=
ates
to true on the first descriptor.

Because there is no check for whether this is the last descriptor
(!(status & rx_not_ls)), it incorrectly subtracts 4 bytes (ETH_FCS_LEN) fro=
m the
payload in the first descriptor, corrupting the packet data.

Additionally, because fcs_stripped is set to true, the actual FCS at the en=
d of
the frame will not be removed when the final descriptor is processed.

> +
>  			xdp_init_buff(&ctx.xdp, bufsz, &rx_q->xdp_rxq);
>  			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
>  					 buf->page_offset, buf1_len, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-stmmac-rx-=
sg-fix-v3-1-ed26fea7180d@oss.qualcomm.com?part=3D1

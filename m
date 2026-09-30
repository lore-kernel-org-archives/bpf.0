Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F83B3C1B;
	Wed, 30 Sep 2026 04:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743927; cv=none; b=FXqDCNaIdXYucaKdlaTGbvtNVxwvekzRD26fOStvSzUBIgQw+Jl+AHGOVCBQ6n3TcULV8vak+VQELpWZ3ieoC+m6MqqRoJZTKBeBRb5Att2hax73ELNCa0BEhSNPdH5Uv/3VGWcqz/EskitKzxwLE+dKMcvzO71WahMtbqJ42+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743927; c=relaxed/simple;
	bh=5HaItgUdKXWkzt4QBlQwFzKR9vfULlWEsUFVHPqPOf0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S9JbfKWjtI2iw1mrfvLc4Q8kzXYfgsEksxjZibPjor8UBIjhqVD5sqyVWa0TkRQq8u4kfSca9c59TdUPflreK79IVnzANd91S2E/OlCdqw69FS2QcfatjbNSFMIk3G8+ErKuychueX2nj1m5y19SUwN9zM5MEWs/nbDKapag3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNUdGE/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNUdGE/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1661F0089C;
	Wed, 30 Sep 2026 04:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743924;
	bh=g4v/SlSrMWhRmKgKZpxJZbQ3XgkC6m+SuApI5SmLzbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SNUdGE/4w/MV9SepRf30+62g2pOVR91AkxoKQEXZyPZTdPjLloqVBmHWdfhrS3nWe
	 dlkd5Wi/wavsSZmitQeI7AO+xB479TC+vS683a2Dl+iYaWuvQQ/+4tzHWnSUuIjH15
	 +rM6VU5QO84iCZ7wxkqpQ9KS40pKLVbPqIwaPayRWOqrbU5Z6gofyNlZ9CU5XPx4b0
	 etLIqoUtjth5bKyoLIfFgRKnjq18tTCXcyNUiaT075JSz3JgwIfC2D3zLV/+lbHKRf
	 lP1QN6iJmNSix6B44gIhZjKod4s+e57Xe++P6HFO2uwJ31Vsaxo5KH6eVBuC3npDb7
	 S3YzX11gX20Bw==
Subject: Re: [PATCH net v4 14/15] net: stmmac: prepare device-local DMA
 interrupt quiescence
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 qiangqing.zhang@nxp.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ansuelsmth@gmail.com,
 yangtiezhu@loongson.cn, chenhuacai@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, fancer.lancer@gmail.com, quic_jsuraj@quicinc.com,
 richardcochran@gmail.com, Joao.Pinto@synopsys.com, vladimir.oltean@nxp.com,
 boon.leong.ong@intel.com, weifeng.voon@intel.com, yoong.siang.song@intel.com,
 linusw@kernel.org, martin.blumenstingl@googlemail.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, horms@kernel.org,
 bjorn@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com,
 wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org,
 edumazet@kernel.org, richard.genoud@bootlin.com, alastair@d-silva.org,
 mripard@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 zhaojinming@uniontech.com, lorenzo.bianconi@oss.qualcomm.com,
 dinghui1111@163.com, linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev
Date: Wed, 30 Sep 2026 04:52:01 +0000
Message-ID: <179074392155.434549.735897685486251330@kernel.org>
In-Reply-To:
 <20260926-submit-stmmac-reset-fixes-v1-v4-14-ec1c0250b3c9@gmail.com>
References:
 <20260926-submit-stmmac-reset-fixes-v1-v4-14-ec1c0250b3c9@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch includes an unrelated whitespace-only reflow in
  stmmac_free_irq() (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c).

--

net: stmmac: prepare device-local DMA interrupt quiescence

This commit adds DMA interrupt-mask accessors (set_irq_mask) for the
supported stmmac cores, plus a per-channel irq_quiesced gate that the
channel lock protects. When the gate is set, stmmac_napi_check() masks
the channel's DMA interrupt sources again. It does this without
acknowledging pending events and without touching the rings that are
being replaced.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4d70645c4a4f8..08049c05ffc48 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -3995,8 +4011,7 @@ static void stmmac_free_irq(struct net_device *dev,
>  		for (j = irq_idx - 1; msi && j >= 0; j--) {
>  			if (msi->tx_irq[j] > 0) {
>  				irq_set_affinity_hint(msi->tx_irq[j], NULL);
> -				free_irq(msi->tx_irq[j],
> -					 &priv->channel[j]);
> +				free_irq(msi->tx_irq[j], &priv->channel[j]);
>  			}
>  		}
>  		irq_idx = priv->plat->rx_queues_to_use;
> @@ -4005,8 +4020,7 @@ static void stmmac_free_irq(struct net_device *dev,
>  		for (j = irq_idx - 1; msi && j >= 0; j--) {
>  			if (msi->rx_irq[j] > 0) {
>  				irq_set_affinity_hint(msi->rx_irq[j], NULL);
> -				free_irq(msi->rx_irq[j],
> -					 &priv->channel[j]);
> +				free_irq(msi->rx_irq[j], &priv->channel[j]);

[Severity: Low]
This isn't a bug, but these two hunks in stmmac_free_irq() only join the
tx_irq and rx_irq free_irq() calls onto one line each. Nothing else
changes.

The commit message describes the DMA interrupt-mask accessors and the
irq_quiesced gate. It doesn't mention the IRQ free path, and this reflow
has no connection to interrupt quiescence.

Could the reflow be dropped from this patch, or sent as a separate
cleanup patch?

>  			}
>  		}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-submit-stmmac-reset-fixes-v1-v4-0-ec1c0250b3c9%40gmail.com

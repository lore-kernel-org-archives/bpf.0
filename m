Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5636EAB0;
	Fri, 16 Oct 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160300; cv=none; b=Eq15puY53IBuFRTYSu4kLpoqzAMmScKOBoeFA+lyRqNOR09KWpLT7x4j3qfPkjdfQGGhDJ4+dTlBtXP73teek96WR7bv2nHXkmU6XY3d9ZXUahH2VgBF7vIWOwzBFXxwbgINwl0PYmO/YhaIr7PnnKarL4+40duGYk6tx8XYqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160300; c=relaxed/simple;
	bh=6fPTbXuXpebnLxYlJmv8nSqO6htrsz1cdf2F38c7eGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf/MigKxKzUOpAyCvuyIHHpRd096DW0/ql28/ZYCt7xImoSR6NcX3BQdTlh2sYGKjIbaF0KEgKza1ia0NjeHFE9qlcXpj/5vg7vo5zpeu/GjYsoHbIqmqb79oxzCyeZOXWa2yVQyuNX+G3n6Pd4Iddr9VgfTXt64BuazuzE0K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VGpBpV3/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VGpBpV3/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 17AF4C62214;
	Fri, 16 Oct 2026 14:19:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98E7C6075D;
	Fri, 16 Oct 2026 14:18:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C2F10328528;
	Fri, 16 Oct 2026 16:18:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792160291; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZJ2733YwARgE1Qwcji1IsWT4iPJBGi64T05DaYIrqJI=;
	b=VGpBpV3/mIpN8RCvaqNdFYhlEv8JpqL/IKivBqkMOrjOuWJqcA7bEDCo3rUg6z5C5nrr0s
	454BQNZGYsXDory6vk9waOY9JZE/GvN9H71zUVkhP5rfPxyHm5RvdtCe4ITjX17k1C5cg7
	+Ac6PvEwWTeBz6KayzJ6Fo8clSJR96Y9YrfuBn34m1j8Vqoeari2xi8GCiqKVV/JJcBfmg
	Gcrso3ExZUxSzKGWlkH1yjqfEoQTCdJ2pdHTYX4Bv0+ASeX/CrYt/JA6m+0xe3rl7Q9L7D
	FUM5Zi9+1sB/5MF87OmJkeBdVpM8gdAlU4GZWLq7WOf6dRHcvHkj2X3hO9+oSA==
Message-ID: <6d1d99b5-1c3c-4e59-a0b2-e4d671e594ce@bootlin.com>
Date: Fri, 16 Oct 2026 16:18:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: disable TX checksum offload for
 jumbo frames on bugged cores
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Ong Boon Leong <boon.leong.ong@intel.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20261012-stmmac-xdp-tx-pre-fixes-v1-0-05fd0c90f7e1@oss.qualcomm.com>
 <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261012-stmmac-xdp-tx-pre-fixes-v1-2-05fd0c90f7e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lorenzo,

On 10/12/26 17:24, Lorenzo Bianconi wrote:
> stmmac_xdp_xmit_xdpf() decides TX checksum insertion from the queue COE
> capability only:
> 
> 	csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
> 
> and lets the enhanced descriptor set TX_CIC_FULL accordingly. On the
> bugged_jumbo cores (snps,dwmac-3.40a, snps,dwmac-3.610 and
> snps,dwmac-3.710) hardware checksum insertion is broken for jumbo
> frames; the skb path works around it by clearing NETIF_F_CSUM_MASK in
> stmmac_fix_features() when the MTU exceeds ETH_DATA_LEN, so skbs are
> never marked CHECKSUM_PARTIAL and no checksum is inserted. The XDP TX
> path bypasses that workaround, so once XDP is allowed at MTU >
> ETH_DATA_LEN, jumbo frames sent via XDP_TX or redirected into the
> device would leave the interface with a full checksum insertion enabled
> on those cores - exactly what the workaround is meant to avoid.
> 
> Disable checksum insertion for oversized frames on bugged_jumbo cores in
> the XDP TX path too.
> 
> Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Looks cleaner to me than the alternative patch from Jisheng :

https://lore.kernel.org/netdev/20260929121025.20821-1-jszhang@kernel.org/

It sure seems there're a lot of people interested in getting XDP/XSK
working properly on stmmac :)

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ca61ab449e32..0e29c5d04714 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5276,6 +5276,14 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  		return STMMAC_XDP_CONSUMED;
>  	}
>  
> +	/* Disable TX checksum offload for jumbo frames on cores where
> +	 * checksum insertion is broken for oversized frames, matching the
> +	 * stmmac_fix_features() workaround used by the skb path.
> +	 */
> +	if (priv->plat->bugged_jumbo &&
> +	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
> +		csum = false;
> +
>  	while (true) {
>  		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
>  		int len = frag ? skb_frag_size(frag) : xdpf->len;
> 


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870509;
	b=JbM/i2diXbHSQiPEgnlG67M0Nur48C6pPPf6LrY4MvE5YmiOU8a6Frr0PsYMrXDaN50p
	 Z5OK2CplD57O2cGPWynOB0JU5hA2m8auAFE/grmE/83bWjxsHhttciqHTyNZjng9pB9Zc
	 Q3URYFKgKzvpscNoJxWYtTqW+Edfl0Gb4Fm8ZrJk5zniwEATjPSfzOd/6BH99jh9LZXK8
	 Kc9kND6LFpf377wRYttUAG3qUQUL7C0FrCSXYPG/nOGlGlkrOEoB5Nihor1qP/cDdupf+
	 PWS83Dmeg9hxc7MbtHAXLarpLFV6fqOFr6zpoP7rQ96wAnMh8Wlvs1VhGKlDN3K3raA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870509;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=uPCau9lp+BpbylcdJNudW5r9b3sR9WDS743Y91v+hfg=;
	b=SUaokxMfBeivfRd1jQJuN+CtDfYfUOPsFCv4vYdQfI7qXBvamWIhMI69uuP/el+X6C2X
	 jhOZH3eUvL2RJmM3WxFMZ+HYqhEUFoiPNDS1pLJAErLnotknKE1nBhQHENTgo+3G6dKE7
	 QN5x9HYFc+HkSUS5bhgJRUkGmmOGlLssIP0z9EedcRH36z8s4HZTU21B3t0pD16VLnOOg
	 AZA8WkFZ8qym95Mcb/w1Arees6V0DvnFgCU0pYdcO2Jsownzus4gkJKLGOW7bX3F3CPZ/
	 L0R3gwaaSmAacPQ0g+YDukoqExYtjIhfRrrwUJ0TxlnRfvLVrE/SpiamNXAsjNwtJkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="0/vPB2c/";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D252606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 09:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D252606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0/vPB2c/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3064AC69156;
	Thu,  5 Nov 2026 09:21:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1029E5FF85;
	Thu,  5 Nov 2026 09:21:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01BB110328E77;
	Thu,  5 Nov 2026 10:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793870503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=uPCau9lp+BpbylcdJNudW5r9b3sR9WDS743Y91v+hfg=;
	b=0/vPB2c/1f9mEl0RkFlMBsx8PHjAfybM5XFJlrhhhrnGot3pGM1q+VjozisV0cV4kdd3aW
	4dDqCBw8HTqr+m23zLyP4kXnfcyvvuErXq+z0m/8HA3I4s9o56fBTdktLmsSGfOn4seGD4
	7THsZ5WIapjan2XNdhjMJNhLlIc9qF+dX5YkNxqW+irp2k8+4xyoFJCLC8NKe0SJia/Pps
	MIOQLv3Gvwa2BD4lg6aeKXiN5y1x10RqMDbRurEEEky8u9oStlzQ5ZewBHiuFKWcAygiA3
	O2uMiiSrb290vBmWBS681d3uwJMYqafNaN9NeVX4OUcv4UnmDbBeYQArdPCuBw==
Message-ID: <8f310c06-8f02-4870-b7e5-ab58184207bb@bootlin.com>
Date: Thu, 5 Nov 2026 10:21:34 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: set XDP metadata length on the page_pool
 RX path
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
 Song Yoong Siang <yoong.siang.song@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bpf@vger.kernel.org
References: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261102-stmmac_meatada_pp_path-v1-1-d93cc4f9a864@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/2/26 12:46, Lorenzo Bianconi wrote:
> stmmac_rx() initializes the XDP buffer with the metadata area valid, so
> an XDP program can reserve metadata with bpf_xdp_adjust_meta() and write
> it in [xdp->data_meta, xdp->data), for example to export the RX hardware
> timestamp obtained from the metadata kfunc. When such a frame is passed
> to the stack, the skb is built in place around the same page with
> napi_build_skb(), but skb_metadata_set() is never called.
> 
> napi_build_skb() clears skb_shared_info up to dataref, which includes
> meta_len, so skb_metadata_len() stays zero. The stack and TC BPF then see
> an empty metadata range even though the bytes are present in the skb
> headroom. The AF_XDP zero-copy path already records the length in
> stmmac_construct_skb_zc().
> 
> Record the metadata length after reserving the headroom and adding the
> frame data. No copy is needed because the skb is built over the buffer the
> XDP program wrote to. With the length recorded, the software VLAN
> stripping path can move the metadata together with the MAC header, as it
> already does for zero-copy frames.
> 
> Fixes: e3f9c3e34840 ("net: stmmac: add Rx HWTS metadata to XDP receive pkt")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

LGTM, matches the ZC path,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b038472b9817..f97f6dc08789 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6012,7 +6012,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		}
>  
>  		if (!skb) {
> -			unsigned int head_pad_len;
> +			unsigned int metasize;
>  
>  			/* XDP program may expand or reduce tail */
>  			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
> @@ -6029,10 +6029,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  			}
>  
>  			/* XDP program may adjust header */
> -			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
> -			skb_reserve(skb, head_pad_len);
> +			skb_reserve(skb,
> +				    ctx.xdp.data - ctx.xdp.data_hard_start);
>  			skb_put(skb, buf1_len);
>  			skb_mark_for_recycle(skb);
> +
> +			metasize = ctx.xdp.data - ctx.xdp.data_meta;
> +			if (metasize)
> +				skb_metadata_set(skb, metasize);
>  			buf->page = NULL;
>  		} else if (buf1_len) {
>  			dma_sync_single_for_cpu(priv->device, buf->addr,
> 
> ---
> base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
> change-id: 20261102-stmmac_meatada_pp_path-0c1b9299e2fb
> 
> Best regards,


Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A41F5EA
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360889; cv=none; b=oCP8nIwiGjig0TfnWdcQN1At0Y9AWt1158h6D9ZtsJRHPu0mfmwVH83Tu+8pvoKK8TsRzG1GZDzAbGYpBfNxIoYLrlI2GmgkO9iXdr9jngM+crZ9WiWJxO/rpTi8ejJn4lYI4CjJy+pAZgAcIMfDKgVNcOuw3gevM5gsH1FO5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360889; c=relaxed/simple;
	bh=KdGdIosxGVCnVTmHO7nXcKEdC5Z/YV7CUzxv2yNCaAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjjwQCT2akSFWlJH/OChadj8L/TRzjW+Pr1V17NL/N/Lonnx62uXqFlwE9Adc5c6oIUcpJBR0kD6CbxoszsdMpl3CSFeesiVngKu1WBWeDA5AfHy5wsLtegpkBPcpkwP2zoJLenGR5rIeIVkDqsAKaC4Fz3TuqAEn69jXDXnGZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fWeBTqmS; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fWeBTqmS"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-79901821bb0so18642297b3.2
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360886; x=1773965686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkE3keE0SIqgIdKBzUwz50sfscGesq4fS8DBICuT/rA=;
        b=fHjhlgAhsb53p3N0dZmZ22b/Vdlffqv5KsBVG9hxo9Q26/i6lk4yVDi2Qfd7e7aX4O
         954wnEfYPCh01mB/X4mQK/cPjDTGWFyI7ZnKkby9/St8PANSxD3PFO9HSGKroBhGZ/re
         UsRZuUgB0ra3n0mBGddXTrpnap8uwsG1CuouhrJ/RICvdigqelgFBnxlqKS5bLj/qwdh
         39SRcOjX2lAhwOrXDV7o56uP4OZHrJpx2BkA4/HlF40jGMJk8ThekDPDhl7hMPEgMfat
         a3ZThxpMYufsIRR4CFTgHVHHTqTpMLxGBI5HjzFSh8fgbrsjRQZBHCmek1ikCIHKZO7S
         ppKw==
X-Forwarded-Encrypted: i=1; AJvYcCUogfIPBaWogjj0XoU7ve0SnAX9nURr+JRaXU1WXyeg9WV9E71PQZAB+4Vnnc0uBRuStQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfExgJZp4cW2ii948M2ekkkd1KyfCrzPfG7ya6/O8BWBxO9MZ
	3zwfO7k9i73zYr5V/cIH7AeKbsnqkGLzpuxlcTrYLs1bXlajclNwvrJKmRQgjOWzpqREMLM2VjS
	G35MAC4U1Tn0dd6DqIjgDfwVIXh9aYy98x45TCcEz4d9u/MM2fkN4X3629l+CDzPXKCwfB1SOxM
	5WuSZSYzS172JWCaqSSBm7bD6rFw16r6VWBfU5jI5sqkfzTJHFoQty2BAGqTPfVaq6jbwCR0q/V
	/02oETa/BJeqw==
X-Gm-Gg: ATEYQzwNotj9tvjIpgMff5flBnABFr2aLrE58/Y81MFuRG6Ot7qqxbzaVzBxUnaKTXJ
	Jqc1QAoNauyAUmFrYCQkP6VlOuZIj/cO/vIAhmO68FOXqmT1T2dIC77/ccdQs7N87HnuEBCq9dh
	RIShnQ+7M+SlEncu2lIN7txuyL7NwkiL3D5vuXHEpp7pHMRurG9shA2A88kfXht2Vm5d4EruWCE
	YOvIb3262JWMNzs8R2Nhu0iMwJwIPySzK03bnoFPJd4BX7Gz6g5J26ZIypgYmPC+/7NX/iY019/
	oME36oH71Hi8TD95cAn+bJ0n3TLS/x/m/e2+UE/vKtsqt3OFK5nE0ktrUsGW7rMDaIClP/wUxzT
	ivrabtMJA4yS1AHZXEvuEn3GAnHhKXgm7qbWcFvaXheGiU7qkQCQnTi/QhNNSkUKuSCqYxGU1Vi
	pfbzFBWA7nDIXDMCueM/R6X0b+YNgzwAqlYQ+fcnH4xAx5sGB56YMk74J1aS40uB0=
X-Received: by 2002:a05:690c:6891:b0:798:6898:9717 with SMTP id 00721157ae682-79a1c0f285emr17867527b3.27.1773360886379;
        Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79917dfc9e4sm6586817b3.7.2026.03.12.17.14.46
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89a0796368eso56523156d6.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360885; x=1773965685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkE3keE0SIqgIdKBzUwz50sfscGesq4fS8DBICuT/rA=;
        b=fWeBTqmSs2Db3lmU9OqLpGJtClZ8Yw7CVuhYL6BOOyi9P+ki0qz/MLQSHS8X3vuCAd
         6jpA51Ef5t/6q22f3MAbnKvgkmU7lkthmJPuYyEccRKDGjOS5e55WOCSVEa/FjDlW9DS
         SRVJXDgtDVEH3NbtoTG3g7CJ7XHi70/ju31no=
X-Forwarded-Encrypted: i=1; AJvYcCXWoH/vHH15ANTdnUsh/Xo8zYTcB+02gEt4bkr7TFEegoNSriSfi8o51fWCuyepViJS6F0=@vger.kernel.org
X-Received: by 2002:a05:620a:4153:b0:8c7:139a:bf48 with SMTP id af79cd13be357-8cdb5b20a75mr233368485a.49.1773360885634;
        Thu, 12 Mar 2026 17:14:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:8c7:139a:bf48 with SMTP id af79cd13be357-8cdb5b20a75mr233365285a.49.1773360885124;
        Thu, 12 Mar 2026 17:14:45 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fddfe8sm437647185a.12.2026.03.12.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:14:44 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:14:39 -0400
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, joe@dama.to,
	kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp
 context
Message-ID: <abNWL8L64m7rweRh@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-2-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-2-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Mar 06, 2026 at 05:00:16PM -0600, Chris J Arges wrote:
> This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
> pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
> along with the completion type.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c982aac714d1..ab73aad40593 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	bool xdp_active = false;
>  	dma_addr_t dma_addr;
>  	struct sk_buff *skb;
> -	struct xdp_buff xdp;
> +	struct bnxt_xdp_buff bnxt_xdp;
>  	u32 flags, misc;
>  	u32 cmpl_ts;
>  	void *data;
> @@ -2231,9 +2231,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	dma_addr = rx_buf->mapping;
>  
>  	if (bnxt_xdp_attached(bp, rxr)) {
> -		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
> +		bnxt_xdp.rxcmp = rxcmp;
> +		bnxt_xdp.rxcmp1 = rxcmp1;
> +		bnxt_xdp.cmp_type = cmp_type;
> +
> +		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &bnxt_xdp.xdp);
>  		if (agg_bufs) {
> -			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
> +			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &bnxt_xdp.xdp,
>  							       cp_cons,
>  							       agg_bufs,
>  							       false);
> @@ -2245,12 +2249,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  	}
>  
>  	if (xdp_active) {
> -		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
> +		if (bnxt_rx_xdp(bp, rxr, cons, &bnxt_xdp.xdp, data, &data_ptr, &len, event)) {
>  			rc = 1;
>  			goto next_rx;
>  		}
> -		if (xdp_buff_has_frags(&xdp)) {
> -			sinfo = xdp_get_shared_info_from_buff(&xdp);
> +		if (xdp_buff_has_frags(&bnxt_xdp.xdp)) {
> +			sinfo = xdp_get_shared_info_from_buff(&bnxt_xdp.xdp);
>  			agg_bufs = sinfo->nr_frags;
>  		} else {
>  			agg_bufs = 0;
> @@ -2261,7 +2265,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  		if (!xdp_active)
>  			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
>  		else
> -			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
> +			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
>  		bnxt_reuse_rx_data(rxr, cons, data);
>  		if (!skb) {
>  			if (agg_bufs) {
> @@ -2269,7 +2273,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
>  							       agg_bufs, false);
>  				else
> -					bnxt_xdp_buff_frags_free(rxr, &xdp);
> +					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
>  			}
>  			goto oom_next_rx;
>  		}
> @@ -2293,10 +2297,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>  			if (!skb)
>  				goto oom_next_rx;
>  		} else {
> -			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
> +			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
> +						 rxr, &bnxt_xdp.xdp);
>  			if (!skb) {
>  				/* we should be able to free the old skb here */
> -				bnxt_xdp_buff_frags_free(rxr, &xdp);
> +				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
>  				goto oom_next_rx;
>  			}
>  		}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index 8933a0dec09a..8c66698bde11 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -12,6 +12,13 @@
>  
>  DECLARE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
>  
> +struct bnxt_xdp_buff {
> +	struct xdp_buff xdp;
> +	struct rx_cmp *rxcmp;
> +	struct rx_cmp_ext *rxcmp1;
> +	u8 cmp_type;
> +};
> +
>  struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
>  				   struct bnxt_tx_ring_info *txr,
>  				   dma_addr_t mapping, u32 len,

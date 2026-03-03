Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC163537F6
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562154; cv=none; b=OC977xeOmDoAUh8Oa2wX74h+di6okPEd50wC4uy+u6UdsPzN1NqX+kJoGUZTqMxcwZ5Eyx2Wo3Xq44sV7ShO9U/GWh9oJcw61urqPI3omtM35s6q/6TUcUmN92ZLpoWjYx65BL0RGrQGaflpf32qzfp9XJ1alMow8NFdeBzkUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562154; c=relaxed/simple;
	bh=tpQuM+5W84CjfyPtIB/HGmRUoecN9Co8woJs1AoFHRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DO2RV0RtJdEZz+rlbB3iPmtFpAwPaN2rTgHow638JdEHDmsS8S7HLfVM11hkgXLf6vnL/7k0SY1X5wyaNXQJLhHWk8p4FXQoE5oK9CAjqyygS/SnjiUfA/xhpQMLwdTORKVj95tV5Jp63cgAETxTp7FhnoQOTG3/HhmobpWkiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=RzNN+vLP; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="RzNN+vLP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae4988e039so18433665ad.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772562147; x=1773166947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buu7Uz55KYttMA+alRRNNRRlc+ACOAEsL4P+TKZKLiU=;
        b=RzNN+vLPpMzzPeOKrosA+GPJJhvCOtZ3HRH0potipfCgc1oCjsQ+mA5k5t2BvxCvT0
         p3+hdgmujTSosjR0R9JgV0SkHr3A4IAHHH/YKqUXtubdIWQPQbuZIf2pgZNA5c/F8hqR
         lyhsTDtO8+sYJdCoGwqmvL8scJsHt6dqRfahDHVh64Myz24c+2xMZAeLdqCglhQ6yaCl
         cB28YGvAu+nFNERycNm3Fgpt5P0QQDY+FRy1QPAtQ1+mOeBN1Bvye4raRAcEEbJU9L6k
         jknKpLGgZQOYQz9A0uuzHr4sUDRGXVGdOSDGCwISLccvcADircwgmJ0+g5F8XA9pt19C
         hPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562147; x=1773166947;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buu7Uz55KYttMA+alRRNNRRlc+ACOAEsL4P+TKZKLiU=;
        b=fszxOb+NSMVrFFwzU9VBmb8PAGCWHSIy/na6XSWLsPXAuLDJPryIV1W+IsMIZ/+iBW
         364y5QINmjRfmbTOLP8nA6wSFoDxECQFN7BHbQzg4NEMPo0HkxRTWJ8WUDBIeDqD0cPS
         7r2JAqU+WclJfpHx88g277Yn2Yz+K466YZX9NQyW0ns25fhz31mdvtgzcVVl/9tAoqKH
         fkDtwO2B2y0YuDRU27yPx0GH51hX93xSpNswrFEn3pGh7TMbsSlQgOkbU3Y7rWMWyC0t
         gvKH6UCyCZQGsZVO/dJJpVYYSlXpx4D2USXZ/rkKRpzpT8VEdLEZ4oYeo06YuT6LTIrr
         fQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0JLUuq4nQwfuX2wvCMiGwgKr1yGPUJQ+tQTCR+qkFhsm++Yb1TXwcrrCWD6RFSYifyRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9cYhrlhxdFoAeZ93wHiK63Uo+x/wofOazi4cwXIjJr1mr7/U
	VOm+bNeFDXCLDZbyMDNJ39sBLg3ICgXnFpX6kPVzxyxgzRXKnlkY79KTa2RC+jskGwNMXxSfo/Q
	FLxdAJJ4=
X-Gm-Gg: ATEYQzwZcrRZhDxiPInwGEfn0Hl5yY9R5Mrzeu1jM9Dsd+IBmSzEz2Uvc8kmoZV8LnQ
	z9nGEjjNfANyLEDt9BKTiBGIG0YjLO9CtIulYGm/+cFO/spLcLSWxzqC9XXFkY9dq4TyWnGsQsK
	Uh62wwU45RgU+PuTp3PVTpfN6PcN8xZ5mL93F4uWHXbGx1lMPYbfWMTpGKvYIoPI8I7O76EKCB5
	gC2LA49aTcXaUs9l1JMiwpEJS0qffcfWbXFBgd+WJmoHwExevh+gCrAS5NUlCg1PRCpNriq/sTF
	xMbPmXc6r7fIXZSC44DvHIZRy+cWbdQHzkPJLzxeLxKHgm8zDFrkL+9olYexq0cBBLuA748wMHs
	R1fn5gWoLvYhLqmVoCHangqFagVuNnAUwOo8/faH7tZodM62PUT9+QqTgYaRhwqU/FaQXeEYXa5
	LmoW+OhZE6pAJFMQ==
X-Received: by 2002:a17:903:1905:b0:2ae:47d7:e101 with SMTP id d9443c01a7336-2ae60c53f62mr27683895ad.1.1772562147351;
        Tue, 03 Mar 2026 10:22:27 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f283sm174125805ad.49.2026.03.03.10.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 10:22:26 -0800 (PST)
Date: Tue, 3 Mar 2026 10:22:26 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aacm4vPHq8V42lw1@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
 <20260303024510.644962-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303024510.644962-3-carges@cloudflare.com>

On Mon, Mar 02, 2026 at 08:43:50PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ab73aad40593..c06033cf9f82 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15906,6 +15906,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
>  	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
>  };
>  
> +static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
> +	.xmo_rx_hash		= bnxt_xdp_rx_hash,
> +};
> +
>  static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
>  				    struct netdev_queue_stats_rx *stats)
>  {
> @@ -16790,6 +16794,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto init_err_free;
>  
>  	dev->netdev_ops = &bnxt_netdev_ops;
> +	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
>  	dev->stat_ops = &bnxt_stat_ops;
>  	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
>  	dev->ethtool_ops = &bnxt_ethtool_ops;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 90fa3e93c8d6..34bb98709f2b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -232,6 +232,7 @@ struct rx_cmp {
>  	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
> +	 #define RX_CMP_FLAGS_ITYPE_ICMP			 (7 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
>  	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
>  	#define RX_CMP_LEN					(0xffff << 16)
> @@ -311,6 +312,7 @@ struct rx_cmp_ext {
>  	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
>  	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
>  	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
> +	#define RX_CMP_FLAGS2_IP_TYPE				(0x1 << 8)
>  	__le32 rx_cmp_meta_data;
>  	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
>  	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..1ab3d9f9b3ac 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
>  				  xdp_buff_get_skb_flags(xdp));
>  	return skb;
>  }
> +
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type)
> +{
> +	const struct bnxt_xdp_buff *xdp = (void *)ctx;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	enum xdp_rss_hash_type hash_type = 0;
> +	u32 itypes;

Sorry don't mean to nitpick (also: I'm just a random subscriber to the list so
maybe the maintainers don't mind), but I think rx_cmp_ext needs to be moved up
to preserve RCT ?

You can retain my Reviewed-by (if you respin) because the rest seems OK to me:

Reviewed-by: Joe Damato <joe@dama.to>

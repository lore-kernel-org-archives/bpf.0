Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C41DF75B
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360916; cv=none; b=Gp7OVTdhYnobVBuuarLuIRjKbK0piIJ/NAeND+kGmGwgMioa8Pay6Mbcky/RzEBnk29pReDH0r3/1UeXkWZAoPXnDq37SKqzzKCVVupHo3veWqjXqac0an9dzhysiVACjq2ULdRzBrhGxUFrAj1kbTfXN8jSBrXlapPnCq8U0Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360916; c=relaxed/simple;
	bh=Y9lEMiOJWuVnBliGg+6TyD1WzpSYX0eYA4l5wRczvYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxwF/iOb61WvY2SXxo+1nzxo/U61EhY8HAGlyw9+G6gqS0sYx2jTEtM1VO8P4OPtsjXwx6AXN/C7lJ8avXVSrMBXffO2KceNMFyLrrsrFNLclf1lH02SyVXKvZywlWA/sI5fFcbwr8hNBdevZyHtEAgzGlBaeXQoLHZpWoyIRQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aFhZAJDJ; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aFhZAJDJ"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-94dd05a4b44so994881241.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360914; x=1773965714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PW/s/EPybKw60UvYTN1AXRWTwN8tPerIA0uLhA0dEA4=;
        b=Xmz1s1a9+7lJJCXWJ5FNEPlv1FLaTAVpWaMYCEO9QlC6DpAqhneWL6/logR9SbEhi+
         VmzaI47f5RHBqY0tq4Q9DjaXf17SM1PdADZbQ2yZn8ZvjriVrjoKcSW+KbW10N1g4WF5
         bMuND/4dqTEx86sr9PdDiqd5vM85zbHYLC0RiKHsv7m0UqJLW6+KwmHNjYK+Q9Z/tZEg
         pmv7Blho7fKykkNiEQx9OzE6AclWsLjD4vId/reklA0WRpkIsxwqc0IKnSjoWCtn61fQ
         jVtXbw6eYIpkrWGKh0u+NhMhgBM70xU3jg0wtsIAxwr0wxPivdk4pL4M0TrVWrAqNHPZ
         +LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQx88BdE0fum/5knt//p/UmnSw61wBUinK5YuaVNIts5fBTJNOyXtQDLwxZ8oxLRJ9Rwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfc2tsI2vYW4qdpyaK88ZIU7JhVedeUEDv86mCRHHX/NSVdz6y
	qWvxEJ8kf6VUR5T+Ku7ltp5FAF9Mk4wYIDcI7UW+aTzkeoYa5rssaZdsVtX63p+V3ILh3axVs4b
	I5fpJr5lwKMI9KmP6PeOUGZUrBnYouP+qakOrwjkk3IV0/JIZgthdFwXsKivtUo8ggGOh4aEnkr
	EIG8G7zb8QRZKCFmaic+nl44bISu4Y5qvp1aXrxfYdutD8hA+ShC+9+y3+KzZw+iqNnCuYqcWk6
	TpPa0Y32V0d5w==
X-Gm-Gg: ATEYQzy+tVSEnUHCkcbf4aidpubKR4njqOLf3KIsy01/8nAfbPypWENoI7rEYSVRj0t
	Qc4FybPlGxKNLJ0/V5UEpD7BUl9bdeeFnOt3rby/4EdHyD/QcnGX+XgfiDrA84yOT0MMiQ1IiN8
	zLhq6ggOwIoZlxSPMJiTtWPROvIVe9HutrMAzjyK0YoeQF7lEeB6avsFrHATBvf2gp4AvXOjSKX
	TgIjzLX8TBi45+iFK6H+Svro5meLwdRtdl0fCJaWCbtGEHWdPXgAstpCrs6zP+pw6jrQP37pber
	uL/JpnEc7w8XNqkkBb1CCH1OLaU0o3igCsPnGtg0ymcHgtSdY9jyGMgZZ3zCvWi1u7tcAOuIhlT
	8QZSneSOgZ6n79OlTqTcli2r/rqovL7Xx9KEb3DDPOEKSmbJaFUMcI2Y0vdXbQGmlCxYdmH1T7S
	v7bIxKdoONQpwDgaVEWaRUV/k5igLHDbmrK1xpSKevYzm9c5OOxnDEY8MWHxiR/uw=
X-Received: by 2002:a05:6102:cc9:b0:5ff:de83:3e46 with SMTP id ada2fe7eead31-601f478ac00mr2282046137.7.1773360914008;
        Thu, 12 Mar 2026 17:15:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94ecfe5a086sm564651241.7.2026.03.12.17.15.13
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2026 17:15:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-899e5c9edb9so129071056d6.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773360913; x=1773965713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW/s/EPybKw60UvYTN1AXRWTwN8tPerIA0uLhA0dEA4=;
        b=aFhZAJDJza96stT69Y9cprTQtXaDh6ns1b/Fmoza45VGJo378ebpa1M4KWpFZlGEBK
         sdwMkPvmzSeKFbX08U8HIsTPHRYlQjLsZNUw17Lg8BhIzKyvE9l9e+LQ6spei9XFgHAd
         y8SUxox2bbNvqbdnenzqKdW0UtWRdgsBeciaQ=
X-Forwarded-Encrypted: i=1; AJvYcCU2cFR2636QeZDLqaSXeFblDJNKAgD3ywVOjkZNoXRJXYAfbD4QrT7U6HCV8F3umg5BucA=@vger.kernel.org
X-Received: by 2002:a05:6214:212d:b0:894:5d38:2e38 with SMTP id 6a1803df08f44-89a72a7948fmr80987336d6.18.1773360913235;
        Thu, 12 Mar 2026 17:15:13 -0700 (PDT)
X-Received: by 2002:a05:6214:212d:b0:894:5d38:2e38 with SMTP id 6a1803df08f44-89a72a7948fmr80986446d6.18.1773360912715;
        Thu, 12 Mar 2026 17:15:12 -0700 (PDT)
Received: from JRM7P7Q02P ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfc409sm44610356d6.35.2026.03.12.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:15:12 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:15:09 -0400
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
Subject: Re: [PATCH net-next v3 2/5] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <abNXDVPK42wLUPYv@JRM7P7Q02P>
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-3-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-3-carges@cloudflare.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, Mar 06, 2026 at 05:00:17PM -0600, Chris J Arges wrote:
> Add support for extracting RSS hash values and hash types from hardware
> completion descriptors in XDP programs for bnxt_en.
> 
> Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
> addition add ITYPE_ICMP flag for identifying ICMP completions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

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
> index 85cbeb35681c..1f920464b426 100644
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
> +	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
> +	const struct rx_cmp *rxcmp = xdp->rxcmp;
> +	enum xdp_rss_hash_type hash_type = 0;
> +	u32 itypes;
> +
> +	if (!rxcmp || !RX_CMP_HASH_VALID(rxcmp))
> +		return -ENODATA;
> +
> +	*hash = le32_to_cpu(rxcmp->rx_cmp_rss_hash);
> +
> +	if (!rxcmp1) {
> +		*rss_type = XDP_RSS_TYPE_L2;
> +		return 0;
> +	}
> +
> +	if (xdp->cmp_type == CMP_TYPE_RX_L2_CMP) {
> +		itypes = RX_CMP_ITYPES(rxcmp);
> +		if (rxcmp1->rx_cmp_flags2 &
> +		    cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE)) {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		} else {
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +		}
> +
> +		switch (itypes) {
> +		case RX_CMP_FLAGS_ITYPE_TCP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_TCP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_UDP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_UDP;
> +			break;
> +		case RX_CMP_FLAGS_ITYPE_ICMP:
> +			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_ICMP;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	*rss_type = hash_type;
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> index 8c66698bde11..fb4f9143929f 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
> @@ -41,4 +41,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
>  struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
>  				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
>  				   struct xdp_buff *xdp);
> +int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
> +		     enum xdp_rss_hash_type *rss_type);
> +
>  #endif

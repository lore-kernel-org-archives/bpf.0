Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546927FB1E
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219090; cv=none; b=sfathJnSCt4W1JO9v3rKWznrBaE5U39XuWVA4ETt9c9MFuYM/wRDA5R34os8JPxE/eK6Ioo0qaHItyUSXFgWEcWaUVkxSxTAN27yjnGZjd6cUN71M3AS3oqcwFdvDHuYrhKS6HUyyyRRAk/+kzr4CVVd+HlbZ+ovCYngK2dYCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219090; c=relaxed/simple;
	bh=IMAyHPy/blEQ/2vnWAKKyy0ruHH1HS387rxT0IWZDHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEFLsWhMvL1ofKE7pzE6N7eELKCQ/mZq0wbZrwAeSUhjTZAhSsMaCryDfx+RpK98Bpf5qaNe3mVyL50ofmRbT/o8TVoGGLpRLF6AGqIhN/3qnULcfjUwVDq4TnPahLgNc242o4tXb6ohQqAafNNNqvrMTseNtdoQGDX+P9t8GT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=o4uRYTK9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="o4uRYTK9"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8274843810cso1063621b3a.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772219089; x=1772823889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seXoHa8MttyanDQdn7I7ioBq+qRY17Mw0b5Mol0x4jI=;
        b=o4uRYTK91pxdLEsQ03ktEwRmtIKQCUAtyTP39KwH0McABvNGMdNkzXDNjpCuJCSLVW
         LrPOVJ94eH+4R7UOoMqrKO6UKiHcS3v+7fyPofiTHHJ4H3kzQzukSIcbMegKs18JiXCK
         joBmGbnI9pg6NU80U8g3OlLMJ8tlrHzVEniZzcZ+yA+Q824qsR9TQFJf2yJqGHNvhp6E
         weBKgGGj1dtr8CTALLOAEhUvSuCaMbMcxEjXOtXYLHMVHBXogyLkeCsp23fqhkU82eTO
         3Mf8TYhACRW7m9B+tGfZT2vgov0bmAJuJpppwN7D8eLXFfpMhpvHoyV7u7NTLv9huXew
         YWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219089; x=1772823889;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seXoHa8MttyanDQdn7I7ioBq+qRY17Mw0b5Mol0x4jI=;
        b=DQIjWC/SYurx1tcm3yFuussXkbLzIu4+3uYf567/06skX0jcvMH76zk5jnSPw/ytds
         PMli+pptUVY1vja+KQ3C/dXYHKy/ATuOivESXiPSjMcgoK2P9PnVrcq1MmHT7ASOymjF
         ZwrUqM/HxxxPgpr34OA+Lg7z5CLrCHkKDS23CnkQGqSFKmUl0ye9fWifLowA9ffJB44r
         D5JwJEAd49F2OwUtcoEA2G59xhpjc6Vk5vIUmip+30BK4/cvKVYUdCt0ozKuKCDLTYF5
         poN+WbGNeFzG9CV7WKf8qqg5Zh9+0NLqDRiQsxI48SlE0B0zd+xPdGO+oaPA5bI9yXI8
         DnHA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUv559mP7HisgJNdDH+fowip0OUywHowB5r5rByFDtai2W60QRHBkJidVW49ctHrcXC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQsS2LmF6tJxl8pvUGx1mjwMubAN1x0XqgIizITQfvbrQwkFUg
	jLTaO+BfBmpfblJizg4cb7PgZDQFEhfDR56gAn8vRmlUb+yRjXKToxBlg2f4d4iq578=
X-Gm-Gg: ATEYQzwMR6SHgx7VaOgTMe/AiK3FCmRyILUw4vbo8f/sNu24gLbI5wejUDpW/sQVdgq
	RsnFooDpUG6SMAHUPm0dhyjv8T3Ir6w/V6EHk9Iq0sQixr5VM+Qvw42e80nwH1f4i39M7imk6r6
	NQS/TbohvqYv0Awa95zDOSV4h3SfzR5S4iCB3vNR8BW4/3VaiSeLsqKd8nA9OWtlKPO2cmqWixM
	drEUbda3mOn9KdL+aYAsfbQ/aXxLKCfTeYDIAsgBru2DAiJKQrFPJ2o2dh3hIsumSDj0LhZrYUN
	Ty3n0d/OUmGfZdM0DGpFgzsfVVSXIr0wPpV2vJHg5Pw5GJj314Uda+oZnB8fxsgpfGzVhZWV2mU
	2S/C1mBJddTPyLFluK3GH0BNn8agkZQIlijpxcXhqFdLUdIDXG6hws6nKFeygO+XBK1K5qq7fpF
	LkSMw=
X-Received: by 2002:a05:6a00:94c1:b0:823:1276:9a86 with SMTP id d2e1a72fcca58-8274d9ebcdcmr4188044b3a.39.1772219088702;
        Fri, 27 Feb 2026 11:04:48 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d8c5bdsm5954955b3a.19.2026.02.27.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:04:48 -0800 (PST)
Date: Fri, 27 Feb 2026 11:04:47 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] bnxt_en: Implement XDP RSS hash metadata
 extraction
Message-ID: <aaHqz/0RZi28xE4Z@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
References: <cover.1772211065.git.carges@cloudflare.com>
 <7fe1e129215a789e55a446610321737aef10e20e.1772211065.git.carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe1e129215a789e55a446610321737aef10e20e.1772211065.git.carges@cloudflare.com>

On Fri, Feb 27, 2026 at 11:40:18AM -0600, Chris J Arges wrote:
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
 
[...]

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 85cbeb35681c..f75060374163 100644
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
> +	u32 itypes;
> +	enum xdp_rss_hash_type hash_type = 0;

Nit: This may need to be put into RCT style. (?)

Everything else seemed OK to me...

Reviewed-by: Joe Damato <joe@dama.to>

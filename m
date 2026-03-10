Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3671257849
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104558; cv=none; b=rbxHiskFLELONfYFjxAnew8OhetCDxX5a8AC6l+qfXnSifHEnXZy142+JbPJeyvZE2Zpv8Wv6KrT90eARQcyh1Sd3VD+2uSPXNdMOp1l/nP3ubBrB5WX/WohlXdB5rmyr2KYt0a0eS5gO6EPLPKZcgpyXzHBv2+qO8/mXRyIBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104558; c=relaxed/simple;
	bh=8u5aIGkzdWH39FyyG84Cpgt7t2bR5rtumOcEDOMTekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr40i3LRzvCjOgkg0BrobGdFfMHbQTEYWDxqjR0Pq2V1z0sXA3ETBC+eiG3VdtuEx4Bhvm9OQXiQ5r8rLVKr0NXPEisQNlnh+5Fb9rc8qqJGpvVisKUGQjBZrG4WgaiIh/C36vyUCUaiHLc7VY2Oj7TZqDc2jUE4esr9sSy326c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=tMN8ZLH2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="tMN8ZLH2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so7415756a91.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773104554; x=1773709354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cozoilkNHFvAFGwq+G8eAqvAnWdVX2syV8KrlFutxF0=;
        b=tMN8ZLH20s6EFrlhhIZPjqr7cDCkAYamW+jL/S+/XcX/y9tB+hjp22m3mkL6dmvw7l
         auhP0To3XFKB5LRg23ecQ5Lgwk6C2CQdO0Fvwaa/M1V6zP5WPdLlFd72OUNDvFD6ug+U
         U7B3cpxH3UhdAHREBX+A9NF3uc1OftTcUdmdfhFSNOM22ZSnemW0IlXHTSzAFBZVzbx9
         ZIZhx+JddPl4BMq5tVMVNjs606ialRiCYVpPmlcl7Hi0x4D8loshj8za3RB9PPb4Okpv
         Jj86NYloq5HDSHMoe6YneJ9b5xGViVgaYUkWQOQYBGfu/fyq9HP320FNP3zRVgKuHdqE
         IX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773104554; x=1773709354;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cozoilkNHFvAFGwq+G8eAqvAnWdVX2syV8KrlFutxF0=;
        b=N8WihyvFICuINTwIzKRtCZdHcoNck//LEFZ143p2oZDIEPwWxgMwrqlz6so5b7vS4/
         icQjf9bci6HhNypTYXhsLKSPadrfbDsU6Gr4G436/Wso4XsGc1o2YU1wLhLDnci8vWov
         nXCF2EJoJHhdlRa5G9tq9eR2Gw9zc1lpQkw11sH84nRHVcjqHJQW+CEglS0FIMy1HmW6
         sct7a9+ln5vR5WEPiE+pCi+nADUzvu+tDoCjj64tqkkqGXe1Tma5j+gzKGYD+RUCYUyj
         Ge3PFqulE/xdnrb8KOC9j3+MR7zlkQ8AuhCtyCWTLh4E3yMIy/6WDwd4+swkhcuSoD0b
         d9iw==
X-Forwarded-Encrypted: i=1; AJvYcCX22ChrbhcF4m1aQasshjrRaGqGx/J73/q+DxLGwAzSOeIrdZ3mTNprZmwFZKm1yjpVLog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1kLvQCs190/ru/Hoys93SFN37VPBGvQAInSPXCGbqfydN1p5a
	xifntoQGWUaN7AMLRbcBu4IQx1H5Tb2HkkADNlz+bfpAVW7/6UaJ1fIpcG5yWXA9YKk=
X-Gm-Gg: ATEYQzyoz2MkCkuR36xB84gK2RmedT0x8n96gfUQ8x1jhMXe/Ycf3aKJjzajRrYFf4a
	TO95upnrP6QsTiF0jJCPsDDrE7dZdjay459LvHUhxnqiGgWt8erLQkPKVswwc5AA1QDbOHJ8hs3
	GCEHPnn4vHhmlTWcLBWfkGFt2b8WkILrewbMIx+szC/RPhHXffREMewVyDdw/oG7TEADZcyK/5r
	fS3sJeBjzKAfGnwLUfG3q9MKFi4Rj+30Ztutvhp4zOGK7H+qxB/aYghTSF9khbe+DvUYFvdWpeK
	MTex5ThpRUvx59+5G/wqLPmFNlT0XFJJW5NvLRgwm6+j5lZu4uBmQAbvleCyeOKi+7xtR98x1cr
	hDnti9WOKVsRJb0Cs73ifT/PRdBJdatPlVqNGoZyvZ45QXyXFQILENVT1v6KANpZthY5FQF8+OI
	GbcsI=
X-Received: by 2002:a17:90a:dfcd:b0:356:2fc5:30d9 with SMTP id 98e67ed59e1d1-359be256405mr12615086a91.10.1773104553864;
        Mon, 09 Mar 2026 18:02:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83fb516esm123326885ad.75.2026.03.09.18.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:02:33 -0700 (PDT)
Date: Mon, 9 Mar 2026 18:02:32 -0700
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] bnxt_en: Implement XDP RSS hash metadata
 extraction for V3_CMP
Message-ID: <aa9tqH8i1GQ0j31Y@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, kuba@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	kernel-team@cloudflare.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260306230600.1628196-1-carges@cloudflare.com>
 <20260306230600.1628196-4-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306230600.1628196-4-carges@cloudflare.com>

On Fri, Mar 06, 2026 at 05:00:18PM -0600, Chris J Arges wrote:
> This adds another conditional for if cmp_type is CMP_TYPE_RX_L2_V3_CMP for
> drivers that support this completion format.
> 
> It uses a similar approach as found in other parts of the driver.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> index 1f920464b426..25ecef1eb96e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -514,6 +514,26 @@ int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
>  		default:
>  			break;
>  		}
> +	} else if (xdp->cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
> +		struct bnxt *bp = netdev_priv(xdp->xdp.rxq->dev);
> +		u8 ext_op;
> +
> +		if (rxcmp1->rx_cmp_flags2 & cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE))
> +			hash_type |= XDP_RSS_TYPE_L3_IPV6;
> +		else
> +			hash_type |= XDP_RSS_TYPE_L3_IPV4;
> +
> +		ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
> +		switch (ext_op) {
> +		case EXT_OP_INNER_4:
> +		case EXT_OP_OUTER_4:
> +		case EXT_OP_INNFL_3:
> +		case EXT_OP_OUTFL_3:
> +			hash_type |= XDP_RSS_L4;
> +			break;
> +		default:
> +			break;
> +		}

Looks like the above code is duplicated from bnxt_rss_ext_op?

Maybe that could be refactored into a helper in bnxt.h and called from here to
reduce code duplciation?

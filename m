Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566C2877DE
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376472; cv=none; b=Pe4x22oheQhCncheyAA2JCJymjGfpWZ+idXu1j0dDqkuFE4Rk3v0w1Or0xpXTnmVCKc0Cfessez7rBPIKTq4HqnrsW6O5WCu/DHu7yvB9B93yVFmmc3iyr0A47SuEoq4/cCVCl5E4xnP7mVdIxC+8oD6zFUn2Ww2DqcI2+z4R18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376472; c=relaxed/simple;
	bh=AKwmyqWipydSHremCFQgnlHauwexTBBnYrUYEyewhLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPN/qe8rO8Ar1TY1lQuC/TIgUg5PoFQ3JbKLk2piniEkh5GcePVPbIPrS8f17b8txEJUeAlkp97dpBY2CZGAy0mOZHTm29Xw0bRlDQQi/HkmzNzxNHBuDZOQRsxcYzb/PS0gFnukaziMJMi1C+qDAoC62JWp5jTJnKldcRjXQLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVKZWy82; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVKZWy82"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-127380532eeso12030007c88.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771376469; x=1771981269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHDJ91Fh3k4sfksoLBobkNabAM6CU9B6Swq8q++g+cs=;
        b=jVKZWy829FuhbDhkutpbjjmC4Mm8ZLls+0Pk6AVURp07pQrD6hqZE7+N88Cycz47iO
         HIuzYeFv98PZz6rDXfTDyAN3z2LEeKeDzHKQb4yzM+g67pI98KN/Z7Nsy6WR85/qNoNt
         Vb1cTBCgKwu1zsO3kQ9PN41Fo8+q5ySlmYgiWhi9ZfBaxTIWMZwgwFDm/gsAjTEIpENR
         /yYKeUTkPhHNodt72xHZfazOSDi5TBdXMLN9zxftYSLSGnbu1L/mvj3B9HiUDxUkJ9B+
         wIUPi+eho80iGiGT1YjAw2LHcjmBXk130UH70TrFJuuJrWv+NaZJ/zisIdVj6ICWJ7A9
         WTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771376469; x=1771981269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHDJ91Fh3k4sfksoLBobkNabAM6CU9B6Swq8q++g+cs=;
        b=Fk5lcw4hSh32/mOfP4NMu0ewHkwUMBIyVFzPonJa/+LSz4EtXsvMmXRHLakdA7d/oG
         NHfWGvuR4lZxULB37o2mWTol7+khz+K0NHq/YHnSCcnwu7sxVWPcEIdktyx+1d96LbS3
         WFocSycDVRzv2pg1fTRLFQ6uwuVk1DUYTFBgn1hpD0hZ4RelLHXn4so97UjhE13nvzmL
         we8HY2VPLEtcBDN81JKY+dzg4+Z6Y5slHbHRlr1Q/Tk82W0LGXjWb7sPCW7rXwuaQEG7
         tgsGkVOESndtzf2oOidTdMn7xDwLgbBMv8EDIyIj3azx3i4LzztWLxWyaE1McbIAufqR
         AM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr8aIMXtVLVIJWNbRICZyZ/wztpsAEGl6c8kFfxny4mN7mE9ZvexO/hdZ8I2rICfTWjAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVIdMbawBk0xzXYBXmdXCKWviWy6v/mYfARhBO9/zFh7L4eRo
	WGtWjvF5te6iHMXXUgTGSDEZ0az0XsLgb+m3xy8TGXznWxFcvWCTcyc=
X-Gm-Gg: AZuq6aLS3V0PE7dBigSChOUEV77ITUiYuhQlNrbI3OlOp+mdlW6Ux3jeSXAH20p8dSg
	SJXZoAx8GCPHVmtq4GnFrmTvA+bsYNF+vd8m0e5/x6wRtxnA68nVfhayZi6njgdMuu6VAGseLtg
	mbEJmM9fcOL4QDj0+3yG75kBsdiLVcZxZa06+AglRo9qVMLUtVSoP6IZn3S8G0SsR+xrqm4UBPZ
	5IXqBjjptKmdjAh/iuUAZ8NoahUhfhEN35lg2BE+0bsOLLrGSgmD4B4odh0hkSh3uAA4CLYvtwn
	kl4rDLz4eZfVyp5MPLl2s7xbvLs11rZEY0c18xwFx7sPHgW7nI2GqWslzJAZ5f9yJuOzRxRTCOL
	7ZymjzW2OpTgcNr5i4RCzytITUm8wFHyxuGLyUUf2UCTrLjown/TrRS3iUNiXKGjxCjv7DcJMP+
	xHADQvH5+KIpKKF18NktNY5yulJ8G0XUUsdjZYZOvEn6xg22HZ8QOuEhhZh+8ehgc2NebKKFMYD
	NSsl3m9yIANu8bUnw==
X-Received: by 2002:a05:7022:1707:b0:124:9dea:188d with SMTP id a92af1059eb24-12759a709cfmr63162c88.30.1771376468918;
        Tue, 17 Feb 2026 17:01:08 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6dc70sm16497835c88.8.2026.02.17.17.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 17:01:08 -0800 (PST)
Date: Tue, 17 Feb 2026 17:01:07 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aZUPUwYMRNXSg-eI@mini-arch>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
 <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-1-30024c50ba71@kernel.org>

On 02/17, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> the eBPF program bound to the device to retrieve the RX checksum result
> computed by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  include/net/xdp.h                       | 13 +++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 28 ++++++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 596c306ce52b8303b20680ff0cd34d4fd9db0e48..58eda634668a07860447a65d9fc2284839af6244 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -61,6 +61,11 @@ definitions:
>          doc: |
>            Device is capable of exposing receive packet VLAN tag via
>            bpf_xdp_metadata_rx_vlan_tag().
> +      -
> +        name: checksum
> +        doc: |
> +          Device is capable of exposing receive checksum result via
> +          bpf_xdp_metadata_rx_checksum().
>    -
>      type: flags
>      name: xsk-flags
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index aa742f413c358575396530879af4570dc3fc18de..00abb2e1e85514b4080d0e4e6e3b8f5f67f73b61 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
>  			   bpf_xdp_metadata_rx_vlan_tag, \
>  			   xmo_rx_vlan_tag) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> +			   bpf_xdp_metadata_rx_checksum, \
> +			   xmo_rx_checksum)
>  
>  enum xdp_rx_metadata {
>  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> @@ -643,12 +647,21 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> +};
> +
>  struct xdp_metadata_ops {
>  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>  			       enum xdp_rss_hash_type *rss_type);
>  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
>  				   u16 *vlan_tci);
> +	int	(*xmo_rx_checksum)(const struct xdp_md *ctx,
> +				   enum xdp_checksum *ip_summed,
> +				   u32 *cksum_meta);
>  };
>  
>  #ifdef CONFIG_NET
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index e0b579a1df4f2126acec6c44c299e97bbbefe640..d20da430cfd57bc26b5ea2f406c27b48d8a81693 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -47,11 +47,14 @@ enum netdev_xdp_act {
>   *   hash via bpf_xdp_metadata_rx_hash().
>   * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
>   *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
> + * @NETDEV_XDP_RX_METADATA_CHECKSUM: Device is capable of exposing receive
> + *   checksum result via bpf_xdp_metadata_rx_checksum().
>   */
>  enum netdev_xdp_rx_metadata {
>  	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
>  	NETDEV_XDP_RX_METADATA_HASH = 2,
>  	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
> +	NETDEV_XDP_RX_METADATA_CHECKSUM = 8,
>  };
>  
>  /**
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index fee6d080ee85fc2d278bfdddfd1365633058ec06..7d1e08d8ab4151ab42c91203def2afafc66d3149 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,34 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>  
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``

The only thing I'm still not sure about is the csum_level and whether
we need to export it or just start with csum_level=0 and extend later
when needed. The rest looks good.

Jesper, Lorenzo mentioned that you might need it? Can you clarify?

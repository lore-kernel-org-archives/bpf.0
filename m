Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79D043ABC
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770959942; cv=none; b=hOdJWs4tdtarRTQ52FM77F7dpsz2Zdg08TRZqlqQeMC66CC41SfFyshL65A0XfQC6LryrfFPxQ/lE1eLYaXH07AkzXNw5jRqHJoCrvjaOwGnOrrpz9TO109xPmFVXaFVAaIPwBwYMkfXF30NEjhnZhJjeY0uKUwab+Wm1kywZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770959942; c=relaxed/simple;
	bh=C79fQuNmsoe1mDgNmWqWlrk1yFpf0tY09o68U+R5SG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqfVvVY4DbC/eReXOA54NGYmwqwH+ZVVZi7ddI/sGu6Xsw7PI7m8mkZ5G+yf8Kuh4AczUOC5t2PLVO1xWO3FARcF9aqB2uyNwmfmbYjqL041b09Y+92KRPs70v5M3d+5/ecUuZJj8ziujdQK7fH9K+La2JWPXjqUKkF5VdaM+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrJjT6C1; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrJjT6C1"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so680610eec.0
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770959940; x=1771564740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgXT3I4sUDI0oaN+QbxtrFi8HM7j7HM1bT+EMzWKpeQ=;
        b=UrJjT6C1B3pEiN9bMSkMMOb7eWvdOhOg/cJ0l4qu/fn4PN2OmYw/qNSCXLrBIWUuRu
         OBOExj9bYJ2GpCtCBRWIVszQulmr3GJfqRLGS6soRjjlqEEBcyvxSpokSSNLblm3W+Tc
         NIojup5O/8l6xc79IMEkNktyxX04OSpPPIAwFw2905ijz3m8bJHwju+8uPTowZ7aZgkt
         3ukfODrtj1lmPk00L6Ad6Z/a3HqjqDIoza1GCJusU5w7g2ipzgVtRV87+z9/Own3fJrT
         EAXSsDS+5hqHxL4pUuErdi+UY4XvDSZYTvlPkino5PW/Z1T9aftjAPI5EwIbuxp7kao/
         pnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770959940; x=1771564740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JgXT3I4sUDI0oaN+QbxtrFi8HM7j7HM1bT+EMzWKpeQ=;
        b=X2muazC6O2CVdCIeHSoJ6eO+9cdtxGZwpCvbPBSNXMfoWvVABYKowqsVzEsfmP7UQo
         BMxFaTyct6ntjC3YCaTXXSaK5Cq+vGtk5owhXWgyKyT4kP2Dy44dqpbRRmPRDwS526/Y
         N/JpJ99kX65MK/9RyJ5MY8m8Hc9Ni7KpDTaHXHEO8Y6MYrhiV00YlRyDNskNFvk0Q+mt
         hXGaEyw4x/k8EqGPhUuI72RiV/oyfT3h8sczS7MxxZcZgRpiKYGj6pybk1w+Wqn/YpYl
         TUN5vuXjQrul2XbLIQfSFrv8sJnC7wB6damzVFP8BgfEILYpwe4/dhiFlYX6AhQ/6Wn5
         oSgg==
X-Forwarded-Encrypted: i=1; AJvYcCVnA19qSj8QNdx0Md6n8zmZnS45FlG+wAwAgaPPcU19hk+KsN5qhdFWXGMChDTCAk4pC9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAChD1ZLv3Q5WFZ/r/Z9xxGdjy+n2ACuE1KVqcl38kOhXudEca
	AGZAakRuYKw3fyiFMDy3Cn5AkCK2BAvD60uiPtqEPQ0/i/+Czh9ZSrU=
X-Gm-Gg: AZuq6aI1nF88M35nJxX7BB0ajI5AcEKFT+NDeBSeBLCMk1IVKD1y1pqX9yUMJq+Z7HF
	3vdMbEXNupa8TComoiQZNQbVwYODF6YT8QmIfKyseM8CGwhZha48m9E9x71Ja4cepb6QlnMAw90
	ZyGEQi3w/vMXt4TYmkXU6AP5/UqriWZ6qdU5v4UZ6Qw6Ib8gWS1VjExjQ6P3ME7WNbRz7s2lYwc
	m/QuBZu7m7Pfhfc5R2BxksVW9o8oC32eecQqy+RPKhznJhI0o9lR1oZTeB/HmKkSi21VnxXhpTl
	fw/GKtRtjvlhUGHztwiSjV+SM1oVXl5Bh6db3diFSYW6TZ9FVdQtllgT6AOakw5GW8pLvXLQoAe
	k3ogpMhdMuKEI3+k7NPIr62hDNCW6uJpADlh5QjFOcrIHQnQlh2PfTmYDD0gkq6ZGVQX6txu8j+
	As1TfeZmydNvKFtOixsB0WMUpMFTF0edD9qk0WtLHN/uc1dHyjVK7Eauz1MHjBa9B/iRGOVeatA
	iQEA8WcMsgr1lCf+A==
X-Received: by 2002:a05:7301:7214:b0:2b7:ee0e:e9bf with SMTP id 5a478bee46e88-2babc4558femr275595eec.27.1770959939783;
        Thu, 12 Feb 2026 21:18:59 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0614sm5463343eec.22.2026.02.12.21.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:18:59 -0800 (PST)
Date: Thu, 12 Feb 2026 21:18:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: Re: [PATCH bpf-next 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY60QrE6DpXVecze@mini-arch>
References: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
 <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-1-e5d55caa0541@kernel.org>

On 02/10, Lorenzo Bianconi wrote:
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> eBPF program bounded to the device to retrieve the RX checksum result
> computed by the hw NIC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  include/net/xdp.h                       | 14 ++++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 54 insertions(+)
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
> index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
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
> @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };
>  
> +enum xdp_checksum {
> +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
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
> index fee6d080ee85fc2d278bfdddfd1365633058ec06..e51346ad3031f28d11c11f8205da6cd954da82de 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,35 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
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
> + * ``XDP_CHECKSUM_PARTIAL``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE`` and
> + * ``XDP_CHECKSUM_PARTIAL``.
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     u8 *ip_summed, u32 *cksum_meta)
> +{

Any reason not to do enum xdp_checksum *ip_summed here as well?

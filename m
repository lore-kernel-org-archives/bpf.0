Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CC37DE84
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710439; cv=none; b=nsukFhOG+SokwwUWkKFZS9MgN49lvq+bFrMzVKWSMOXROkkUNBg323z/5VZeZoLu4H17PKT1y/YRq7kclQJdcQnThCUVGr3WbJGvpoFeqx4pm46jNT/WxMNbHdjq7xMNDf2Jg1EW4GSTu8VB5zkZndEmuXhDom+D/Nb1Qt4xqZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710439; c=relaxed/simple;
	bh=SEmPD7JblkDJEFTqqdJbX3FS5ZS5bnh861fzGASB8Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa06b04CapoFwlUEQOatiTCFov+mzwb6I1fkSNTg0b5kg0YeDJsgAaH0kLmkx2ahMJUR4wF3yd1OwH7eVKMKOm3WOgqflMMIlefOriwCNOMFZjhXSR3iclxIIF+//Bz5JzX7WD4+lfFXQsipRxjztvn4X21w6H1hXQ6wqVTatg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY16zhBd; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY16zhBd"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c95bd574471so512858a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783710437; x=1784315237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWBjaJanp528VpTu2TOH4GFEEplwcn9VXFowenlC8oo=;
        b=VY16zhBdtvy8kx0Qv3/hNaOhjnG+AsRpAtHwJdWQXyXY2iDIpqNvSe3OR78QpwFJef
         9Z4Rs7WoagyIscid+iGekoOmkLJIqKgciOgSz9eTfjt12R/+DlUB8fotKygOdh8rXi2n
         USfusKgkb56lRVfYj7taPDzNhnNkJOIjQZhrejCe2z8kmXi9eU5+nZmbfDWh9TiUpwOP
         LzyCPX8mnj32gowWADaZ7I+kuMYEtm3khD5+2OmkGFCupUiM8n55Stk2+gxghiAc8tuj
         rxszWrSknPTCWkBnTabQxFOZDUedGK20qcgPYyERN4ZwEPCYlDX8J7eUEYt+H92bRFO7
         51mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710437; x=1784315237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWBjaJanp528VpTu2TOH4GFEEplwcn9VXFowenlC8oo=;
        b=swt8JgxiyoMHjifITHRlqRIsSlgKrbuNBXWzufaM+bfL9Ui0zCWeRyygcJTAUPjw7l
         jPzGUM15bwy0PJK92CWTjbUiVwdzmh6Q54qrYA+Ul4aE10qJFGMaiI2CWR0lA/CsZbGO
         MwnJ40ikADgmJkAifyz9IK3WJYeH2ZcgiHS5tf1tQ0EzjO8V6YaiyEDNVdSils+CpQ9C
         ZuB1nFBaiGOLmlJO97eOhKJXCDYgouCBWgRquCapefIiV92wneiL/JfsnXl01Zqgt9le
         Ozv31z0J5Dd8uZ56VzTAfmS2Gk0dOMnXUEdFYh1NZOSKmOeVRqlP1uAEGd4xVh8c1pib
         vqfg==
X-Forwarded-Encrypted: i=1; AHgh+RpNfPjjruLgWQx6rdsipIDt+Z48/NxHe+6QsV9U8qBeO5UsOZvB1XN+36oPxJpBnCoTDcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3n6GOkoqJ7Wt/XTBPNUDvpHOs3wbnaQKbUlMrBKM4QNUKplxK
	Rqdt6DUEMf7b42JMCvNn4v4/U+7nbNaMYzTmnY8tsQUWgsEEwBb2bU/S
X-Gm-Gg: AfdE7cmribvv/MGLOYcz93XAjOpHXGTR4LM+gm5ypzrJ5/NZHrLbrNU70QQqwvWE7tN
	wLOY/zhvFQn2dtDVW0rVsvwxv5zBmT9o5N8wHuR27iXcTs1JVKEZLgcPw6c8gVQ+Do1tqFaJdbG
	1gbMgpcv/JnoplwBjkJ/2gwgnZO4fgtB/2fYMcvZ1km9PRGdTtiTQ4JVuKhu1G+58WtudmfyNyU
	mwakAXZRyLigeeKgz+n24vsH8QS1CxTsA8D6AXX7tjc9R5Wh4+nm8Ep0hWH//Y9+csvSZ4ozMRc
	VEepg60II919tq48hMtOhGf6Iq6CHA4BnDy/qb9UN1ckKQ7auCHcQjm88Jxe8UwXKV3M5/5f8S2
	AQ/0lb2v+6MZJQ7H7ZT9Gcf91NPfoOYVDzc2ZbJ2dUMMdv8IGgSkHsLzU/vr1waY9zxSsCxrT21
	9f6cFykl+VIUoRs5/o
X-Received: by 2002:a05:6a00:180b:b0:848:2eac:bfb2 with SMTP id d2e1a72fcca58-848895db4e2mr303610b3a.13.1783710437502;
        Fri, 10 Jul 2026 12:07:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84856e7c8edsm3299574b3a.36.2026.07.10.12.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:07:17 -0700 (PDT)
Date: Fri, 10 Jul 2026 12:05:23 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708203410.45121-2-deliran@verdict.gg>

On 07/08, Vladimir Vdovin wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> checksum will be use by devices capable of exposing receive checksum
> result via bpf_xdp_metadata_rx_checksum().
> Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> the eBPF program bound to the device to retrieve the RX checksum result
> computed by the hw NIC and reported via DMA descriptors.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
>  Documentation/netlink/specs/netdev.yaml |  5 ++++
>  include/net/xdp.h                       | 18 ++++++++++++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  5 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 5f143da7458c..6d0d90d3a614 100644
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
> index aa742f413c35..e255ff786131 100644
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
> @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
>  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
>  };

[..]
 
> +/* Please note the driver is required to invalidate the checksum if the NIC
> + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> + * modifies the packet since it can change some fields validated by the
> + * checksum.
> + */

Sorry, a bit confused about this part. IIUC this is in response to this
discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?

Looking at a few drivers:
- bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
- mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
  bpf prog attached
- fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
- gve (gve_rx) - can do COMPLETE even with xdp attached?

So none of the drivers invalidate anything (and nether the bpf machinery), some
choose to (correctly?) not report COMPLETE when there is XDP. So was the
discussion about documenting this and giving some guidance? This probably
belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?

Also, can you add your new rx_checksum to
Documentation/networking/xdp-rx-metadata.rst's list of supported kfuncs?

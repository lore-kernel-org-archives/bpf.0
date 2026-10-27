Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092259;
	b=FJ9hghtbo24pz2VgMdv4pQ2IaDleiQjXUEpFEi6rNrCtwSgLm5eS+TZzSL9punsdDo0b
	 IxFP0aS8fyW3SguklkfBFSq6MPlxZOYsGslG4MjANH5Zqvwe5AJlMQZzCnlLOen0+VSmj
	 syl/335sUjeVa+SScPoioOKACl0Kail/NunnH5O2eszeyaSNJ6uANtLjQZz8tkalMz+uH
	 RBhkYOLOKpvWktFKyMcJtwSFPJXnM2U+nZfFIN4xWvZTeoixfHoNP3e+gdIa9B12SUL8r
	 1InTpH4ZsHgHXqFZvWOjUHtwrh6fu4WN/fa0xT2Q3RhAbnMj4kO7pL8D2ftWcYg7hjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092259;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mlggcwoG0DvfTCXP7ejSDYVRjRbl/qkcqpGTFuN6n2s=;
	b=Obz7toPFb9Xljj7z3G+sbhs1kxzm9m6QxHF1zbmo1mQQEPReeKwIzDjbfjIS7W2mADIq
	 lTZ1rNf/FjGsNdrzpNCrPLaWcNcrp0O1/Y3wF4DPQYMbyI9xtlTAx+P9LYIorMLoALdUH
	 X+P2UyUy2kullKLqj4tQ1fBr49xWTiLrUrMir1BEpuce1h6Vgr3kCbp/sxFBZo2Qr6cEV
	 5JJr+7JTNpRuzKAhIRvYnmVuIUr1310s31u690O2mxvc53T2IfP9vjqgGD5JhvESoKnQE
	 tkcD1huPU2/jwpHKllEBzO8Q/DuSGPFm7KYnaOWaG9gZDSi9k2XYW30MspyhMZMZ48g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsUzvWop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0141606A323;
	Tue, 27 Oct 2026 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsUzvWop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953231F031E1;
	Tue, 27 Oct 2026 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793092258;
	bh=mlggcwoG0DvfTCXP7ejSDYVRjRbl/qkcqpGTFuN6n2s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YsUzvWopm3C/u14vd2Db/AOVOM0G0Qyw/Xz2nXXSUQgeLOjWiQqOCDJ0AVroBk6bP
	 ppvu0E+RoPeukmmAUh70/0DWFBh285VvP2xD88PwA0ZXejzaCMs1r8zfoDy/mh5FXO
	 i8CAqHmReZ0qAH48AWsmXV1iwJzUv/ZyFFolIyWn+ymenLABah90ekVv44jKGTPoVC
	 mrqLZm8pA6YjKFauaLH2ZRMaFUuSXOqGX1FkCUHvPywwniDfpIX6WA948vmSSlgNGH
	 qNWcqPFENOwxPOxIVINLQCYn2EvfgsbUhHwqWgdWBJLq5uxufSG3DqnmjtGlBbUPxX
	 v+pUdOQPQg+8g==
Subject: Re: [PATCH net 5/6] net: stmmac: fix VLAN tag stripping on short and
 non-linear RX frames
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Tue, 27 Oct 2026 09:10:57 +0000
Message-ID: <179309225715.3134.11251912403308890296@kernel.org>
In-Reply-To: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
References: <20261023-stmmac-xdp-fixes-v1-5-efb37e19f5bd@oss.qualcomm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In stmmac_rx_vlan()
  (drivers/net/ethernet/stmicro/stmmac/stmmac_main.c), the patch adds an…

Pre-existing issues:
- [Medium] Only one of the two stmmac RX paths that call stmmac_rx_vlan()
  records XDP metadata in the skb.
- [Medium] The new VLAN-error drop branch in stmmac_dispatch_skb_zc()
  does a plain `priv->xstats.rx_dropped++` (line 5567).

--

net: stmmac: fix VLAN tag stripping on short and non-linear RX frames

This patch changes stmmac_rx_vlan() so that it pulls ETH_HLEN before
reading h_vlan_proto, and pulls VLAN_ETH_HLEN before reading the TCI. It
returns an error so callers can drop frames that claim a VLAN tag but lack
the full header. It also moves XDP metadata together with the MAC
addresses when the tag is popped.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 8a2faf50d6957..32b2c5834c340 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
>  
> -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> +static int stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
>  {
> -	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
> -	__be16 vlan_proto = veth->h_vlan_proto;
> -	u16 vlanid;
> +	struct vlan_ethhdr *veth;
>  
> -	if ((vlan_proto == htons(ETH_P_8021Q) &&
> +	if (!pskb_may_pull(skb, ETH_HLEN))
> +		return -EINVAL;

[Severity: Low]
This pull happens before the h_vlan_proto and dev->features checks. A frame
shorter than ETH_HLEN is now freed and counted in rx_dropped by both
stmmac_rx() and stmmac_dispatch_skb_zc(), even with CTAG/STAG RX stripping
disabled. The hw_vlan_en branch in those callers has no matching check.

Is that intended? The commit message says:

    untagged frames, including short ones, are left untouched.

That holds only for frames between ETH_HLEN and VLAN_ETH_HLEN in length.

XDP doesn't seem able to reach this case, because bpf_xdp_adjust_head()
and bpf_xdp_adjust_tail() both refuse to go below ETH_HLEN. Dropping such
a runt is also arguably safer than handing it to eth_type_trans().

Could the commit message mention that frames shorter than ETH_HLEN are now
dropped?

> +
> +	veth = skb_vlan_eth_hdr(skb);
> +	if ((veth->h_vlan_proto == htons(ETH_P_8021Q) &&
>  	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> -	    (vlan_proto == htons(ETH_P_8021AD) &&
> +	    (veth->h_vlan_proto == htons(ETH_P_8021AD) &&
>  	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> +		__be16 vlan_proto = veth->h_vlan_proto;
> +		u8 meta_len = skb_metadata_len(skb);
> +		u16 vlanid;
> +
>  		/* pop the vlan tag */
> +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> +			return -EINVAL;
> +
> +		veth = skb_vlan_eth_hdr(skb);
>  		vlanid = ntohs(veth->h_vlan_TCI);
> -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> +		memmove(skb->data - meta_len + VLAN_HLEN,
> +			skb->data - meta_len, meta_len + ETH_ALEN * 2);

[Severity: Medium]
This isn't a bug introduced by this patch, but skb_metadata_len() can only
be non-zero for skbs built by stmmac_construct_skb_zc() on the AF_XDP
zero-copy path:

stmmac_construct_skb_zc() {
    ...
	memcpy(skb->data - metasize, xdp->data_meta, datasize + metasize);
	if (metasize)
		skb_metadata_set(skb, metasize);
    ...
}

On the page_pool path, stmmac_rx() calls xdp_prepare_buff() with
meta_valid set to true, so bpf_xdp_adjust_meta() succeeds there. The
XDP_PASS skb is then built without recording the metadata length:

stmmac_rx() {
    ...
			/* XDP program may adjust header */
			head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
			skb_reserve(skb, head_pad_len);
			skb_put(skb, buf1_len);
			skb_mark_for_recycle(skb);
    ...
}

So skb_shinfo(skb)->meta_len stays 0 for these skbs. Doesn't that mean
metadata written by a non-ZC XDP program is lost before tc BPF can see it?
It would also mean this memmove only moves metadata for zero-copy skbs.

Should stmmac_rx() also call skb_metadata_set() with
ctx.xdp.data - ctx.xdp.data_meta?

This patch's own claim still holds on that path, since meta_len is 0
there and data_meta cannot end up pointing at the wrong bytes.

>  		skb_pull(skb, VLAN_HLEN);
>  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
>  	}
> +
> +	return 0;
>  }

[ ... ]

> @@ -5546,12 +5559,15 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  	}
>  
>  	stmmac_get_rx_hwtstamp(priv, p, np, skb);
> -	if (priv->hw->hw_vlan_en)
> +	if (priv->hw->hw_vlan_en) {
>  		/* MAC level stripping. */
>  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -	else
> -		/* Driver level stripping. */
> -		stmmac_rx_vlan(priv->dev, skb);
> +	} else if (stmmac_rx_vlan(priv->dev, skb)) {
> +		dev_kfree_skb_any(skb);
> +		priv->xstats.rx_dropped++;

[Severity: Medium]
This is a pre-existing issue, but priv->xstats.rx_dropped is one
device-wide unsigned long in struct stmmac_extra_stats. Every channel's
NAPI poll updates it with a plain read-modify-write:

stmmac_dispatch_skb_zc()
    priv->xstats.rx_dropped++;

stmmac_rx_zc() and stmmac_rx()
    priv->xstats.rx_dropped += rx_dropped;

stmmac_napi_add() registers a separate rx_napi/rxtx_napi for each channel,
so these polls can run at the same time on different CPUs. No lock, atomic
or u64_stats_sync protects the counter.

Can drop increments be lost this way? stmmac_get_stats64() also reads the
field without READ_ONCE().

This patch only adds one more site that follows the existing pattern.

> +		return;
> +	}
> +
>  	skb->protocol = eth_type_trans(skb, priv->dev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261023-stmmac-xdp-fixes-v1-0-efb37e19f5bd%40oss.qualcomm.com

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346628;
	b=a4fyy1gpl9P7/LWAi5DCsHYynWHuJ9OuwCLr4efjINFWCwqPyrR43oTXNxFxA1BvJ7T9
	 GoXfWwumQiHcX5SI4TQ8zuuVwlYX3UlfV3b+X17HLTDgQqNEea2LcGFH9b6IW4OdB85rM
	 Jef5GwjqWmQWUXZ9mhr1v70o8bnxb4XS5F55sHZrfEiVrADvnyhJYaC+S9AiOFnW5ZslP
	 7zCcm7alaiZOt8xHAbTcNhwBEI7AwVyiHNfLNmn1sdkyn4Hj7nPFalvYYghJBQdwjnHWM
	 XWDA9Ix9VOfx4nUkkojxd0d6ueTzYAcEdlBOcGZr+Tj3nF+Y+mP2jtjyIpDcHMserYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346628;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9QbTMCo8QhI3rZTi++6hxe83pTxoV8DQ3LgUnh1nOB0=;
	b=1L9aMJYrWt/c31qESCBs+72mkIiUVGdEUTGtj2yfPypS36bUA+CMhVmlVGYnSRB3au/f
	 P/yLV+iIYvLuDfbv826FRk9hXBor8NuQUiEJGXHizDQW4lB9FcCZL2l14SwFHcGodWVFm
	 RuThVOsIDUCVJTe7podyg8kUQ1lvTa1oJhOCjUJBo8u0WaKkHYRK03REmGIWfcosHopCE
	 9hp3d63ztXs9jw2mDlvp4WfvgqQQM2SPeJUM1Sz0wgQFr1AcNtdYEA+Jwv7ZUwFWrdUHj
	 s9yIBRnvmA+mbxzal1TsHSbRlQOvQiWLrhXJs9AlTTMpMVS7GM6Vk3p4cZ5/l4gSNCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TScUShkf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F76606A31C;
	Fri, 30 Oct 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TScUShkf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578891F000C1;
	Fri, 30 Oct 2026 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793346628;
	bh=9QbTMCo8QhI3rZTi++6hxe83pTxoV8DQ3LgUnh1nOB0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TScUShkfykqiD9fruEHDK0sEh8jbm5B7WTgEQ8H6cQ4rEyYIuTogngl5WuB375nrC
	 8JcjKlKeVAKSji0gGkQDRY/XEL402GNBIpw1HnpBqrsVmHjPKU86yFyNrCn99AoBCt
	 /Ft6RqIz37gKj8JVXzhLHSRfisml4bOD1V41Fz/+pKAE+0FJACEnrifDHgG3wJADrc
	 6ba12dlO8vvJo83MG9S0GfEQnJOT/MR45xxQBSKljYhuhd0YndxQweSWXuornLaWh+
	 VcdM4sZJbucCUAKL1CytYHeHSZMv7vx4AHEXHszgq9sApxZfxaPEr4LU8LJKEg6+q2
	 jYFtX3uB49iIA==
Subject: Re: [PATCH net v2 5/6] net: stmmac: fix VLAN tag stripping on short
 and non-linear RX frames
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, Jose.Abreu@synopsys.com, boon.leong.ong@intel.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Fri, 30 Oct 2026 07:50:26 +0000
Message-ID: <179334662692.3134.6357778981334990835@kernel.org>
In-Reply-To: <20261027-stmmac-xdp-fixes-v2-5-10eae8a093a8@oss.qualcomm.com>
References: <20261027-stmmac-xdp-fixes-v2-5-10eae8a093a8@oss.qualcomm.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the VLAN-pop code now moves the XDP
  metadata written with bpf_xdp_adjust_meta() along with the MAC header,…

Pre-existing issues:
- [Low] priv->xstats.rx_dropped is a single device-wide unsigned long
  (struct stmmac_extra_stats, common.h:240).

--

net: stmmac: fix VLAN tag stripping on short and non-linear RX frames

stmmac_rx_vlan() now pulls ETH_HLEN, and then VLAN_ETH_HLEN, into the
linear area before it reads the VLAN header. It returns an error so that
stmmac_rx() and stmmac_dispatch_skb_zc() drop malformed frames. When the
tag is popped, it also moves any XDP metadata together with the MAC
addresses.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d9fc2464a160a..fb3b7174599e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5102,22 +5102,35 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,

[ ... ]

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
The commit message says:

  Also move the XDP metadata written with bpf_xdp_adjust_meta() together
  with the MAC header when the tag is popped, so data_meta still points at
  the metadata after eth_type_trans() anchors mac_header

Does that hold for frames coming from stmmac_rx(), or only for the AF_XDP
zero-copy path?

On the page_pool path, the XDP buffer is set up with meta_valid set to
true. However, the XDP_PASS skb is built without calling
skb_metadata_set():

stmmac_rx() {
    ...
	xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
			 buf->page_offset, buf1_len, true);
    ...
	head_pad_len = ctx.xdp.data - ctx.xdp.data_hard_start;
	skb_reserve(skb, head_pad_len);
	skb_put(skb, buf1_len);
	skb_mark_for_recycle(skb);
    ...
}

napi_build_skb() clears skb_shared_info up to dataref, and meta_len sits
before dataref. So skb_metadata_len(skb) is always 0 here.

On that path, this memmove() does the same MAC-address-only move as
before. The metadata written by the XDP program stays where it was, and
TC/BPF sees an empty data_meta range.

The only skb_metadata_set() call in the driver appears to be in
stmmac_construct_skb_zc():

	if (metasize)
		skb_metadata_set(skb, metasize);

The last patch of the series does not seem to add another one either.

The missing skb_metadata_set() in stmmac_rx() predates this patch. Still,
the Fixes: tag points at 5fabb01207a2 ("net: stmmac: Add initial XDP
support"), which is the page_pool path.

Would it make sense to add something like
skb_metadata_set(skb, ctx.xdp.data - ctx.xdp.data_meta) in stmmac_rx()?
Alternatively, the commit message could say that the metadata handling
only applies to the zero-copy path.

>  		skb_pull(skb, VLAN_HLEN);
>  		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
>  	}

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

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch. Can
updates to priv->xstats.rx_dropped get lost here?

The counter is a single unsigned long in struct stmmac_extra_stats, shared
by all queues. Several per-queue NAPI contexts update it with a plain
read-modify-write:

stmmac_dispatch_skb_zc():
	priv->xstats.rx_dropped++;

stmmac_rx_zc():
	priv->xstats.rx_dropped += rx_dropped;

stmmac_rx():
	priv->xstats.rx_dropped += rx_dropped;

With per-channel MSI or threaded NAPI, polls for different queues can run
on different CPUs at the same time. stmmac_get_stats64() then reads the
counter without any locking, so the reported rx_dropped value can be too
low.

This patch adds another writer that follows the existing pattern, and the
new VLAN drops in stmmac_rx() go through the same shared update.

> +		return;
> +	}
> +
>  	skb->protocol = eth_type_trans(skb, priv->dev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027-stmmac-xdp-fixes-v2-0-10eae8a093a8%40oss.qualcomm.com

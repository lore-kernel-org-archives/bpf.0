Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616861;
	b=bLl8VHCNQW123btVhWvf9g7lBlxMHkPaFVRtEldVQJ+zZ3DGQqVTW65YvV8/AUyHcYCj
	 hIX+YmvCCcQHZ313mr6CKX1Ezqtm5U6B0MtEtcxJH0U6pdbXeH/k/ee30WeMcPg9biSad
	 xQ0/+zp8yo7IFhmMpg7V3i6izMfF7kjJ697pznD7ykBadz+yW7hd8Uoht/+fbeHYjUiOB
	 ACxfYC4yeRRZh4AC40JsOeMz3CRtZTZRuXGv3LShXQJw8axKYX9Heb8QbGbrNHPtDQqrt
	 qe2hDM+WmKc8eRrpdPOquHEKyHF2U/2ZSjGeJNvCLkJRDQUQ2rGGVhN2wONDXpXlCZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616861;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CjLRfksphLBZ5dLCo3wFcxpp9BM8icCeVRM63N1CHfQ=;
	b=Jn3zQITHPd2WNbNCj2uMs+0SXOH+KZHylqabyjamBtSHblBVMfEU93I4OY6oZyRxiFH5
	 sGbOA47x1F5zFTDjMjOm+eAwj6FgOa+3ONhhwsdFJvIg+I9jkp7MZ9INLdTXVAcUbQ12W
	 HC0n2JbyvL1MtCPOVYqgO0JlUKoUl2iqYQ4xNUOOC8lsfHzdLhSYdv/zuQuiLIi1nmVmQ
	 zKwRTL4jEnD8rTHohbl416goE7+EC0ZCBbizX5SrOuTBGaLa1Z0Wr8WwqDa12lwLEqwGX
	 rEz6DrfCJjlbNGqqQ8a4ukyyOfNw6bh5X3m/WAEJDpZX3Ygt8OSGreFQ46HW7Y/Hulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYQ7DaDC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CA606A327;
	Wed, 25 Nov 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYQ7DaDC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2521F000EB;
	Wed, 25 Nov 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616861;
	bh=CjLRfksphLBZ5dLCo3wFcxpp9BM8icCeVRM63N1CHfQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XYQ7DaDCbNZT0B/BZDGeTkI68HT1uw6j1DTpypTBD358aeikMbtU2TiQ/OXo1+WcW
	 wdptc2d5yOKFNk7ZHN/LPymVgSYXGuRYv23S8hoV2/GGLvoidRQ7C7qJZYxgr3M8AP
	 tcDuwX1xa11SROHek1n8mHs1/gMS6lcXIOk0zGTIjdwYWuxZjoBGvg3XH8e3Evb3NQ
	 XLPdWk103tdQvz5rsEg3CJsEEL9MsxdRNkgqIiiDYnxJ2uPrimM/Dwe0YiuKXGB+1W
	 8fs5Id+W3hz8mM+fNNw5Fp2F1AAxFd7L4XNWoXjgSPwTXJ/EKZO9x+N2zEzthgAB3N
	 QywlLF52VNnxQ==
Subject: Re: [PATCH net v3] net: xdp: fix generic XDP on skbs without an
 Ethernet header
From: netdev-bot+sashiko@kernel.org
To: jiayuan.chen@linux.dev
Cc: netdev@vger.kernel.org, kennethbwlee@snu.ac.kr, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, kuniyu@google.com,
 wang.zhan@smartx.com, mkarsten@uwaterloo.ca, bpf@vger.kernel.org
Date: Wed, 25 Nov 2026 14:27:39 +0000
Message-ID: <179561685970.3135.9452194614168004635@kernel.org>
In-Reply-To: <20261124142545.221584-1-jiayuan.chen@linux.dev>
References: <20261124142545.221584-1-jiayuan.chen@linux.dev>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] dev_xdp_attach() (net/core/dev.c) now rejects every
  XDP_MODE_SKB attach with -EOPNOTSUPP when dev->type is neither…
- [Medium] The new early return in netif_receive_generic_xdp() (`if
  (skb->data - skb_mac_header(skb) != ETH_HLEN) return XDP_PASS;`) skips…
- [Low] Documentation/networking/af_xdp.rst (around line 86) says XDP_SKB
  mode, which is used when the driver has no XDP support or XDP_SKB is…

--

net: xdp: fix generic XDP on skbs without an Ethernet header

The patch refuses to attach a generic XDP program to a device that is
neither ARPHRD_ETHER nor ARPHRD_LOOPBACK. It also skips the generic XDP
program at runtime for any skb whose mac header is not exactly ETH_HLEN
bytes. The goal is to fix a WARN in skb_vlan_push() that comes from the
Ethernet header fixup in bpf_prog_run_generic_xdp() on L3 devices such as
sit0.

Closes: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/

> diff --git a/net/core/dev.c b/net/core/dev.c
> index cd0796a1dbfdf..a9ef193967bab 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5825,6 +5825,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  	if (skb_is_redirected(skb))
>  		return XDP_PASS;
>  
> +	/* XDP is Ethernet only, skip skbs without an Ethernet header. */
> +	if (skb->data - skb_mac_header(skb) != ETH_HLEN)
> +		return XDP_PASS;

[Severity: Medium]
Can this silently skip a program that was attached successfully to an
ARPHRD_ETHER device?

Take a VLAN device with reorder_hdr off. Its type is ARPHRD_ETHER and it
has no ndo_bpf, so dev_xdp_attach() defaults to XDP_MODE_SKB and accepts
the program. On receive, vlan_do_receive() does this:

net/8021q/vlan_core.c:vlan_do_receive() {
    ...
	if (!(READ_ONCE(vlan_dev_priv(vlan_dev)->flags) & VLAN_FLAG_REORDER_HDR) &&
	    ...
		skb_push(skb, offset);
		skb = *skbp = vlan_insert_inner_tag(skb, skb->vlan_proto,
						    skb->vlan_tci, skb->mac_len);
		...
		skb_pull(skb, offset + VLAN_HLEN);
		skb_reset_mac_len(skb);
	}
    ...
}

That leaves skb->data - skb_mac_header(skb) == 18. Then
__netif_receive_skb_core() jumps to another_round and calls
do_xdp_generic() with the VLAN device's program. The new check returns
XDP_PASS for every packet.

Before this patch the program ran on the full Ethernet+VLAN frame, so
read-only filters and XDP_DROP filters worked. reorder_hdr can be toggled
at runtime, so a filter that is already attached could stop being
enforced. Nothing reports this: no warning, no extack and no tracepoint.

The commit message justifies the runtime check only by dev->type changing
after attach. The VLAN effect appears only in the v2->v3 note below the
--- line, and that note won't be kept when the patch is applied.

Would it make sense to warn once here, or to reject the attach, and to
describe this in the commit message?

A separate point: bpf_xdp_link_update() calls dev_xdp_install() directly:

net/core/dev.c:bpf_xdp_link_update() {
    ...
	mode = dev_xdp_mode(xdp_link->dev, xdp_link->flags);
	bpf_op = dev_xdp_bpf_op(xdp_link->dev, mode);
	err = dev_xdp_install(xdp_link->dev, mode, bpf_op, NULL,
			      xdp_link->flags, new_prog);
    ...
}

This path never reaches the new dev->type check in dev_xdp_attach(). The
device type can change after the link is created, for example through
bond/team port enslavement or TUNSETLINK. In that case the link update
still succeeds, and the new program never runs either.

Is this inconsistency intended?

[ ... ]

> @@ -10775,6 +10779,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>  			NL_SET_ERR_MSG(extack, "XDP program already attached");
>  			return -EBUSY;
>  		}
> +		/* lo is ARPHRD_LOOPBACK but uses Ethernet framing. */
> +		if (mode == XDP_MODE_SKB && dev->type != ARPHRD_ETHER &&
> +		    dev->type != ARPHRD_LOOPBACK) {
> +			NL_SET_ERR_MSG(extack, "Generic XDP only supports Ethernet devices");
> +			return -EOPNOTSUPP;
> +		}

[Severity: Medium]
Does this break existing generic XDP users on L3 devices?

Today an XDP_MODE_SKB attach succeeds on tun in IFF_TUN mode, wireguard
(ARPHRD_NONE), sit/ipip/gre/ip6tnl, PPP, RAWIP WWAN and IPoIB.

Some programs never modify the first 14 bytes, for example read-only
filters or programs that return XDP_DROP or XDP_PASS. These programs run
correctly, because the fixup in bpf_prog_run_generic_xdp() only fires
when those bytes change:

	if ((orig_eth_type != eth->h_proto) ||
	    (orig_host != ether_addr_equal_64bits(eth->h_dest,
						  skb->dev->dev_addr)) ||
	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
		__skb_push(skb, ETH_HLEN);

A plain "ip link set dev X xdp obj ..." with no mode flag is affected as
well. dev_xdp_mode() falls back to XDP_MODE_SKB when ndo_bpf is missing:

	return dev->netdev_ops->ndo_bpf ? XDP_MODE_DRV : XDP_MODE_SKB;

tun_netdev_ops (TUN mode) has no ndo_bpf, so XDP on an IFF_TUN device
always uses generic mode and is now always rejected.

The commit message says these attaches will be refused, but it describes
generic XDP on L3 devices only as comparing garbage.

Could it say that generic XDP setups that work today on these devices will
now get -EOPNOTSUPP? The Fixes: tag points at a 2017 commit, so this uAPI
restriction would also reach every stable tree.

[Severity: Low]
Should Documentation/networking/af_xdp.rst be updated in the same patch?
It describes XDP_SKB mode as:

  A fallback mode that works for any network device.

After this patch, dev_xdp_attach() returns -EOPNOTSUPP for XDP_MODE_SKB on
any device that is neither ARPHRD_ETHER nor ARPHRD_LOOPBACK. That covers
both cases the document describes: an explicit XDP_SKB request, and the
fallback for drivers without XDP support.

netif_receive_generic_xdp() also skips skbs whose mac header is not
ETH_HLEN bytes, so generic XDP runs in fewer cases than the document
describes.

>  	}
>  
>  	/* don't call drivers if the effective program didn't change */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124142545.221584-1-jiayuan.chen%40linux.dev

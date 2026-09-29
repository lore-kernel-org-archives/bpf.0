Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E282320A34
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710515; cv=none; b=uoLixWN20pM3tUQ/EP7QNa7f15aLBUhsLu+l5HCfHqnmQNdC5BdzFMZt1q7sau0hcdgaoQ8AVlPYjlVjhAkxiAHYjEIadx5ZA8nbu6S+73ZX43uk/FAlmPZ+EBKAOirwMhiFuPhACVMem/VT6shDQ4FF07QVbGEOt5k+inaWjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710515; c=relaxed/simple;
	bh=u9d/x+w8lLWQf1tTJWeF5T/H7i4tux4Js50TS7uokT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tiD2LuP0nl/AjI5u+yqzR2CvQTNmYEjrJ1ahmpWGxBPX6msLJPG8AAY8oq8sfNbgp4mW9YAepkt+1u19V66RKrWm+nNDPg+9JTqhVFt5AC796SDjm7CLc/Q8ydm9maXd3MG5mt6/4MiMi5/gWvmyQQttEY3bRmD6iJBaqILNV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0UdhXuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0UdhXuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6821F00893;
	Tue, 29 Sep 2026 19:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710514;
	bh=mVFehtqIJ0+3gE1Ydaizpuox9u8kKCuAJzwuxBjJh8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0UdhXucV07ciss1YmWC7UAulciidnHGpO9FrEJnW6Un7nh8T+2psIbghSVmiCswt
	 6sq++OduyAc0EpuggUnaNRViUAlMYHMp1rxPnBInSwQKdyNeggnZEEVYjv9s/Q+GxP
	 hpKJUEOQwYyynWTL+GJLjEvVOW49EwqIYtDPTDplAYFVG/NKjcEM5BcAc6sIX9ghIb
	 uzKByfk1HHT6dVcTtfHp0mbLaGaKNvHy01CjyXxomo65ptNARyGGUAcv43ZddQl+VZ
	 HYekHUuXWvGHu0oKHQt9KXH21lK7v/iPBzNvOnhjhpBDUFMk47I0e1b6Dd6Uciw6cH
	 H9zPNspxq0cKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 11/15] net: lan966x: add PCIe FDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
 <20260928-lan966x-pci-fdma-v9-11-a17caf60f89a@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:35:13 +0000
Message-Id: <20260929193514.5A6821F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: missing length validation in hardware offload checks leads =
to OOB read
--

commit 0077ede3c2cac9977be6b338e3fa7c1952aabe74
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA support

Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
transfer instead of per-page DMA mappings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..f511e70613141
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> @@ -0,0 +1,458 @@
[ ... ]
> +static bool lan966x_fdma_pci_hw_offload(struct lan966x *lan966x, u32 por=
t,
> +					struct sk_buff **pskb)
> +{
> +	struct sk_buff *skb =3D *pskb;
> +	u32 val;
> +
> +	val =3D lan_rd(lan966x, ANA_CPU_FWD_CFG(port));
> +	if (!(val & (ANA_CPU_FWD_CFG_IGMP_REDIR_ENA |
> +		     ANA_CPU_FWD_CFG_MLD_REDIR_ENA)))
> +		return true;
> +
> +	if (eth_type_vlan(skb->protocol)) {
> +		skb =3D skb_vlan_untag(skb);
> +		*pskb =3D skb;
> +		if (unlikely(!skb))
> +			return false;
> +	}
> +
> +	if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> +	    ip_hdr(skb)->protocol =3D=3D IPPROTO_IGMP)
> +		return false;

[Severity: Medium]
Does this code safely handle truncated packets? If a remote attacker sends a
truncated IPv4 packet (e.g., a 14-byte Ethernet frame with the ETH_P_IP
ethertype) to the interface, eth_type_trans() consumes the MAC header, leav=
ing
skb->len =3D=3D 0.

Calling ip_hdr(skb)->protocol without first validating that the SKB payload
contains a complete IPv4 header would read past the valid payload. This
out-of-bounds read could access uninitialized SKB memory padding, leading to
unpredictable forwarding decisions.

Should there be a length check before dereferencing the IP header here?

(Note: This is a pre-existing issue in the original lan966x_hw_offload()
function in lan966x_main.c, which appears to have been duplicated here.)

> +
> +	if (IS_ENABLED(CONFIG_IPV6) &&
> +	    skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> +	    ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) &&
> +	    !ipv6_mc_check_mld(skb))
> +		return false;

[Severity: Medium]
Similarly, does this IPv6 code path require a length validation before
accessing ipv6_hdr(skb)->daddr?

> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-lan966x-pc=
i-fdma-v9-0-a17caf60f89a@microchip.com?part=3D11

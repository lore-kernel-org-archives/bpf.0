Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D787A2EC083
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789817733; cv=none; b=QAfQyKC8oykuRwUGgPr9rB9HWCsf7UKT9O0invEDIbs+OnPdyE/rmP90hGrCsImbN/7619v4RJ6ckRlq3lYffvTLDjkliVyr50tNezJgz7ACXBgaYYWX2qNcwvlsspLYcLoWxuumgeRz/7rR4hxR6RplHZs8o5UK44Gp1hB+4wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789817733; c=relaxed/simple;
	bh=aQtKxpQwpf+hOsxFrVrFonJ3KebqKkv3y/5wKjqvcXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bNm5K/CGDllksn87K3a/swhSL1EdAjxtzG2RcPoi8zMjfhB5sE++xa/LbWfFczUkkYT7XMrNTa7hwspxpjr+fK/Nxp4suMMh5ED35Um6dq1bdkoFffuGHumF6ac3a0pkCAdKm2Skm/20mUMigg0EQf57MljcfpaUDa4nau+JvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmeV/Vma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmeV/Vma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFC81F00898;
	Sat, 19 Sep 2026 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789817731;
	bh=f5EIB2gr5BWw4a+7dLSmE5ErKj39RbyhtndgZeNjcvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JmeV/VmasoDGSbdlc9O7Hb3e6QX4e59patEeIMbIdzBJ0FlwiuybV9td22oPdq8Gr
	 /wMqzzkZWTI4t8X0dZhCT9E8W1Xhi05JUFPqSNCx2QIIYsu5/spxZU2rZZBbTqB259
	 oaULBeULVi/yNwVuWSitprcHmBIMbdswTGFQPm1dF/Ocnn/MmbJyb+leVTkd6ER9Gm
	 dLRfxgA/KqWB3spstZosiVfY5fPUzm+WOLaoi1gxVdHSh67SzwsBRWbYxYjhxhrPHf
	 +P4e9Rp8dpBDJKaCzFhmi0hf3AfTNtutQin4wSGFAxe/u315JQ+1uV3WfkSw2pZfbG
	 ApQQ8fDHRBFmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 10/14] net: lan966x: add PCIe FDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
References: <20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com>
 <20260918-lan966x-pci-fdma-v7-10-0ecc179c8a2c@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 11:35:30 +0000
Message-Id: <20260919113531.4EFC81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: lan966x: rx_bytes statistic undercounts received frame size
--

commit 33bf15bc7637a43a47c2a31af68430d11cdb1f96
Author: Daniel Machon <daniel.machon@microchip.com>

    net: lan966x: add PCIe FDMA support
   =20
    Add PCIe FDMA support for lan966x. The PCIe FDMA path uses contiguous
    DMA buffers mapped through the endpoint's ATU, with memcpy-based frame
    transfer instead of per-page DMA mappings.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..5d6902459f200
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> +						     u64 src_port)
> +{
[ ... ]
> +	skb->protocol =3D eth_type_trans(skb, skb->dev);
> +
> +	if (lan966x->bridge_mask & BIT(src_port)) {
> +		skb->offload_fwd_mark =3D 1;
> +
> +		skb_reset_network_header(skb);
> +		if (!lan966x_hw_offload(lan966x, src_port, skb))
> +			skb->offload_fwd_mark =3D 0;
> +	}
> +
> +	skb->dev->stats.rx_bytes +=3D skb->len;

[Severity: Medium]
Does this regression undercount the received frame size for the rx_bytes
statistic?

In lan966x_fdma_pci_rx_get_frame(), eth_type_trans() inherently pulls the
Ethernet header from the SKB, reducing skb->len. Additionally, if
lan966x_hw_offload() optionally calls skb_vlan_untag(), it further reduces
the length.

Adding this modified, smaller skb->len to the rx_bytes counter instead of
the original wire length causes the statistic to systematically undercount
received bytes by at least 14 bytes (the MAC header size) per packet, and
potentially more if VLAN tags are present.

Although this pattern may have been copied from the existing non-PCI path,
it is a newly introduced instance in this file. A check of the subsequent
patches in this series reveals the problem remains unfixed in the final sta=
te
of the series (commit f075590a2768b1e0f139412f8b14c4b61658552e).

Could the original length be recorded for the statistic before the headers
are pulled?

> +	skb->dev->stats.rx_packets++;
> +
> +	return skb;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-lan966x-pc=
i-fdma-v7-0-0ecc179c8a2c@microchip.com?part=3D10

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE5349362E
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045312; cv=none; b=hCpb2LBmOtfvQhja4YGG5Dfy9dT1cpPNEn7EU5pBUbCaqIGdbRCbsHHQym27GjFTY+vqhjuObvqWUEB0/A3tdXnx+n/Sl4fZciV4YTi2wbS2jyMB/hw3FOIoOOFZra2/Gnqs24ZcJut9xMlGbuAeEyrNYmSu3hEjrRTpsMZRCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045312; c=relaxed/simple;
	bh=Lm5pqky3u8k79qdTiNzfZm6YGYxsboM2b36RWt//bFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2/EMfiiv5UJT9siY/ho7noe+wXIvrIYRKqJTy86thaxePm21DE2mj2R7MW9GqfCGBANfCN1OgZzdWUXF3FFE7XQmeGqk1ZrKp6djDT1SsJARje6TQ+3yIBlToLBFu8sNugh0G8JcpnzMpNSFmapOOS0OWkoB5PFqF5CQGrcEKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBT1k4Dm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBT1k4Dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D71F000FF;
	Thu, 10 Sep 2026 13:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045309;
	bh=peAHrncuGmkWHcfCZcmE988LIlSwG7VTjoJ0xwLBqBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBT1k4DmnohN05OTn2m74zv2M18Coqq+w6dTsd+vX4D7bYDH0oQZj+HQ220kbn/9M
	 ctyEY16yhEosMk4hkCd7hwB9dL8QZeEXNgR7zvAFX4/Sc+38ModEiMpalB52qRbald
	 +qp1At23fheRcX45KVdaXtOCtyiyeP0Qdod4HO5NjXLSgKjYLR1Xr0dqfa6GiSPIg+
	 KUQ1J/Ugo/bLYPM2ShSjMN7pj1nqEokpN8Taw4jtiTeEeSyGdjPycebuTpHlmXX46Z
	 uOVgWXVmR3+YRJkmmG0H4o32D9qw6QLKIJXCKoN6gDQoQ6wfxDxRJE1X0tD7RT7VKF
	 l1hgXdRZ6DZiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 10/14] net: lan966x: add PCIe FDMA support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909-lan966x-pci-fdma-v6-10-6f48dab9d671@microchip.com>
References: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
 <20260909-lan966x-pci-fdma-v6-10-6f48dab9d671@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:01:48 +0000
Message-Id: <20260910130149.070D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Missing memory barrier between reading RX packet data and handing =
the descriptor back to the hardware.

Pre-existing issues:
- [Critical] Use-After-Free on `skb` due to pointer invalidation inside `la=
n966x_hw_offload`.
- [High] Missing SKB length validation before reading IP/IPv6 headers.
- [High] DCB initialization in `__fdma_dcb_add` writes the link pointer bef=
ore initializing the new DCB, creating a race with the DMA engine.
--

commit 6962735ae0c2fc198779cdd8603a67a7aa3b15a3
Author: Daniel Machon <daniel.machon@microchip.com>
Subject: net: lan966x: add PCIe FDMA support

This patch adds PCIe FDMA support for the lan966x driver, mapping contiguous
DMA buffers through the endpoint's ATU. This approach uses memcpy-based fra=
me
transfers instead of per-page DMA mappings, which significantly increases
throughput.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..f1f3c789d3a6e
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> +						     u64 src_port)
> +{
[ ... ]
> +	if (lan966x->bridge_mask & BIT(src_port)) {
> +		skb->offload_fwd_mark =3D 1;
> +
> +		skb_reset_network_header(skb);
> +		if (!lan966x_hw_offload(lan966x, src_port, skb))
> +			skb->offload_fwd_mark =3D 0;

[Severity: Critical]
This is a pre-existing issue, but can this sequence lead to a use-after-free
on the skb pointer?

If a malformed or truncated VLAN packet is received, lan966x_hw_offload()
calls skb_vlan_untag(skb). If skb_vlan_untag() fails to pull the VLAN heade=
r,
it frees the skb internally and returns NULL, prompting lan966x_hw_offload()
to return false. The caller in lan966x_fdma_pci_rx_get_frame() then proceeds
to access the freed skb pointer to clear skb->offload_fwd_mark, which could
cause a kernel panic.

[Severity: High]
This is also a pre-existing issue in lan966x_hw_offload(), but is there a
missing length validation before reading the IP or IPv6 headers?

If a packet arrives with an IP or IPv6 ethertype but has a truncated payload
that is shorter than the header size, lan966x_hw_offload() casts the network
header and dereferences fields like ip_hdr(skb)->protocol without verifying
if the skb contains enough linear data via pskb_may_pull(). This could resu=
lt
in an out-of-bounds read of kernel memory.

> +	}
> +
> +	skb->dev->stats.rx_bytes +=3D skb->len;
> +	skb->dev->stats.rx_packets++;
> +
> +	return skb;
> +}
[ ... ]
> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weig=
ht)
> +{
[ ... ]
> +	/* Get all received skbs. */
> +	while (counter < weight) {
> +		if (!fdma_has_frames(fdma))
> +			break;
> +		/* Order DONE read before DCB/frame reads below. */
> +		dma_rmb();
> +		counter++;
[ ... ]
> +	}
> +	while (dcb_reload !=3D fdma->dcb_index) {
> +		old_dcb =3D dcb_reload;
> +		dcb_reload++;
> +		dcb_reload &=3D fdma->n_dcbs - 1;
> +
> +		fdma_dcb_add(fdma,
> +			     old_dcb,
> +			     FDMA_DCB_INFO_DATAL(fdma->db_size - XDP_PACKET_HEADROOM),
> +			     FDMA_DCB_STATUS_INTR);

[Severity: High]
Does this loop need a memory barrier before writing the descriptor status b=
ack
to the hardware?

The CPU reads the incoming packet payload from a contiguous coherent DMA bu=
ffer
via memcpy() during lan966x_fdma_pci_rx_get_frame(), and then iterates here=
 to
reclaim used descriptors by writing to their status fields in the same cohe=
rent
memory space. Because there is no general memory barrier (like mb() or
smp_mb()) separating the payload read from this descriptor write, the
operations might be reordered. If the descriptor write commits to memory be=
fore
the payload read completes, the device could start DMAing a new packet into=
 the
buffer while the CPU is still reading the old one, leading to silent data
corruption.

[Severity: High]
This is a pre-existing issue in the fdma api, but does the call to
fdma_dcb_add() create a race condition with the DMA engine?

When appending a new DMA Control Block (DCB), __fdma_dcb_add() updates the
hardware-visible nextptr of the current tail DCB to point to the new DCB be=
fore
the new DCB's own nextptr (to mark the list end) and info fields are proper=
ly
initialized:

drivers/net/ethernet/microchip/fdma/fdma_api.c:__fdma_dcb_add() {
    err =3D dcb_cb(fdma, dcb_idx, &fdma->last_dcb->nextptr);
    if (unlikely(err))
        return err;

    fdma->last_dcb =3D dcb;
    dcb->nextptr =3D FDMA_DCB_INVALID_DATA;
    dcb->info =3D info;
}

If the DMA engine is actively processing the list, could it follow the upda=
ted
nextptr and consume the new DCB while it still contains uninitialized or st=
ale
data from a previous cycle?

> +
> +		lan966x_fdma_rx_reload(rx);
> +	}
> +
> +	if (counter < weight && napi_complete_done(napi, counter))
> +		lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);
> +
> +	return counter;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-lan966x-pc=
i-fdma-v6-0-6f48dab9d671@microchip.com?part=3D10

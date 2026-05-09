Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE1938B125
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315240; cv=none; b=DC5/oUdIbLldI03MVL13/1RZEVdw2GgwuoLC1kYFSWKQVBiwYgY0omnE8QGRR1QcG6J+KZRFObfX4oAKGJOWBdQ9PApB9ZzZVBirGhLGaAja2am00waPDDpMPgQObDc3evvaCAHIwNhUGXD9Qb/wdtj2gIsOFXwcCb53iS7uagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315240; c=relaxed/simple;
	bh=6yyVaU0P3FlSLXrMr995PiLhA3L2zvEGrAhx5ugsWBg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BIqvXQRSaHiEBFOk3ud4/7TiMhBeXhF29pivgxJqvuHrLF1cBuij41RXbtYj+yBVJzdba2YvV2CmQ2MRCZqHEMroPvyAZDVapRwEUHX5IftnBb008rOJwlUZUZ4Uc3gihD4vxbUWCoK8MhjeHHV7HLjV8uLbZ70NZlbHmnJE97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoDmu72o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoDmu72o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503A6C2BCB2;
	Sat,  9 May 2026 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778315240;
	bh=6yyVaU0P3FlSLXrMr995PiLhA3L2zvEGrAhx5ugsWBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=YoDmu72oEUT7ERvY/Mi1khQCho5U+cab87JQ+O6nqwu4wf3k6mdgKjZ6CIla4Myqi
	 9hmI12rCz07SvKs3fq9vsuaT8gkVBtrcTveEBHfP1wue+lroBtbrg/pS3brpnldQtd
	 Buep2AvZU9Awc53x2MyNmRPoJIr4GgVde4ru2sx9u4GEX9RLkWyD0hkrkVMa/wqYkV
	 ooBiwNiOvRyb4mI0sCbwL1Mt1C5xBAg0ByQFWG8gC1oPRTMRaig0NhgMftZEgzKiiK
	 mH+fWzF+31Nd8LvIkSiXbou8B0F6cQmyoYnIAzhUeiO/AB1uBXiQUUIKZwofJJpNup
	 pED6kCKuDD4pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 09/13] net: lan966x: add PCIe FDMA support
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260508-lan966x-pci-fdma-v4-9-14e0c89d8d63@microchip.com>
References: <20260508-lan966x-pci-fdma-v4-9-14e0c89d8d63@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 08:27:19 +0000
Message-Id: <20260509082720.503A6C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability on DMA des=
criptor status leading to out-of-bounds kernel memory read.
- [High] Use-After-Free in the transmit path due to unconditional SKB consu=
mption when PTP is enabled.
- [High] TX Ring out-of-order traversal breaks hardware FIFO ordering and c=
auses permanent TX queue stalls.
- [High] Use-After-Free during teardown due to freeing DMA memory before un=
registering network devices.
- [High] NAPI RX queue stall on SKB allocation failure or malformed frames =
due to premature loop exit.
- [High] Missing memory barrier in RX descriptor recycling leads to silent =
data corruption.
- [High] Teardown race condition: hardware RX channel is disabled while NAP=
I is still active.
- [High] Unconditional re-enabling of all FDMA interrupts causes interrupt =
storms.
- [Medium] Missing feature implementation for NETIF_F_RXFCS in the PCIe RX =
path.
- [Medium] Parsing IFH fields before verifying frame bounds allows network-=
controllable WARN_ON triggers.
--

commit e3118c2c5891c088b15f392a451ae362b3da62d0
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add PCIe FDMA support

This patch adds PCIe FDMA support for the lan966x driver, mapping contiguous
DMA buffers through the endpoint's ATU and using memcpy-based frame
transfers instead of per-page DMA mappings, improving throughput
significantly.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c b/=
drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
> new file mode 100644
> index 0000000000000..2e88d211073d6
> --- /dev/null
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma_pci.c
[ ... ]
> +static int lan966x_fdma_pci_get_next_dcb(struct fdma *fdma)
> +{
> +	struct fdma_db *db;
> +
> +	for (int i =3D 0; i < fdma->n_dcbs; i++) {
> +		db =3D fdma_db_get(fdma, i, 0);

Does scanning from index 0 on every call break the hardware FIFO ordering?
If the CPU reuses index 0 while the hardware is processing a later index,
will the hardware miss the new descriptor until it wraps around the ring?

Also, if the hardware encounters a DONE descriptor and halts, and the CPU
places new data at index 0 without advancing the hardware's pointer, could
the TX path permanently stall? Should this use a cyclic running index inste=
ad?

> +
> +		if (!fdma_db_is_done(db))
> +			continue;
[ ... ]
> +static int lan966x_fdma_pci_rx_check_frame(struct lan966x_rx *rx, u64 *s=
rc_port)
> +{
> +	struct lan966x *lan966x =3D rx->lan966x;
> +	struct fdma *fdma =3D &rx->fdma;
> +	struct lan966x_port *port;
> +	struct fdma_db *db;
> +	void *virt_addr;
> +	u32 blockl;
> +
> +	/* virt_addr points to the IFH. */
> +	virt_addr =3D fdma_dataptr_virt_addr_contiguous(fdma,
> +						      fdma->dcb_index,
> +						      fdma->db_index);
> +
> +	lan966x_ifh_get_src_port(virt_addr, src_port);
> +
> +	if (WARN_ON(*src_port >=3D lan966x->num_phys_ports))
> +		return FDMA_ERROR;

Is it safe to parse the IFH fields from memory and validate them with a WAR=
N_ON
before verifying the frame bounds? Could a runt frame or corrupt DMA descri=
ptor
from the PCIe endpoint trigger this WARN_ON unnecessarily, causing a
denial-of-service via kernel log spam? Should the length check happen first?

> +
> +	port =3D lan966x->ports[*src_port];
> +	if (!port)
> +		return FDMA_ERROR;
> +
> +	db =3D fdma_db_next_get(fdma);
> +
> +	/* BLOCKL is a 16-bit HW-populated field; reject obviously-bad
> +	 * values before they feed memcpy/XDP sizes.
> +	 */
> +	blockl =3D FDMA_DCB_STATUS_BLOCKL(db->status);

Can a malicious or compromised PCIe endpoint modify db->status between this
size validation and the memcpy in lan966x_fdma_pci_rx_get_frame()?

Since the descriptor resides in shared memory, could a secondary modificati=
on
bypass the size validation and allow an out-of-bounds read of adjacent kern=
el
memory into the network stack?

> +	if (!lan966x_fdma_pci_rx_size_fits(fdma, blockl))
> +		return FDMA_ERROR;
> +
> +	return FDMA_PASS;
> +}
> +
> +static struct sk_buff *lan966x_fdma_pci_rx_get_frame(struct lan966x_rx *=
rx,
> +						     u64 src_port)
> +{
> +	struct lan966x *lan966x =3D rx->lan966x;
> +	struct fdma *fdma =3D &rx->fdma;
> +	struct sk_buff *skb;
> +	struct fdma_db *db;
> +	u32 data_len;
> +
> +	/* Get the received frame and create an SKB for it. */
> +	db =3D fdma_db_next_get(fdma);
> +	data_len =3D FDMA_DCB_STATUS_BLOCKL(db->status);
> +
> +	skb =3D napi_alloc_skb(&lan966x->napi, data_len);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	memcpy(skb->data,
> +	       fdma_dataptr_virt_addr_contiguous(fdma,
> +						 fdma->dcb_index,
> +						 fdma->db_index),
> +						 data_len);
> +
> +	skb_put(skb, data_len);
> +
> +	skb->dev =3D lan966x->ports[src_port]->dev;
> +	skb_pull(skb, IFH_LEN_BYTES);
> +
> +	skb_trim(skb, skb->len - ETH_FCS_LEN);

Does this unconditionally trim the FCS, breaking the NETIF_F_RXFCS feature
for PCIe-based devices? The non-PCI path seems to conditionally trim it
based on skb->dev->features.

> +
> +	skb->protocol =3D eth_type_trans(skb, skb->dev);
[ ... ]
> +static int lan966x_fdma_pci_xmit(struct sk_buff *skb, __be32 *ifh,
> +				 struct net_device *dev)
> +{
[ ... ]
> +	/* Safe to free: the PCIe DTBO does not enable the PTP interrupt,
> +	 * so lan966x->ptp stays 0 and lan966x_port_xmit() never enqueues
> +	 * this skb on port->tx_skbs for a TX timestamp.
> +	 */
> +	dev_consume_skb_any(skb);

Can this cause a use-after-free if the packet requires a TX timestamp?
When PTP is enabled, lan966x_ptp_txtstamp_request() queues the SKB for later
processing. Does unconditionally consuming the SKB here free the memory bef=
ore
the PTP worker accesses it? Is it possible for a standard device tree to
enable PTP on this interface, despite the comment?

> +
> +	return NETDEV_TX_OK;
> +}
> +
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
> +		switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> +		case FDMA_PASS:
> +			break;
> +		case FDMA_ERROR:
> +			fdma_dcb_advance(fdma);
> +			goto allocate_new;
> +		}
> +		skb =3D lan966x_fdma_pci_rx_get_frame(rx, src_port);
> +		fdma_dcb_advance(fdma);
> +		if (!skb)
> +			goto allocate_new;

If napi_alloc_skb() fails due to memory pressure, does branching to
allocate_new prematurely break out of the processing loop? Since the hardwa=
re
interrupt was already cleared, and napi_complete_done() is called below,
will this cause the RX queue to stall permanently for the remaining
unprocessed frames? Should the code drop the packet and continue instead?

> +
> +		napi_gro_receive(&lan966x->napi, skb);
> +	}
> +allocate_new:
> +	while (dcb_reload !=3D fdma->dcb_index) {
> +		old_dcb =3D dcb_reload;
> +		dcb_reload++;
> +		dcb_reload &=3D fdma->n_dcbs - 1;
> +
> +		fdma_dcb_add(fdma,
> +			     old_dcb,
> +			     FDMA_DCB_INFO_DATAL(fdma->db_size),
> +			     FDMA_DCB_STATUS_INTR);

Is a memory barrier needed before recycling the descriptor?

The CPU reads the packet payload via memcpy() in lan966x_fdma_pci_rx_get_fr=
ame(),
and then recycles the descriptor by writing to db->status via fdma_dcb_add(=
).
Could weakly ordered architectures reorder the descriptor status write to o=
ccur
before the payload reads have completed, allowing the hardware to overwrite
the buffer prematurely?

> +
> +		lan966x_fdma_rx_reload(rx);
> +	}
> +
> +	if (counter < weight && napi_complete_done(napi, counter))
> +		lan_wr(0xff, lan966x, FDMA_INTR_DB_ENA);

Does writing 0xff forcefully enable all 8 FDMA channels simultaneously?
Could this override the channel-specific bitmask configured during
initialization and lead to interrupt storms from uninitialized or
disabled channels?

> +
> +	return counter;
> +}
[ ... ]
> +static void lan966x_fdma_pci_deinit(struct lan966x *lan966x)
> +{
> +	if (!lan966x->fdma)
> +		return;
> +
> +	lan966x_fdma_rx_disable(&lan966x->rx);
> +	lan966x_fdma_tx_disable(&lan966x->tx);
> +
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);

Can a race condition occur because the hardware RX channel is disabled while
NAPI is still active?

If an interrupt triggers on another CPU, could the poll function process
frames and call lan966x_fdma_rx_reload(), restarting the hardware channel
and conflicting with the disable sequence? Should NAPI be disabled before
shutting down the hardware?

> +
> +	fdma_free_coherent_and_unmap(lan966x->dev, &lan966x->rx.fdma);
> +	fdma_free_coherent_and_unmap(lan966x->dev, &lan966x->tx.fdma);

During module removal, lan966x_fdma_pci_deinit() unmaps the PCIe ATU and fr=
ees
the DMA buffers before the network devices are unregistered.

Can the networking stack still concurrently invoke ndo_start_xmit during th=
is
window? If so, would lan966x_fdma_pci_xmit() attempt to write to unmapped
and freed DMA memory, resulting in a use-after-free and potential PCI bus
aborts?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-lan966x-pc=
i-fdma-v4-0-14e0c89d8d63@microchip.com?part=3D9

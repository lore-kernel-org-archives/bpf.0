Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A7E377A8B;
	Mon, 28 Sep 2026 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623981; cv=none; b=ZIPdwxL9cbrt7F26lVioJpNodgAx1xjjzn1zcjIQ0M4E1JbXDCVVPdp5qWmPP59qMQthjvlpNg1Y8VZDU3y1n/pNLS31m5I4nVhpLAoIz3XDaHCsYETC+hJua18NJ24ofIxLjXWnlJtXja3NwAnoCegMHaBqnjKksCnpvELM6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623981; c=relaxed/simple;
	bh=AQshiReT6epNxwKsY5NmZGp/dBB4g/z6A9fOiDBa/qw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XnW9R2uZ38E6lCC+ZXbYoVsKtocz01WwAOQ9ze3Yoj+LaFh3/2X5lT0kHLplvSOYlJjFmcMNl0NHExbKw/nIiGYD6oV7HuPGBizNEC3ihh6mll67JT4RjnuRWua+W3w5TEh7RIygI4TZ235T7izxXPpoBaVx8CVLKq/1pb71QCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wB/Jn6vS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wB/Jn6vS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790623979; x=1822159979;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=AQshiReT6epNxwKsY5NmZGp/dBB4g/z6A9fOiDBa/qw=;
  b=wB/Jn6vStBxH32D5Zzo0fO3sYWbLKh2WV3Z2ONY8cnHzb8w//Br69ErT
   9jUIS06nH5uNZqba7Z3081IusP+6r1pVwIZPaoXqGtFJWwDKiReQTztAs
   14bhUBz+Vxnc7SUU2ZAIAnuPz7C9atw864oOoLvb6mSFEUJW2CgiDjqbt
   HiwRraST6mDsr5QeJVhs9CvEJEYY8mrhE0hnvgmoDyU8S6XLyOTW1la/M
   wuRDOUuNG08B5gkOohNsi1fcD95Hmde618Ty8lnrbgU0jVoSBB7UBmXla
   1ZOM0Bk263DhywRXuAL7FSWdcZZKzjCInEUUbBM7UtF0G5l1opPDtGX6G
   A==;
X-CSE-ConnectionGUID: SAVYTVgyRburbMp3c07Hpg==
X-CSE-MsgGUID: cxirhw30RNC7Vs6+eGiW7A==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="231389902"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 12:32:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 12:32:57 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:32:54 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v9 00/15] net: lan966x: add support for PCIe FDMA
Date: Mon, 28 Sep 2026 21:32:48 +0200
Message-ID: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAODAumoC/23QzWrDMAwH8FcpPs9D/rZ72nuMHRxZWQxrUpISO
 krffSI7JFAfhayfpf9DLDRXWsT59BAzrXWp08hFejsJHPL4TbIWroUG7cEoI3/ymLy/yytW2Zd
 LlslSsdEVbfoseOw6U1/vG/kpRrrJke438cWdoS63af7d/lrV1v9nNbyyq5IgqXcWu9QB2u7jU
 nGecKjXd5wuG7jqHbE6NhDNSDGE3hN4ftdCzI44sA3EMJKd712wUGKAFmKPSGsTy4iyBBhTicW
 bFuIOSDMTxwjyKiqFTOCamfgdSZAaiGfE9zaW3KXig2oh4YCo1jmBESBEFRLGrLGFxAOiW8FGR
 jQoDF2AUOLLOc/n8w8hxlSnoQIAAA==
X-Change-ID: 20260313-lan966x-pci-fdma-94ed485d23fa
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Herve
 Codina <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, "Simon Horman" <horms@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
X-Mailer: b4 0.14.3

When lan966x operates as a PCIe endpoint, the driver currently uses
register-based I/O for frame injection and extraction. This approach is
functional but slow, topping out at around 33 Mbps on an Intel x86 host
with a lan966x PCIe card.

This series adds FDMA (Frame DMA) support for the PCIe path. When
operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
directly access host memory, so DMA buffers are allocated as contiguous
coherent memory and mapped through the PCIe Address Translation Unit
(ATU). The ATU provides outbound windows that translate internal FDMA
addresses to PCIe bus addresses, allowing the FDMA engine to read and
write host memory. Because the ATU requires contiguous address regions,
page_pool and normal per-page DMA mappings cannot be used. Instead,
frames are transferred using memcpy between the ATU-mapped buffers and
the network stack. With this, throughput increases from ~33 Mbps to
~620 Mbps for default MTU.

Patch 1 adds the shared drivers/net/ethernet/microchip/fdma/ directory
to the Sparx5 SoC MAINTAINERS entry.

Patches 2-4 prepare the shared FDMA library: patch 2 renames the
contiguous dataptr helpers for clarity, patch 3 adds PCIe ATU region
management and coherent DMA allocation with ATU mapping, and patch 4
gives the descriptor fields an explicit little-endian type, since on the
PCIe path the descriptors are written by the host CPU.

Patches 5-8 refactor the lan966x FDMA code to support both platform
and PCIe paths: extracting the LLP register write into a helper,
exporting shared functions, introducing a dedicated device for DMA
operations, and adding an ops dispatch table selected at probe time.

Patches 9-10 harden the existing FDMA path for the PCIe endpoint
lifecycle: patch 9 clears latched FDMA error/interrupt stickies after
the switch reset so they don't assert as soon as interrupts are
enabled, and patch 10 adds a shutdown() callback that quiesces the
FDMA engine on host warm reboot (on the PCIe card the FDMA survives
host reset and would otherwise keep the shared INTx asserted into
the next probe).

Patch 11 adds the core PCIe FDMA implementation with RX/TX using
contiguous ATU-mapped buffers. Patches 12 and 13 extend it with MTU
change and XDP support respectively. XDP_PASS, XDP_TX, XDP_DROP and
XDP_ABORTED are supported; XDP_REDIRECT is deliberately not, because
the PCIe data path does not use page_pool.

Patches 14-15 update the lan966x PCI device tree overlay to extend the
cpu register mapping to cover the ATU register space and add the FDMA
interrupt.

Patches 1-13 touch MAINTAINERS and drivers/net/ethernet/microchip/, and
are for the netdev tree.

Patches 14-15 touch drivers/misc/lan966x_pci.dtso, and are for the
char-misc tree.

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Steen Hegelund <steen.hegelund@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Herve Codina <herve.codina@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v9:
- PCIe: use a private copy of lan966x_hw_offload() that reports when
  skb_vlan_untag() frees the skb, fixing a use-after-free reachable via
  XDP shrinking the frame.
- Link to v8: https://lore.kernel.org/r/20260924-lan966x-pci-fdma-v8-0-201c7b707d8b@microchip.com

Changes in v8:
- New patch 4: use little-endian types for the FDMA descriptor fields.
  On the PCIe path the descriptors live in host memory and are written
  by the host CPU, which may be big-endian, while the FDMA engine reads
  them little-endian. The fields become __le64 and are converted at the
  library boundary; the dataptr/nextptr callbacks keep their u64
  signatures, so sparx5 and lan969x need no changes. Checked with sparse
  (-D__CHECK_ENDIAN__). No functional change on little-endian hosts.
  Tested on lan966x (arm), sparx5 and lan969x (arm64), and lan966x over
  PCIe on an x86 host, with no regressions. (Simon)
- PCIe: read the RX block length through fdma_db_len_get() instead of
  open-coding the status field, following patch 4.
- Stickies: extend the comment to also mention the data-block sticky,
  which is cleared alongside the error stickies.
- Shutdown: reword the commit message to describe the tree at that
  commit, noting where it relies on the PCIe FDMA backend added later
  in the series.
- Link to v7: https://lore.kernel.org/r/20260918-lan966x-pci-fdma-v7-0-0ecc179c8a2c@microchip.com

Changes in v7:

Mostly a response to the automated review of v6. The notable change is
that the resize-time MTU guards added in v6 are replaced by an advertised
limit. v6 rejected an oversized MTU inside lan966x_fdma_pci_resize() with
-ERANGE, which is late, and leaves dev->max_mtu advertising a range the
PCIe path cannot honour. v7 derives the maximum from the same constants
and publishes it in dev->max_mtu instead, so the core rejects the request
up front and both -ERANGE returns become unreachable and are removed.
Also, the shutdown() was refactored to not race with ndo's.

- PCIe: cap dev->max_mtu on the PCIe path (FDMA_PCI_MAX_MTU), derived
  from the contiguous ring having to fit one MAX_PAGE_ORDER block after
  padding to the ATU region granularity, and from db_size having to fit
  the 16-bit DCB DATAL field. On a 4KB-page, MAX_PAGE_ORDER=10 build that
  is MTU 15498. Both resize-time -ERANGE checks are removed with it.
- PCIe: factor the frame overhead into LAN966X_FDMA_OVERHEAD and use it
  for both the cap and lan966x_fdma_get_max_frame(), so it is not
  open-coded twice.
- PCIe: skip the resize while the FDMA is not initialised. The rings are
  built by lan966x_fdma_pci_init(), which runs after the netdevs are
  registered, so an MTU change in that window would dereference NULL.
- PCIe: comment why NAPI has to be enabled before the queues are woken in
  the MTU reload path.
- shutdown(): rework the quiesce ordering. Free the xtr, ana and FDMA
  irqs first so no source can assert INTx, mask ANA_ANAINTR whether or not
  the FDMA is in use, then disable NAPI, stop and detach the netdevs,
  disable the FDMA channels, clear the FDMA interrupt enables and unmap
  the ATU windows.
- ATU: document the alignment requirement and -EINVAL at
  fdma_pci_atu_region_map(), document at fdma_pci_atu_translate_addr()
  that the caller must quiesce DMA and the descriptor paths before
  unmapping a region, initialise the region bookkeeping explicitly in
  fdma_pci_atu_init(), and fix the comment on the upper limit register.
- Patch 3 commit message: drop the claim that the patch adds PCIe FDMA
  support; it adds the helpers the lan966x path later uses.

Reported by the v6 review and deliberately not fixed here, because the
code is pre-existing and the fixes want a Fixes: tag:

- register_netdev() and the FDMA irq request both happen before
  ops->fdma_init(), so an MTU change or a stale interrupt can reach an
  uninitialised FDMA. Pre-existing on the platform path; the fix is a
  reorder of the shared probe, which I will send against net. The skip
  above closes the MTU-change half on PCIe in the meantime.
- lan966x_hw_offload() frees the caller's skb and reports only a bool.
  Pre-existing, all three callers affected. Goes to net with
  Fixes: 6476f90aefaf.
- The platform XDP hook leaves the FCS in the window handed to the BPF
  program, while the PCIe hook strips it. Pre-existing. Goes to net with
  Fixes: 6a2159be7604.
- Link to v6: https://lore.kernel.org/r/20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com

Changes in v6:

The main change is a DMA bug on the PCIe path, found after enabling the
IOMMU on the test host. The rest is hardening and cleanup.

- New patch 6: use a dedicated device for DMA operations. On the PCIe
  path lan966x->dev is the platform device created by
  of_platform_default_populate(), which carries no iommus/dma-ranges of
  its own, so it is not the device the IOMMU has a domain for. DMA
  mapped against it lands outside the domain the endpoint's requester ID
  is associated with. With the IOMMU enabled, AMD-Vi reported
  IO_PAGE_FAULT for the endpoint and no traffic passed. All FDMA DMA now
  targets the real PCIe endpoint device. Retested with the IOMMU in
  translated (DMA-FQ) mode.
- ATU: serialise region allocation/free and ATU register access with a
  mutex.
- ATU: program the region limit per mapping (base_addr + size - 1)
  instead of the full region bound, and disable every region in
  fdma_pci_atu_init().
- ATU: return -ERANGE instead of -E2BIG when the requested size exceeds
  the region size, and clear fdma->atu_region on unmap.
- PCIe FDMA: check fdma_dcbs_init() and unwind the coherent allocation
  and the ATU mapping on failure.
- PCIe FDMA: drop the WARN_ON() on an out-of-range src_port; a malformed
  IFH should not be able to splat the host.
- Quiesce consistently in shutdown, deinit and the MTU reload: stop the
  netdev queues and NAPI before disabling the FDMA channels, and share
  one lan966x_fdma_tx_disable_netdev() helper instead of open-coding it
  per path.
- shutdown: also mask ANA_ANAINTR, which shares the PCIe INTx with the
  FDMA sources.
- MTU change: reject an MTU whose ring would not fit in a single
  MAX_PAGE_ORDER coherent block, and reject one whose db_size would be
  truncated by the 16-bit DCB DATAL field, rather than programming a
  wrong buffer length.
- Assign lan966x->ops directly in the ops dispatch patch, so that patch
  no longer adds a helper returning a single constant; PCI detection now
  derives from dma_dev and arrives with the PCIe implementation.
- ATU: reject a target address that is not aligned to the 64KB ATU region
  granularity, instead of programming a translation offset by the
  misalignment.
- Drop the CONFIG_MCHP_LAN966X_PCI guard around the fdma_pci.h include in
  fdma_api.h (Jakub).
- Use ifneq ($(CONFIG_MCHP_LAN966X_PCI),) instead of ifdef in both the fdma
  and lan966x Makefiles; the symbol is tristate, so the condition has to
  cover both y and m (Jakub).
- Reprogram the FDMA LLP registers on the platform reload restore path,
  which stopped happening when the LLP write moved into the allocation
  functions.
- XDP: drop the napi_synchronize() before freeing the old program on the
  PCIe path; READ_ONCE() on port->xdp_prog plus the RCU-deferred
  bpf_prog_put() already cover the in-flight poll.
- XDP: note that the ETH_ZLEN floor is deliberately not enforced on XDP_TX.
- PCIe FDMA: count tx_dropped when the DCB ring is full.
- PCIe FDMA: guard the deinit napi_disable() on fdma_ndev, as shutdown()
  already does; NAPI is only initialised on the first ndo_open.
- ATU: program the region translation before enabling the region.
- ATU: pad the mapped allocation to the 64KB outbound region granularity,
  so the window does not extend past the coherent allocation.
- ATU: reject mapping an fdma that already holds a region, instead of
  overwriting the handle and leaking the old mapping. The MTU reload clears
  the handle on the live rings first, since it keeps the old mapping alive
  until the new rings are in place.
- PCIe FDMA: declare the RX DCB DATAL as the space actually available to the
  extraction engine (db_size - XDP_PACKET_HEADROOM), since the data block
  pointer starts that far into the slot.
- Move the XDP-unsupported guards from the XDP patch into the PCIe FDMA
  patch, so that no intermediate commit advertises NETDEV_XDP_ACT_NDO_XMIT
  for a PCIe instance while tx->dcbs_buf is NULL, and none lets an XDP
  attach reach the platform page_pool reload. The final tree is unchanged.
- shutdown: take rtnl, so it cannot interleave with the rtnl-only reload
  paths and double-disable the NAPI, which would spin forever in
  napi_disable().
- Link to v5: https://lore.kernel.org/r/20260520-lan966x-pci-fdma-v5-0-ca56197ae05b@microchip.com

Changes in v5:

This version fixes a single AI review issue, flagged by Paolo. Other AI
issues  for v4 has been classified as pre-existing or changes for
follow-ups.

- Fix premature napi_complete_done() in lan966x_fdma_pci_napi_poll() on
  FDMA_ERROR and napi_alloc_skb() failure. Bailing out left DONE=1 DCBs
  in the ring with no IRQ to drain them. Drop the frame and continue
  the poll loop instead. Bump rx_dropped on memory-pressure drop.
  (Paolo)
- Link to v4: https://lore.kernel.org/r/20260508-lan966x-pci-fdma-v4-0-14e0c89d8d63@microchip.com

Changes in v4:
- Consolidate rx size checks into lan966x_fdma_pci_rx_size_fits().
  Subtract XDP_PACKET_HEADROOM on the max size check, and add ETH_HLEN
  on the min size check. This fixes potential OOB reads/writes.
- On xdp_prepare_buff(), update comment to clarify that data is already
  offset by XDP_PACKET_HEADROOM.
- Link to v3:
  https://lore.kernel.org/r/20260504-lan966x-pci-fdma-v3-0-a56f5740d870@microchip.com

Changes in v3:

Version 3 fixes a number of issues reported by sashiko - mostly
hardening.

- Fix double use of XDP_PACKET_HEADROOM.
- Fix ERR_PTR persistence in fdma->atu_region and add missing
  NULL/ERR_PTR guard in fdma_pci_atu_region_unmap().
- Reject size <= 0 in fdma_pci_atu_region_map() and return
  -ENOSPC (was -ENOMEM) when no region is free.
- Introduce lan966x_fdma_pci_tx_size_fits() that accounts for
  XDP_PACKET_HEADROOM; use it from both xmit paths to keep
  bpf_xdp_adjust_tail from writing past the TX slot.
- Validate BLOCKL in rx_check_frame() (reject < IFH+FCS or
  > db_size) before it feeds memcpy/XDP sizes.
- READ_ONCE(port->xdp_prog) inside lan966x_xdp_pci_run() to close
  a TOCTOU on XDP detach that could deref NULL in
  bpf_prog_run_xdp().
- Strip IFH and FCS pre-XDP in rx_check_frame(). After BPF runs
  the driver cannot tell whether the tail was modified; drop the
  unconditional skb_pull/skb_trim in rx_get_frame().
- Account tx_bytes/tx_packets on XDP_TX success and tx_dropped on
  XDP_TX size reject.
- Add dma_wmb()/dma_rmb() around DCB status writes and reads in
  xmit, xmit_xdpf, and napi_poll.
- Collected Tested-by: Hervé Codina.
- Link to v2: https://lore.kernel.org/r/20260428-lan966x-pci-fdma-v2-0-d3ec66e06202@microchip.com

Changes in v2:

Version 2 primarily addresses issues with module unload/load, where
traffic would stop working (Hervé), and XDP head/tail adjust that would be
discarded (Mohsin).

Apart from that, I ran through issues reported by Sashiko, and fixed a
number of other issues.

- New patch 1: add drivers/net/ethernet/microchip/fdma/ to the Sparx5
  SoC MAINTAINERS entry.
- New patch 7: clear latched FDMA error/interrupt stickies after the
  switch reset so they don't fire as soon as interrupts are enabled.
- New patch 8: shutdown() callback, quiescing FDMA on host warm reboot.
- Replaced the depth-2 dev_is_pci(parent->parent) backend selector
  with a parent-chain walk.
- XDP: use xdp.data/xdp.data_end for the post-XDP frame length so that
  bpf_xdp_adjust_head/tail are respected (Mohsin Bashir)
- MTU change: drain in-flight xmits with netif_tx_disable() on every
  port before reallocating rings, waking them again on completion.
- MTU change: cap the PCIe DCB ring at 256 entries so a full-ring
  coherent DMA allocation fits in a single MAX_PAGE_ORDER block at
  jumbo MTU.
- PCIe ATU: disable the region before clearing its translation on
  unmap.
- PCIe FDMA: hold tx_lock in napi_poll around the free-DCB check used
  to wake stopped netdev queues.
- PCIe FDMA: return -ENOSPC (not -1) when the DCB ring is exhausted.
- Link to v1: https://lore.kernel.org/r/20260320-lan966x-pci-fdma-v1-0-ef54cb9b0c4b@microchip.com

---
Daniel Machon (15):
      MAINTAINERS: add FDMA library to Sparx5 SoC entry
      net: microchip: fdma: rename contiguous dataptr helpers
      net: microchip: fdma: add PCIe ATU support
      net: microchip: fdma: use little-endian types for descriptor fields
      net: lan966x: add FDMA LLP register write helper
      net: lan966x: export FDMA helpers for reuse
      net: lan966x: use a dedicated device for DMA operations
      net: lan966x: add FDMA ops dispatch for PCIe support
      net: lan966x: clear FDMA interrupt stickies after switch reset
      net: lan966x: add shutdown callback to stop the FDMA on reboot
      net: lan966x: add PCIe FDMA support
      net: lan966x: add PCIe FDMA MTU change support
      net: lan966x: add PCIe FDMA XDP support
      misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
      misc: lan966x-pci: dts: add fdma interrupt to overlay

 MAINTAINERS                                        |   1 +
 drivers/misc/lan966x_pci.dtso                      |   5 +-
 drivers/net/ethernet/microchip/fdma/Makefile       |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  65 +-
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |  42 +-
 drivers/net/ethernet/microchip/fdma/fdma_pci.c     | 208 ++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h     |  57 ++
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  97 ++-
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 731 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  | 121 +++-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  69 ++
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |  25 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   6 +
 14 files changed, 1357 insertions(+), 78 deletions(-)
---
base-commit: 014d795c73837ea2339a4ea8e8f82c6e959b845d
change-id: 20260313-lan966x-pci-fdma-94ed485d23fa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


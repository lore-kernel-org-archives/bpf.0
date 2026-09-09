Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7393DA7DF;
	Wed,  9 Sep 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958824; cv=none; b=CqWYyhgli42d9Vh65gB/PFV8oPoWNPiKubcw8a8jjpocin3/QCOYGYjHmY0gVy/yXLVXI54/RatasItXjawesae/WJqI3CUnbFy4CqOr9RH8HwMu66t8Feh6lt3tsBR+uG2bM5eDZmeIoA028RXaHrylsES9gjmtXiIvAjRvJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958824; c=relaxed/simple;
	bh=psT43/NCoFcQxW3ncFLvS/f4usrJzRqlQlNmkfWVJGE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GQdsPXVvJaH1bl6CRWsE2GRZfKDQLi0TjsznuGlA6aNi98OdQkr9lSROSb4bx+RNfiRhYWGHNsLjG5YIcKUeP2NKLOtchOw98HJs5D5s9qhye5ebaQHYJp33RBqblyj/yN4f/Nh8iNANsvVPVMRsRx/xDqtBFkCZDR/KnxsgC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rFzPWESL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rFzPWESL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788958822; x=1820494822;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=psT43/NCoFcQxW3ncFLvS/f4usrJzRqlQlNmkfWVJGE=;
  b=rFzPWESLXEqePPThW/q20W1QYcuxxZfXesn+5I1xcVjMCJWEiiYajwEx
   Rgeeyx5EjTuKr2rGAG0A22ynU9e+JyuhdAGYm3WiOLpgTxLY6JqUywLbt
   0b7156X6ORoMd2CLMQ+zHoohJuSN2ACTiHvMIkexpu75UehGNLAcSmQjr
   4zDWcera1ptlZTbw3w4qya+HfPKgxrFVSR8gNFC7sPyRIZKM8Zk6Tt/Or
   0s1Z0qT48t8koC9zy/Qu7EECsH+WxGb3Ez2qvpcIUHiwT2HHFeE/VNTt1
   FG5PH37CjAu+CTMSciOGVMuygf3Y/emc1xsYYTNXG8rGhISYyyBJ8+Bu0
   g==;
X-CSE-ConnectionGUID: VcuYTEQOQlWP/cPMQgLOyA==
X-CSE-MsgGUID: 5dLIGTk2QZyiOuDW+ADG5A==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="230464533"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 06:00:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 9 Sep 2026 06:00:21 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 9 Sep 2026 06:00:17 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH net-next v6 00/14] net: lan966x: add support for PCIe FDMA
Date: Wed, 9 Sep 2026 15:00:02 +0200
Message-ID: <20260909-lan966x-pci-fdma-v6-0-6f48dab9d671@microchip.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFJYoWoC/23QzWrDMAwH8FcpPs9D/ozd095j9ODY8mJYnOCEk
 FLy7jPZoYX6KP7ST0IPsmBJuJDr5UEKbmlJU66F/rgQP7j8gzSFWhMOXINggv66bLXe6ewTjWF
 01EoM0qjARXSkjs0FY9pP8ptkXGnGfSW3mgxpWadyP3dt7Mz/WQ7v7MYoUIxK+t724GX/NSZfJ
 j+k+dNP4wlu/IlIbhoIr0gQ6LVG0LWvhYgnokA2EFERp3RUnYRgOmgh8hVpXSIrwiSCNzaYoEU
 LUS9I8yeqIr6ewmznENTbT47j+AOwELW50gEAAA==
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
	<mohsin.bashr@gmail.com>
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

Patches 2-3 prepare the shared FDMA library: patch 2 renames the
contiguous dataptr helpers for clarity, and patch 3 adds PCIe ATU
region management and coherent DMA allocation with ATU mapping.

Patches 4-7 refactor the lan966x FDMA code to support both platform
and PCIe paths: extracting the LLP register write into a helper,
exporting shared functions, introducing a dedicated device for DMA
operations, and adding an ops dispatch table selected at probe time.

Patches 8-9 harden the existing FDMA path for the PCIe endpoint
lifecycle: patch 8 clears latched FDMA error/interrupt stickies after
the switch reset so they don't assert as soon as interrupts are
enabled, and patch 9 adds a shutdown() callback that quiesces the
FDMA engine on host warm reboot (on the PCIe card the FDMA survives
host reset and would otherwise keep the shared INTx asserted into
the next probe).

Patch 10 adds the core PCIe FDMA implementation with RX/TX using
contiguous ATU-mapped buffers. Patches 11 and 12 extend it with MTU
change and XDP support respectively. XDP_PASS, XDP_TX, XDP_DROP and
XDP_ABORTED are supported; XDP_REDIRECT is deliberately not, because
the PCIe data path does not use page_pool.

Patches 13-14 update the lan966x PCI device tree overlay to extend the
cpu register mapping to cover the ATU register space and add the FDMA
interrupt.

Patches 1-12 touch MAINTAINERS and drivers/net/ethernet/microchip/, and
are for the netdev tree.

Patches 13-14 touch drivers/misc/lan966x_pci.dtso, and are for the
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
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
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
Daniel Machon (14):
      MAINTAINERS: add FDMA library to Sparx5 SoC entry
      net: microchip: fdma: rename contiguous dataptr helpers
      net: microchip: fdma: add PCIe ATU support
      net: lan966x: add FDMA LLP register write helper
      net: lan966x: export FDMA helpers for reuse
      net: lan966x: use a dedicated device for DMA operations
      net: lan966x: add FDMA ops dispatch for PCIe support
      net: lan966x: clear FDMA interrupt stickies after switch reset
      net: lan966x: add shutdown callback to stop FDMA on reboot
      net: lan966x: add PCIe FDMA support
      net: lan966x: add PCIe FDMA MTU change support
      net: lan966x: add PCIe FDMA XDP support
      misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
      misc: lan966x-pci: dts: add fdma interrupt to overlay

 MAINTAINERS                                        |   1 +
 drivers/misc/lan966x_pci.dtso                      |   5 +-
 drivers/net/ethernet/microchip/fdma/Makefile       |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c     |  44 ++
 drivers/net/ethernet/microchip/fdma/fdma_api.h     |  22 +-
 drivers/net/ethernet/microchip/fdma/fdma_pci.c     | 203 ++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h     |  52 ++
 drivers/net/ethernet/microchip/lan966x/Makefile    |   4 +
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c  |  97 +--
 .../ethernet/microchip/lan966x/lan966x_fdma_pci.c  | 692 +++++++++++++++++++++
 .../net/ethernet/microchip/lan966x/lan966x_main.c  |  88 ++-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  42 ++
 .../net/ethernet/microchip/lan966x/lan966x_regs.h  |  25 +
 .../net/ethernet/microchip/lan966x/lan966x_xdp.c   |   6 +
 14 files changed, 1229 insertions(+), 56 deletions(-)
---
base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
change-id: 20260313-lan966x-pci-fdma-94ed485d23fa

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


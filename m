Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C644F7CDD;
	Mon, 28 Sep 2026 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790623993; cv=none; b=cWYuRrhWIjcvByypPwAPjV4NlAsa8nDOknL3L2DVR9qnf1bmYua3X3pQ7fh7UZAc9N6Aq0b+D2AWUYhFiGGv5lE+4IZ2f62hUAa3sCgPcI9lbUseF9dxi33QIKbLRq026+X+Q/x70aZnjxqkI3Wzj7oY9UtEjVADSxhhgm1hFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790623993; c=relaxed/simple;
	bh=eWXDxvjo1b40Oaa4SLtuLOQS21zoSGBx8A9HWDSwW9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Yz9c9JrRiWjCD4LsHPR467dutlgF1kN1B0ol8G+HICGTWjH5T3X14tA4ZM0MJSjui/AueqOdPEjLO5mhDniRvNxE/REHRn23QiouPKvLpJ0zdEatIU50U+ZRMH7KbJ0qQoKJlk+oU0jfx7ETe+I8OnnwHLXTXsLPro8KJJDZm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PriV21uA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PriV21uA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790623997; x=1822159997;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eWXDxvjo1b40Oaa4SLtuLOQS21zoSGBx8A9HWDSwW9M=;
  b=PriV21uAuSzJ+MEvWRjMVM8QNLsSq0u1PmBoQQ17JKn9POEfhuhNuG32
   qrBnZyf1K8agYkF5XFpA0lMsswzidGbECJf3fvj5yIq9Y4nwaH0AwracA
   oumJzgfDv9oBBpi2GBj8RzbgrxnhxNB6BHTkp4xavmOadfLkZ0/J5SRLu
   26BTbtZ202ywSaxehFOinWbmdwd+cF/zckcFoolSbod6UJVMIdLI3h6UB
   q8Fkkukc+3H/Ufi8RvU+DUenqfaV/4pjjdARGn5UHLmamZTw0Sf5mFEcp
   U2jHnzPTEtyBvtv+C3sgmtiEpkoSCqVRGA/WBCjhO3Uff+NvhVhC/NPVb
   Q==;
X-CSE-ConnectionGUID: JlByMZEQT++nWSNrrYke0A==
X-CSE-MsgGUID: 0/zvgtPzTbuQ2Mk59eZQYg==
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="63340433"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2026 12:33:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 28 Sep 2026 12:33:10 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 28 Sep 2026 12:33:06 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 28 Sep 2026 21:32:51 +0200
Subject: [PATCH net-next v9 03/15] net: microchip: fdma: add PCIe ATU
 support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260928-lan966x-pci-fdma-v9-3-a17caf60f89a@microchip.com>
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
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

When lan966x or lan969x operates as a PCIe endpoint, the internal FDMA
engine cannot directly access host memory. Instead, DMA addresses must
be translated through the PCIe Address Translation Unit (ATU). The ATU
provides outbound windows that map internal addresses to PCIe bus
addresses.

The ATU outbound address space (0x10000000-0x1fffffff) is divided into
six equally-sized regions (~42MB each). When FDMA buffers are allocated,
a free ATU region is claimed and programmed with the DMA target address.
The FDMA engine then uses the region's base address in its descriptors,
and the ATU translates these to the actual DMA addresses on the PCIe bus.

Add the required functions and helpers that combine the DMA allocation
with the ATU region mapping. These are used by the lan966x PCIe FDMA
path.

The ATU cannot express a limit finer than its 64KB region granularity,
so pad the mapped allocation to that boundary; otherwise the outbound
window would extend past the memory the host allocated for DMA.

This implementation will also be used by the lan969x, when PCIe FDMA is
added for that platform in the future.

Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/fdma/Makefile   |   4 +
 drivers/net/ethernet/microchip/fdma/fdma_api.c |  44 ++++++
 drivers/net/ethernet/microchip/fdma/fdma_api.h |  14 ++
 drivers/net/ethernet/microchip/fdma/fdma_pci.c | 208 +++++++++++++++++++++++++
 drivers/net/ethernet/microchip/fdma/fdma_pci.h |  57 +++++++
 5 files changed, 327 insertions(+)

diff --git a/drivers/net/ethernet/microchip/fdma/Makefile b/drivers/net/ethernet/microchip/fdma/Makefile
index cc9a736be357..910a10b33fb9 100644
--- a/drivers/net/ethernet/microchip/fdma/Makefile
+++ b/drivers/net/ethernet/microchip/fdma/Makefile
@@ -5,3 +5,7 @@
 
 obj-$(CONFIG_FDMA) += fdma.o
 fdma-y += fdma_api.o
+
+ifneq ($(CONFIG_MCHP_LAN966X_PCI),)
+fdma-y += fdma_pci.o
+endif
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.c b/drivers/net/ethernet/microchip/fdma/fdma_api.c
index e78c3590da9e..a3c9e3097c5c 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.c
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.c
@@ -127,6 +127,50 @@ void fdma_free_phys(struct fdma *fdma)
 }
 EXPORT_SYMBOL_GPL(fdma_free_phys);
 
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+/* Allocate coherent DMA memory and map it in the ATU. */
+int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
+				struct fdma_pci_atu *atu)
+{
+	struct fdma_pci_atu_region *region;
+	int err;
+
+	if (WARN_ON(fdma->atu_region))
+		return -EBUSY;
+
+	/* The ATU cannot express a limit finer than the region granularity, so
+	 * the hardware widens the programmed limit to that boundary. Pad the
+	 * allocation to match, or the outbound window would extend past the
+	 * memory we own.
+	 */
+	fdma->size = ALIGN(fdma->size, FDMA_PCI_ATU_REGION_ALIGN);
+
+	err = fdma_alloc_coherent(dev, fdma);
+	if (err)
+		return err;
+
+	region = fdma_pci_atu_region_map(atu, fdma->dma, fdma->size);
+	if (IS_ERR(region)) {
+		fdma_free_coherent(dev, fdma);
+		return PTR_ERR(region);
+	}
+
+	fdma->atu_region = region;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fdma_alloc_coherent_and_map);
+
+/* Free coherent DMA memory and unmap the memory in the ATU. */
+void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma)
+{
+	fdma_pci_atu_region_unmap(fdma->atu_region);
+	fdma->atu_region = NULL;
+	fdma_free_coherent(dev, fdma);
+}
+EXPORT_SYMBOL_GPL(fdma_free_coherent_and_unmap);
+#endif
+
 /* Get the size of the FDMA memory */
 u32 fdma_get_size(struct fdma *fdma)
 {
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_api.h b/drivers/net/ethernet/microchip/fdma/fdma_api.h
index dea8e3cc155a..ccc30d506e89 100644
--- a/drivers/net/ethernet/microchip/fdma/fdma_api.h
+++ b/drivers/net/ethernet/microchip/fdma/fdma_api.h
@@ -7,6 +7,8 @@
 #include <linux/etherdevice.h>
 #include <linux/types.h>
 
+#include "fdma_pci.h"
+
 /* This provides a common set of functions and data structures for interacting
  * with the Frame DMA engine on multiple Microchip switchcores.
  *
@@ -109,6 +111,11 @@ struct fdma {
 	u32 channel_id;
 
 	struct fdma_ops ops;
+
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+	/* PCI ATU region for this FDMA instance. */
+	struct fdma_pci_atu_region *atu_region;
+#endif
 };
 
 /* Advance the DCB index and wrap if required. */
@@ -233,9 +240,16 @@ int __fdma_dcb_add(struct fdma *fdma, int dcb_idx, u64 info, u64 status,
 
 int fdma_alloc_coherent(struct device *dev, struct fdma *fdma);
 int fdma_alloc_phys(struct fdma *fdma);
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+int fdma_alloc_coherent_and_map(struct device *dev, struct fdma *fdma,
+				struct fdma_pci_atu *atu);
+#endif
 
 void fdma_free_coherent(struct device *dev, struct fdma *fdma);
 void fdma_free_phys(struct fdma *fdma);
+#if IS_ENABLED(CONFIG_MCHP_LAN966X_PCI)
+void fdma_free_coherent_and_unmap(struct device *dev, struct fdma *fdma);
+#endif
 
 u32 fdma_get_size(struct fdma *fdma);
 u32 fdma_get_size_contiguous(struct fdma *fdma);
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.c b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
new file mode 100644
index 000000000000..dd1dc46cbc9d
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/align.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "fdma_pci.h"
+
+/* When the switch operates as a PCIe endpoint, the FDMA engine needs to
+ * DMA to/from host memory. The FDMA writes to addresses within the endpoint's
+ * internal Outbound (OB) address space, and the PCIe ATU translates these to
+ * DMA addresses on the PCIe bus, targeting host memory.
+ *
+ * The ATU supports up to six outbound regions. This implementation divides
+ * the OB address space into six equally sized chunks.
+ *
+ * +-------------+------------+------------+-----+------------+
+ * | Index       | Region 0   | Region 1   | ... | Region 5   |
+ * +-------------+------------+------------+-----+------------+
+ * | Base addr   | 0x10000000 | 0x12aa0000 | ... | 0x1d520000 |
+ * | Limit addr  | 0x12a9ffff | 0x1553ffff | ... | 0x1ffbffff |
+ * | Target addr | host dma   | host dma   | ... | host dma   |
+ * +-------------+------------+------------+-----+------------+
+ *
+ * Base addr is the start address of the region within the OB address space.
+ * Limit addr is each region's own upper bound. The value actually
+ * programmed is set per-mapping as base_addr + mapped size - 1, and is
+ * usually smaller than this.
+ * Target addr is the host DMA address that the base addr translates to.
+ */
+
+#define FDMA_PCI_ATU_OB_START        0x10000000
+#define FDMA_PCI_ATU_OB_END          0x1fffffff
+
+#define FDMA_PCI_ATU_ADDR            0x300000
+#define FDMA_PCI_ATU_IDX_SIZE        0x200
+#define FDMA_PCI_ATU_ENA_REG         0x4
+#define FDMA_PCI_ATU_ENA_BIT         BIT(31)
+#define FDMA_PCI_ATU_LWR_BASE_ADDR   0x8
+#define FDMA_PCI_ATU_UPP_BASE_ADDR   0xc
+#define FDMA_PCI_ATU_LIMIT_ADDR      0x10
+#define FDMA_PCI_ATU_LWR_TARGET_ADDR 0x14
+#define FDMA_PCI_ATU_UPP_TARGET_ADDR 0x18
+
+static u32 fdma_pci_atu_region_size(void)
+{
+	return round_down((FDMA_PCI_ATU_OB_END - FDMA_PCI_ATU_OB_START) /
+			  FDMA_PCI_ATU_REGION_MAX, FDMA_PCI_ATU_REGION_ALIGN);
+}
+
+static void __iomem *fdma_pci_atu_addr_get(void __iomem *addr, int offset,
+					   int idx)
+{
+	return addr + FDMA_PCI_ATU_ADDR + FDMA_PCI_ATU_IDX_SIZE * idx + offset;
+}
+
+static void fdma_pci_atu_region_enable(struct fdma_pci_atu_region *region)
+{
+	writel(FDMA_PCI_ATU_ENA_BIT,
+	       fdma_pci_atu_addr_get(region->atu->addr, FDMA_PCI_ATU_ENA_REG,
+				     region->idx));
+}
+
+static void fdma_pci_atu_region_disable(struct fdma_pci_atu_region *region)
+{
+	writel(0, fdma_pci_atu_addr_get(region->atu->addr, FDMA_PCI_ATU_ENA_REG,
+					region->idx));
+}
+
+/* Configure the address translation in the ATU. */
+static void
+fdma_pci_atu_configure_translation(struct fdma_pci_atu_region *region)
+{
+	struct fdma_pci_atu *atu = region->atu;
+	int idx = region->idx;
+
+	writel(lower_32_bits(region->base_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_LWR_BASE_ADDR, idx));
+
+	writel(upper_32_bits(region->base_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_UPP_BASE_ADDR, idx));
+
+	/* The OB address space lies entirely below 4GB, so the limit always
+	 * fits the lower limit register and the upper one is left alone.
+	 */
+	writel(region->limit_addr,
+	       fdma_pci_atu_addr_get(atu->addr, FDMA_PCI_ATU_LIMIT_ADDR, idx));
+
+	writel(lower_32_bits(region->target_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_LWR_TARGET_ADDR, idx));
+
+	writel(upper_32_bits(region->target_addr),
+	       fdma_pci_atu_addr_get(atu->addr,
+				     FDMA_PCI_ATU_UPP_TARGET_ADDR, idx));
+}
+
+/* Find an unused ATU region. */
+static struct fdma_pci_atu_region *
+fdma_pci_atu_region_get_free(struct fdma_pci_atu *atu)
+{
+	struct fdma_pci_atu_region *regions = atu->regions;
+
+	for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
+		if (regions[i].in_use)
+			continue;
+
+		return &regions[i];
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
+/* Unmap an ATU region, clearing its translation and disabling it. */
+void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region)
+{
+	if (IS_ERR_OR_NULL(region))
+		return;
+
+	mutex_lock(&region->atu->lock);
+
+	region->target_addr = 0;
+	region->in_use = false;
+
+	fdma_pci_atu_region_disable(region);
+	fdma_pci_atu_configure_translation(region);
+
+	mutex_unlock(&region->atu->lock);
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_region_unmap);
+
+/* Map a host DMA address into a free outbound region. */
+struct fdma_pci_atu_region *
+fdma_pci_atu_region_map(struct fdma_pci_atu *atu, u64 target_addr, int size)
+{
+	struct fdma_pci_atu_region *region;
+
+	if (!atu)
+		return ERR_PTR(-EINVAL);
+
+	if (size <= 0)
+		return ERR_PTR(-EINVAL);
+
+	if (size > fdma_pci_atu_region_size())
+		return ERR_PTR(-ERANGE);
+
+	/* The ATU region base is only ever aligned to FDMA_PCI_ATU_REGION_ALIGN;
+	 * require the same alignment of the host target address, since the ATU
+	 * translates addr - target_addr + base_addr and any misalignment here
+	 * would shift every translated address by the same amount.
+	 */
+	if (!IS_ALIGNED(target_addr, FDMA_PCI_ATU_REGION_ALIGN))
+		return ERR_PTR(-EINVAL);
+
+	mutex_lock(&atu->lock);
+
+	region = fdma_pci_atu_region_get_free(atu);
+	if (IS_ERR(region)) {
+		mutex_unlock(&atu->lock);
+		return region;
+	}
+
+	region->target_addr = target_addr;
+	region->limit_addr = region->base_addr + size - 1;
+	region->in_use = true;
+
+	fdma_pci_atu_configure_translation(region);
+	fdma_pci_atu_region_enable(region);
+
+	mutex_unlock(&atu->lock);
+
+	return region;
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_region_map);
+
+/* Translate a host DMA address to the corresponding OB address. */
+u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr)
+{
+	return region->base_addr + (addr - region->target_addr);
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_translate_addr);
+
+/* Initialize ATU, dividing the OB space into equally sized regions. */
+void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr)
+{
+	struct fdma_pci_atu_region *regions = atu->regions;
+	u32 region_size = fdma_pci_atu_region_size();
+
+	atu->addr = addr;
+	mutex_init(&atu->lock);
+
+	for (int i = 0; i < FDMA_PCI_ATU_REGION_MAX; i++) {
+		regions[i].base_addr =
+			FDMA_PCI_ATU_OB_START + (i * region_size);
+		regions[i].limit_addr = 0;
+		regions[i].target_addr = 0;
+		regions[i].idx = i;
+		regions[i].atu = atu;
+		regions[i].in_use = false;
+
+		fdma_pci_atu_region_disable(&regions[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(fdma_pci_atu_init);
diff --git a/drivers/net/ethernet/microchip/fdma/fdma_pci.h b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
new file mode 100644
index 000000000000..010bdb4d50b0
--- /dev/null
+++ b/drivers/net/ethernet/microchip/fdma/fdma_pci.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _FDMA_PCI_H_
+#define _FDMA_PCI_H_
+
+#include <linux/align.h>
+#include <linux/bits.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define FDMA_PCI_ATU_REGION_MAX 6
+
+/* Outbound regions are 64KB granular (datasheet section 3.24.7.4.1), so both
+ * the region base and the mapped size must be aligned to this.
+ */
+#define FDMA_PCI_ATU_REGION_ALIGN BIT(16)
+
+#define FDMA_PCI_DB_ALIGN 128
+#define FDMA_PCI_DB_SIZE(mtu) ALIGN(mtu, FDMA_PCI_DB_ALIGN)
+
+struct fdma_pci_atu;
+
+struct fdma_pci_atu_region {
+	struct fdma_pci_atu *atu;
+	u64 base_addr; /* Base addr of the OB window */
+	u64 limit_addr; /* End addr of the active mapping (base_addr + size - 1) */
+	u64 target_addr; /* Host DMA address this region maps to */
+	int idx;
+	bool in_use;
+};
+
+struct fdma_pci_atu {
+	void __iomem *addr;
+	struct mutex lock; /* Protects region alloc/free and ATU register access */
+	struct fdma_pci_atu_region regions[FDMA_PCI_ATU_REGION_MAX];
+};
+
+/* Initialize ATU, dividing OB space into regions. */
+void fdma_pci_atu_init(struct fdma_pci_atu *atu, void __iomem *addr);
+
+/* Unmap an ATU region, clearing its translation and disabling it. */
+void fdma_pci_atu_region_unmap(struct fdma_pci_atu_region *region);
+
+/* Map a host DMA address into a free ATU region. target_addr and size must be
+ * FDMA_PCI_ATU_REGION_ALIGN aligned; a misaligned target_addr returns -EINVAL.
+ */
+struct fdma_pci_atu_region *fdma_pci_atu_region_map(struct fdma_pci_atu *atu,
+						    u64 target_addr,
+						    int size);
+
+/* Translate a host DMA address to the OB address space. Reads the region
+ * unlocked, so the caller must quiesce DMA and the descriptor paths before
+ * unmapping the region.
+ */
+u64 fdma_pci_atu_translate_addr(struct fdma_pci_atu_region *region, u64 addr);
+
+#endif

-- 
2.34.1


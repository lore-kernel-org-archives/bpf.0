Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747735FF5B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 01:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127844; cv=none; b=o+nWz2FsldKDCkTevmqLEtNreE2YMtnnBfNYR1PBhnahEAcKVgdqBwb/Zm0bz89toFlfo8eV6tunZAvV7QLU6puvP8bRxWNcvT9msTWR6LCdzrSWKDV2Nt2/hWdCDPfK9Qlqq1lHoSXERfEC9vC9PS8ZM5nqllVa1w6mysiDvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127844; c=relaxed/simple;
	bh=rX7r1Gv+Zqy2XDYDnOJyXdXHXL+ZIMwfriPPPV5kVeg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLZ5iZ8nveLPczawjUGHGFC2g/cuEeIYNaw60DymqKchOj75lY7LPd2+KZqQ9jL8LTmKy2OCoV/8YR/pcjPc5A/6ROpEzY/avwILDRn5YDV9TDbUsPkc6145PjeLl/2RzwWQvundfoW0RpajTzJNz9P50pdDtQKpehh/Wl6T+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms0ubb8V; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms0ubb8V"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4881ca701a4so303157fac.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 18:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127841; x=1790732641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FEVXgXSiMb0G3V8IOr/2pxYlQu8bVHCYpeXjjxcarkY=;
        b=ms0ubb8VQl+20+pQQpVBGzKCGL2SXJ1EpowNcwjnJq98uZ3THe5RgXpaDUYd0pr5zX
         +b/7DQo4dEEtr3cVGe1VDQc6B1Gzx/mQFRQ78g7UX5s0n5Z7vQBYEg+r9CJdPeCtFM6g
         fUrN364N6NLmkdwTdNdEEcsBOiaKy9iRt/ksiAjp5vOYYry9Av/zgwc94NhPgEK8mY+Z
         rBvn0nokJR1sHv/kv2jFPWk86xVfXascI3QBfh3RL7R0IhvU0F50nKovZPZs6b9DcIRJ
         oSSVXfN4vKJTscbpn3WuCdbX2x8ap8dhLo/FNTJnPqlAJrRlgBp3RpxLt4Z7j/FFf1KA
         Dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127841; x=1790732641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEVXgXSiMb0G3V8IOr/2pxYlQu8bVHCYpeXjjxcarkY=;
        b=zs90LFjgjxZLJcmxkJ50Z+fFB1n3PVznBicoOLUFz/itywZ1/KAqjXA8DzAxWrqtsC
         6I09+epLuaoLGtaF330LNGXiWzfXutlpVDptmTO50KQEMIyjYtNJLxGt1EpU8KnKOuaX
         Qal5rm2RnimDVyQniGjIPtGCG5HWduIltQggUv1EAI0EEfkcFMcCvNq/EGHHr4eDHSs1
         wRQDaE0KdJdmnkz48NSSWQ+X3ELieZI6qokFiF5xDSmRbkmRnFjnUYbLvcdwIUMkL97a
         011n+jcs4j+UcxsCxDJ3tFwFPgiZigCQ10P64Vd1gvEh4ffU1xhdU2QYXJ8edGLPeAtM
         tRsw==
X-Forwarded-Encrypted: i=1; AKwUvBwwYN3R0kjxbHWNrsZTi/+tAmGTpBCOv8dHXx+ZMrDg/bqviORdssnj0qrUlLYRb1nuxbk=@vger.kernel.org
X-Gm-Message-State: AFuF++nKZGfDL0zD4g7438h8ZwcaPRMWSS/4JSiho/GCvrm+ktjoNQAF
	2PL4UPteVwi3dcDymXKfMg02SaeYp5YMaHZflz6AC2Ia39l5Teier97hhoWj1P89
X-Gm-Gg: AYBFou2sxjgWOS/Obe0oORbBHBtnVQx0RloIjc1g1GsoTVcJF+a9Y/Zxo/A7mim5OWj
	PyTRmc4m2/zEUBzdpFsmMpDjwBcWDbxeEPpUH3x6BviI1wMXXB5/ioPjSwH11JK/ve8sRdIocdJ
	amV6O7E3aUYEn+KT0oJoo7DTKJSR2xpMzQ+c9QwovvAIZrn0a0eXsCLkvst61hdbOVP4A0IF81J
	TJOnwvr8rfHq/P0nx0WBzYpSX6nFkqqmNMIEvioXz/mjJQMvr8juPncnrHkC9ry8i5eqKdnbwFa
	doPb2nfirr90m2Boda+7FOlTkShe4e5XsQ1Sm10f7iI1j1O09hNJ/zMSFgTPutSMW3k2MqkDUr2
	vxhZb+Mgit7qTg7oPLn4sNBuiqp17c3O0b9oFV/U8j6whKD34VUH2AWkR50a3x9LzSqetUW6OEF
	rzY9u2Oygy3pXuJYGd2oBWAZXg0myOiedLmXzUzXA0cyxoMaoHTBac9GNUlNTcxb2w53I=
X-Received: by 2002:a05:6820:1c9c:b0:6be:4117:ae1e with SMTP id 006d021491bc7-6d2d0240feamr1036942eaf.14.1790127841386;
        Tue, 22 Sep 2026 18:44:01 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4908efd733bsm1122182fac.18.2026.09.22.18.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:44:00 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 22 Sep 2026 18:43:39 -0700
Subject: [PATCH net-next 1/8] eth: mpnic: add scaffolding for Meta
 Platforms NIC
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-linux-mpnic-v1-1-236844f53072@gmail.com>
References: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
In-Reply-To: <20260922-linux-mpnic-v1-0-236844f53072@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, 
 Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

MPNIC is the next network interface controller designed by Meta. Create
a bare PCI driver for it. Subsequent changes will flesh it out.

Registers live in BAR0 and are addressed as an array of 32 bit words,
which is why the CSR indices are a quarter of the byte offset. Most of
the register file is only accessible as 64 bit, so that is the only
accessor added here.

If a read returns all ones, a second read to an unused register with
reset value 0 is performed to determine if the device is gone. If the
device is gone, the mapped BAR0 pointer is cleared, so no further
accesses reach the bus.

For now, if mpnic_mmio_err() clears mpd->uc_addr0, nothing will
reassign it. The user will have to unbind and rebind the driver. Future
series will reset uc_addr0 from pci error handlers.

In addition to being used as a 0 value reference CSR, MPNIC_BDQ_SPARE is
also used to perform write flushes, because it can be read without
producing side effects.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Note: not including an mpnic.rst at this point by design. That will be
introduced when the driver actually exposes user-visible statistics or
configuration options.
---
 drivers/net/ethernet/meta/Kconfig           |  12 +++
 drivers/net/ethernet/meta/Makefile          |   1 +
 drivers/net/ethernet/meta/mpnic/Makefile    |  12 +++
 drivers/net/ethernet/meta/mpnic/mpnic.h     |  40 ++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_csr.h |  24 +++++
 drivers/net/ethernet/meta/mpnic/mpnic_pci.c | 147 ++++++++++++++++++++++++++++
 6 files changed, 236 insertions(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index ca5c7ac2a5bc..f940048a5e37 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -35,4 +35,16 @@ config FBNIC
 	  To compile this driver as a module, choose M here. The module
 	  will be called fbnic.  MSI-X interrupt support is required.
 
+config MPNIC
+	tristate "Meta Platforms Network Interface Controller"
+	depends on 64BIT || COMPILE_TEST
+	depends on !S390
+	depends on PCI_MSI
+	help
+	  This driver supports the Meta Platforms Network Interface
+	  Controller.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called mpnic.
+
 endif # NET_VENDOR_META
diff --git a/drivers/net/ethernet/meta/Makefile b/drivers/net/ethernet/meta/Makefile
index 88804f3de963..633973419c21 100644
--- a/drivers/net/ethernet/meta/Makefile
+++ b/drivers/net/ethernet/meta/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_FBNIC) += fbnic/
+obj-$(CONFIG_MPNIC) += mpnic/
diff --git a/drivers/net/ethernet/meta/mpnic/Makefile b/drivers/net/ethernet/meta/mpnic/Makefile
new file mode 100644
index 000000000000..2588f1f1f1d5
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+
+#
+# Makefile for the Meta(R) Platforms Network Interface Controller
+#
+
+obj-$(CONFIG_MPNIC) += mpnic.o
+
+mpnic-y := \
+	mpnic_pci.o \
+# End of mpnic-y
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic.h b/drivers/net/ethernet/meta/mpnic/mpnic.h
new file mode 100644
index 000000000000..6b8bee93033a
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _MPNIC_H_
+#define _MPNIC_H_
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/types.h>
+
+#include "mpnic_csr.h"
+
+#define MPNIC_DRV_NAME		"mpnic"
+
+struct mpnic_dev {
+	struct device *dev;
+
+	u32 __iomem *uc_addr0;
+};
+
+u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg);
+
+static inline void mpnic_wr64(struct mpnic_dev *mpd, u32 reg, u64 val)
+{
+	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
+
+	if (csr)
+		writeq(val, csr + reg);
+}
+
+static inline void mpnic_wrfl(struct mpnic_dev *mpd)
+{
+	mpnic_rd64(mpd, MPNIC_BDQ_SPARE);
+}
+
+static inline bool mpnic_present(struct mpnic_dev *mpd)
+{
+	return !!READ_ONCE(mpd->uc_addr0);
+}
+
+#endif /* _MPNIC_H_ */
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_csr.h b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
new file mode 100644
index 000000000000..473a2e9f5a09
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_csr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _MPNIC_CSR_H_
+#define _MPNIC_CSR_H_
+
+#include <linux/bits.h>
+
+#define CSR_BIT(nr)		BIT_ULL(nr)
+#define CSR_GENMASK(h, l)	GENMASK_ULL(h, l)
+
+/* Register Definitions
+ *
+ * The register file is addressed as an array of le32, so the byte address of
+ * a register is 4 times the index below. Each register is listed with its
+ * name, index and byte address.
+ *
+ *	Name				Index			Address
+ *****************************************************************************/
+
+/* NIC_CORE_RBP_HP_GLBL */
+#define MPNIC_BDQ_SPARE			0x42013e		/* 0x10804f8 */
+
+#endif /* _MPNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
new file mode 100644
index 000000000000..96393e781241
--- /dev/null
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "mpnic.h"
+
+#define PCI_DEVICE_ID_META_MPNIC	0x0014
+
+static void mpnic_mmio_err(struct mpnic_dev *mpd, u32 reg)
+{
+	/* Hardware is giving us all 1's reads, assume it is gone */
+	WRITE_ONCE(mpd->uc_addr0, NULL);
+
+	dev_err(mpd->dev,
+		"Failed read (idx 0x%x AKA addr 0x%x), disabled CSR access, awaiting reset\n",
+		reg, reg << 2);
+}
+
+u64 mpnic_rd64(struct mpnic_dev *mpd, u32 reg)
+{
+	u32 __iomem *csr = READ_ONCE(mpd->uc_addr0);
+	u64 value;
+
+	if (!csr)
+		return ~0ULL;
+
+	value = readq(csr + reg);
+
+	/* If any bits are 0 value should be valid */
+	if (~value)
+		return value;
+
+	/* All ones can be a valid value, so confirm against a register
+	 * which never reads that way on a live device.
+	 */
+	if (reg != MPNIC_BDQ_SPARE && ~readq(csr + MPNIC_BDQ_SPARE))
+		return value;
+
+	mpnic_mmio_err(mpd, reg);
+
+	return ~0ULL;
+}
+
+static struct mpnic_dev *mpnic_alloc(struct pci_dev *pdev)
+{
+	struct mpnic_dev *mpd;
+
+	mpd = kzalloc_obj(*mpd);
+	if (!mpd)
+		return NULL;
+
+	pci_set_drvdata(pdev, mpd);
+	mpd->dev = &pdev->dev;
+
+	return mpd;
+}
+
+/**
+ * mpnic_probe - Device initialization routine
+ * @pdev: PCI device information struct
+ * @ent: entry in mpnic_pci_tbl
+ *
+ * Return: 0 on success, negative on failure
+ **/
+static int mpnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	void __iomem *uc_addr0;
+	struct mpnic_dev *mpd;
+	int err;
+
+	if (pdev->error_state != pci_channel_io_normal) {
+		dev_err(&pdev->dev,
+			"PCI device still in an error state. Unable to load...\n");
+		return -EIO;
+	}
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "PCI enable device failed: %d\n", err);
+		return err;
+	}
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(46));
+	if (err) {
+		dev_err(&pdev->dev, "DMA configuration failed: %d\n", err);
+		return err;
+	}
+
+	mpd = mpnic_alloc(pdev);
+	if (!mpd)
+		return -ENOMEM;
+
+	uc_addr0 = pcim_iomap_region(pdev, 0, MPNIC_DRV_NAME);
+	if (IS_ERR(uc_addr0)) {
+		err = PTR_ERR(uc_addr0);
+		dev_err(&pdev->dev, "Mapping the register file failed: %d\n",
+			err);
+		goto err_free_mpd;
+	}
+	mpd->uc_addr0 = uc_addr0;
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+
+	return 0;
+
+err_free_mpd:
+	kfree(mpd);
+
+	return err;
+}
+
+/**
+ * mpnic_remove - Device removal routine
+ * @pdev: PCI device information struct
+ **/
+static void mpnic_remove(struct pci_dev *pdev)
+{
+	struct mpnic_dev *mpd = pci_get_drvdata(pdev);
+
+	kfree(mpd);
+}
+
+static const struct pci_device_id mpnic_pci_tbl[] = {
+	{ PCI_VDEVICE(META, PCI_DEVICE_ID_META_MPNIC) },
+	/* required last entry */
+	{}
+};
+MODULE_DEVICE_TABLE(pci, mpnic_pci_tbl);
+
+static struct pci_driver mpnic_driver = {
+	.name		= MPNIC_DRV_NAME,
+	.id_table	= mpnic_pci_tbl,
+	.probe		= mpnic_probe,
+	.remove		= mpnic_remove,
+};
+
+module_pci_driver(mpnic_driver);
+
+MODULE_DESCRIPTION("Meta Platforms Network Interface Controller");
+MODULE_LICENSE("GPL");

-- 
2.52.0


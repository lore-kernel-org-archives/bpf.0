Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91C3CAE7A
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017725; cv=none; b=T1FvHA6WvtEL9KO9wnaRlAdzZeNVx1gwMs1VfqQ1DMqxQMTamWDrvM8Q7aBpzClLDrhX4SPB4iIEvqwA6y5Lq/am+Lf4INQqjuTlVnLbn8gDT8S+Jfn0uz9cw3PGpMJ7ciPr0s7kGkF2FmeULYMGwuvkMFI2zaQgMJNx6hcwX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017725; c=relaxed/simple;
	bh=e96EXxfLihKuO05dFmuztcwCzRpZVtLutKKCC6HBE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3lVA0pR8M/lEoHMzO3ytkxrpZ2ybuYf7l/Tdg6a4cy6e59+zO7x74r6u3D7bybOZm0ZTkUZi7gSCmDTz6E7tdJWSlerwwgS1LzW/AMB7E+cLPjX7jzNSEPecSH8WVMnchQ1E+1QII0WiZzJ8tTNQtdWDOH8+yiGLanLlCzu24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=KEuw/nq0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="KEuw/nq0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7393c6832bso795651a12.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017724; x=1774622524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=KEuw/nq0UxFJEN94nRSwwQWNasWOGQAm8/mjC4bDR1u6SRbMirnO1JZXZZHGoIv5hT
         Lw2+fXOnNjgUEo9LCUYC0KY5XVYP5ZrqcmLZ6n7tsX/UcFO9t2eDzVpCxVcCHWAZCywv
         U5AMgk0thL5wvEKRF94+W2s8DPvywhTPPMXh5oH0cIl7llC6pJvcmDCc7aVMvuaLfU2U
         HsRaqls+Zf8aR8T/bmzxhQcozo61CvAFG1E8l/I76GofLD0m6OPFpKPEOfxe/nq55Lg+
         7eJhJIsp9nQepQNkIaNDIEsyjQ3wXfSZbFDoG2/Qn6vYJ2IMaJUx0VagcsKEDR1T/BjX
         5jQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017724; x=1774622524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=egF6yqfV2LGQ1MtGwjRJvPPaiW2tvpCH9CcxPEMx/WK7uhk9Dmv29hQpE8IZUK0xHe
         /G43rMQExZh7+VHSSPfMbc6vL73Km/leopudzgsiQq8l6/FZ/LaAG2b8fTrCIAhD1NWD
         CdIfBo2FMtDIko8a7K1FVawSfD4qCFE7mORtVk1oI29oI12SCoWnxFo0qC7vYnv2mCLY
         2BsomX6eTjGqv9MuLG900Cyr+bZC1iHqripALQJpp0SJzAO02t0qw4UFry5D2ZGPeQVN
         JRyh6ZoPQkiGR0FE6BIVaYuLQuWrvUgh8qotc6cDLTugnJDZ3Z+HMspCW0AzfAXYvbBR
         ugYg==
X-Forwarded-Encrypted: i=1; AJvYcCWbji2aEWFNNojqrKcwWup4057dJu/IIr+NB0/4RpNjefTgAsjgXpPpGdfctgBBOSXdpyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVOSHo0xXJH4q26G+mKRFRr0kz8wAdB3riqSwzaVhuIrBzW4VH
	+qkOzzFc+zDau4rWWgFnOAt/Uv/+l/fd90NHwCwhGpJ077ZD4meeibqtWsymzrMtgaI=
X-Gm-Gg: ATEYQzwuMJGWQZLFLXuT/y40JMc6/OT0qAQRCbwyIdW4evgc1J1xYZLFvFHhsUCdbLh
	bwXrRBp6fHQB1oLN9XH+z189+WWiBJ3GC0JcZpRtL7zdzBo96SQucdGxN0rlPgmqYeu6g2ZK8f7
	KhONgo1IHypgixFqvhY0yOtmQnKWBprRSj4Czuk1CRs+nQdmUJsuhpaSRbKcVb65ghtbn4eIp+X
	YPPDWczdXbsn8WiYrrsWFGyQYbAZRqKFBhBEN7gl3ndWsXKRStZYuCsM166bizBjncq0gJG8SmI
	ONiawo4VLtiM03XSkj6Mxv714OHLRMK3rcARpRxHa04GSVGp5GTDB+OVMbrAOA8o2ZfAvMH1D/e
	diC3o/jp3kItcEg3Yuogy5dXONRaUFsQuTsJpsURwfjRAPlHqLjvOhk8+wfeiex0/mq+ipp2MuW
	Log7g=
X-Received: by 2002:a17:903:3c2d:b0:2ae:3afc:eb42 with SMTP id d9443c01a7336-2b0827de54amr34730085ad.38.1774017723548;
        Fri, 20 Mar 2026 07:42:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835604cdsm23482005ad.37.2026.03.20.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:42:03 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>,
	bpf@vger.kernel.org
Subject: [net-next v4 07/12] net: bnxt: Add boilerplate GSO code
Date: Fri, 20 Mar 2026 07:41:28 -0700
Message-ID: <20260320144141.260246-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bnxt_gso.c and bnxt_gso.h with a stub bnxt_sw_udp_gso_xmit()
function, SW USO constants (BNXT_SW_USO_MAX_SEGS,
BNXT_SW_USO_MAX_DESCS), and the is_sw_gso field in bnxt_sw_tx_bd
with BNXT_SW_GSO_MID/LAST markers.

The full SW USO implementation will be added in a future commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/Makefile   |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 30 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h | 31 +++++++++++++++++++
 4 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h

diff --git a/drivers/net/ethernet/broadcom/bnxt/Makefile b/drivers/net/ethernet/broadcom/bnxt/Makefile
index ba6c239d52fa..debef78c8b6d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/Makefile
+++ b/drivers/net/ethernet/broadcom/bnxt/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_BNXT) += bnxt_en.o
 
-bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o
+bnxt_en-y := bnxt.o bnxt_hwrm.o bnxt_sriov.o bnxt_ethtool.o bnxt_dcb.o bnxt_ulp.o bnxt_xdp.o bnxt_ptp.o bnxt_vfr.o bnxt_devlink.o bnxt_dim.o bnxt_coredump.o bnxt_gso.o
 bnxt_en-$(CONFIG_BNXT_FLOWER_OFFLOAD) += bnxt_tc.o
 bnxt_en-$(CONFIG_DEBUG_FS) += bnxt_debugfs.o
 bnxt_en-$(CONFIG_BNXT_HWMON) += bnxt_hwmon.o
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d9543d6048d8..593b78672be8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -891,6 +891,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_ts_pkt;
 	u8			is_push;
 	u8			action;
+	u8			is_sw_gso;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
@@ -898,6 +899,9 @@ struct bnxt_sw_tx_bd {
 	};
 };
 
+#define BNXT_SW_GSO_MID		1
+#define BNXT_SW_GSO_LAST	2
+
 struct bnxt_sw_rx_bd {
 	void			*data;
 	u8			*data_ptr;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
new file mode 100644
index 000000000000..b296769ee4fe
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/netdev_queues.h>
+#include <net/ip.h>
+#include <net/ipv6.h>
+#include <net/udp.h>
+#include <net/tso.h>
+#include <linux/bnxt/hsi.h>
+
+#include "bnxt.h"
+#include "bnxt_gso.h"
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb)
+{
+	dev_kfree_skb_any(skb);
+	dev_core_stats_tx_dropped_inc(bp->dev);
+	return NETDEV_TX_OK;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
new file mode 100644
index 000000000000..f01e8102dcd7
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Broadcom NetXtreme-C/E network driver.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef BNXT_GSO_H
+#define BNXT_GSO_H
+
+/* Maximum segments the stack may send in a single SW USO skb.
+ * This caps gso_max_segs for NICs without HW USO support.
+ */
+#define BNXT_SW_USO_MAX_SEGS	64
+
+/* Worst-case TX descriptors consumed by one SW USO packet:
+ * Each segment: 1 long BD + 1 ext BD + payload BDs.
+ * Total payload BDs across all segs <= num_segs + nr_frags (each frag
+ * boundary crossing adds at most 1 extra BD).
+ * So: 3 * max_segs + MAX_SKB_FRAGS + 1 = 3 * 64 + 17 + 1 = 210.
+ */
+#define BNXT_SW_USO_MAX_DESCS	(3 * BNXT_SW_USO_MAX_SEGS + MAX_SKB_FRAGS + 1)
+
+netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
+				 struct bnxt_tx_ring_info *txr,
+				 struct netdev_queue *txq,
+				 struct sk_buff *skb);
+
+#endif
-- 
2.52.0


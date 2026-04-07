Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B169383C82
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599418; cv=none; b=i86+RvcBJScp5KeXQM6RYtJ3PWXQURZLdXtMhZndG0z7fUMzutP7ZbG6OetjH5q8YyA3SzCR/BJqW1sPBD8d5qiL1qtTXiVd2XqOmqk89Inv5y1ef6WeNw1yZKJsdEEtoTKEJF/q9Rd3GE+yOCX8aKtsbpKioq9CEOWCk0sE4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599418; c=relaxed/simple;
	bh=imhnP3c90RnqduwmC0Bs7sD+WwiHek5Y56xEli2D4zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHFj/OX/DqLrc2OsxwPKYKn+wfNsJKvnDatYpg3MuRaO5mUN9j8X2HG2XZomHghGWmR5TOynS4tTdMu4GDQaqnMO6YUvpy3dpNRtCM1WqTSBrp/3bbERMJaKKtd0S8ZKszK0j2ku2NrZrZSrw6nGZk8MdTsZeD1cCrgSjxE6hWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=OeaIq4w1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="OeaIq4w1"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3463164a91.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599415; x=1776204215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=OeaIq4w1UWsmJt2SS/SwaRN0lm/dL8rp/v6RBkDZr2H+IoVRDQEPY3g8xhrtaNyWJw
         Sw250wO19OUFzNrIjXJfp83zWGZGhwE/pE5bvWzGpVjfC3ViGZVm6yOmLmJ4eBTilgxC
         eoTci1LPniiAVp5308znOoyzQav/VVAWANZ9JL0sFlJJarXO4xHf6TBRSiDmcAezOivk
         jyVGWOOhY6bWNnFIM1ATf5Dn/7zVXJAidLgcauo4Ucs+zoWd1OzskIY6zTIixAm8EBoT
         M0Z0zUT0yAOmWN13UoBZSBH3tb0Kp+RToVC3F9qWb0aUaShKJdYnTIhTbrCphGKR8G4g
         ktvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599415; x=1776204215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=snl46CL4sHUpljDXsvqSdDziskU2r/Gp9STJK+5VapmB7ICSXKYH9BTbCcajCljHa3
         7Dld1M2sMKRoIcS0ZLj4tSBGB9KJPugrlqd2bUq/xTkEtJptky7faMqR4D46NYTAHDBb
         8BjelE/sqNIkO/4J+vzTGgPMRhnoYqMC/TX1qKZYt6nsA4yZne4kR1gQlg5kCXnIcAju
         M8S5+hEDN4i6T4LIDLwjqI1eGPjW7V6J5wNKB9EHhu48v0XBOCkrQIm42tMGNLUX7kdD
         tvIWWSj0WUG9ZkXBLOp6GkzecX4y7GvKdta5n0N/8XFxrU7HNv98rNduxMhrFeLmN/ZL
         bY3g==
X-Forwarded-Encrypted: i=1; AJvYcCUKNbF5mTwHTb5MQliZ59KJulwzyj2EzZAA6FxI3PsdLUfcS+unjzBEh98zrJF3jfY/vF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXo36FK6/opgJWHq8SY+HLaCuvBPUf25BFRFrxrGKC+sx4XUBm
	rdUHMrFJDlfF2tpvy7E9fPYb7AFdb3nKqq0RT0oDJTxAsOsxghS/nzFKy56b6yog594=
X-Gm-Gg: AeBDietHp6FaiotIqcQgLycpW/Oqav/H2HcaKuMtE7m4WboDSJjH6Ji9HY8pA8wJZV0
	wyH9oNFRQZOnQ643iNPJDCmYpU+3C8lF6EB+m1GiN/PRuDDFfYxLd058Q/jzzUr73qu8WOHjeXW
	QGjVc6ZEzlhl2tZooVc6whOL5UMrj+a/jvfyWmgGZlIrwNvCEAdLWyt4hBpdzL0K5ybrYPe/N/M
	RvITTAY2xukjs+FTUWuxAYJ4/HzRi3zLuKH4LHc3FdzJy9L3fQ/QWDlZBbkBZbN7gSZZC6ppDrj
	omTKd8it3h+IdQ9bHbz04rIpIkAE5srZrNJVs4pZnR21kleTUJ57nH9erMYLkuwnuBsZn3qWiF5
	qj1b1a+ucGw8qu3v5Pbx/0PcnQX3sTHHqla57+LCM2IMs/ZTB1WAyJQcpK3AhgkxKDA0zBdirHg
	h5EY1x
X-Received: by 2002:a17:90b:48c1:b0:35d:a542:2dc5 with SMTP id 98e67ed59e1d1-35de67d6247mr15710132a91.2.1775599415062;
        Tue, 07 Apr 2026 15:03:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367c142sm18408801a91.11.2026.04.07.15.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:34 -0700 (PDT)
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
Subject: [net-next v9 06/10] net: bnxt: Add boilerplate GSO code
Date: Tue,  7 Apr 2026 15:03:02 -0700
Message-ID: <20260407220313.3990909-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v7:
   - Changed the placement of is_sw_gso in struct bnxt_sw_tx_bd to be near
     other is_* fields.
   - No functional changes.

 v5:
   - Added Pavan's Reviewed-by. No functional changes.

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
index d98a58aa30f6..6b38b84924e0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -892,6 +892,7 @@ struct bnxt_sw_tx_bd {
 	struct page		*page;
 	u8			is_ts_pkt;
 	u8			is_push;
+	u8			is_sw_gso;
 	u8			action;
 	unsigned short		nr_frags;
 	union {
@@ -900,6 +901,9 @@ struct bnxt_sw_tx_bd {
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


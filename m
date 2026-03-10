Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0003E277B
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177781; cv=none; b=Q6c6VsyK4doOf6LPHhpLHPkOZ46pmL21E7KcJI1CeQk1IqZJmr0y7xo/NYY+iKxP8u4KBCUkZZ1k6ijGTqDwvOH21qMBQxk8eyZ37F+k64vhTKhvz+hB7RRzU3WcGCLDCcv57M3e7MTpYPMXiy/k04RNV72opmguq1fgm1/B/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177781; c=relaxed/simple;
	bh=1cSenaADeYpz69y+fz8kGgIfSyE1YZ/fkoMWAV5wOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OLYBARKeUBl1kvnDk5P/Ufxy1vSePLJ0IH8mW+WnAlZTWwzX5/6Ldxy+73Ph0fkKaHePo0aPB46fGWdd35VaV9D1XBn5OIRJDqJFy45h2fFLjDUfQs6Jh8/Vp/LQDF7dhGbV4rvLSzRF/22dXREhwd6uPOEW78wvXzjBngKefFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=0zp2CYzS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="0zp2CYzS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae3a2f6007so77570005ad.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177775; x=1773782575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISfec1K3jJo2AiWUBgbx3JM6HbVDacr1Hr+xolgCOdc=;
        b=0zp2CYzS2lwnfkEZrNLLH6la9soJi22sQXk/kpy9H3/1w7ODf6CR30ZjC0g73X5/gs
         NqSKNHUomU5qcSniqcnrBCviuqT1LhYsfIoZ4P5jQ82rXqy+QlBIqAGFIuZ/8Wh1/Gv0
         +OerGvjQ6HrPRe9tafWar4NGeY1HpTkTGH0/901nCAeOf9MNmxve0kOlgkL0J/SxDvq8
         m55FasPP8g5ExZH8xh26nq5ik0eXDCbMv/CjMt/LJ84T2XNQucZ4rtEHji6sDeiRk7hA
         oqnKfaBDFed+cP5XWpfVK8/QhY8giqL4DuGxjQg8hDaxnLsJE9fUX91ozKsW2qEADCdF
         vQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177775; x=1773782575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ISfec1K3jJo2AiWUBgbx3JM6HbVDacr1Hr+xolgCOdc=;
        b=uOoNF7SYxNT+v6PJMXJx7gmn8qjp8jNR3vXHtCpor7WGvAMsPYLK9N/BSA4HVo4WS+
         L/CbiXDtvwad3wxVvIUwby81P+ypnzjVSHPEO74aKEssFtfPVt5fvHNbPoiQgAXj+Wz3
         ootakye23lWXTup5dEMo6UFfgAhjhGnUu2bLsqwp/WVN3U8xsZ1JX8bQuG8cdT0YV3ME
         uvBdFSOvl3QgGkOU9Q7RuYiR6NC2Hj3EfPmIrnb9MhmPA1kINt3tqVIjv5MgrZReQjkl
         oA9Qt3+gUYxza98ykSZMt94hnoRFSt8TUJ/gy0u+D8AP3/4IjFMqbRE1DHib9rfudZ8r
         2HPw==
X-Forwarded-Encrypted: i=1; AJvYcCVcFFb9akolYYYBSqaNnrxtUygEiISeaQXk4V7XVk9Khmuv06gyHxTltkGrXdlD6rPOarw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrExEUrwdUDpHQHp4aLcBqmUwN6GXBdb8Gr/zYgv//LDd6+5E+
	iv/oCjeNl0kEy3+E89KiscFTBT1fdhRRRYN8L+g1KUCAgDo/oWK6XVsbcRWLmXoCwc8=
X-Gm-Gg: ATEYQzzVyb8lfooTAGmfCj4QBGUtYdNBMowXr42uwIOARkmAdy+bpxWpaZr9HE2TsOY
	aDK93+siVkjmQ/pxDxySfwqmn2K9A3qmhdC/N3qVVoSUapqgqZifizmXwy5XIaCClPydnpUPUVi
	WT/ostQhSSHz7BZ7CBY9zLAHZABSEeG2MLDE9Medcf0c1k5ywlpeResXzQl3UYRoLNUslz9dKG5
	xT/uy591S46TtTFtSaJr6Cc/7vKU47uQJHovMn2P6hVKfs3UHoXSwOJqrHgK2dctVrDpTr+CMTm
	V5vYypZ/CAtBnvQ9/CjeMvS7UdRC7ioPYbBhOfEvznvUKjIX0vVthqL+668+9BF4YroktBsW1+T
	PVzjEGozKCBXfxZ2C5YqGD2AlNEr513+y5ftANxP9h3r6WZRADg2i/tlRRtz5T+dnNytIBcqL9y
	jsD3dKQWeVTwYFVpU=
X-Received: by 2002:a17:902:cec1:b0:2ae:483f:b239 with SMTP id d9443c01a7336-2aeae876363mr1855375ad.30.1773177775172;
        Tue, 10 Mar 2026 14:22:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222ab6sm2417595ad.10.2026.03.10.14.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:54 -0700 (PDT)
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
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	bpf@vger.kernel.org
Subject: [RFC net-next 07/10] net: bnxt: Add boilerplate GSO code
Date: Tue, 10 Mar 2026 14:21:55 -0700
Message-ID: <20260310212209.2263939-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
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
index 41d933a4c282..99c625b954d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -889,6 +889,7 @@ struct bnxt_sw_tx_bd {
 	u8			is_ts_pkt;
 	u8			is_push;
 	u8			action;
+	u8			is_sw_gso;
 	unsigned short		nr_frags;
 	union {
 		u16			rx_prod;
@@ -896,6 +897,9 @@ struct bnxt_sw_tx_bd {
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


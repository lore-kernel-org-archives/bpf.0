Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B538946A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689586; cv=none; b=Lmu03ngbyOSjhmlZuR7rZJOc6LA3j3YlOIeh5sCZYvs4R8qEyju4FmYUAx3QurJ1J1PczwnUuZ3eW4zsXtPHWwItWs/ZWp5HLPPJtiyC69MLduhwji+uej1Ch7CxO0AZoqUggGsY98QBk7xyx28AF9ul94YzPQPqRVcCRy5GE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689586; c=relaxed/simple;
	bh=imhnP3c90RnqduwmC0Bs7sD+WwiHek5Y56xEli2D4zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXynjAGLNiY2hvGsABLYil/mUIVoCKdX9EQ3ZMpu/rn/5MsrLJA57+vnO2ZYM8TaoyfthJ7gm8fe7WVp0CNbHp6ilubKvJlFaJIDHbE+DfHRgzRxuaqGAvAPnH7BYrMMpYe6+PDder8juT85AkPIL4gIbjoMsSUSZMWc5eKCcKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=PCd+W6uJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="PCd+W6uJ"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2503753efso2612485ad.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 16:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689584; x=1776294384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=PCd+W6uJyv2pSwLleizYtKZImlVCVQPf/pogGHl2I7eZ2DxxDTOxNVSvGxCY9SS6ZQ
         r+8YaKQF1EPKNkgasH/o2IWcrNPOt71q8hGdUZg2h7/3waFbPEkVcUNFDuVrzLLo0aaA
         waQDL+GhBEIcc1BK8xDqW1vEKviepj2fL0N0xkDCHsGcy00suldpTPr3BVDU5RwIzkhU
         O7adZvmjYZrSu2IdW2ZyMaKGcQGVia2VK68WlnCHGIKv9PNd4gH7NcuzNTxVCDf5425X
         Jelil90Arem91upK4tJBr3TVJWfd5LcyffdDsssWJoLVw52WdH02quewebC58FhLgk6k
         Ddbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689584; x=1776294384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=N+3HGKnEPfaZWYXqbfSPr7E/RokFE5xACVh2Rpt0Hyzg9p/LdzjXFbwoBrsaqT2gig
         E8xGEHF6UBE5QOhKQoNuV2AXb/Y34dnV7smERLyKWq7BlDIZo0ZGSDr9F6V/1KPnFl4g
         +Qp+hNp+kREmvAyxp/P5EuCNcD8Yk5obNu1NIL0eoY1GXj4dlQTHPjOBuOcaDdI3G+nV
         FcuQPb4xChrjSjvy+y2TWsPGs6jYvn1bZOTFPEYf/fc/d5SyMvQnWncAcFK8lA+OsAil
         P8820vDlhhavpOVTbopsAKBtacxk7lj0GVcV+z2V5bZJZNRUkQxE6YQ8AE6a1GUWK+IN
         w5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWfIaZP0gBRyERDD8oaC1R8E+JlSMykoSlyuVJtiNAGLdHnRhQpQjkSujiuea1nWN7l3TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HrHAn3GsPHAzHMZWe4waglCZW+iT0g1xp7dG7jtUAGklxd4C
	4GJsP1Kt8a0efDrSnU9bvSWLIL1SykaOkk2OkwtE+9UwImolMOczcgPv/CPt2P1jkXU=
X-Gm-Gg: AeBDietoB5YuwA+ElFGOlMMxafCVP/i/H78bjtvtwZ3ArLduMyzqXEKkFlinZCzPUa2
	ntq0nNJ0vf9OCk+LGfAHbokC/VPK2Z76ZfY1aWKArVmJYJqZOidF8xXFP5SxyHFyeHbYeHsjJlu
	WXIf+PnTqQ1QYBGXMpe1fOpOC3a8JVE0kEiPPsrjKeOAa0zSzmPORN9VrJQWQtoL2ORVyun27fy
	nTnaAZE+3nRowPq1gSmHaC8C0GGru6Ec+QoLM/nwtZjJFb3Xn04t7i/1jGW8ObH1WcHKFQyYCOt
	+SEURu9uIdmJr/ws3+Y7tXAiITjcBqs9fO6UoXdaIBeDr6NRCgQ686y8uWvCXSHo871Gm9eRVNx
	XgmAoN2IPqtdigOhDdrGbZJh+bg7QnzoNpa8RP64X9hTQGUPbjhlG9JNZoFiPFWKrFlUDVVBrYH
	EV55Dr
X-Received: by 2002:a17:903:287:b0:2b0:c2d9:270a with SMTP id d9443c01a7336-2b28198d6e9mr235351495ad.42.1775689584518;
        Wed, 08 Apr 2026 16:06:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27475ff56sm213190295ad.22.2026.04.08.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:24 -0700 (PDT)
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
Subject: [net-next v10 06/10] net: bnxt: Add boilerplate GSO code
Date: Wed,  8 Apr 2026 16:05:55 -0700
Message-ID: <20260408230607.2019402-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
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


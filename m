Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8A3C2784
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569186; cv=none; b=g+a9NY7SgVvSO2OPwA9AgeD+DrATdAU7UOot6V6jUvpTy/Zq+b4byAHViuDoWOqNpr6MSBvmxMdCUKdjbY/mOQoL65ERatWYCN4Im/sJkZ+iBmq6CLVrY8tJg5WjwENe5Bg2L2OKihMtzp3ZdTmoPVKZWqYEheupvY/GVdg4HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569186; c=relaxed/simple;
	bh=HtDcextZUR/YPcgIMnOZtvtxd0jwbtm6Ak5Sth33ogo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWyKQRD/j/oxnpqzeRkWo7gELgimvcKnjRhGQGPoEk4FDZSVVw2TvU+/LN9f2T/ylQ4+ONBNPFDeT+AacnPeHa8kjrXvX6uShl8KiUOUV57Zpd4JJM//lAKw9Z4JR9ujPPCFxqnKh4UdL7QOvi8fxLBQsXuJRHr7+QyQaJHx3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kXqtFuek; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kXqtFuek"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b0603ee486so9830235ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569183; x=1775173983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgC2gqkZaDT8s1RV7I0kqk405vgv8rZzFFbIUkMM2/c=;
        b=kXqtFuek94WJt7r2KC+Av/wJ6DSOvmz0JiLkjAi4tJ7nGq0/txUB1udkzWw2q3Zh28
         oVNoT0VvaqAsf8xrsfHeDij9BxcutoYtmAJX4TvHQlBQafKztXXhqv0X70kW9y4FK0FB
         cmrd245AHZYQzBiKJFWtMUTXNWXCQC4LzYaaaK7adUgGVtMLpp//H3HaGBR8iUlJ/b1i
         +T3n5ZPcmIXv75IbC1igB6tL3kHn/8j2a74prw/QCSg6I9ktXfuMx4flt0BtmVSY7l2/
         +zeg3Rko2pJGHrxmmkthKwpDRCWoA8xDCRS/Rl7ujy0T37uuWwR+k7tZZWIkczuJ5K2u
         tU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569183; x=1775173983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sgC2gqkZaDT8s1RV7I0kqk405vgv8rZzFFbIUkMM2/c=;
        b=eiIfZuIWZddqvlkSuZPjkqi7wCcvDx18pOa72NerBO/r0FuCutanTP1kRfScRhLInV
         Ug9KcuMWfoJ3a+3WbVKpBLaoV9nUVT/t555mB/INy5xDfxYdAXM2wIeAbjrwU3h0BBXX
         puwnv6Ap/NBbHqlG45a1CkRiiuybM4RAVMw6jQYbuVV9RWE4P870mL2y+gvlywx8SPWn
         KEgwN9wFnbkY7Kqo/sTkU15ROeDuxgSepc2PZTNI40k64ZkbS5Uvt2ZdEawQG6Kc7T3h
         7+5eZX0tejja5p5JsvU7wQBJEzpjAji42RQaK32UR3RY9gBxelEBcnk/g+PbULhN+UQM
         NRWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzPaZQdVHCEpeg5OBJ8vOxgMtXu9jKxd3llyfyAtc+sAluOrjELdK7FJkz9EIoxG5SnDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymM+IMh6U9zOIAGj0jUTVvPdYY4jSkQ7TNXeETzgsA7Q+YaRRG
	zgEsGCbGDeGbtPcxYavtLr+hTY3VLw7P/mk4I45EH06xJvO2AA+odVFaq8twjKFhWOI=
X-Gm-Gg: ATEYQzxGyXoTaCLTu+bRh70dWmO2zskAZCzRL9EUbIQUVyFt43pn4KcDtUz1JuGyjBW
	QNFX3CwVhR1ZL6+VahpTG8Bl5DAK2Omu19XZBEzlcOlCmFlYNrZ2kXeXXswAJTBCfmzpCmTrq0t
	cU2ZKx4lSUgvsOnZWynbXwlCDm33HjUFXRVLJ++DKOqb544rrD3JCxAn11S/5P77QzZO2PsVBf9
	3rHCNO3YpYsh3fYEd49sDMNi5dhnkhHlrQMnQMumLk4XHSaEqPUkqJZhYdMt6V7dDEfz7+KMCCo
	HReIXbjTKfezZumcxiLsG9It7i8E5GDQGs8+WBGEbi9fBeFM6p++vya/cFzyYI3gIy46bFSrEId
	Y212nypjzTOVKbXobYqcfwjAU2zGtr8wKgYVpivkpZMwtt941LXCgLTWGC6bOVHO3aZLIgSd03b
	tc8mXdVMO1l2tozA==
X-Received: by 2002:a17:902:e54f:b0:2b0:65b8:b5b4 with SMTP id d9443c01a7336-2b0cdd830d7mr4268795ad.39.1774569183083;
        Thu, 26 Mar 2026 16:53:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f28fasm3179687a12.7.2026.03.26.16.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:53:02 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>,
	bpf@vger.kernel.org
Subject: [net-next v6 07/12] net: bnxt: Add boilerplate GSO code
Date: Thu, 26 Mar 2026 16:52:26 -0700
Message-ID: <20260326235238.2940471-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
index 751dbc055fdd..18b08789b3a4 100644
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


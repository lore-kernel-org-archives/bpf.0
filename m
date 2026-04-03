Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A545274B58
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 00:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176560; cv=none; b=hMlQdBKfpEcuRHfSksXeriCDzrnmKgVW/ZJGOtD59k+9ciCbJGn2WdMUs3RHPM7Vj4dLSgSqUV6c34ObIbQQcL9rT49TKLMh02Jc2qptc3WuTl62URd781pA6l3dtIUyK8o1BlXN3xuQsg8WWM6LToaL8AXbLDXJ+pkjtsQs2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176560; c=relaxed/simple;
	bh=imhnP3c90RnqduwmC0Bs7sD+WwiHek5Y56xEli2D4zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXzgWolG8ib9EccDSCdL+VP7Gjo0RirA3E+FfEeqtTOM9/qXcf+1UDZOuhJ0QPxqbg6RqAXau9EN+/QG8xvhzsPXUTr9DrZsbEQ4x5dEcTP2aTuqf4Uq/gUSml+XaHNtENGEQDbakswOM6Xuo0BQLA+cCWqdR3/0MP8MjqUv97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QHMMUcqv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QHMMUcqv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so906502a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 17:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176559; x=1775781359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=QHMMUcqvwoWK0MV+nlSsntKhuvS60F74AnRr3iQUJNSS9J8VX1SCB9JLLJjSF4Y2Dh
         us6iPEYIfSapwJYmjo6LrXnOe9ZB8E9yNQ7qGNdlsLtC/yG/TqD2eAxBEsL3lEhCVIRU
         p5bHypMGtzhcnuaiWcAfcBRpXf4h47KPbqoUZ8XEFXOYm7jcWCOLM4bV0ymN5obSKiiQ
         WXZmrQwnFHMhyzM66chYGUKyIJh/Fm/ME/RFRjKrTKtR4PdQ4lIiWIBl8lisUvp6vZj5
         AUh2Xv+Rxv/MD4SAj0e2FqQodN2vfzbkNfvLCgnPqYNQNliFOlkladGo5rslW0RNvRWB
         0zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176559; x=1775781359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gILlFOgGbo5p4rommdyZj12/KVIzsVhqUzxLDwWsXoM=;
        b=dcJXBIobL+KQ3AXJ9jg9joyZXkZVIbtoUkOINg+RY7WcXSJPM7gXZ0FDwhs5PRkSLP
         DdQvk7lgT6Oz3eXtNH5/vfMpK6vlUuae7qcRWQf7ApdAttq9WM48H1lXPFqSF3Y0+On6
         1ivvv0YzFbTckJ+y1AIKLT1a4SeCKp9md8B1gE30anSKC2hkYXxI7kRBgVtQJ15WL/Z5
         Rh8Af8+ObqM8F5YEEE/Lkj50ZUhDNyd0Qyo8wfQMxby3BAExPX8bsn+u+Yy5tKd0vIht
         cS4DICGHsn8ZQDjfdVf97PZLDvNq8pj4LiQJOnvAs7sOEkvD+1P2Myeutl56NRMyk1HH
         pVZw==
X-Forwarded-Encrypted: i=1; AJvYcCUk+yOqwao3GdCM9fakf4TDjhBGPPTfHWWjIaqc+Lxmk1/4fCCfDObMkqjjQJM7RXMkvZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmQO6sumpdhWq9q+sBAsH3kvqCfzUguhBAr0nRZWSVGiX4zTh
	hIL5mY3HXMZSeSPOGHqhYBEFczcQ1IdYNo4sGvHfk6+V/3czoqYpBfrxzADmNBFrMv8=
X-Gm-Gg: AeBDiesAINUC5det+DlcdkxtgIau+9r/07zTBMXsOpMkNmWy5KsxSN6jxoYSeGbEPGJ
	uhgnVIVDfkJEDsm+Pf2QXX0EqGm3jsXb+PUEMfpAy1FGUCNbdNmSKD8FWb8ePCssGjOXFQiKKAK
	kVfdzBsa5yvxDOZbOrbf4mAGmXVhfx/6tf0S6rsflaW4XA7bfvaQpyxaYrmD4GCmJmyMN1p/QBG
	kiRW8P0x+yGWAyEd7S0RtK8T8FFqOpwh/ppDizz9bNJMmBSyAyzjYVxaTTmotzVUIbKbmz2YQgY
	eV7TwWYnNgP/U3SleZukKz39XDu+efd4/FBOLDjHXS0NaaXJ8HSv6JW/HVRN1zUhDsu4F9Kd9jR
	MSB7dHhjGpB7gZsyyU2snhQQRYc+FRitaM+zqvN0IrdwJgeXmClFb5HLZQbqY0n3e3+7tPk96Sg
	JWPVy5
X-Received: by 2002:a17:90b:4fc9:b0:35d:ac4d:3cb7 with SMTP id 98e67ed59e1d1-35de68417f5mr782080a91.6.1775176558886;
        Thu, 02 Apr 2026 17:35:58 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe62f5dbsm9310718a91.8.2026.04.02.17.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:58 -0700 (PDT)
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
Subject: [net-next v8 06/10] net: bnxt: Add boilerplate GSO code
Date: Thu,  2 Apr 2026 17:35:13 -0700
Message-ID: <20260403003524.2564973-7-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
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


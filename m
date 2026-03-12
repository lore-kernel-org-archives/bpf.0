Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C123BD23A
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354926; cv=none; b=aIVX9Wx+exuIsNQTT0Lm3qT/zD1JNQdohAtObnwVm3PSCGVLGD2YiRq887Xx4bTcXhwUTWtEatTEdJFJ6s9O3AqFQAGzg8szC/JIoU1sRWTwM9HFw/Kzl6hofd5/lPS9Q/IXWluwL1XudYDpJKYizgTGg76DIlq1wqWbLs9IzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354926; c=relaxed/simple;
	bh=e96EXxfLihKuO05dFmuztcwCzRpZVtLutKKCC6HBE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmikDKBOTjT2agGQlT2Gv+F//PjycLhzuZQ167tHfcNVN9mkSlPOavmod5FXTRjaLbQX2J4olyu+q/M3fI8Oqq58EeIrkhZqrs5HoEvyew1LdnaiuJy41Dr3kGRH1EQ2YtV6P3Ao9vZQsMbfBFXqTKDzjUiXrHc/+jmzSCWTTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kH38lWFI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kH38lWFI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829abaaa92bso1030355b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354920; x=1773959720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=kH38lWFIb8tjyfHn/7AIXv70zfvgmacoR/SLbJrkct0eLtjuuZVexooEsX6tEJsE3F
         wyVBo2dYr/+uEvNOt2A7I+BAtjNwKGoxxPCuHOhmPWfQ3nUdU4BfzLfLzaJdVsLLTHh9
         eZCt9Q/BxQxb0K5DDt8V3ZqODyI5ILzcD2Bu8g01RBwtobA+pcH9Ifd5dQQnbcpbQv6s
         KUalqM2ou+/CmNJfA1cjSdj6ODbaEpky01MdsmsjhG7YDw3R4p+0GAkBxVJRth6yIaFX
         +v003H7H2aTl2mr1mXJ42ugvo1dVAIcEUg3psdRq6yjsJDxlMBiai47JYsOlX/69wnPr
         UoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354920; x=1773959720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=QVoFEdCv4hj6Q5jUCG5SUuBN0ZReWZLOvuzUeZYS/ovLugqsco18d33VlIt2WccYGp
         xSFSwQVh7yKfH/ItQaLWHKRLqc/lIF7WdUFS7juEAIh4JN49Q7R0ozOSznfAKKjDKsqx
         iACQ3Aa9joCeJa0kg7//A3bO/VxUqpb+jVu5afSb2FODTikDu1R8CJFMjLJzQSLXJFDo
         qUWxpLBdvJ7/ZJHvG6v1aMxySrrbXu10uk1FQmJMWDWYPE5KpKpto3X6I8HHR8UCnN3W
         OiQIoKPme5UdrAxvpn9bwSxv64LI/KeWSmcc5CjlzZGCKnqmkNEayBENs2NJ6UKCf1tz
         KepQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzjJcSLfs2pbwEugu66scYOiHcPKM+QK2rG9WZzAZ9kD5XgwaHUPNMGoTvGye7poO14d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeKGE/CXm+ut6nFYOFlqhUutdjS4hLwgCCpTx8sC1lLzP3Ukr
	G53NtG6fOgtf7SsNyAyRmMyjXv/9JfyCqMR9CP7zatq6L/z/PzFpJ6oVLzNAyI9V6c8=
X-Gm-Gg: ATEYQzy4/qdzKQL3b+qMTl9e5j7w3KJgeOFo39rbIfM3gjQpLxg/dIl2wh8ot5O4K1/
	5uG8Ap/ajE0EoQ53Pm/jKIAybnB2sNqQ84132luMD2TMTc9UDTX8psR9JOeGKTHWCmR8oiduMee
	e23KfcB4vRx8VdRuDY3fDu95K/FMToG3DpJrRxvkzBJalihntaieU2PJmO/QPaT1zjK1JXZXe6j
	MD/h8wEeS7+DGe5od9mpmELlmV4jRzxgnb8Le6lm9BVvdg4uPg6BApcpNSZegzm0CSXM6Hh6UJP
	MLgEua9pk4U1bnz7uwni0Kj6stnrJEDpleYnGBTg7XKX+QNS51UHg3ZPTxIG4yKPw1PNJS2g9L4
	5RsL/868dmdHiO2dqVGCQjqjcuzM5+TlfWjehNdR6vHeiFRJU8xdT+kTdwr1A1pMNKkj1TPNQ57
	oN+hem
X-Received: by 2002:a05:6a00:1a02:b0:827:32dd:59d8 with SMTP id d2e1a72fcca58-82a1972e8dfmr667827b3a.16.1773354919660;
        Thu, 12 Mar 2026 15:35:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0724407csm3861688b3a.8.2026.03.12.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:19 -0700 (PDT)
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
Subject: [RFC net-next v2 07/12] net: bnxt: Add boilerplate GSO code
Date: Thu, 12 Mar 2026 15:34:44 -0700
Message-ID: <20260312223457.1999489-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
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


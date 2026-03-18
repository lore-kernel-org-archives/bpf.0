Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADA3F20F4
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 19:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861232; cv=none; b=ATwG4fOkdglH5AGWn4Feix1yxGMzfagWCpajxDnVz/T5Nr8JlQCkazqZJRoRotccH+KxeK7Ez1xyxgFkRj80+CgJVThIXUoIUD3voofH+FF7r2Lyk5fP7Ni9Vk0y73qd8m9jXBH+vh3MWcPZ6fjLjKR3fXZgXO0aY+0B5KIvPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861232; c=relaxed/simple;
	bh=e96EXxfLihKuO05dFmuztcwCzRpZVtLutKKCC6HBE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehek7bvR4oNFmI/Tr66+smPqqODmKbVhIPW7NhrvDlWb+r7QJNocgEYFqbUEZTTTdhvYI15T31/zWd/MYK5jr+s7ju+0ZLnllKAnXHLmUtx8eX+1x5eAh/M11Imag14HDC7gBHjFXS5qjfV/MeM2afHkLEcugbrhlaRiAEUWA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=MO2xs7zA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="MO2xs7zA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8298fad2063so169811b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861228; x=1774466028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=MO2xs7zApCTC/XOLmS/C87uN0V9wMi6R4RG0QxjOTWaudvGe6IJB6ArNF/0mBrsb/U
         xaUhJy6WVPN0Eo0Mpp9bYyMT2BLRhtopa7h5Q4LzYwzLfn21wUOKeXjeZtzE1FcI5SO7
         dmNy1UWKc49LYkw3s8J4e4t445YMKlceR77qeZumgoYHB8sByFZfq1mRqojAqGWA8+mE
         75TaFt0Rur3pnjBM3738MpZdvHz0DlNYs8s3igdzX4EoJrKoBYOIIjin+6kkO/JyjdOK
         O+3sAMGklTwaD7Q1RvHy5A3mxOEuqlbCRpoG1sEDmguPhKa1Zm+xQEavD9GAgDMRXFt4
         PlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861228; x=1774466028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LU0lxc3eKqf92oDepH/UmC/x9vwxuAnsiBKDevCcH+I=;
        b=KeJ2hnc4RgsD6gaVdohIBRS1JxwSZs7ffwTd1sKSOeZHnzBNbNUgs0LbAREQuh68fE
         6Hj6TSiO4mw50AtNe7asgkM0i/mgAc9JkSOwPyImeaw46tCcyvun1FE1cu5h3SR7Meu+
         XZcKtUCrde2/bGg3nk0neL4g5g0+UAc5d9EbBifO8/3Uv4SxyZvEJxJtZT43YEwT1wFx
         IzVz0ktUUjtaWKNe2pPeHplX2uJqrDpqv86m7Qfyh8QQZxpcpKB0SPFAXVzGlROnytYX
         xzpeDUevTVbto9zQIbECHQbUrUJFBubqOIm8Q1pLeqH8DEIIaftgvZbX9HZPxwAXcpQE
         rvsg==
X-Forwarded-Encrypted: i=1; AJvYcCV7/xSYlaQKhiSERzj07syqCq401p1YOnIr61CSC3T4budDiyuFkYy0i1vdimG+lVtgusQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3+Q37mJDlTzjliez7Lq5rAHTL7hO14X2U9A4wRwhAvk8tq9n
	nlaHbPwfU3tc+CCaGjIbdXXAyd6x/TSzMIKIQBsRDanIX3WvTgA3IbCvn5JojLC/fTI=
X-Gm-Gg: ATEYQzz2trELTP2bhAfs8mL6iW9ZpjH0JDw/vCWhlhQPnVQhRtfg8HdhevF81GaEYWd
	eJXW/ompgQHsBmPF8z9q3V2slcjNoSufCPcOa4PbxpF+S+s/TnR+vsuK9ubRfOckBHIuRy12Z8e
	RraevU52E9TTcl3KyjP4Jo/hze35UB7uKELNc2tPuadwC1rj9jBdk2AkNSumwCHpmUokU9xk8uZ
	DUVS4owXbzs7Jhdv1bfuRXoVgO4r/mr0z9NuclvbnI5WeC7SA/saDvgnUaB9bsdyZg9+s/dGnjp
	Q7gjWzpjfJGK5tipAE7BMfX1AI5V6/eDYkpt4A2nISBapVJ5FQrEUYv2+FeZCE+9CxQEugchEVe
	MB/sza3Vl7/PYHKAlKrlCSpCL0m7omWPT5f+tJO9VFy88XRhFGRlZhU4pgzPC+TRMy7Lttg+faD
	Vhvedk
X-Received: by 2002:a05:6a00:4208:b0:827:2b3f:f9c5 with SMTP id d2e1a72fcca58-82a6b267579mr4257490b3a.60.1773861227885;
        Wed, 18 Mar 2026 12:13:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe801csm3490498b3a.46.2026.03.18.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:47 -0700 (PDT)
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
Subject: [net-next v3 07/12] net: bnxt: Add boilerplate GSO code
Date: Wed, 18 Mar 2026 12:13:12 -0700
Message-ID: <20260318191325.1819881-8-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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


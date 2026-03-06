Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC8366805
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838396; cv=none; b=sTAxcoFOWkLHrveERlbQ6BREBDHnxMGioAXJj8aINYDftqOA5O7y9qDkimL/XGyozGxGzSNnduBG0T/LI+Nlx9sim5P/SR/VP7lv+bSydE+xgij2DP4jxRvBQrGXaLz/hzykjTctNtRN54HiiKcq5vR+aWlwOE+JF9SXHS+GkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838396; c=relaxed/simple;
	bh=rxHb6J1UCG1hUNMj/PdYWFJAlj9OQSBagFs2o0mfkUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv9U3OuCeKqC47EfTNhbyMjAcnfVqeAy5/Cs40SF/N10ERwpqbPuYW7DffiTqWg/nEeGD7dK9jrPuzmI4Dvi45/pE0zp/N2IX6WhBt2iDkFjG53FV8qAe+TXZJSCsNbkQPB5DEb0o2/gw3ikg2x0FgFSnIc0ux/VPJmCLm509GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QRTKWa4c; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QRTKWa4c"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-463960df4f9so6400767b6e.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838393; x=1773443193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjFAHzXw5FIo5Aqox3mqKOIem5GdNhwRKMvrAdIQMv4=;
        b=QRTKWa4c25vvwfVK5aNfNWWjcyDTB7L0qR/N6vvaFtstB1CDRi00MSB9yPy2maZUY8
         oORajANtvqZ9spbZnesDAnEIS864kMucqUhFERbQOxnMHibITq5lN93ZftCVJjaZZ++c
         qcPRD1sggCVC4BfIdryNUSherJwu07rVey9cMqyL7GkEikeXybrzw0EerEMYN6HRa9E2
         +Ip4XVKWq/Y7JwIO8tGwRoMH4BBq6GMu43dPsiWFW9zrrK58wntB74aV+fArDHeDUYB+
         CBeVskaU7XUVi3urXcjgslaw3YMVAFr7hXBpN0KClbdIkrb1CKxIJoGX59APIRMjxqO9
         qaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838393; x=1773443193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AjFAHzXw5FIo5Aqox3mqKOIem5GdNhwRKMvrAdIQMv4=;
        b=eAhZj7tVZYuA661Mx2J4cbnX9/IjBWzIBR7FJV5tIVg+Fcx2E3lwNNU3bJOmzzGlMn
         uEU43t7ByICKJ8DVh6bfEc8mbnSfqRQuk8WIReNbjkR5bbV8c8YKhw7ZGrCRieLthw2o
         PdHintKT4+QQnTUI5A03/VcyjW775+K7bmoSnhnfQ00ZW8RnzLAtnMrBv3WoYhFiCOXv
         i2yaSuoSSJE/xaobFJhqWRmeJKCsegIi1Qd3DhVqK5Is4FcK/yK8SQ9436BlFfncaeQQ
         GPEDniD0ZgvhuxSvoJd4DrVlLyy3iH98Xd+ZJkojgpMqJNG0/t4RqsYyLchjrzJpo1cW
         Zppg==
X-Forwarded-Encrypted: i=1; AJvYcCVGkIIyEx7QZWbHpeIEmR3Q29BuXw6RI6C1UX7tnBleQ+9Lfc1yRSiZItnQHPiD9/FTu/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2zFA3X6jDw6EySzADGkSZla6V4FzVy2U/xmCvwsHpLwgSbzbS
	H+4/OnJ580jD5+H4G90l6ACdYSLg/pJARFpeOdzlxUOBAzFC6p2l9x5QFgLa6pFM2Fw=
X-Gm-Gg: ATEYQzzvvTysxUyAwkwawp1oRc3nBOr+1kBwdQT5zTIBKyqVDNxo9Q8Pu1xwRvPFVPf
	cLUSArBmQ610qlonNyLNruxQGmCmxldabqbsJGiMjt/INWSwRKob0a1SHZ414D+MdOyn6GwCoZt
	sUYhHzb7A+9RFy2HYAXTskJJP5s/4TRSt2CZZXPH1W1Hw/rYkX4uIMiqbe9chweuR4DsqqZ96fy
	CFDDp0Riekt8MXEB1qWIhDYq7WvbBH8K4gzQ8xafXTxwdmWpWU2YvkarCYUUN61xiaXufbgGPDK
	LLAjt4FrHxYf2vg+acQV8AwqL0OGPd66lIeCE070bKk6pYE4R59/3ve5PG5XgLKDANejLS478+f
	k9sP11WDxFDdmLGfglY1Se7FaKTxapyN2zNzlYqvPOjR1n2anI+UDvmeuShW9XYwGyT/1S+TUY4
	+O1FsD/rY5e7VR2GxK3KE=
X-Received: by 2002:a05:6808:1a13:b0:45c:90d6:9911 with SMTP id 5614622812f47-466dcb2c844mr2231206b6e.36.1772838393004;
        Fri, 06 Mar 2026 15:06:33 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:32 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	joe@dama.to,
	kuba@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 2/5] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Fri,  6 Mar 2026 17:00:17 -0600
Message-ID: <20260306230600.1628196-3-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306230600.1628196-1-carges@cloudflare.com>
References: <20260306230600.1628196-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for extracting RSS hash values and hash types from hardware
completion descriptors in XDP programs for bnxt_en.

Add IP_TYPE definition for determining if completion is ipv4 or ipv6. In
addition add ITYPE_ICMP flag for identifying ICMP completions.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ab73aad40593..c06033cf9f82 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15906,6 +15906,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
 };
 
+static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
+	.xmo_rx_hash		= bnxt_xdp_rx_hash,
+};
+
 static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_rx *stats)
 {
@@ -16790,6 +16794,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 90fa3e93c8d6..34bb98709f2b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -232,6 +232,7 @@ struct rx_cmp {
 	 #define RX_CMP_FLAGS_ITYPE_UDP				 (3 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_FCOE			 (4 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_ROCE			 (5 << 12)
+	 #define RX_CMP_FLAGS_ITYPE_ICMP			 (7 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_PTP_WO_TS			 (8 << 12)
 	 #define RX_CMP_FLAGS_ITYPE_PTP_W_TS			 (9 << 12)
 	#define RX_CMP_LEN					(0xffff << 16)
@@ -311,6 +312,7 @@ struct rx_cmp_ext {
 	#define RX_CMP_FLAGS2_T_IP_CS_CALC			(0x1 << 2)
 	#define RX_CMP_FLAGS2_T_L4_CS_CALC			(0x1 << 3)
 	#define RX_CMP_FLAGS2_META_FORMAT_VLAN			(0x1 << 4)
+	#define RX_CMP_FLAGS2_IP_TYPE				(0x1 << 8)
 	__le32 rx_cmp_meta_data;
 	#define RX_CMP_FLAGS2_METADATA_TCI_MASK			0xffff
 	#define RX_CMP_FLAGS2_METADATA_VID_MASK			0xfff
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 85cbeb35681c..1f920464b426 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
+
+int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+		     enum xdp_rss_hash_type *rss_type)
+{
+	const struct bnxt_xdp_buff *xdp = (void *)ctx;
+	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
+	const struct rx_cmp *rxcmp = xdp->rxcmp;
+	enum xdp_rss_hash_type hash_type = 0;
+	u32 itypes;
+
+	if (!rxcmp || !RX_CMP_HASH_VALID(rxcmp))
+		return -ENODATA;
+
+	*hash = le32_to_cpu(rxcmp->rx_cmp_rss_hash);
+
+	if (!rxcmp1) {
+		*rss_type = XDP_RSS_TYPE_L2;
+		return 0;
+	}
+
+	if (xdp->cmp_type == CMP_TYPE_RX_L2_CMP) {
+		itypes = RX_CMP_ITYPES(rxcmp);
+		if (rxcmp1->rx_cmp_flags2 &
+		    cpu_to_le32(RX_CMP_FLAGS2_IP_TYPE)) {
+			hash_type |= XDP_RSS_TYPE_L3_IPV6;
+		} else {
+			hash_type |= XDP_RSS_TYPE_L3_IPV4;
+		}
+
+		switch (itypes) {
+		case RX_CMP_FLAGS_ITYPE_TCP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_TCP;
+			break;
+		case RX_CMP_FLAGS_ITYPE_UDP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_UDP;
+			break;
+		case RX_CMP_FLAGS_ITYPE_ICMP:
+			hash_type |= XDP_RSS_L4 | XDP_RSS_L4_ICMP;
+			break;
+		default:
+			break;
+		}
+	}
+
+	*rss_type = hash_type;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 8c66698bde11..fb4f9143929f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -41,4 +41,7 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   u8 num_frags, struct bnxt_rx_ring_info *rxr,
 				   struct xdp_buff *xdp);
+int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+		     enum xdp_rss_hash_type *rss_type);
+
 #endif
-- 
2.43.0


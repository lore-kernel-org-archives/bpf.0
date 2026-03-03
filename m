Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43A377025
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505951; cv=none; b=epp+l+4ZI+GhVfhjRAPqtVSLSXe82rNC+V92aboMU2kVETe7nv/hhimrb4U2JD5+dzyXyuhcjF9zs0OuFNQiWVEgSdgxrO3k7djLt8UWhxrAeyKJi6A5252hHGgWudKqpTFuEVcnjtX7VGHJnSixI5+FCsAAPtMgswU3u6U+R58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505951; c=relaxed/simple;
	bh=pElAbihQQNOxujkBD8Lomv7fDpeamcGOpqHzxcFZtCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szH+uVS2Azzh2nl6MR8h8eFNhOJqQRnsJY1YQsswTsgdUgN4XFCXDDsJi7fd+vnuLDIsiur8x2UD/9JqYpja7kfC9CjYxc3cApeUcvgFRTBhPevdHDNPqKIj6mJoo1G9kUe+mxn3ZvT+UiKUfQ4xCzcm89297KOHmcnbDCwKyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DXGmEapC; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DXGmEapC"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-676815e147dso2788139eaf.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 18:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772505949; x=1773110749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YB/Rf8h8lr04XqCKhyJqZtv0aOaL1JDOz6tQ0DYFlVY=;
        b=DXGmEapCErVyjnu3lcbgNy7WKwH5ChrVlQ9jl92PRsx1qKvEIrqkqz3o5xohxPF9/v
         XGO8Nt2vF6D0uWYPzftwMwe0yOzTpNskZyctpxZ5FCcRuHawkWa9hKgPO0Nsg/aJZfTZ
         0d+YSfN+VASZ/16n2usSPxpc1DuEbIxY/3/hqXFAXP0ssRjk8B47VAz0dHQmIxODAiAb
         Gwj0XTSND/TPinHZw1Q//ktgN10HsLQTadZYGTWLkXjBi0RoK3p9lABLlKIITrv1GJVn
         MQo9OGDWAN55rgNhFuln5GYKvsSkNbV9ZXe40vA4RES0S8iLp9iASS/SKHmicwL5vgkU
         rNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505949; x=1773110749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YB/Rf8h8lr04XqCKhyJqZtv0aOaL1JDOz6tQ0DYFlVY=;
        b=O5J17uH1G0Opcw8QNJWLujyHBGW3EH2PODt3d64271Bq83GG//BvsBUFmyT2b+znzm
         M0WI96zakTMcNtyd7pU0ELQf6UvHfI1iJG7Tk/wjKxT0imFkjd7hi13RYPqzB9XGmL5R
         pxG66FLlgOA/tbnNSkvfe4M2le1zwnuXmcYmuqqoY1O1s3oFoa6lYpSbSiftmUKuw/Xe
         27Y1712foIBdrt1qTasUtjOv84XgBBjGYRkp5C1vcg/MitA/TN4eJ+KOujfe58rnLlz7
         UhpdHb3BgndcccqOxhAv4aaaoQ0CIALh8srHsxTwpGaek9nw9pso0WFlgnFOaUYiZ5bZ
         DIow==
X-Forwarded-Encrypted: i=1; AJvYcCVENyrR4nZI13EYmlaUWbQXpyVKfsUX7sBpzKjCDQHOhdBC9XV6jdQNQl5n8hkFRY/j2d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvDQ8syWLx53HewElGbMOYIP0U/4lziYbb3X8HzyTpvOSr0ez
	p95EWMD7Dbv0HR4N0VQzSkQBokjVIDuuslUHY3VhrPXAs0dUvszmzSR+ch23s2VHaUM=
X-Gm-Gg: ATEYQzxlQG+ezfIOZKMasZL/BR4n6sQaSWgFeA2qHkDJ0gqnkL57IDr0YloOd3Rxl38
	AiH4rT/4oPf5bLRtXF8WbFQ2mDgRAoTxSxi9ycPLDSmhG4kqIjhOzKUjVRUS2cR6sabHprrGs+g
	oBVH7VhH6yR08tGYeNaohhXw6hEC7Bnoq0RgqqJTOCRKQO7L+6n06L26aCEMXWi70MUVPwYl6w0
	QP3wy6gKnNw/gxwhzHpKhaaR4jL1VNMw/otnqmyoXlz8Q5qF9dAXp4dbxe4bQtP6Efuwkys753/
	7icdZzwoPuQRL1MCTYbs/vQydFoF3LQNZsD3b/MRalk0k3JNuvwuu6VH3GrYAl/zRzBIHq150za
	hDsqvGhMtHQUMr1LReAWOIz64LDxvHY2pD9+TYax+n2anpkA6aYTTGHGtTOXFyy0oG4IzbhZUDI
	3V42YNSZsbwt2KGSOaow==
X-Received: by 2002:a4a:ce86:0:b0:67a:42d:85e with SMTP id 006d021491bc7-67a042d09aemr4383427eaf.47.1772505949549;
        Mon, 02 Mar 2026 18:45:49 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::a2:70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm10205642eaf.9.2026.03.02.18.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:45:49 -0800 (PST)
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
Subject: [PATCH net-next v2 2/4] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Mon,  2 Mar 2026 20:43:50 -0600
Message-ID: <20260303024510.644962-3-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303024510.644962-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
 <20260303024510.644962-1-carges@cloudflare.com>
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
index 85cbeb35681c..1ab3d9f9b3ac 100644
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
+	const struct rx_cmp *rxcmp = xdp->rxcmp;
+	const struct rx_cmp_ext *rxcmp1 = xdp->rxcmp1;
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


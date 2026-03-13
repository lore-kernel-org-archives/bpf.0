Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE3384233
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441058; cv=none; b=R/FJ7JHyRGoTcBIGA4H87RiKAe7BedJIPwj9hDcT2M+Td5aWGKGjbWNCwGr81MztTUfkXBHgcuyz1cMiBu3svhzWBJQ/IyO+FyD/ADvnU9zJGeyWVtm7vWaSzR0yp3rYbUz8q8kjZS0lrE1b029forgTPZIqppRukmZf9QV3ueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441058; c=relaxed/simple;
	bh=+1Nr0Jil7w93d9S780sxk/ZwDE85Lpd4DcR7sfP5MRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHn3e7Z5zB715aaeIAgAjVTMePv9hfvljvih6h1qS5lZDpVGHfO+qbqS7o4L7wpT/A4QSwZ11lsnf55GtM1vt4TGTMtaX/Re/drBBrOGAXBt1+jkSMr0Wi/lQ97/mDC4HmJcKQnA/cvNRZ6SMjLZUqR8NCp3K7ziILVa7otZR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HumhbsnZ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HumhbsnZ"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4671cbce465so1378659b6e.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441056; x=1774045856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2JdvacgjZAGz3EP35cm2jBWXr/fY7/W6wCgdpj3LTQ=;
        b=HumhbsnZ0OQqImvM/FAuL+yvccY6TB3Qa+TqffYleAjmL3FMy0oE/p2MLdQepEwO6K
         Jl8lTK69o2R1NHuDvmhWAyw8eEzX2n4A1yk21/7Ek4r7LX+cX+8pj8e3ihmyxlJlcbQh
         vXAGEZhOFiLPoXFGksnppg3lFDbq0zpvaoTur5joGoCbsLHXf0+a+zbvpdkD0BaAqLP8
         wBPK9M1IwnNVGMGZvfyspY9SRZgjbykn8kdCf2g07KCT9tR1kOJx7bMu6KjgKoIrwvV8
         quIyHdTBfuBePYyKpT+l8GhVaorgpORG+hu7y/EDWfNr8WHT/U0OoNqkh/pLb4ZMpiic
         V0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441056; x=1774045856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2JdvacgjZAGz3EP35cm2jBWXr/fY7/W6wCgdpj3LTQ=;
        b=Qf5MFLPBtsgfqAGNEQDF9rkA2+0i/xhUvKm6zoGyL8Pn9vT0W5CD/0X0heavQWnZq8
         YUiq8PpnVqhFYVQFjal4gZgmLGIDVp7rScLKJ2misvgawIqkXU18jVk2eY2GJBDY4Ay6
         Y/ea4JW8qAQcqRbH2Zm+ma9ldtrxgpLL86ChGt4L8ZvaroNK71pKat0XNN0lfQ6LXvZ7
         dJLATRtkF9iSWeQ+c1juZY8Ht7VFH4sbAOEjwr+snKOKjRvUrgK4tIIKeuueAAM9/x+w
         yqpsNA+UWd0dF8V8gT+BND/y/nfQBv+sjcQqnF3y+W7OgcopCaKybSCkeEz+vV6juv/N
         WnoA==
X-Forwarded-Encrypted: i=1; AJvYcCWseo4+/fKVO7x67z/I6YlP9zqY0P2jLcACPKi+NRcFMZ3FbS22RjiGTDtOxyxINTRsL7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7Nyn0w1eB27X+27sd+ZCgg2x4VicV/2et57zokdZ8uI/d5SL
	FlauSExTc1+hY1WCvvudycFJUpVkYWrcw7ZzulNsEAiEoHG7C89k5lglLUgSMiju3gA=
X-Gm-Gg: ATEYQzwVugVKDGY0mBINY2eNZ19kMNMPUI29UHqYc1KAamlY5k/6YLDpqEMW6BPvdIR
	viNscUAge6ZzIkOREHG/rgSXxD0R4pxxr6LYQlUr1X/tK7nvREeA8HhD8YNRe21jh4kmYKJBDPq
	HejDKI+EoFHQomaWgSGGPieyE18ThgSOZUTrFwpnEYi6rCLAo7njkTIb52gf/qIWxQqomsAcDKw
	SLczzT0lAy54seE/EfsqyhELBBONgOaU3BOZ09uAtRJBNf6AmLMX4ehMnxCNkhL3nJV6evAYMqE
	dv+OIsemuLWXaRqU6xu3GP8JvC8iItUh1heNq4q/fXleGNep9DQJGoAKNb4sZ9XU238OvYwZfes
	yel4ZdC4fefEenMCbZ6s82zVTJKGzutTcGhmnmA/vb2afku15JbuOE/vlwJZMUqj+rQVvRsKDRn
	k61WLGiDbx
X-Received: by 2002:a05:6808:4f66:b0:45e:e52c:8a9b with SMTP id 5614622812f47-46757649336mr2867556b6e.59.1773441055758;
        Fri, 13 Mar 2026 15:30:55 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:54 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 2/6] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Fri, 13 Mar 2026 17:27:32 -0500
Message-ID: <20260313223029.454755-3-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313223029.454755-1-carges@cloudflare.com>
References: <20260313223029.454755-1-carges@cloudflare.com>
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
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
---
v4: no changes
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  5 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  3 ++
 4 files changed, 57 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1b170b9cf461..4881d9359549 100644
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


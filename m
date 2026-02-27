Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EE3612EF
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214137; cv=none; b=V/jMVGYAYoBKW61BOOB8P2og7NIJaV3Z6HV4ZXExEgtXqWem1Skh+P/6v9GNIaSby/eWkug/d9vHCiBKFzWyPu3MFSY2V7A7+R3EEPEmQmtm+M3+RwKiTqbKQjz2GNKnRkYvwV4tmuulyxQ6oJZEzcsw1+1qSV+I1DG7t/p1qAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214137; c=relaxed/simple;
	bh=QY4Nm2uJC4I9Iw+gNvxxiXJkI+e+5CmElRJDd7MYJak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVclykx3nv+BiwQKCUDWewNMerhi9whOUJyblpbe5qmG7o4C77o+jkoj+0xtfL7DrrsSRMi7DGo/7zsZ5xo+FMQqMiTztR4h1YA5qL7ovn+FGoDrPMpVTKFZdRGYBdvNUK3q3HE/VGFf7VGurka5/oZX2J0toug9Awwq9lm94oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SJzUxYFU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SJzUxYFU"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-463a94f8475so1834869b6e.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772214134; x=1772818934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGTnMn3WOQKAnHaIABdLeoazv2H3v3K0zHveE+KWcH8=;
        b=SJzUxYFUw/YJ6Fc5cU32baaIzF/DV7xFDpFPUAy+05rVdpjWBo6d0bBMI9FHWn0Qjg
         9t1k5qB2MUaMbd1rrKZHI+49Ar0kVZl/juFqurJyHtlFxl2a9vLX6bQRuiUbkudm1qJm
         oKGQZSoVOE+c40ztw7iltfKazfhGZmqi/rmEyz1dvBrMvrSZ2eWt52GuOTa7l3pHtbsJ
         Si+bA+KxYWhVGegCjM+r55Mu6L6FXHAP/YAaNIpBk6uv1Hn0dnd13ATDMtO/MPf2gm7N
         J4dQGsQc9CU7SveT/QqI3/v7lpczYYadX9ntm2CGYv37iob4rQTV+vUS4kIB8bTZVXIu
         FKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214134; x=1772818934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGTnMn3WOQKAnHaIABdLeoazv2H3v3K0zHveE+KWcH8=;
        b=aNYopc746121NbnXf+pfRV0r0JX0oqSmj2z6AAYMLFSjnL4xtwHmwyuXMCtYAyenTr
         khV5+c6yRpbpp3rlhLde0PzrNvuOJ29gs6iy7SAAwmknpMbBFtitdpyKOmzOD8ggq5d/
         u/xJEItROMqCD3Mj2+9F5bbEsOPS8TphSj6PdYsELFk1AYlUssVT8YfT21yjFkyO+ZEN
         qZwn095i8I9ig1zVljwjfU/42WXTWgIdiaW7SOggYsLHxmMjKtJwCGUJBFnOcVWQhP8O
         bw1mRFpdiekvSXA3/JcTKawAliiKAV/VdqFlEZHDG9j+hH1ZGwNeNzXpImq4zAl8Pii6
         +RPg==
X-Forwarded-Encrypted: i=1; AJvYcCXiUaVOI2BBaCFQKHvzkijpBohcvoNwp0mBCOd+R0EBvlcZr7jtyhnX4dYflasInCeW66M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXS4LqOQ1C4c3sY+eTaAM8J/Lxe0iSGKNFYSQU99tBWLqs7vaF
	Fp4JZsndhEhyyn0MA0NeDpGeRkYTgqT6l9a6UIhJo/6vLS1mOA6BKTFXQleywM/bJHU=
X-Gm-Gg: ATEYQzxtSRxgjVKSGvyPwu4ra/Gw8Pz19/eRhjhYXMIi5SkgcFkz6+W1gZtoeP9vSwP
	FZi+03g14Yf+0dnTp4zYoHtFOzpb+wdtzKUUQSJZ695BtlTUTXV9IzlcDoaPY6Duwi/qMjFZ9pn
	8SqCQl9em02Bfg1OGPy027kmaCuGcwPepc7NByQGSBJXOgGYklgBa/4NwjIFQiKVVcxws01NKjq
	tvNaBypY+dJNthjyxpDSan5DfPJ5DT3ZTFxYGrEhf73FyGM70hfsZajs3QapRRk1CW0yq9aSC9W
	QUxuiBNejCIThFQcVhI14q364XkQ9aP1VroW95SvBgUGT+G9u2PBIv9gEv/WVZHlOHLZ7gZFXgN
	hTwVQBH6iWf79jnkZWp7ZQcb5o5nFB2thwEo34fRGzSskmM0/V5BKf5ka4cInQzn+a0wTNkPmW8
	3BX3GhXDsRp9wXI1jIag==
X-Received: by 2002:a05:6808:c3ea:b0:455:e5c2:a6f9 with SMTP id 5614622812f47-464a5dc5377mr4370011b6e.14.1772214134297;
        Fri, 27 Feb 2026 09:42:14 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::f:3cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm4723385a34.2.2026.02.27.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:42:13 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net-next 2/4] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Fri, 27 Feb 2026 11:40:18 -0600
Message-ID: <7fe1e129215a789e55a446610321737aef10e20e.1772211065.git.carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772211065.git.carges@cloudflare.com>
References: <cover.1772211065.git.carges@cloudflare.com>
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
index a80ec5391b89..a8ea73c880e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15905,6 +15905,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
 };
 
+static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
+	.xmo_rx_hash		= bnxt_xdp_rx_hash,
+};
+
 static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_rx *stats)
 {
@@ -16789,6 +16793,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9a41b9e0423c..13eb1ca814b7 100644
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
index 85cbeb35681c..f75060374163 100644
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
+	u32 itypes;
+	enum xdp_rss_hash_type hash_type = 0;
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


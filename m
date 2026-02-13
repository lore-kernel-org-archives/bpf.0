Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077992848BE
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010718; cv=none; b=tHkgU4Zw3bvYJzE0v5hyqbnuhGGlq0WdqPArdyHdejqLaJHfGI4HA8fJ4YNsTm6bisXzxrnEdHNB9BFyzOW/BC7gCuGJ9jK1k6ZRb1leGy9GlGS9eTVfuII6WM3AMUskVekuBV/XUYmaf/SkBLK++R5vnneVexvPvStLKevr6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010718; c=relaxed/simple;
	bh=8b0QYhOGwS2V2AItVoEQ6N4KsyNesW8120oxsVTsrdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq8JNghdehkqxA58zf9iAqh3DxlbYJafP6zPl4mhsDNLqfa6yN8HbqN1wZ7zhfO6qhm5ynvsMpxlAVuDVTRWEQ2A32JOB2eaKzp0whvHvcUvYUB1XguYk1SjIX3gFSzcnX79ycJuj19faOIG9wFfU/Yvo7XR1RGXVSbq/wCAv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BTwEf+NU; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BTwEf+NU"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4ba9abbecso1447401a34.1
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771010716; x=1771615516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBbOQadYCksTHWu4+/GITak2TLFEO73uM1y/DwDxxcg=;
        b=BTwEf+NUWikgGP2Z9hEkRrvoiPCotV+yhzrjddIbSRBoZav835hFauvGiWyvA3IhnT
         qRj+71vzk0MJcnXfBLMDAjWP+khVCFK/552X8FNp5/SDEI7kgiP1CQTX+QQeElXvU2rJ
         JKaM8HsGr1fAcRMnXyyVUPeVtN9vFaeQvPikb37bhvqlbTjbUCVS74F9ELUIhCkDLZvi
         +Rc3hZH+Tg40CxxlhTqFmKJ6JfW1LNKbJa2Pyui4Cla2L0UXZFuIsqkt3NbLfcj87OzI
         xKMvl2hNCCCQkHHaNwtfXFWUqh5ASiigLJ0mfGP6LcqlWn3flfnI2JVKljLERMfjDOQP
         pWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010716; x=1771615516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBbOQadYCksTHWu4+/GITak2TLFEO73uM1y/DwDxxcg=;
        b=tPLE/Ro9ua6a6p/BHjQ3dSW3nJoN3DhfQux2g45hiwkuTOSEHOO2EP1+UirT5G0lCh
         Jd49Vv5qjKSG6nUeXdodpYeujVScMKIv7Y13/zv7ifhfy4st13FVd9IAAnC64WGEDVUm
         Z1dA/HQI4tbWqmEl/NwpMRjHIHKz9qFn0F2NbqXVeluILNECzDmnP0Lt4ltLJSq4m1cQ
         G421e0/9DvjIyvLrbfxirFyMADX+yai9cOuB0FEMObKgsmtGgdvjlbgM6jkW9crOwgKF
         iYEIm/qz5rS5qkjvzYVXpX8JBZdb17M9QHM9J1jxe1C8cA7Hgl2bOW54g5Uedm2MzgsE
         1T4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEU+JIJ8Njct1+JzndzwXUF3IsD+VAiB6YJx5oK0YFo6BH6oCSCr2fHxfF3uWx5wb09fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwauG4qUe80jd3izOZ1HHqZykFjpUoL5Oew8/YrIHb0W3d+mqx8
	XCjciAYEVpufVShidwiQFsqMfhQzZliVk4yTDLXCYy779iTsJ5F9OSCkek9rJNBqKm4=
X-Gm-Gg: AZuq6aItU23FjYQ7UnIqIkefLCiX9sVlTl0gqhMmAGWsHx3nV49nrHqFMhD0sxqbFmR
	bTZdegcaseMmUigC9sK61rCyFvZiUxygm00ZpCwhBZiGATL1udDKll7SddxPtqHfrRn8odzyJka
	zSKjUs6W7v8Gmxvrkj5Sx4XT1WLU22H/0ZGXNuEl3A9Hti7w7egxxNqyz9neOOmPQ1063N/qDQ/
	j0c4Waa661uZgVeF+k365YJfkoxt1/zlSO+8Z9qAa6NkSEFOP6H+k1bgdMOshYNjzuwlwcZQQ5o
	GTZLh8kbbrStgvxhMgY6sOeE7V0Qhs+faPGEalaHktbT4hoBhEg+KV9pHmvyj9T1BCWP/9YW92y
	7aiTjevQW8aNYfnqqwCurH7WT8zc+m3d2Skw2CubiZKvl1pC1GCzBuJ+F3UjIm2XLJslnAwp9Z3
	FB2VVI5/8m
X-Received: by 2002:a05:6830:2a8c:b0:7ca:c7b0:17eb with SMTP id 46e09a7af769-7d4c300277amr2066239a34.10.1771010715968;
        Fri, 13 Feb 2026 11:25:15 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm6591407a34.21.2026.02.13.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:25:15 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com,
	jbrandeburg@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 2/2] bnxt_en: Implement XDP RSS hash metadata extraction
Date: Fri, 13 Feb 2026 13:24:28 -0600
Message-ID: <20260213192449.1294830-3-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>
References: <20260213192449.1294830-1-carges@cloudflare.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  2 +
 4 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4c5e50bad783..42c024e9d974 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15845,6 +15845,10 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_hwtstamp_set	= bnxt_hwtstamp_set,
 };
 
+static const struct xdp_metadata_ops bnxt_xdp_metadata_ops = {
+	.xmo_rx_hash		= bnxt_xdp_rx_hash,
+};
+
 static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 				    struct netdev_queue_stats_rx *stats)
 {
@@ -16684,6 +16688,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto init_err_free;
 
 	dev->netdev_ops = &bnxt_netdev_ops;
+	dev->xdp_metadata_ops = &bnxt_xdp_metadata_ops;
 	dev->stat_ops = &bnxt_stat_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f88e7769a838..ef5f71c97c63 100644
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
index c94a391b1ba5..28f7f03662df 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -472,3 +472,50 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 				  xdp_buff_get_skb_flags(xdp));
 	return skb;
 }
+
+static int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+			    enum xdp_rss_hash_type *rss_type)
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
index 5f60b848fcc4..53fed951c151 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -41,4 +41,6 @@ void bnxt_xdp_buff_frags_free(struct bnxt_rx_ring_info *rxr,
 struct sk_buff *bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb,
 				   u8 num_frags, struct page_pool *pool,
 				   struct xdp_buff *xdp);
+int bnxt_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
+		     enum xdp_rss_hash_type *rss_type);
 #endif
-- 
2.43.0


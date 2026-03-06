Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C80361DA6
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772838392; cv=none; b=sLiuIhJrqhhPi3B0Gx3uVfECEu+fEmy/4On3SGDJydLrROmF90JcmU7rmrI/HFH/K2Yf3LgxfTai3hOMO5/5k7eKcHFOqRwZcSEnpD6jzXN2A9+nJskyKra2ixeYmjdzgiulaldbapBIKlKXkNeWoPMjHVOyGItRV1/Y5lv0euU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772838392; c=relaxed/simple;
	bh=N3ZN/577J6T3HfUZPetTc7LoqcDuy41jvH2ej5cM8aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RStCbLiq6Mm/CGrvvGd6iNbJunAu4PA1y20zPjy0blWNicDAsVRIJw/3QNcH3c5nuD2fH1EcRN9ZkrwFlg/z2Zoe7UxAyicQ9OjfY8cJ+1KU86laYGkIJfX8WIeJ4oXJZXF2MaCdicrcdjZh3X1szmSZBuh0b7UdiSeKVanjo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cCR815hz; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cCR815hz"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463960df4f9so6400750b6e.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 15:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772838390; x=1773443190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=cCR815hziuUMFUfWK4Stk/YI597xtSI9WzBjcFlJWuidKTHBHH+v/Ni7bj7DOyY/lN
         F5Qu30o5HyEMWS0Y4fOn8S0Oa8Aep2j/BowQFORSywS1wAcbFuunVsCIXwI9eIe9JFcH
         SfP+p+OZPFY8vrY3GGXTZw//4tNYfNdLB1eavGOj9tZqbkBdo9iyLk7Y64ZqWPTeRLrQ
         RTJv/8S0mr2vk8vbndvcZNo3Zcfx7uA6GxXYPedyJ+Rd7nwdbsjjbwt/rC83sibiR63A
         QlDlIfQQiw5XxLQw9SEZIdIq1ZzSGrsJ/k0rQGrLx4Ksi0SnePpSUjTLb6rpp5fW/CKe
         wpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772838390; x=1773443190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2gWuEUywlHiJAdc+KzkRLmXtzIjty9yNKhswxVvxm90=;
        b=kFsaWVqzySJIF3L4AuyIW0tVHpjUMYhoPGMVhyC4IbZeRO7HbaRZiNwTCUxUdp+uRy
         v+HbdlLBP7rJ+50r+45/kePy3wjYwinrZZ3ki/1oB/6bDDBTOst3z+CPTRjCP6A91Oo7
         KbPiHCBSbxfwmmC2nYnIF6e9Vtvo0CEgb7xMfRy3l2kQY7ocoyL1c3Vz52RkeyIhU8Sm
         jId5j+BON2kga8jjdp1QPy9790kne9KTvRxgijfjQ2SzYnOliFaYaoy68sSaQ51HYHq7
         KKFDHzXNKBdH9MKlq+1SVwbBBbVmZL8ucssNulx+R/W+CHgutWJnXuzCH3p7piVol4nA
         iPmA==
X-Forwarded-Encrypted: i=1; AJvYcCW/8rRyGflNl9aw3DU9w5FDkYKXmet6LvhhnxvJeHhVO44L5tVVsE6rdvhHTm7BHzT2Aek=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBa/S8HszbSzyUq6A/B92pL/WWOHxCNh+Bg/sKSD1yv9WcLzJ
	y3TxA0XNDqOa46FIbxlOJe5tyg8VGd5L9Zg7MDJLrYw9SdBpqc2TO+e/9oeXp9QfuRQ=
X-Gm-Gg: ATEYQzxQu8UMmVe0G/pghGY0KFv7rlHkf/GMwGkEs/sSHQ7vrlaAcveuZS/kwzCDRQQ
	OWqJnJ/NLKnqD9PMzmXW7/XKtraesnc95Y1GGrXXhAm5R7gRdLmyrTerl3imzO/rgh4KL1+BwSY
	EFEGoTBSmVzOJVrojLz8J/Lntg0923OHQJQDJ6L8xXueSbMXNy4TpaaB1QN0tWagDEcXBi6J+UT
	wEmiprkbA/wV3IMd2o0arg/RH4UUCVseO+W9e9GmB44DwIqNassJV70aINkTNi/PIalbqGA99Wk
	jbovqW+TFnbzK5sQaD/b0Xtcur+h4Qe2yKn4fIeYTTpCdIvU/qt+8pLhoAlSqdWPz7R3GdWfbZ3
	ltSQfe/BGBSOq45vZO5vdKin/oCFRdFoP2iwE7oCrGGzc4Lx1oWiWOcZcEXNiMqATqIiSeyLx8g
	9G00JM21Fu
X-Received: by 2002:a05:6808:1905:b0:45e:f91c:7b with SMTP id 5614622812f47-466dcb93248mr2047693b6e.54.1772838390287;
        Fri, 06 Mar 2026 15:06:30 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac17b3sm1532769b6e.14.2026.03.06.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:06:29 -0800 (PST)
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
Subject: [PATCH net-next v3 1/5] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri,  6 Mar 2026 17:00:16 -0600
Message-ID: <20260306230600.1628196-2-carges@cloudflare.com>
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

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..ab73aad40593 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2118,7 +2118,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
+	struct bnxt_xdp_buff bnxt_xdp;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	void *data;
@@ -2231,9 +2231,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_addr = rx_buf->mapping;
 
 	if (bnxt_xdp_attached(bp, rxr)) {
-		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &xdp);
+		bnxt_xdp.rxcmp = rxcmp;
+		bnxt_xdp.rxcmp1 = rxcmp1;
+		bnxt_xdp.cmp_type = cmp_type;
+
+		bnxt_xdp_buff_init(bp, rxr, cons, data_ptr, len, &bnxt_xdp.xdp);
 		if (agg_bufs) {
-			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &xdp,
+			u32 frag_len = bnxt_rx_agg_netmems_xdp(bp, cpr, &bnxt_xdp.xdp,
 							       cp_cons,
 							       agg_bufs,
 							       false);
@@ -2245,12 +2249,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (xdp_active) {
-		if (bnxt_rx_xdp(bp, rxr, cons, &xdp, data, &data_ptr, &len, event)) {
+		if (bnxt_rx_xdp(bp, rxr, cons, &bnxt_xdp.xdp, data, &data_ptr, &len, event)) {
 			rc = 1;
 			goto next_rx;
 		}
-		if (xdp_buff_has_frags(&xdp)) {
-			sinfo = xdp_get_shared_info_from_buff(&xdp);
+		if (xdp_buff_has_frags(&bnxt_xdp.xdp)) {
+			sinfo = xdp_get_shared_info_from_buff(&bnxt_xdp.xdp);
 			agg_bufs = sinfo->nr_frags;
 		} else {
 			agg_bufs = 0;
@@ -2261,7 +2265,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
+			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (!skb) {
 			if (agg_bufs) {
@@ -2269,7 +2273,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 			}
 			goto oom_next_rx;
 		}
@@ -2293,10 +2297,11 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			if (!skb)
 				goto oom_next_rx;
 		} else {
-			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs, rxr, &xdp);
+			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
+						 rxr, &bnxt_xdp.xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
+				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 				goto oom_next_rx;
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 8933a0dec09a..8c66698bde11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
@@ -12,6 +12,13 @@
 
 DECLARE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
 
+struct bnxt_xdp_buff {
+	struct xdp_buff xdp;
+	struct rx_cmp *rxcmp;
+	struct rx_cmp_ext *rxcmp1;
+	u8 cmp_type;
+};
+
 struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 				   struct bnxt_tx_ring_info *txr,
 				   dma_addr_t mapping, u32 len,
-- 
2.43.0


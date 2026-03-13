Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB92C234E
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441055; cv=none; b=JLeJLP1RSS3+rai3sRfAIWmDki+cCFnXEF014rhcZUtjUORulFBRe2JlpBsoGKO5z+/hycU3yAbmtEbKV6ebI0S06RvwreNawQpFSuxzi2Xarq9G4DM0HQf3l694tFTux5vKe3RuaNPk7v+6/CwwOfqIpNqNVLe9Uhcey8SHebI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441055; c=relaxed/simple;
	bh=q92wW6u9jfkve4Jnxrkv5vS9DQpou808H07Lfmn6g9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr40E586FgNoGzC2aInZAsFSWjqWWhNtdBdSP9YEfkGaRYAqFTYeRS0uwlIrB/+HVIlrQqd7Hu/EULvGHWSW6DArnsWcnJH5iH8WguOszAU7XPbO9lKFpdATNj7pmapAYTseRnOnMkcVIoaFbiKIYC/qKCWhXGmpmGF8jbenPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Fg67lBn6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Fg67lBn6"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4670bcc40d7so1078754b6e.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773441053; x=1774045853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIfbn2R80P+GEE142tyIwDUaWaiGTo/JYywBsc0gehU=;
        b=Fg67lBn6VNth/bzG0G0XGngQWSejaH5rpNdNd2+0QfcFy/qko+S0kwN5JJv/WJjkDm
         tcV4ZOXiae8W2FHTEXABUy/IGMt3mCclSECY9ei5imBSHLDhCFyTkhZZcdEWRBqgq5+k
         FnJVSBU4hbz9iPHvAyf2qXarRWOtZri99lQgAwjAiJXoHPyRXQ7rz+62FZ+Y0Uehe2NW
         LdeJunjbjJoFaHET/OFM2QRT7jasxLJt41YeJLsDqdgMFNcah0epyE7FX06axESPfZ18
         GnjRsarrVkuregBk+gt7OiA9hOybChLJn5/lKnog+uXUeFfaqJzQTexhTbq6A9Ge/oVe
         xo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441053; x=1774045853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIfbn2R80P+GEE142tyIwDUaWaiGTo/JYywBsc0gehU=;
        b=cISP/Mi9SWvkVBpEDUSIfSZYplWR13ZVmBlTyyiDZPYBgtjxbUUnL4HagnvOiRcMTX
         LnSHF69i9tXNQlL1Sfwb8R7sMFk6cd0AivV+D8uLRbGqUCKqfvoijFcrJSbEt7njohOf
         qhToZknbZdGU3UOwZTZGKeYLMtGLtarK00WOJCvkQmXJZxCgF1yuv+7+cffmghS16h3o
         iM0p9yKjzAR+P7ijHuyeVssiSLe/7HMLH8mL8Djj0oqTb/Elza6MEpkHvhwJwUjDQF+H
         ax83/kui4votIAdlmRhOuq7z3bOFXDDh2Yamv3DR0Fhk+Xu8sxqxsm+O5HEYFyr0HKmK
         a0tA==
X-Forwarded-Encrypted: i=1; AJvYcCXrsIkiHbQX3CngdzeMlo3JfeY0ylLCJ0PGELRzsZb+K1FUesFo6k315Dzj2cqnra/+D3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgYKihZjjUWGoZ+4250ApwWZIOSMxCoBp7p0Y2tDa+971pYj/
	eDcfzrTqlwaNTH3Dvz/jLWEvW604PV6KYb6FOreyRnb++7ZKyH3HsUsmvjqYqgqOV5E=
X-Gm-Gg: ATEYQzyHoFlGAe+5wKndcDkpr1MJ/ahNyWK+NBly1sxj1CUys3VStxjI0zMk1F0AI9s
	CpWgtUwuKbQVoRdKB7PHpBA06egnGdVR3abvitwmwnCjD1L6KWmH3x+JzAmvvYreXTxjGUXlM3h
	C39Yj+ev1/LqHAH/SOKJPaxRwMbn3MXxpoii9awrsii2wSH8lLBfIW5XhB+FCOBE5jsSZ0HbkBp
	/BnLKjqTyxl2RqOHahc/B97CPUF0XyJiLRNnzbw20anDBjZOCvjUUcl7ezXI0XJW4e3P2SIicMO
	mG5jwytetcHbkO2zPhTP70aZGrbgdYX3ZpMGD0ffHR7u302QYYl8tv8phpBieQdCx60VM9FQXWm
	H7LthcS42MtCKyC9ln4igAPisrJC92pFUBN0+w6y+rLJzslhBhEAgsO2OtRjlBsESbRA3Q4LAgW
	odyh5NIkpgfZ05dFW61CQ=
X-Received: by 2002:a05:6808:e8b:b0:467:21dd:aa94 with SMTP id 5614622812f47-4675762d0dbmr2499832b6e.55.1773441053170;
        Fri, 13 Mar 2026 15:30:53 -0700 (PDT)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::22f:7d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342fab49sm5408516b6e.16.2026.03.13.15.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:30:52 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/6] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri, 13 Mar 2026 17:27:31 -0500
Message-ID: <20260313223029.454755-2-carges@cloudflare.com>
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

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
v4: moved bnxt_xdp declaration to follow RCT style
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c982aac714d1..1b170b9cf461 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2115,10 +2115,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
 	u8 *data_ptr, agg_bufs, cmp_type;
+	struct bnxt_xdp_buff bnxt_xdp;
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
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


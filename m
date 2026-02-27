Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955144B66D
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214134; cv=none; b=BlksdSPxS4/uDA2Js/phCCtnuchXOwNv+w1pNXydyZVbyLmdFbPaPfjkjHv7yGU2aqB+J3ldcgQq3L9mOVt4mxJWd3iUkXrEMsGhWabdki9MA02xIK3XlVpw7Ynm8B5auXhvkDoW7xs90h4gfJ1ZoFm5zjUiwJ5smGsiYxm4SsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214134; c=relaxed/simple;
	bh=iG0DhWbt+VsFMnXOpZaAVysdoGQruPrbvdF4uDVWyIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdIxdvc8MtU1fEPJtKMa2gdxr/P544pAysGSq52aU9HtwobyKkLDXDsNEaKF9ykWsxcMyeOaULVkgCcfqzj8e3iaIvSo9jhh8EphFWXn/loLg7VhuJupwebuYoUiQ0YRFTNCUoIu92l6cIX8okD8Sn+YB7j+S5UyUylf0JWFTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dLS8FUNV; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dLS8FUNV"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4ba9abbecso2682108a34.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 09:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772214131; x=1772818931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETPCtqQ5zGuYJDHbRqq4hLf7csSuCLugoIc0+9S3eO8=;
        b=dLS8FUNVcCSbiTJw2AI9xg+KVmD11Uwe+h4fGJqjHsQIFRm37AqmmPGiYPKxBDxIb2
         4Rqymk5Ln1c56TwTiid6YyjjMdk1H8MUaXjUZZL0QtOFKZZuUOJt2o+LAs8quWz75H05
         bgg4MKuVSADrnlRjLltjDSDRjQQZ5XLR49uYG0z34cN1+y7MALeJ7UCtVZGIIW71PLjk
         fHV7T77COJP/GLmnKFjkssx2mUfXpRQV9qRSLlcChsKUIeD9B7m9qrHGECLEE+7S0cOy
         5SHpBH1g1HGTWwMFnnrgOYC3X9SqstDxbuLY94P8fU203EUdEAYtrwKUNPabeJsxMNeK
         +UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214131; x=1772818931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETPCtqQ5zGuYJDHbRqq4hLf7csSuCLugoIc0+9S3eO8=;
        b=oFGQmQvwEsFYa4h8ouNyHbYzvZKCzGRQm0q1Y4acHxC4aoPfor0YlcfvDRAylL9uIl
         DuwtH4+I217GI423xKr/NkNgXWsgPb8rn5e/Yj1cQSWhMRog20lJTFDG+P64Xiv2Tre1
         l/lq+w4WTzXPRBG/gi9uhj6KSZNVOOqu1FH9maawQ5ojPqqtNzvRDgNx3gn/ioBtSNC7
         q+MRk+kumE1ozsVvJcLSktE1irk19WMkoFHWwysWxWU06EXnm02rA3B8hSmsquHGeA6T
         HmZ+wvKn8EhhO0mrVdUksV6EpJ6Bk8XbsL1gGato5RsFwJ/LP5ABhExL4ga/gSWpYrg6
         5SHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJqtJOIypmaOxMo+z1sPHUyTpm6vx6oqdqhNn4ku4K8NNKTZpyLAoHO4RmlkFNRpgBRlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RInYl4je+dcynUDsQp3IpaYnBTjOINdC5tgSHcgU7DWSTmAv
	cvXwWGJRZdFfOFGgjz6SSdjWJ4Obwz2b0TDGQnSvrzca92cLsDxGy3nLRZ7/zP1E5Jk=
X-Gm-Gg: ATEYQzxXfGBVZUMq/iUqQnjXLxyxDOGQ8uIzvS80XLo97EWtwAFHjziLGLlOwU2jOYg
	fGqO36/3LsfCvWqTicjjYrEoP1Z1deksxZznthwK/M3eojtD0pkjjPRSf4Qumr2nnbLt1R/hHF7
	mI8DCsjAk4PYjgoXzk81yPED1EHuq6YZC7zvbDSwDJ9G0Eum50WgDaHE8iiu1tbzv9HHhg5Ogi7
	GrJocfheMYfrYD9+HkecazTdzJ0wzHXkHpdu4rnGIDoDnneuw95/9nhlQbY0jFLL8OYow1R1T/+
	ERxmBxxuOayLlwaoKxUIlzKxJguSDQ2DHxv26yapvrWcWp56432efW3JA9sI7A9nrNFL/zNDunr
	14AhICxER2G6GXHKc/ccReKbU/ry2rxIVlp3AeZ8cefrbkvnEzBa6ddDje3+CHbmorF/h1XNZSM
	d0LTRqbrQ=
X-Received: by 2002:a05:6830:a91:b0:7c9:5ac6:12de with SMTP id 46e09a7af769-7d591b1bef6mr2579131a34.5.1772214131281;
        Fri, 27 Feb 2026 09:42:11 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::f:3cb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edf0sm4723385a34.2.2026.02.27.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:42:10 -0800 (PST)
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
Subject: [PATCH net-next 1/4] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri, 27 Feb 2026 11:40:17 -0600
Message-ID: <fcafa0f65dd8bb8cadf7a8fe1afaab0398df56e3.1772211065.git.carges@cloudflare.com>
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

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 25 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e062d5d400da..a80ec5391b89 100644
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


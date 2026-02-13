Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DB283FCF
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010716; cv=none; b=VnGUQ5GYwOUgZJV80EkYwVioLLqMp6MpRkWKTOW/RpUCCofzhhkY0Y09Fye5poH1FnZW8S4OEN2xjJqJKhcywXWwHCUQ9sCqN1Z+9lVjuGDYRrGnXZ494QzGctDWPKQOTxuArh+pe6/9o27Fp37sYTdvjVzcYaXYKJ5Jd5+pn+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010716; c=relaxed/simple;
	bh=1AWsqbF6uQ5IO3/lEjud9uj1H4t9rPI6+yXkNMP+snY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SostNGQ6ddazmqfd5pDET9KlpQmw+ucdVHBOM3GdfzYVfOjZk0awqCQpPR85Y4rZ1Sfmc4/2Ea2h3a0Xqvydhw72dMu7ttKPB4ptR/vrAbLPSI0QN5Reeb0HVF8raQQz3qDEPsb6TpEomlII7zxV+5nK1PBk1HYyeu/y+GV6hRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Vosu4kxF; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Vosu4kxF"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so1108190a34.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771010714; x=1771615514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDx6aNjolaLjlY/tFPaDQVZ9LraL1BXHhtWRZ+My8mI=;
        b=Vosu4kxF1wB/ty5K265dJlS7H9OC7tKdaHCL+9ThK2jQVIJKmQwfMDsfAJ9oUmkeVT
         jmL5LJ0KuJhLeeZ0/ETWr1MUQWEhFTNKZRRz7hDe3Lovk76Gz7OfprhVdGB59mixHCRo
         kaH/0PnlPIWAgu6LApNCo8ZEKDU7Q8psCFKGYpgmqq+uV4VZ70sP9NDTENjcPwuJg6IB
         V2nOC49Xs1w2l4PoQsugPk0sVW4SicxkZEemryD/PWLghuLsjOSRLkgF2Q9C55oPLLRo
         fwAu0U9XRmhMFdcNRc1V7qJpSFEC6QcYLq6Q3QJinvqh5BUOOXXRfEUoX4Ojc2zh6Jzl
         6H3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771010714; x=1771615514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDx6aNjolaLjlY/tFPaDQVZ9LraL1BXHhtWRZ+My8mI=;
        b=rJs9V6IZNb6vjOewMyWJiBFd1cKi1Z5Wc1F0UNmRm1Hwcu3NycHZROmkXkEAhMI34h
         gEGj7Fr6hQA4p8GbCKikOUBOpya6pOYYLZJ2imHhSpuwSW7Ik+JD2NkhiZk/gfkLcF+b
         y5U3vJU3uZSrjosbI+16FG07Yzf5qZAXFs94dzONxvXyFjEZjKSWdXR8+yNeqi5NW641
         vF2SWRutkS8FoLuoLjPt1xKdSr2j35a69n9TCLfMkVuVur5EVvQ3w1m0ZyE2gR0lKT91
         FYf1qoSxQudyOCZfkvYWhOrMnvzLh7368ejUnrwsmbT4vzYOlCub83cHFHnbo6ZhAR6V
         ksBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvulaJf4qsZbLwhSfkf0NlD+3oUUwv4CiUWOlqn76LNJpHy3Qx3WJYOmGvrzJ19XpiHMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x93V1I6X75PrYlKSMQspPUfiREu+ldIQPnvxxctCOFCR2/cC
	LJBXFyS9YH+fyTixe+g/3yXbgr2iAwCsfUmWAnorb/ITeigCuVcPOXdPIzBRm0rZ9I4=
X-Gm-Gg: AZuq6aLV+Y80ctaKvVqNy+EjmETFLV+I0iMJlC5ylPSR9NO+WRgpls9eB2vg3/YvUGe
	IEP3FW5H3Smnejjsix3tyOCx+tydzscPcz5w3BfLSo5RqW/wJM8Sw7HWW506VN1+o8TBJj6cDty
	L3807BwmKZVTvXPKIlEWUAKsYQDNHvDACG+Myqh41GkED1LMzNQ9+PIqeorBL3/lJKdVmV7Qqwd
	qqrq0EjoyV1T+/jvrJJ6RvCgG+AHyhwgM6NBS5I3ordQCXluD206vrkEc02yz/he4uwep+VLric
	jRJCkz6y8KSkXMkeHbKYOU4DN46BHhnzKAMva2WufnY6MY5psj9su2+9IApNsz1MsP9yJbhcX5N
	knEVdZvpklw6+eYdRNGvn9lVmwWY0CG1Dq4V0LhZt7wg2xhJvCL75YOjlFe3WSo2xDiz+clBlud
	fApvu6/vzQ
X-Received: by 2002:a05:6830:6686:b0:7c7:655c:7353 with SMTP id 46e09a7af769-7d4d0adabe0mr284901a34.12.1771010713650;
        Fri, 13 Feb 2026 11:25:13 -0800 (PST)
Received: from 20HS2G4.. ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a76f96b8sm6591407a34.21.2026.02.13.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:25:13 -0800 (PST)
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
Subject: [PATCH 1/2] bnxt_en: use bnxt_xdp_buff for xdp context
Date: Fri, 13 Feb 2026 13:24:27 -0600
Message-ID: <20260213192449.1294830-2-carges@cloudflare.com>
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

This adds bnxt_xdp_buff which embeds the xdp_buff struct and stores
pointers to hardware RX completion descriptors (rx_cmp and rx_cmp_ext)
along with the completion type.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  7 ++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8419d1eb4035..4c5e50bad783 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2115,7 +2115,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	bool xdp_active = false;
 	dma_addr_t dma_addr;
 	struct sk_buff *skb;
-	struct xdp_buff xdp;
+	struct bnxt_xdp_buff bnxt_xdp;
 	u32 flags, misc;
 	u32 cmpl_ts;
 	void *data;
@@ -2228,9 +2228,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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
@@ -2242,12 +2246,12 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
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
@@ -2258,7 +2262,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (!xdp_active)
 			skb = bnxt_copy_skb(bnapi, data_ptr, len, dma_addr);
 		else
-			skb = bnxt_copy_xdp(bnapi, &xdp, len, dma_addr);
+			skb = bnxt_copy_xdp(bnapi, &bnxt_xdp.xdp, len, dma_addr);
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (!skb) {
 			if (agg_bufs) {
@@ -2266,7 +2270,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					bnxt_reuse_rx_agg_bufs(cpr, cp_cons, 0,
 							       agg_bufs, false);
 				else
-					bnxt_xdp_buff_frags_free(rxr, &xdp);
+					bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 			}
 			goto oom_next_rx;
 		}
@@ -2291,10 +2295,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				goto oom_next_rx;
 		} else {
 			skb = bnxt_xdp_build_skb(bp, skb, agg_bufs,
-						 rxr->page_pool, &xdp);
+						 rxr->page_pool, &bnxt_xdp.xdp);
 			if (!skb) {
 				/* we should be able to free the old skb here */
-				bnxt_xdp_buff_frags_free(rxr, &xdp);
+				bnxt_xdp_buff_frags_free(rxr, &bnxt_xdp.xdp);
 				goto oom_next_rx;
 			}
 		}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h
index 220285e190fc..5f60b848fcc4 100644
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


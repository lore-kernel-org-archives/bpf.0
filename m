Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135F3D091E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241689; cv=none; b=tVUk1sbpsNM9FRFNCzuU/TNCjFDoUVflSW8NKRkfdzdeDRoR3FsBbUT3ftVCMmxgzJVHcKauvACwc8XRKTNlRJVmZoTml1EA1zZ/RQfWIiKwybTQoluhHsO/zcdYn/f1F71yhXhgxdXuMLVtDT3kga04U8UHFxxh3Yxb+7vZxJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241689; c=relaxed/simple;
	bh=mfGH8PXsgNGoAUVak2QkX9SmpnxShRY1KKH0A84oZTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fm+bGW84LKGBSsN+IV+USK4HHp0DQ2ttKjHHcXSy2UuyKh5Ag4nPCmu03wPuBubAqbV1Uj85RPsnXsKSthibjLNvvomLs2N5o4gEfCvtAuklWu/Tc3fr8yywN6i8FF9by1s79m+sID9bUiJK/IEjxWK6DqD4a6lWkBu0HiL3Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be3d7lCg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be3d7lCg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so43473335ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241688; x=1776846488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z76sQ1pIrwnQrnT/9DZ6xoWkdfsEI4At+20OGeyJlFw=;
        b=Be3d7lCgmuC7a03gDDnjsknYdnjtRbsTTUXyJ2EeNX2YipTgl5AyFnvvfIvztLvd/Y
         xTGWm7L3s4J7Ijew2KMzmaZI0IdONp1bUdZDvgDKuX59uowyELKx8Wz8n1AmmdJ1uRK2
         P+clLG5z+WJh+2MY0V9V3rOkzSZlj/AuX+LhX4NBL0xUuIZMVH01Y+cf59Pej2GO3ujd
         np6T9gHLXEuuxJzps9bme9KYC4ONF62vnCv1RqYWsINWiVvfT6/Vr8cYnWsHqIWimWg8
         BdpVuXoYWz/iJ43FwSXE9OSNAV4UsQGTQMb9tqBPdYr5rnb1tKIACbwV+FivoKofRpvw
         7sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241688; x=1776846488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z76sQ1pIrwnQrnT/9DZ6xoWkdfsEI4At+20OGeyJlFw=;
        b=WIqvQt2H7tQ12G0smh0Tda26nepYiP+1Iq3g23/4NTLPZwx+tBHG3BZMxzuwFlBbRc
         XNgLMSaQkCJvcLLul502eM5drGORLyTVo1fmz6TmrMBoYY3ZmOwRDEfjm9pfUMMR0ebm
         kAXqCYMug3IAFt8SCtHYWGgOe9qjd27Tu/ojTAhTYDxRcrnlyv7XxONEkamT83aMciFN
         U1DxUnJqcsQ2DoTVtiY5IPQvxRvksjFO9DCKJVH4vm4g2QTTGYdPMHm/YwxYtvSRMbpi
         D75Pgr7sSer3eiVzBfiHQxj6q2/8PtQCU1Q3NbyVTQyQbI3G0igKvWh4oMB7HFLjIQcg
         ngSQ==
X-Gm-Message-State: AOJu0YyVZ40cOPHn84iTVyRggRfOvVhlBBBeMFSCvQcog6RJIAPlixqJ
	6P8N3/ogpQtXos6VMWGNjYLr9njAMnTqS0RRrO325q5jSsJw3udv3fX3
X-Gm-Gg: AeBDiesCJk1IWiOkuxXev5hZq1rgEV49IHvZTmdxVEp7jEq1VIivAW5txQpyqb0VVex
	7C233sQD3Gg/7v/H0kqSirgQsPaaMX/LAsbe3n6r41Isu/aRgiaVBBV9Jmd+ML6rouyo4+FP7Ny
	qo89LJadkvT1jMlfmKrhgrdVsydJPZBUinGhx3QNYHulFuSHmJO77fWRDh8cSCtkBgmibExB7BW
	EdETK5N+srysk/rTPd3QoPiAxIa2PolLT1fSiG/XyraxabE7GtRHVrllZtx2vNZtNDBIWYq6ZIJ
	uTXnT3/HzVTuMoV0vqtHliVPvG6qmK+OCfcw/TJV8BlEHPiW9MUXW5mrtlHOvKXCyKQ5QkSTgP5
	ee8uMYuThaiiFCDDItzOS8u79jZP1VzQGJ/IQ1HDoQ8A0pvbR1fJq1Ry1qBKQc5l9VBojgPa1p2
	ha7xcHM6HC2x4Td4WK5NGOq5gTMztDZ1rRgvMr3H99p8c/qwgmRLSL66oIwGcynYDifVoi9WlC2
	5OxsclO
X-Received: by 2002:a17:903:2596:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b2d5965babmr136700755ad.17.1776241688093;
        Wed, 15 Apr 2026 01:28:08 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:28:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 10/14] xsk: extend xsk_cq_reserve_locked() to reserve n slots
Date: Wed, 15 Apr 2026 16:26:50 +0800
Message-Id: <20260415082654.21026-11-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Previously it only reserves one slot. The patch extends it to n to cover
the batch mode.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c       | 12 ++++++++----
 net/xdp/xsk_queue.h | 12 +++++++-----
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6cd2e58e170c..c26e26cb4dda 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -546,12 +546,17 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
+/* The function tries to reserve as many descs as possible. If there
+ * is no single slot to allocate, return zero. Otherwise, return how
+ * many slots are available, even though it might stop reserving at
+ * certain point.
+ */
+static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	int ret;
 
 	spin_lock(&pool->cq->cq_cached_prod_lock);
-	ret = xskq_prod_reserve(pool->cq);
+	ret = xskq_prod_reserve(pool->cq, n);
 	spin_unlock(&pool->cq->cq_cached_prod_lock);
 
 	return ret;
@@ -947,8 +952,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		err = xsk_cq_reserve_locked(xs->pool);
-		if (err) {
+		if (!xsk_cq_reserve_locked(xs->pool, 1)) {
 			err = -EAGAIN;
 			goto out;
 		}
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 354f6fe86893..34cc07d6115e 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -413,14 +413,16 @@ static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 	q->cached_prod -= cnt;
 }
 
-static inline int xskq_prod_reserve(struct xsk_queue *q)
+static inline int xskq_prod_reserve(struct xsk_queue *q, u32 n)
 {
-	if (xskq_prod_is_full(q))
-		return -ENOSPC;
+	u32 nr_free = xskq_prod_nb_free(q, n);
+
+	if (!nr_free)
+		return 0;
 
 	/* A, matches D */
-	q->cached_prod++;
-	return 0;
+	q->cached_prod += nr_free;
+	return nr_free;
 }
 
 static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
-- 
2.41.3


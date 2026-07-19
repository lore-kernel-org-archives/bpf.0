Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9E1E520A;
	Sun, 19 Jul 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469389; cv=none; b=O1etV6pVp+dMsOeUT4YZOuVJ7GGR16y2xNGzfPtqPuiBPnpOfsl8Cb7rhjzZ4AdGcydvmSZfXcMOYeA3q1RR3WVYyVBDzBqpuQwXLyQt4Q4wLLdzh8zT7FDENW0swki0bdCTE08WqZkLSaUBtqtm8Y80NhQtKi7iFE7L3NOlZ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469389; c=relaxed/simple;
	bh=uLcLgSw3/jdC0zr4UwoSgWly6XpwWPjEuo6lGBf64TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYPferuAEZgyRQYICzJoO1sMUEfgvZxCNApzmrI69xodzADj2XJXP/PjmqQcfNAJzaT2Q/MxL8qRJA0hKLu2S5XiiOfhRR7W1IBJF11tyPjdAB95RwRqLr11E3hhbdso5e/SwQhYiErcw9HTv2MK/NH6Pm86Sn5O5NQ7/f1a0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AEPu8zJm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AEPu8zJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784469388; x=1816005388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLcLgSw3/jdC0zr4UwoSgWly6XpwWPjEuo6lGBf64TA=;
  b=AEPu8zJmttaWA5+kXaQZiFWCJXTDlNHst4JHvmgXbiu6WFCgn5tKQH32
   40n9jnMqXsvVQJW4a98sep+kweiKDzZ+wSre1dOuZlQlgtBnJ/ySwPRhr
   +F+VG4Z9R67xT4EgUpuMp5NtK9u4nYQ5tR1qhHOxlRQFOrSSUjLAkhGRK
   HJ5bkdezeLRsxFqf3Et8c40MtSWT6Nyzo/tyKMBYZ+G5nQIABxAUvtsca
   eoSwiBStl3tuAV61WBI2cc9SpZTYpUIU6zb/BbdJnjoQdRIUvrfl/gtff
   bMDFbC5wVp+EtdmUPFnqNXVlc0sezlELry6da1SuwfZpHb56yvcQeRkL3
   Q==;
X-CSE-ConnectionGUID: 74n2KyZPRtiQxxPHn3pwbw==
X-CSE-MsgGUID: J8yKmGhGSJ+8L1N8AAKbQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88894160"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88894160"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:56:27 -0700
X-CSE-ConnectionGUID: VSjheyalR5CKLFjxN1AEtA==
X-CSE-MsgGUID: tZKNEhX+QcCazF3t/SmrYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="260791922"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Jul 2026 06:56:24 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 net 2/6] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Sun, 19 Jul 2026 15:56:05 +0200
Message-Id: <20260719135609.147823-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix generic xmit path multi-buffer logic when packets are either too big
(count of descriptors exceed MAX_SKB_FRAGS) or an invalid descriptor is
included in fragmented packet. Introduce xdp_sock::drain_cont and act
upon this flag - when it is set, keep on consuming descriptors from
AF_XDP Tx ring and put them directly onto Cq. Previously these
descriptors were silently lost and could never be reached again.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
Reviewed-by: Jason Xing <kernelxing@tencent.com>
Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # wrapped cq addr submission onto routine
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 45 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index ebac60a3d8a1..8b51876efbed 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -80,6 +80,7 @@ struct xdp_sock {
 	 * call of __xsk_generic_xmit().
 	 */
 	struct sk_buff *skb;
+	bool drain_cont;
 
 	struct list_head map_list;
 	/* Protects map_list */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a7a83dc4546a..12a845d012f6 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -737,6 +737,19 @@ static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
 	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
 }
 
+static void xsk_cq_submit_addr_single_locked(struct xsk_buff_pool *pool,
+					     struct xdp_desc *desc)
+{
+	unsigned long flags;
+	u32 idx;
+
+	spin_lock_irqsave(&pool->cq_prod_lock, flags);
+	idx = xskq_get_prod(pool->cq);
+	xskq_prod_write_addr(pool->cq, idx, desc->addr);
+	xskq_prod_submit_n(pool->cq, 1);
+	spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
+}
+
 static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	spin_lock(&pool->cq->cq_cached_prod_lock);
@@ -1028,13 +1041,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 static int __xsk_generic_xmit(struct sock *sk)
 {
 	struct xdp_sock *xs = xdp_sk(sk);
-	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
+	u32 cached_cons;
 	u32 max_batch;
 	int err = 0;
 
 	mutex_lock(&xs->mutex);
+	cached_cons = xs->tx->cached_cons;
 
 	/* Since we dropped the RCU read lock, the socket state might have changed. */
 	if (unlikely(!xsk_is_bound(xs))) {
@@ -1063,11 +1077,21 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+			xs->tx->invalid_descs++;
+			xskq_cons_release(xs->tx);
+			xs->drain_cont = xp_mb_desc(&desc);
+			continue;
+		}
+
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
 				goto out;
+			if (xp_mb_desc(&desc))
+				xs->drain_cont = true;
 			err = 0;
 			continue;
 		}
@@ -1096,18 +1120,33 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		sent_frame = true;
 		xs->skb = NULL;
 	}
 
 	if (xskq_has_descs(xs->tx)) {
+		bool drain = xs->skb || xs->drain_cont || xp_mb_desc(&desc);
+
+		err = xsk_cq_reserve_locked(xs->pool);
+		if (err) {
+			xs->tx->invalid_descs--;
+			if (xs->skb)
+				xsk_drop_skb(xs->skb);
+			xs->drain_cont = drain;
+			err = -EAGAIN;
+			goto out;
+		}
+
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
+
+		xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-	if (sent_frame)
+	if (xs->tx->cached_cons != cached_cons)
 		__xsk_tx_release(xs);
 
 	mutex_unlock(&xs->mutex);
-- 
2.43.0


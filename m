Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F147ECC5;
	Tue, 14 Jul 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038109; cv=none; b=CxkDaKeRV3b65ds8g90a3g/FTZU0iT2IMzCQj77+QyxH2ZcPjIErK0DfRTPDSNXNuAF64sL632i2U6vr9hXCvorXukVURwGFc8ICJIw0oIwGlh9dLVfiS83ov332S0nUnmjKc7AC0tsVI58A2JyMrLlDKaJBRO5vA1XSo6kWbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038109; c=relaxed/simple;
	bh=T14auuWp4LpZ+GEVrhfVTCOgD1wNpXN0wa4rzRyJ+Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxZ4y8hpu838g9HazQGgpQPFrnHbpw8C6G94m2KeGPjbZf7y2oS6GVSNFCr74ApZIVZLsbRsc/W2eNdZw1lzS5BXipEZTJ4oaSqAHRhx7ZHxPmDV9GxxXBK7EqgYDo2yhIuQoqrYr66bmOJlC0LBLthrMvWP2W2JLAjeTjDMDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwrLztr6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwrLztr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038107; x=1815574107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T14auuWp4LpZ+GEVrhfVTCOgD1wNpXN0wa4rzRyJ+Vs=;
  b=GwrLztr6gnjchxRQRykBpxNHtsx3ddej0dlNoc6ss2qJrMynpGwVuZHE
   0CmIun2DA6rXCkLs2dtAGEhSA0qmvh2Vm9fC1Urh47PnyR3Z4hOQILxbU
   7Z/7guz2Mru/L2HCvoKbTcLVyPeTD3E5fAe2i8PcYdJljknffTYbGUn3Y
   cLIVj9luK7iDmZmuNQesxcxts3p3pG+R0oCPAyLpW5VvQ5ByMUzPXKIzj
   //hkFsWtZcI1KidTAln0czD3TMrehWmh5KIwukR9FWzLA47uS24Uy6xhT
   ibJl+nCGqu4i5C3WCArndVcz//36y0JWCfwb7zwOdPMZex12eebWHGZug
   g==;
X-CSE-ConnectionGUID: TkuMc2sdTjCDmPWcPwU4Ng==
X-CSE-MsgGUID: CRysLMw4S6SEnWnfOxqHfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110207024"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110207024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:07:37 -0700
X-CSE-ConnectionGUID: iz8KM/abQk+VFzXjn+pkAg==
X-CSE-MsgGUID: gPvgl0QOS4KGEv9Xnj/Nfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254120958"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 14 Jul 2026 07:07:34 -0700
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
Subject: [PATCH v3 net 2/6] xsk: drain continuation descs after overflow in xsk_build_skb()
Date: Tue, 14 Jul 2026 16:07:18 +0200
Message-Id: <20260714140722.111645-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
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
Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # wrapped cq addr submission onto routine
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/xdp/xsk.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index a7a83dc4546a..43791647cf18 100644
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
@@ -1063,11 +1076,22 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
+		if (unlikely(xs->drain_cont)) {
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
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
@@ -1101,9 +1125,24 @@ static int __xsk_generic_xmit(struct sock *sk)
 	}
 
 	if (xskq_has_descs(xs->tx)) {
+		bool reclaim_desc = xs->skb || xs->drain_cont;
+
+		if (reclaim_desc) {
+			err = xsk_cq_reserve_locked(xs->pool);
+			if (err) {
+				err = -EAGAIN;
+				goto out;
+			}
+		}
+
 		if (xs->skb)
 			xsk_drop_skb(xs->skb);
+
+		if (reclaim_desc)
+			xsk_cq_submit_addr_single_locked(xs->pool, &desc);
+
 		xskq_cons_release(xs->tx);
+		xs->drain_cont = xp_mb_desc(&desc);
 	}
 
 out:
-- 
2.43.0


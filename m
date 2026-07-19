Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B528379C56;
	Sun, 19 Jul 2026 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469392; cv=none; b=NkcCC/RJGIrvcXhBeRj81eqCy2OBZoG5gDvGgHB0Qf0UUULJ96tBqYrc6qxvrVhI2LYnzCn61c3ppGZNGTgxjeun5OOtRj+D9ZFn17TOQ4vBSc2CgirNj48Br3XfbopZ6UmVOVm/Cximlkhpg8fOWjJRlFPVpb4lzEZfQJg8x+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469392; c=relaxed/simple;
	bh=etL/nuSSqDIoXNFrE7jx7xgtltKO6zzLuG8A3gsb5B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ5LtatOZ45zrpL/OKgBNwFKxGNlsXAOLfl82k0U4s2KImyowLrHeuw3m0udDbQkD3DcSTj/V5yoEV7Jh4B2nfte8y305b62Wd/q1YD/jGp81s53sxlEJ6GgxUXailb6pxxq1TC+/4Uyx1pYE2djqghk1wqwwVWO2jUmMJH5RwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFixsAqn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFixsAqn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784469391; x=1816005391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=etL/nuSSqDIoXNFrE7jx7xgtltKO6zzLuG8A3gsb5B0=;
  b=FFixsAqnT64RxDzKoYDwZ853FjGz4SuQu0SXZ+6Tl7aH4xXLiWtuH7uO
   HY0lMZgNUyG6eBIyYXb3eB3AyqVBgkx6I9pGpLV0xeF7cvQXY/xPoUZGf
   stxDegd/RE0mjuQriauDAcH5aqsIefcf+5ugTGDSiuidhbTg+x6WkNQO7
   2sy9N0dQihHlHvRNkAKqfb9zBSyrU0N/ogn0DqszoEXeGSH+pYOptDlJJ
   QxIgPGCdkG9QsznC5C7gpQv/vODt0OfS/MDzmMJNDHGq2rd7RP4Mk4EgG
   d3huXo1B15AjPuHRCCkVwfhgWhiRd88jSyWoVOiJvg9XIWxDLeZ04sAtn
   A==;
X-CSE-ConnectionGUID: 5oSwV2bMRKSQ7OfZ3JXNCw==
X-CSE-MsgGUID: FLMbZ1RsQH2Dn3ovKMVmkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="88894167"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="88894167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:56:30 -0700
X-CSE-ConnectionGUID: Tj+9XFLDSOq5UaYlmTmk7w==
X-CSE-MsgGUID: 5YUhTLjPQt2eodpEDRE7UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="260791933"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 19 Jul 2026 06:56:27 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v4 net 3/6] xsk: provide sufficient space in pool->tx_descs
Date: Sun, 19 Jul 2026 15:56:06 +0200
Message-Id: <20260719135609.147823-4-maciej.fijalkowski@intel.com>
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

The temporary Tx descriptor array in an XSK buffer pool is currently
sized from the Tx ring of the socket that creates the pool.

This is insufficient for shared-UMEM Tx. A later socket may have a
larger Tx ring and submit a valid multi-buffer packet containing more
descriptors than the first socket's ring, while still remaining within
the device's xdp_zc_max_segs limit.

A packet-framed batch parser bounded by the temporary array cannot reach
the end-of-packet descriptor in that case. It leaves the packet on the
Tx ring and encounters the same packet on every subsequent attempt,
stalling Tx processing for that socket.

Size the temporary descriptor array to the larger of the first Tx ring
and the device's xdp_zc_max_segs capability. This keeps the array large
enough to inspect one maximum-sized valid packet. Larger shared Tx rings
do not require further resizing, as they can be processed over multiple
batches.

Following commit will actually address the data path side.

Fixes: d5581966040f ("xsk: support ZC Tx multi-buffer in batch API")
Reviewed-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xsk_buff_pool.h |  6 ++++--
 net/xdp/xsk.c               | 10 +++++++---
 net/xdp/xsk_buff_pool.c     | 12 ++++++++----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index ccb3b350001f..f5e737a83055 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -102,12 +102,14 @@ struct xsk_buff_pool {
 
 /* AF_XDP core. */
 struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
-						struct xdp_umem *umem);
+						struct xdp_umem *umem,
+						u32 max_segs);
 int xp_assign_dev(struct xsk_buff_pool *pool, struct net_device *dev,
 		  u16 queue_id, u16 flags);
 int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 			 struct net_device *dev, u16 queue_id);
-int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs);
+int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
+		      u32 max_segs);
 void xp_destroy(struct xsk_buff_pool *pool);
 void xp_get_pool(struct xsk_buff_pool *pool);
 bool xp_put_pool(struct xsk_buff_pool *pool);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 12a845d012f6..091792d1d82d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1525,7 +1525,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			 * and/or device.
 			 */
 			xs->pool = xp_create_and_assign_umem(xs,
-							     umem_xs->umem);
+							     umem_xs->umem,
+							     dev->xdp_zc_max_segs);
 			if (!xs->pool) {
 				err = -ENOMEM;
 				sockfd_put(sock);
@@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 			 * utilizes
 			 */
 			if (xs->tx && !xs->pool->tx_descs) {
-				err = xp_alloc_tx_descs(xs->pool, xs);
+				err = xp_alloc_tx_descs(xs->pool, xs,
+							dev->xdp_zc_max_segs);
 				if (err) {
 					xp_put_pool(xs->pool);
 					xs->pool = NULL;
@@ -1575,7 +1577,9 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		goto out_unlock;
 	} else {
 		/* This xsk has its own umem. */
-		xs->pool = xp_create_and_assign_umem(xs, xs->umem);
+		xs->pool = xp_create_and_assign_umem(xs, xs->umem,
+						     dev->xdp_zc_max_segs);
+
 		if (!xs->pool) {
 			err = -ENOMEM;
 			goto out_unlock;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 1f28a9641571..12c9fb29af05 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -42,9 +42,12 @@ void xp_destroy(struct xsk_buff_pool *pool)
 	kvfree(pool);
 }
 
-int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
+int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
+		      u32 max_segs)
 {
-	pool->tx_descs = kvzalloc_objs(*pool->tx_descs, xs->tx->nentries);
+	u32 nentries = max(xs->tx->nentries, max_segs);
+
+	pool->tx_descs = kvzalloc_objs(*pool->tx_descs, nentries);
 	if (!pool->tx_descs)
 		return -ENOMEM;
 
@@ -52,7 +55,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
 }
 
 struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
-						struct xdp_umem *umem)
+						struct xdp_umem *umem,
+						u32 max_segs)
 {
 	bool unaligned = umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
 	struct xsk_buff_pool *pool;
@@ -69,7 +73,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		goto out;
 
 	if (xs->tx)
-		if (xp_alloc_tx_descs(pool, xs))
+		if (xp_alloc_tx_descs(pool, xs, max_segs))
 			goto out;
 
 	pool->chunk_mask = ~((u64)umem->chunk_size - 1);
-- 
2.43.0


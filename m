Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53386481224;
	Tue, 14 Jul 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038112; cv=none; b=XwGIb+kiHVVW5727gIHpXVqvCD+pT5+C+l7M5SgjKq74vHBiHNcyszqlCvOK8TjvP31dzEgaL1W2wuVBqYzKDPaG+ESx1EKZNBcX1YJg62OJAD5SUJGjSjjPMYaPDtkyMkwAR2KbxGAprCSGWURBFRqZ0zBUXrQlfFt7Q5SSOEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038112; c=relaxed/simple;
	bh=z2IWUhjJv9DDD3oMAX0bgGKGSemedsqnG6v0Ut9Yrc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RH7tTH4CXqWbqhw2jDh1WOmu33oHgCMYVY/Vs8OakOTvJY5ejTEHS+uBDJK52gTmPRO/xh9bOBqJZ1962HDhx0brXzQTUgY3b2dhqVlsi4kYnuIfrgsBIwcjev1vdp1dtBjcpgmHmufhVk2jsdUpEGZuyd1vXCmVeOj3syhklNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kb7jFonP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kb7jFonP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038109; x=1815574109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2IWUhjJv9DDD3oMAX0bgGKGSemedsqnG6v0Ut9Yrc8=;
  b=kb7jFonPKTxVsscIenhWvsTv9EreVk+iGRQfMHtRS9dTlfLzgZyE0FWU
   6UfblcnWBbWSvm3hOqDQGfXPh7JgxSGa3e8vqDcsFVg/gGMKYGoRWhfgx
   CKTdZILlOX4aMDYK5vNsfPUz8iQhdRL9GMZw6ckxclFxhXaZ57MY+FSfj
   GLxPFQSdRnvFDdOmZT7oL0OmPPIxzucQqkGsKk45upMLfvqDcBA7Nt24K
   xEWYaUCn1haX1lUkeXFClLQ0jU0aTRksO1moQOORXkdG/OMxgR3oxfuHN
   UeFRiHGX2GbCg9JDX4Ihl6Fxo3vPE9B5AOO8Iohm9NptMboYoA96Jg0Cb
   Q==;
X-CSE-ConnectionGUID: 9rlH24XwTuiWjxeyrq2teQ==
X-CSE-MsgGUID: V5+SXnl1TN62YlSW7eiYeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="110207031"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="110207031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:07:39 -0700
X-CSE-ConnectionGUID: rzkt4dN6Sm2LHi4cN8CunA==
X-CSE-MsgGUID: mJ7WBSXlTnu8Nndrj2p3SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254120970"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 14 Jul 2026 07:07:36 -0700
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 net 3/6] xsk: provide sufficient space in pool->tx_descs
Date: Tue, 14 Jul 2026 16:07:19 +0200
Message-Id: <20260714140722.111645-4-maciej.fijalkowski@intel.com>
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
index 43791647cf18..385a3f4a1b32 100644
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


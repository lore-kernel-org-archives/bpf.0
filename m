Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3413876D6;
	Fri, 10 Jul 2026 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712702; cv=none; b=id9xzxgbogFaptUDzLP+/lJh6Zhk+SbiqtityRKqQp1sRyXgfFODPGQDcCYAGABLEBbu4qrlOn37Yf6JyMDSNvzQqgDRPbeAIjZr9R2vPQcxWtKvnN50gjDqaei6uXpMAC9Zme2Jaw5tRgwicbsUudfwrDQGxHUuVSWvJtO9X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712702; c=relaxed/simple;
	bh=WXdiyUDH4AliXZbuy+qTwbnjZH7cvcZPbR0KJnLqz/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuDXKkahpgiNPeMtHEdH47kqCOvTrixGMrOmq/8/UrTcGO0OMxjjGSEJGmG4w5aXQYcPi9aJGUGNf8BjQ2JKoS+cu+50ExzO5j5NKRl5EarochN5M5b0KE5Oju09uvs+q1ws4CLFnVhaPtjNA9eb3/BOBq/n0zvHlAM9j8XULh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A842ecDw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A842ecDw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712699; x=1815248699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WXdiyUDH4AliXZbuy+qTwbnjZH7cvcZPbR0KJnLqz/s=;
  b=A842ecDwhTCJu2hr7I1E3MKbYsBK7fh0hKB/SrTs0uiT2+vKwfY7HV8t
   qrSYeYQHU8R+Xg8CFhpdR32OguZs0L8wf1JVcEtM65lq3ZYSNxDCYQXyQ
   0t21Ycz8ETz4YnSt5Tb+mmHowEDO0DlwERZ1p3la6vs9eMeYV1bM34v86
   NtqJimVIbBpGuxplZ1JLurqbklozLgs2Mky0wAv9+6PGpUlTOD7tK0O7l
   kyRxCr2x2yswr4Euqlyh9JD88+ws9HPNtBqJqmNFEan2fx371XT2bNXhP
   vZ19A7O29U78pobiCrjSq7IV3pSJFvfxGTjplk+mGa2U2cvU/sifgDts9
   g==;
X-CSE-ConnectionGUID: Z/afQiphRESH0DKjXylXDw==
X-CSE-MsgGUID: XpZUF7G6To+d+KuVgV4Qww==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965202"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965202"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:44:56 -0700
X-CSE-ConnectionGUID: 581gnggASLKrAXDC50HYYA==
X-CSE-MsgGUID: E+GOyX/cTjWsgPz10bszSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157258"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:44:54 -0700
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH v2 net 1/5] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
Date: Fri, 10 Jul 2026 21:44:20 +0200
Message-Id: <20260710194424.84844-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This patch is inspired by the check[1] from sashiko. It says when
overflow happens, the address of cq to be published is invalid.
Actually the severer thing is the whole process of publishing the
address of cq in this particular case is not right: it should truely
publish the address and advance the cached_prod in cq as long as it
reads descriptors from txq.

The following is the full analysis.
xsk_drop_skb() is called in three places, which all discard a partially
built multi-buffer skb:
1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
   the TX ring prevents the partial packet from completing
3) xsk_release(): socket close while xs->skb holds an incomplete packet

In all three cases, the TX descriptors for the already-processed frags
have been consumed from the TX ring (xskq_cons_release), and CQ slots
have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
the buffer addresses never appear in the completion queue, userspace
permanently loses track of these buffers.

Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
destructor, which already submits buffer addresses to the CQ via
xsk_cq_submit_addr_locked().

Note that cancelling the descriptors back to the TX ring (via
xskq_cons_cancel_n) is not a appropriate option because an oversized
packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
which is an obviously deadlock bug in the TX path.

Also move the desc->addr assignment in xsk_build_skb() above the
overflow check so that the current descriptor's address is recorded
before a potential -EOVERFLOW jump to free_err, consistent with the
zerocopy path in xsk_build_skb_zerocopy().

[1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b970f30ea9b9..a7a83dc4546a 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
 
 static void xsk_drop_skb(struct sk_buff *skb)
 {
-	xdp_sk(skb->sk)->tx->invalid_descs += xsk_get_num_desc(skb);
-	xsk_consume_skb(skb);
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+
+	xs->tx->invalid_descs += xsk_get_num_desc(skb);
+	consume_skb(skb);
+	xs->skb = NULL;
 }
 
 static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
@@ -877,7 +880,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(-ENOMEM);
 
 		/* in case of -EOVERFLOW that could happen below,
-		 * xsk_consume_skb() will release this node as whole skb
+		 * xsk_drop_skb() will release this node as whole skb
 		 * would be dropped, which implies freeing all list elements
 		 */
 		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
@@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 			}
 
+			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
+
 			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
 				err = -EOVERFLOW;
 				goto free_err;
@@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
 			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
-
-			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
 		}
 	}
 
-- 
2.43.0


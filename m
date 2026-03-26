Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D20E3F7A83;
	Thu, 26 Mar 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525788; cv=none; b=feqyKmTcBgqy418pEELneAgv+Swe4ooQIrYaTEKIsL7/wRjkKKytmCfG9iS8HBwa984v9t1xJTuMcbTfVSPZT+8Y7rJc5/9dppokuGEjLJTK3LdiKB+VtcK3ZybdDZX35SSCfos0Mo/9sq0bwgNILwtx5tr+8wr8ZDkLl6CzchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525788; c=relaxed/simple;
	bh=PzBFdDhMquFEuDQF9TQj8dLh3ssgnCZMs5ANL6V0d74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1K5MT4z5kGeYg4VzQmUiUV9PbfE985WLeC7xospZcOzblRZz+I+9joA5zZmr2mUvyqgH7SmaENJx8AFh3umY6tROHAzjAznz80Xo3dDcNVu8Rei/uos4Rfeli3kYgXvdWDxF4Y2/ecYP4w9v9m2zMTxaMDK/6XI1xwu4Aiisek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1zWMz/v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1zWMz/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774525778; x=1806061778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzBFdDhMquFEuDQF9TQj8dLh3ssgnCZMs5ANL6V0d74=;
  b=N1zWMz/vKapxkhEqt0itB3CDBpxAF1Wx0II5egvagbwnmWdi/GbVd6V5
   N7Apz2XW8nU9aSL/pDWSanMmDPjYCi8mPOveOGgCGNpWi81wAl3h/8Yge
   ETUrWkUHmA6m2KnXLzYVysUkExysz0uUm608PyHA2hTSrttMEv3I7OCNq
   s+4n2SxrAbfKB7fiCF2aDg7rYTF6wyDFnxdnnzETjMAFRUaCll2M/Hzd0
   b6jSjMoy7+xVj0K5cJUlkimgEuCXA4pLKSwj/oV3aqZTeA0j9oTBCSi3U
   XuyfEA9iiSTRaZkKBbJBkXb1NPYSIrLRdm95ZTZs0V/mMRXCRZb+meqtN
   w==;
X-CSE-ConnectionGUID: U63LQadHTLiYxhtJAGL0aw==
X-CSE-MsgGUID: 38YkNZNJRNGkqHMFH7VJkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75776238"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75776238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 04:49:37 -0700
X-CSE-ConnectionGUID: OahEZdzFQmWpBRqxkWCW8w==
X-CSE-MsgGUID: i6gqtILOS5KJ8aBStRTtMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248029012"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2026 04:49:34 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	bjorn@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v4 net 02/11] xsk: respect tailroom for ZC setups
Date: Thu, 26 Mar 2026 12:49:10 +0100
Message-Id: <20260326114919.519456-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
References: <20260326114919.519456-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Multi-buffer XDP stores information about frags in skb_shared_info that
sits at the tailroom of a packet. The storage space is reserved via
xdp_data_hard_end():

	((xdp)->data_hard_start + (xdp)->frame_sz -	\
	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

and then we refer to it via macro below:

static inline struct skb_shared_info *
xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
{
        return (struct skb_shared_info *)xdp_data_hard_end(xdp);
}

Currently we do not respect this tailroom space in multi-buffer AF_XDP
ZC scenario. To address this, introduce xsk_pool_get_tailroom() and use
it within xsk_pool_get_rx_frame_size() which is used in ZC drivers to
configure length of HW Rx buffer.

xsk_pool_get_tailroom() is only reserving necessary space when pool is
zc and underlying netdev supports zc multi-buffer. Rely on pool->dev
state when configuring tailroom. xsk_pool_get_rx_frame_size() inside
ndo_bpf is usually called when bringing up queues and before xsk's dma
mappings have been configured, which makes it valid to rely on
pool->dev.

Typically drivers on Rx Hw buffers side work on 128 byte alignment so
let us align the value returned by xsk_pool_get_rx_frame_size() in order
to avoid addressing this on driver's side. This addresses the fact that
idpf uses mentioned function *before* pool->dev being set so we were at
risk that after subtracting tailroom we would not provide 128-byte
aligned value to HW.

Reviewed-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Fixes: 24ea50127ecf ("xsk: support mbuf on ZC RX")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 6b9ebae2dc95..dcf811c45b22 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -41,6 +41,19 @@ static inline u32 xsk_pool_get_headroom(struct xsk_buff_pool *pool)
 	return XDP_PACKET_HEADROOM + pool->headroom;
 }
 
+static inline u32 xsk_pool_get_tailroom(struct xsk_buff_pool *pool)
+{
+	struct xdp_umem *umem = pool->umem;
+
+	/* Reserve tailroom only for zero-copy pools that opted into
+	 * multi-buffer. The reserved area is used for skb_shared_info,
+	 * matching the XDP core's xdp_data_hard_end() layout.
+	 */
+	if (pool->dev && (umem->flags & XDP_UMEM_SG_FLAG))
+		return SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	return 0;
+}
+
 static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 {
 	return pool->chunk_size;
@@ -48,7 +61,9 @@ static inline u32 xsk_pool_get_chunk_size(struct xsk_buff_pool *pool)
 
 static inline u32 xsk_pool_get_rx_frame_size(struct xsk_buff_pool *pool)
 {
-	return xsk_pool_get_chunk_size(pool) - xsk_pool_get_headroom(pool);
+	return ALIGN_DOWN(xsk_pool_get_chunk_size(pool) -
+			  xsk_pool_get_headroom(pool) -
+			  xsk_pool_get_tailroom(pool), 128);
 }
 
 static inline u32 xsk_pool_get_rx_frag_step(struct xsk_buff_pool *pool)
-- 
2.43.0


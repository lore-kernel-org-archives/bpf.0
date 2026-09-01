Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBE396562;
	Tue,  1 Sep 2026 21:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297490; cv=none; b=WZwiGcbup9U4jM97g8If843Gw+Sv+62f4T0n8ekU3EPS/EL1//ggOh6KHV3+z7K8p0xZdBbNz3sj6d8TCN/xUrXLjkFHCMy0Z0c9bnI5eY6IxT6k9VRf8yYOz+jkIDJwTuSDkn/qRqOGAJtPoVc8PuIkpeBbCmW8r1+Af6YaWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297490; c=relaxed/simple;
	bh=FylQuS3QpNE4by8TIFglcIyDmir/5h/bLrrGFX18dsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJoNRStddqjpPUsk/mJgQ4DcMrPtuQvt5DqIuWFrFqZ/ZMj079409g2NFpAAebzyGAFdmHYEs0bs8I34A2X03GUxqgPBsbxy4ik3gZff4OHmVN/ql0ffOGK6wr4NY6DE4OW5FZ4cM1s9PIraGiojKg5quwPUsmKWZDt3Xa0A03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QGhFVSCT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QGhFVSCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297489; x=1819833489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FylQuS3QpNE4by8TIFglcIyDmir/5h/bLrrGFX18dsw=;
  b=QGhFVSCTPrGD1JpoMDh/wlEQPKmBUcvhAhcmXZ6JTr1BjxnRqWwUrQ+9
   9YW6SghiK9Vzh4JcO0a/NsFPZd3z7Xk2HygUs/IN+jsViFCtgzpEWfEjy
   OMSo9izNYyBYf1s18GgWPeUV4+aZZVfcgoIKq7iwMQGkm5nKL0Z1gBOZL
   +4HoReqqzcEz51zQ/1FisdAcxCOjxjCDkISPYH9cBXc9Iv4tdympPeJiA
   m909IZsl+Ku4uxhFBbkdQmLryg9ft/hNrFE2m3qJUA3e0HmZFQ0VqWesX
   H6lNjR0UALVNRLtW8QmQed/t2hBgMA0pF/+OCi/xI5YGE1FSZeM7/xtIB
   w==;
X-CSE-ConnectionGUID: KFOVMdneQLG97JbNeLt/sg==
X-CSE-MsgGUID: pqE77wsuSpal6+cBYgvkVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88670348"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88670348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:18:06 -0700
X-CSE-ConnectionGUID: bmMh18MNQSy1LRnKoaWxxw==
X-CSE-MsgGUID: gSULh+IJQxSzb/DCCqLnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267439750"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 14:18:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	enjuk@amazon.com,
	chris.packham@alliedtelesis.co.nz,
	przemyslaw.kitszel@intel.com,
	blair.steven@alliedtelesis.co.nz,
	carl.smith@alliedtelesis.co.nz,
	horms@kernel.org,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net-next 1/4] i40e: prepare for XDP metadata ops support
Date: Tue,  1 Sep 2026 14:17:47 -0700
Message-ID: <20260901211752.1922993-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
References: <20260901211752.1922993-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <kohei@enjuk.jp>

Prepare 'struct i40e_xdp_buff' that contains an xdp_buff and a pointer
to i40e_rx_desc in order to pass the RX descriptor to the XDP kfuncs.
Also in ZC path, use XSK_CHECK_PRIV_TYPE() to ensure i40e_xdp_buff
doesn't exceed the offset of cb in xdp_buff_xsk.

No functional changes.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 ++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0cd0e5597c90..4b11ae9ed8d5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3622,7 +3622,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp_ctx.xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef5e657816f0..7f68adb5109b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2438,10 +2438,11 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			     unsigned int *rx_cleaned)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	struct i40e_xdp_buff *xdp_ctx = &rx_ring->xdp_ctx;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
 	u16 clean_threshold = rx_ring->count / 2;
 	unsigned int offset = rx_ring->rx_offset;
-	struct xdp_buff *xdp = &rx_ring->xdp;
+	struct xdp_buff *xdp = &xdp_ctx->xdp;
 	unsigned int xdp_xmit = 0;
 	struct bpf_prog *xdp_prog;
 	bool failure = false;
@@ -2530,6 +2531,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		if (neop)
 			continue;
 
+		xdp_ctx->desc = rx_desc;
+
 		xdp_res = i40e_run_xdp(rx_ring, xdp, xdp_prog);
 
 		if (xdp_res) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 1e5fd63d47f4..bb741ff3e5f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -283,6 +283,11 @@ struct i40e_rx_buffer {
 	__u32 page_count;
 };
 
+struct i40e_xdp_buff {
+	struct xdp_buff xdp;
+	const union i40e_rx_desc *desc;
+};
+
 struct i40e_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -345,7 +350,7 @@ struct i40e_ring {
 	 * and to resume packet building for this ring in the next call to
 	 * i40e_clean_rx_ring_irq().
 	 */
-	struct xdp_buff xdp;
+	struct i40e_xdp_buff xdp_ctx;
 
 	/* Next descriptor to be processed; next_to_clean is updated only on
 	 * processing EOP descriptor
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..51a05ce4c7ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -246,6 +246,8 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	u32 nb_buffs, i;
 	dma_addr_t dma;
 
+	XSK_CHECK_PRIV_TYPE(struct i40e_xdp_buff);
+
 	rx_desc = I40E_RX_DESC(rx_ring, ntu);
 	xdp = i40e_rx_bi(rx_ring, ntu);
 
@@ -396,6 +398,14 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 	WARN_ON_ONCE(1);
 }
 
+static struct i40e_xdp_buff *xsk_buff_to_i40e_ctx(struct xdp_buff *xdp)
+{
+	/* xdp_buff pointer used by ZC code path is allocated as xdp_buff_xsk.
+	 * i40e_xdp_buff private fields overlap with xdp_buff_xsk->cb.
+	 */
+	return (struct i40e_xdp_buff *)xdp;
+}
+
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -472,6 +482,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
+
 		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
 		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
 					  &rx_bytes, xdp_res, &failure);
-- 
2.47.1


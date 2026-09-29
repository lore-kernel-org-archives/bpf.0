Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F47C108;
	Tue, 29 Sep 2026 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790723603; cv=none; b=iyM7dnIIcCwoHECoOSAyy2iIL4c5Cj2WGz4gzmGBPEDvcJ6eQ8pUa7BEohtNKv1jtScl3kQP/ONh+RMQhwgqyxybMFKBuo0C/IU8G1IHpBsepARMa8CddFlhl6QcRn/hlUon0h7zy002Nsc6fvH+lsrCsQngbyYWdYNxDR3ThBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790723603; c=relaxed/simple;
	bh=1MGXEOJ2p+IWmNGLAy6M1E/gQdMxoV2v2XuInceATYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLdp9dIX63XruBUVG4HrCp2NLIGMj0Kk8MAshbHPj//0AbiLRdjjjqYBPI/C+qg0FnxcQrFfwOWCyJs6WezhQWnOAituuY7LA8DnmL59PPwKEttn1/vNz750aBvBkTuUbZdqFoYh5rCXS3bFS9V5lMUe2++hDiIZR8C3uAHYDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WihTNh/S; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WihTNh/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790723602; x=1822259602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1MGXEOJ2p+IWmNGLAy6M1E/gQdMxoV2v2XuInceATYE=;
  b=WihTNh/SiqPlZoBmIvT0okojL8ZpzLMpQ9HWrelxIKb1eQLAmd/Z+V+0
   7+30H0Z14mQJmCBIQVBrjyBF6a+BVBMdCzwLMiRhcxmIFACLJCNeJTpnx
   ad05St3NbmBAgYnCUPsv1jJlcmUD+IJd1M1ktwTxCmSVpvgvJ7UIGL3zj
   MnQE4CO30XA9yonEuLizVbi22cp7DZUePem1GROz+rwTgFvGqeUjbhz/c
   CY6e5uKPyNvXBlm8xMPgugjB6FGRM3JIW86W0fvUXH9Mq0HLkGc+x/G+J
   E1fq/YvxmoovFvCmIH28TacVmCqlpyXS1gWrkKZ0Piip5ASb781W9pb2V
   g==;
X-CSE-ConnectionGUID: Fvq1docJTfaS+1GG0qfIiQ==
X-CSE-MsgGUID: Wsx7sURBQ8yiRh5N8vn2Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91550416"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91550416"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 16:13:21 -0700
X-CSE-ConnectionGUID: u0r0Ef8fTVWmg8MPDFdsEA==
X-CSE-MsgGUID: qbdcxcdgSP2o2TVCMfU89w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="280264667"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 16:13:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	sridhar.samudrala@intel.com,
	emil.s.tantilov@intel.com,
	boolli@google.com,
	decot@google.com,
	brianvv@google.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	YiFei Zhu <zhuyifei@google.com>,
	Patryk Holda <patryk.holda@intel.com>
Subject: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs without Tx FIFO support
Date: Tue, 29 Sep 2026 16:13:00 -0700
Message-ID: <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
References: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

From the first days of XDP implementation in idpf, it relied and
worked solely on top of the queue-based scheduling Tx mode, which
basically means simple FIFO. However, turned out not every firmware
supports this mode and XDP doesn't work there at all.

Since the flow-based scheduling Tx mode is mandatory and supported
by every FW, introduce a simple fallback guarded by a static key
to not hurt the more performant mode. The FB mode generates a
completion for each Tx descriptor and never guarantees that there
won't be any out-of-order completions. Serialize that using a
bitmap of completed descriptors and report contiguous blocks of
free bits to match XDP and XSk expectations and avoid further
code complication.

The usage of a bitmap on hotpath might sound scary, but this
fallback is able to reach around 70% of the QB mode's performance,
which is comparable to what ice gives us. The main bottlenecks are
unlikely()s and one completion per each descriptor, while in the QB
mode we have one completion per batch (which might contain 64 or
even 128 frames), plus the size of the completion descriptor is
8 bytes in this mode (4 bytes in the QB mode), which means a lot
of additional PCI traffic.

bloat-o-meter shows .text increase in about 2 Kb without adding new
functions or uninlining any of the existing ones. I played a bunch
with inlining and uninlining certain pieces or the whole fallback,
but the compiler collapses and optimizes libeth templates so hardly
so that each additional external call only makes things worse.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h      |   2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c |  12 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  18 +--
 drivers/net/ethernet/intel/idpf/xdp.c       | 131 +++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/xdp.h       |  73 ++++++++++-
 include/net/libeth/xdp.h                    |  13 ++
 6 files changed, 230 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f214023095ee..e76bee11756e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -354,6 +354,7 @@ struct idpf_q_vec_rsrc {
  * @txqs: Used only in hotpath to get to the right queue very fast
  * @num_txq: Number of allocated TX queues
  * @num_xdp_txq: number of XDPSQs
+ * @xdpsq_fb: whether flow-based fallback is enabled for XDPSQs
  * @xdpsq_share: whether XDPSQ sharing is enabled
  * @xdp_prog: installed XDP program
  * @vdev_info: IDC vport device info pointer
@@ -383,6 +384,7 @@ struct idpf_vport {
 	struct idpf_tx_queue **txqs;
 	u16 num_txq;
 	u16 num_xdp_txq;
+	bool xdpsq_fb;
 	bool xdpsq_share;
 	struct bpf_prog *xdp_prog;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad9..1f989fe476b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -227,7 +227,7 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 
 	idpf_xsk_setup_queue(vport, tx_q, VIRTCHNL2_QUEUE_TYPE_TX);
 
-	if (!idpf_queue_has(FLOW_SCH_EN, tx_q))
+	if (!idpf_queue_has(FLOW_SCH_EN, tx_q) || idpf_queue_has(XDP, tx_q))
 		return 0;
 
 	refillq = tx_q->refillq;
@@ -1054,6 +1054,13 @@ static void idpf_clean_queue_set(const struct idpf_queue_set *qs)
 			if (idpf_queue_has(XDP, q->txq)) {
 				q->txq->pending = 0;
 				q->txq->xdp_tx = 0;
+
+				if (static_branch_unlikely(&idpf_xdp_fb) &&
+				    idpf_queue_has(FLOW_SCH_EN, q->txq)) {
+					bitmap_zero(q->txq->pending_mask,
+						    q->txq->desc_count);
+					q->txq->last_ntu = 0;
+				}
 			} else {
 				q->txq->txq_grp->num_completions_pending = 0;
 			}
@@ -1316,7 +1323,8 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
 			if (!txq_grp->txqs[j])
 				continue;
 
-			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j])) {
+			if (idpf_queue_has(FLOW_SCH_EN, txq_grp->txqs[j]) &&
+			    !idpf_queue_has(XDP, txq_grp->txqs[j])) {
 				kfree(txq_grp->txqs[j]->refillq);
 				txq_grp->txqs[j]->refillq = NULL;
 			}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index fe0c913f9bb9..37b9beccc018 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -628,12 +628,14 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  * @clean_budget: singleq only, queue cleaning budget
  * @cleaned_pkts: Number of packets cleaned for the above said case
  * @refillq: Pointer to refill queue
+ * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
+ * @tstamp_task: Work that handles Tx timestamp read
  * @pending: number of pending descriptors to send in QB
  * @xdp_tx: number of pending &xdp_buff or &xdp_frame buffers
  * @timer: timer for XDP Tx queue cleanup
  * @xdp_lock: lock for XDP Tx queues sharing
- * @cached_tstamp_caps: Tx timestamp capabilities negotiated with the CP
- * @tstamp_task: Work that handles Tx timestamp read
+ * @pending_mask: mask of buffers waiting for completion in the FB XDP mode
+ * @last_ntu: @next_to_use from the previous batch in the FB XDP mode
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -695,6 +697,9 @@ struct idpf_tx_queue {
 			u16 cleaned_pkts;
 
 			struct idpf_sw_queue *refillq;
+
+			struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
+			struct work_struct *tstamp_task;
 		};
 		struct {
 			u32 pending;
@@ -702,12 +707,12 @@ struct idpf_tx_queue {
 
 			struct libeth_xdpsq_timer *timer;
 			struct libeth_xdpsq_lock xdp_lock;
+
+			unsigned long *pending_mask;
+			u32 last_ntu;
 		};
 	};
 
-	struct idpf_ptp_vport_tx_tstamp_caps *cached_tstamp_caps;
-	struct work_struct *tstamp_task;
-
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
 	__cacheline_group_end_aligned(read_write);
@@ -724,8 +729,7 @@ struct idpf_tx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
-			    104 +
-			    offsetof(struct idpf_tx_queue, cached_tstamp_caps) -
+			    96 + offsetof(struct idpf_tx_queue, tstamp_task) -
 			    offsetofend(struct idpf_tx_queue, timer) +
 			    offsetof(struct idpf_tx_queue, q_stats) -
 			    offsetofend(struct idpf_tx_queue, tstamp_task),
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index cbccd4546768..c771663677a5 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -7,6 +7,8 @@
 #include "xdp.h"
 #include "xsk.h"
 
+DEFINE_STATIC_KEY_FALSE(idpf_xdp_fb);
+
 static int idpf_rxq_for_each(const struct idpf_q_vec_rsrc *rsrc,
 			     int (*fn)(struct idpf_rx_queue *rxq, void *arg),
 			     void *arg)
@@ -149,10 +151,12 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
 
 static void idpf_xdp_tx_timer(struct work_struct *work);
 
-int idpf_xdpsqs_get(const struct idpf_vport *vport)
+int idpf_xdpsqs_get(struct idpf_vport *vport)
 {
 	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
-	struct net_device *dev;
+	unsigned long **masks __free(kvfree) = NULL;
+	const struct net_device *dev;
+	bool warn;
 	u32 sqs;
 
 	if (!idpf_xdp_enabled(vport))
@@ -176,6 +180,34 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 	dev = vport->netdev;
 	sqs = vport->dflt_qv_rsrc.xdp_txq_offset;
 
+	vport->xdpsq_fb = !idpf_is_cap_ena(vport->adapter, IDPF_OTHER_CAPS,
+					   VIRTCHNL2_CAP_SPLITQ_QSCHED);
+	if (!vport->xdpsq_fb)
+		goto setup;
+
+	masks = kvzalloc_objs(*masks, vport->num_xdp_txq);
+	if (!masks)
+		goto err_masks;
+
+	for (u32 i = 0; i < vport->num_xdp_txq; i++) {
+		masks[i] = bitmap_zalloc_node(vport->txqs[sqs + i]->desc_count,
+					      GFP_KERNEL, cpu_to_mem(i));
+		if (!masks[i]) {
+			for (int j = i - 1; j >= 0; j--)
+				bitmap_free(masks[j]);
+
+			goto err_masks;
+		}
+	}
+
+	warn = !static_key_enabled(&idpf_xdp_fb);
+	static_branch_inc(&idpf_xdp_fb);
+
+	if (warn && net_ratelimit())
+		netdev_warn(dev,
+			    "The FW doesn't support Tx in FIFO mode, XDP Tx performance might be suboptimal\n");
+
+setup:
 	for (u32 i = sqs; i < vport->num_txq; i++) {
 		struct idpf_tx_queue *xdpsq = vport->txqs[i];
 
@@ -183,8 +215,8 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		kfree(xdpsq->refillq);
 		xdpsq->refillq = NULL;
 
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq);
-		idpf_queue_clear(FLOW_SCH_EN, xdpsq->complq);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq, vport->xdpsq_fb);
+		idpf_queue_assign(FLOW_SCH_EN, xdpsq->complq, vport->xdpsq_fb);
 		idpf_queue_set(NOIRQ, xdpsq);
 		idpf_queue_set(XDP, xdpsq);
 		idpf_queue_set(XDP, xdpsq->complq);
@@ -197,12 +229,25 @@ int idpf_xdpsqs_get(const struct idpf_vport *vport)
 		xdpsq->pending = 0;
 		xdpsq->xdp_tx = 0;
 		xdpsq->thresh = libeth_xdp_queue_threshold(xdpsq->desc_count);
+
+		if (static_branch_unlikely(&idpf_xdp_fb) && vport->xdpsq_fb) {
+			xdpsq->pending_mask = masks[i - sqs];
+			xdpsq->last_ntu = 0;
+		}
 	}
 
 	return 0;
+
+err_masks:
+	vport->xdpsq_fb = false;
+
+	for (u32 i = 0; i < vport->num_xdp_txq; i++)
+		kfree(timers[i]);
+
+	return -ENOMEM;
 }
 
-void idpf_xdpsqs_put(const struct idpf_vport *vport)
+void idpf_xdpsqs_put(struct idpf_vport *vport)
 {
 	struct net_device *dev;
 	u32 sqs;
@@ -222,10 +267,23 @@ void idpf_xdpsqs_put(const struct idpf_vport *vport)
 		libeth_xdpsq_deinit_timer(xdpsq->timer);
 		libeth_xdpsq_put(&xdpsq->xdp_lock, dev);
 
+		if (static_branch_unlikely(&idpf_xdp_fb) &&
+		    idpf_queue_has(FLOW_SCH_EN, xdpsq)) {
+			bitmap_free(xdpsq->pending_mask);
+			xdpsq->pending_mask = NULL;
+			xdpsq->last_ntu = 0;
+		}
+
 		kfree(xdpsq->timer);
 		xdpsq->refillq = NULL;
 		idpf_queue_clear(NOIRQ, xdpsq);
 	}
+
+	if (!vport->xdpsq_fb)
+		return;
+
+	static_branch_dec(&idpf_xdp_fb);
+	vport->xdpsq_fb = false;
 }
 
 static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
@@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
 	return upper_16_bits(val);
 }
 
+static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
+{
+	struct idpf_compl_queue *cq = xdpsq->complq;
+	unsigned long *mask = xdpsq->pending_mask;
+	u32 done_frames, tx_cnt, new_ntc;
+	u32 ntc = cq->next_to_clean;
+	u32 cnt = cq->desc_count;
+	bool gen;
+
+	gen = idpf_queue_has(GEN_CHK, cq);
+
+	for (done_frames = 0; done_frames < budget; ) {
+		int ret;
+
+		ret = idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
+		if (ret >= 0) {
+			__clear_bit(ret, mask);
+			done_frames++;
+
+			goto next;
+		}
+
+		switch (ret) {
+		case -ENODATA:
+			goto out;
+		case -EINVAL:
+			break;
+		}
+
+next:
+		if (unlikely(++ntc == cnt)) {
+			ntc = 0;
+			gen = !gen;
+			idpf_queue_change(GEN_CHK, cq);
+		}
+	}
+
+out:
+	cq->next_to_clean = ntc;
+
+	if (unlikely(!done_frames))
+		return 0;
+
+	tx_cnt = xdpsq->desc_count;
+
+	/* Don't go past next_to_use */
+	__set_bit(xdpsq->next_to_use, mask);
+
+	new_ntc = find_next_bit(mask, tx_cnt, xdpsq->next_to_clean);
+	done_frames = new_ntc - xdpsq->next_to_clean;
+
+	if (new_ntc == tx_cnt)
+		done_frames += find_first_bit(mask, tx_cnt);
+
+	__clear_bit(xdpsq->next_to_use, mask);
+
+	return done_frames;
+}
+
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 {
 	struct idpf_compl_queue *cq = xdpsq->complq;
@@ -260,6 +377,10 @@ u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget)
 	u32 done_frames;
 	bool gen;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq))
+		return idpf_xdpsq_poll_fb(xdpsq, budget);
+
 	gen = idpf_queue_has(GEN_CHK, cq);
 
 	for (done_frames = 0; done_frames < budget; ) {
diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
index 63e56f7d43e0..95e47ea2ccba 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.h
+++ b/drivers/net/ethernet/intel/idpf/xdp.h
@@ -8,6 +8,10 @@
 
 #include "idpf_txrx.h"
 
+struct idpf_q_vec_rsrc;
+
+DECLARE_STATIC_KEY_FALSE(idpf_xdp_fb);
+
 int idpf_xdp_rxq_info_init(struct idpf_rx_queue *rxq);
 int idpf_xdp_rxq_info_init_all(const struct idpf_q_vec_rsrc *rsrc);
 void idpf_xdp_rxq_info_deinit(struct idpf_rx_queue *rxq, u32 model);
@@ -15,12 +19,40 @@ void idpf_xdp_rxq_info_deinit_all(const struct idpf_q_vec_rsrc *rsrc);
 void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
 			       struct bpf_prog *xdp_prog);
 
-int idpf_xdpsqs_get(const struct idpf_vport *vport);
-void idpf_xdpsqs_put(const struct idpf_vport *vport);
+int idpf_xdpsqs_get(struct idpf_vport *vport);
+void idpf_xdpsqs_put(struct idpf_vport *vport);
 
 u32 idpf_xdpsq_poll(struct idpf_tx_queue *xdpsq, u32 budget);
 bool idpf_xdp_tx_flush_bulk(struct libeth_xdp_tx_bulk *bq, u32 flags);
 
+static inline void idpf_xdp_tx_xmit_fb(struct libeth_xdp_tx_desc desc, u32 i,
+				       const struct libeth_xdpsq *sq, u64 priv)
+{
+	struct idpf_flex_tx_sched_desc *tx_desc = sq->descs;
+	u32 cmd;
+
+	cmd = FIELD_PREP(IDPF_TXD_FLEX_FLOW_DTYPE_M,
+			 IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE);
+	if (desc.flags & LIBETH_XDP_TX_LAST)
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_EOP;
+	if (priv && (desc.flags & LIBETH_XDP_TX_CSUM))
+		cmd |= IDPF_TXD_FLEX_FLOW_CMD_CS_EN;
+
+	tx_desc = &tx_desc[i];
+	tx_desc->buf_addr = cpu_to_le64(desc.addr);
+
+#ifdef __LIBETH_WORD_ACCESS
+	*(u64 *)&tx_desc->qw1 = ((u64)desc.len << 48) | ((u64)i << 32) | cmd;
+#else
+	tx_desc->qw1.rxr_bufsize = cpu_to_le16(desc.len);
+	tx_desc->qw1.compl_tag = cpu_to_le16(i);
+	tx_desc->qw1.ts[0] = 0;
+	tx_desc->qw1.ts[1] = 0;
+	tx_desc->qw1.ts[2] = 0;
+	tx_desc->qw1.cmd_dtype = cmd;
+#endif
+}
+
 /**
  * idpf_xdp_tx_xmit - produce a single HW Tx descriptor out of XDP desc
  * @desc: XDP descriptor to pull the DMA address and length from
@@ -34,6 +66,14 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
 	struct idpf_flex_tx_desc *tx_desc = sq->descs;
 	u32 cmd;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN,
+			   libeth_xdpsq_to_sq(sq, struct idpf_tx_queue,
+					      next_to_use))) {
+		idpf_xdp_tx_xmit_fb(desc, i, sq, priv);
+		return;
+	}
+
 	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_DTYPE_M,
 			 IDPF_TX_DESC_DTYPE_FLEX_L2TAG1_L2TAG2);
 	if (desc.flags & LIBETH_XDP_TX_LAST)
@@ -53,12 +93,34 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
 #endif
 }
 
-static inline void idpf_xdpsq_set_rs(const struct idpf_tx_queue *xdpsq)
+static inline void idpf_xdpsq_set_rs_fb(struct idpf_tx_queue *xdpsq)
+{
+	u32 ntu = xdpsq->next_to_use;
+	u32 old = xdpsq->last_ntu;
+
+	if (old > ntu) {
+		bitmap_set(xdpsq->pending_mask, old, xdpsq->desc_count - old);
+		if (ntu)
+			bitmap_set(xdpsq->pending_mask, 0, ntu);
+	} else {
+		bitmap_set(xdpsq->pending_mask, old, ntu - old);
+	}
+
+	xdpsq->last_ntu = ntu;
+}
+
+static __always_inline void idpf_xdpsq_set_rs(struct idpf_tx_queue *xdpsq)
 {
 	u32 ntu, cmd;
 
+	if (static_branch_unlikely(&idpf_xdp_fb) &&
+	    idpf_queue_has(FLOW_SCH_EN, xdpsq)) {
+		idpf_xdpsq_set_rs_fb(xdpsq);
+		return;
+	}
+
 	ntu = xdpsq->next_to_use;
-	if (unlikely(!ntu))
+	if (!ntu)
 		ntu = xdpsq->desc_count;
 
 	cmd = FIELD_PREP(IDPF_FLEX_TXD_QW1_CMD_M, IDPF_TX_DESC_CMD_RS);
@@ -84,7 +146,8 @@ static inline void idpf_xdpsq_update_tail(const struct idpf_tx_queue *xdpsq)
  * Set the RS bit ("end of batch"), bump the tail, and queue the cleanup timer.
  * To be called after a NAPI polling loop, at the end of .ndo_xdp_xmit() etc.
  */
-static inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent, bool flush)
+static __always_inline void idpf_xdp_tx_finalize(void *_xdpsq, bool sent,
+						 bool flush)
 {
 	struct idpf_tx_queue *xdpsq = _xdpsq;
 
diff --git a/include/net/libeth/xdp.h b/include/net/libeth/xdp.h
index 898723ab62e8..ed61d83bda2d 100644
--- a/include/net/libeth/xdp.h
+++ b/include/net/libeth/xdp.h
@@ -430,6 +430,19 @@ struct libeth_xdpsq {
 	struct libeth_xdpsq_lock	*lock;
 };
 
+/**
+ * libeth_xdpsq_to_sq - get SQ pointer from an XDPSQ pointer
+ * @xdpsq: &libeth_xdpsq corresponding to the queue
+ * @type: typeof() of the driver Tx queue structure
+ * @member: name of the NTU field inside @type
+ *
+ * Some of the sending callbacks take only &libeth_xdpsq pointer and no pointer
+ * to the actual driver Tx queue structure. Use this helper to quickly jump to
+ * the latter when needed.
+ */
+#define libeth_xdpsq_to_sq(xdpsq, type, member)				      \
+	container_of_const((xdpsq)->ntu, type, member)
+
 /**
  * struct libeth_xdp_tx_desc - abstraction for an XDP Tx descriptor
  * @addr: DMA address of the frame
-- 
2.47.1


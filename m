Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5089FC282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EE120693
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 12:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbfDPM6b (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:58:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:29568 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfDPM6b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 08:58:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="292005178"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.47.235])
  by orsmga004.jf.intel.com with ESMTP; 16 Apr 2019 05:58:26 -0700
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, bruce.richardson@intel.com,
        ciara.loftus@intel.com, ilias.apalodimas@linaro.org,
        xiaolong.ye@intel.com, ferruh.yigit@intel.com,
        qi.z.zhang@intel.com, georgmueller@gmx.net
Subject: [PATCH bpf v3 1/5] xsk: fix XDP socket ring buffer memory ordering
Date:   Tue, 16 Apr 2019 14:58:08 +0200
Message-Id: <1555419492-16906-2-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
References: <1555419492-16906-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The ring buffer code of XDP sockets is missing a memory barrier on the
consumer side between the load of the data and the write that signals
that it is ok for the producer to put new data into the buffer. On
architectures that does not guarantee that stores are not reordered
with older loads, the producer might put data into the ring before the
consumer had the chance to read it. As IA does guarantee this
ordering, it would only need a compiler barrier here, but there are no
primitives in Linux for this specific case (hinder writes to be ordered
before older reads) so I had to add a smp_mb() here which will
translate into a run-time synch operation on IA.

Added a longish comment in the code explaining what each barrier in
the ring implementation accomplishes and what would happen if we
removed one of them.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk_queue.h | 56 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 610c0bd..88b9ae2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -43,6 +43,48 @@ struct xsk_queue {
 	u64 invalid_descs;
 };
 
+/* The structure of the shared state of the rings are the same as the
+ * ring buffer in kernel/events/ring_buffer.c. For the Rx and completion
+ * ring, the kernel is the producer and user space is the consumer. For
+ * the Tx and fill rings, the kernel is the consumer and user space is
+ * the producer.
+ *
+ * producer                         consumer
+ *
+ * if (LOAD ->consumer) {           LOAD ->producer
+ *                    (A)           smp_rmb()       (C)
+ *    STORE $data                   LOAD $data
+ *    smp_wmb()       (B)           smp_mb()        (D)
+ *    STORE ->producer              STORE ->consumer
+ * }
+ *
+ * (A) pairs with (D), and (B) pairs with (C).
+ *
+ * Starting with (B), it protects the data from being written after
+ * the producer pointer. If this barrier was missing, the consumer
+ * could observe the producer pointer being set and thus load the data
+ * before the producer has written the new data. The consumer would in
+ * this case load the old data.
+ *
+ * (C) protects the consumer from speculatively loading the data before
+ * the producer pointer actually has been read. If we do not have this
+ * barrier, some architectures could load old data as speculative loads
+ * are not discarded as the CPU does not know there is a dependency
+ * between ->producer and data.
+ *
+ * (A) is a control dependency that separates the load of ->consumer
+ * from the stores of $data. In case ->consumer indicates there is no
+ * room in the buffer to store $data we do not. So no barrier is needed.
+ *
+ * (D) protects the load of the data to be observed to happen after the
+ * store of the consumer pointer. If we did not have this memory
+ * barrier, the producer could observe the consumer pointer being set
+ * and overwrite the data with a new value before the consumer got the
+ * chance to read the old value. The consumer would thus miss reading
+ * the old entry and very likely read the new entry twice, once right
+ * now and again after circling through the ring.
+ */
+
 /* Common functions operating for both RXTX and umem queues */
 
 static inline u64 xskq_nb_invalid_descs(struct xsk_queue *q)
@@ -106,6 +148,7 @@ static inline u64 *xskq_validate_addr(struct xsk_queue *q, u64 *addr)
 static inline u64 *xskq_peek_addr(struct xsk_queue *q, u64 *addr)
 {
 	if (q->cons_tail == q->cons_head) {
+		smp_mb(); /* D, matches A */
 		WRITE_ONCE(q->ring->consumer, q->cons_tail);
 		q->cons_head = q->cons_tail + xskq_nb_avail(q, RX_BATCH_SIZE);
 
@@ -128,10 +171,11 @@ static inline int xskq_produce_addr(struct xsk_queue *q, u64 addr)
 	if (xskq_nb_free(q, q->prod_tail, 1) == 0)
 		return -ENOSPC;
 
+	/* A, matches D */
 	ring->desc[q->prod_tail++ & q->ring_mask] = addr;
 
 	/* Order producer and data */
-	smp_wmb();
+	smp_wmb(); /* B, matches C */
 
 	WRITE_ONCE(q->ring->producer, q->prod_tail);
 	return 0;
@@ -144,6 +188,7 @@ static inline int xskq_produce_addr_lazy(struct xsk_queue *q, u64 addr)
 	if (xskq_nb_free(q, q->prod_head, LAZY_UPDATE_THRESHOLD) == 0)
 		return -ENOSPC;
 
+	/* A, matches D */
 	ring->desc[q->prod_head++ & q->ring_mask] = addr;
 	return 0;
 }
@@ -152,7 +197,7 @@ static inline void xskq_produce_flush_addr_n(struct xsk_queue *q,
 					     u32 nb_entries)
 {
 	/* Order producer and data */
-	smp_wmb();
+	smp_wmb(); /* B, matches C */
 
 	q->prod_tail += nb_entries;
 	WRITE_ONCE(q->ring->producer, q->prod_tail);
@@ -163,6 +208,7 @@ static inline int xskq_reserve_addr(struct xsk_queue *q)
 	if (xskq_nb_free(q, q->prod_head, 1) == 0)
 		return -ENOSPC;
 
+	/* A, matches D */
 	q->prod_head++;
 	return 0;
 }
@@ -204,11 +250,12 @@ static inline struct xdp_desc *xskq_peek_desc(struct xsk_queue *q,
 					      struct xdp_desc *desc)
 {
 	if (q->cons_tail == q->cons_head) {
+		smp_mb(); /* D, matches A */
 		WRITE_ONCE(q->ring->consumer, q->cons_tail);
 		q->cons_head = q->cons_tail + xskq_nb_avail(q, RX_BATCH_SIZE);
 
 		/* Order consumer and data */
-		smp_rmb();
+		smp_rmb(); /* C, matches B */
 	}
 
 	return xskq_validate_desc(q, desc);
@@ -228,6 +275,7 @@ static inline int xskq_produce_batch_desc(struct xsk_queue *q,
 	if (xskq_nb_free(q, q->prod_head, 1) == 0)
 		return -ENOSPC;
 
+	/* A, matches D */
 	idx = (q->prod_head++) & q->ring_mask;
 	ring->desc[idx].addr = addr;
 	ring->desc[idx].len = len;
@@ -238,7 +286,7 @@ static inline int xskq_produce_batch_desc(struct xsk_queue *q,
 static inline void xskq_produce_flush_desc(struct xsk_queue *q)
 {
 	/* Order producer and data */
-	smp_wmb();
+	smp_wmb(); /* B, matches C */
 
 	q->prod_tail = q->prod_head,
 	WRITE_ONCE(q->ring->producer, q->prod_tail);
-- 
2.7.4


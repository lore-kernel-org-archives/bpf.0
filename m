Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E85625E1
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098697; cv=none; b=qSndPdrBZjGKUeiWrkvVkKdmtDezZxvr3QDWzybOmDOHSkdryQ//Nx3+FrYGd/DEK5IPMxxhfqvsHn2mrJvv4EuN+6VDa72YdJW7b//2wsjFIjIYC+vvBJtqAk57ls89CFNWXGPX2iA1BDpLdhe0ee0S/uUu0jH68yIuplYt+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098697; c=relaxed/simple;
	bh=BpDy0Q+B3EJV+k+IAamdW+DmPn+p9LF1Y0jblVqAnRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BCkos1U/Md3yShveEZhvYMWyCVC+XqGgHVcpRdTlt3sGT/VdufRsKVzkj3+G6ej9NVYsHBqiMQUQniwypWnFlRPXisg2wL81QYLgvsbQztuoQw/yTPxGoMjBTW7A1cQYsQx3lOPT6Qb/LHJC1DWI71poDcdoFr01EwzO3D9lwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=n/So3/n3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="n/So3/n3"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b63bd2030so68892406d6.3
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792098692; x=1792703492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vNsdGGmxBM/0rEd4hmp6LWXsKxPRAH6Q547gkcbLIac=;
        b=n/So3/n3IFvEv6sW4pIGSj8LeUqo3s/ROJznrJjsr9toJnmY23QJB2YUJnH42AkQL3
         wetiPa6+tALAkOUUWlEzIt9wvLP38xOffVUNDpI/wfNxUuDh7RjxnBK/EZttaIz6d48J
         aPKCj0EejOn+jRqXC0inavTboA/CBZkAhqvQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792098692; x=1792703492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vNsdGGmxBM/0rEd4hmp6LWXsKxPRAH6Q547gkcbLIac=;
        b=YHnGfvYErABQLhqanR+i/Dor4JgMHvfbdoL/q5wW7FLRMZJgyYrAksCOEk4evPqMO4
         4kXWHkbpbP4DOveuldHy4M2JFL1cyGpTXVtZHyMuiSo0LQe/qkZQ8+hjaPq98BvpB4sU
         VamzmevOG95aiB0TKOJPnEX3z476MeRIqZRHTeUZbJ4DCMrgTBZXs8f+/BoeI4egf86f
         LrLa6YAsmf8mU2kgvcYHAX1nrg2o45Plxyakmpx+5Y9IRKPekQs6Yn9OxWC1zMRC+ZLu
         pcUXWoxcmkM1XYFRiNBjKQr26eI+2bX5KiWFC0NaLm5tCXufKcNVvrvvoONbkYTkdKub
         0IXg==
X-Forwarded-Encrypted: i=1; AKwUvBw2Yg9GHnifLcqj37sbrqswcSAwHVfk1LXGcUGQ3gw+a7dIIsZvtUHzjM7cb82XDT3mrrA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLsTVpiwf0ijdbXRi8NR2zaIGnHvT10ikHnxVReeaoEDUT6D8AG
	6CKlO+cD+oSTHvCLyuqNNzXSGMIiYzUTEcV/021r+XAYH36nOetlZDE15lh9s+jImw==
X-Gm-Gg: AYBFou3fTiN0Lu5w/3MBdKjUXCMmo7LUo53fh3SPxEFmKRBDyPHIMbxwk0Sfthvbbp/
	qsK4/N6da/BIaBxZGQ/Kxp0eJoHZP7Qh2N2iDurwT4ZqLlklg9mpAeVLm6xkU6NCBq+K12by31T
	gBwThA/+Hpvvg4MR/tmp2u8u/0BaIcuBBsvuhoX55iMokUJzkGeRuBy72wKGU+eEbAhJBsd9FaL
	t+aOEQ2sZSneJfxuC1S2OBfvOAHKm8bTx49800WMDt/Tvn+E9VbUGN9xtr0nVBBc8RcxS4IfK63
	L0q0qmfw6tM7uHHDmwUSHiNbHPofx8/ndOB9NNEKJvkp1TrjNDhskaiwFG3XBiV2t5O/c/H3T/r
	4uthDCqvPw7sBpd7wBcgp7+2QUJ0hOihlgijJGfkdrNtD73kgGfbVwJvI0KeTUYyZDISUdF/v7y
	1py7D4uaOQS//wxnb6wWt5SA33pHVGnF5hBbEazdmn2edm7KTEC+cAPXYa5T8jIky9QX6wBgFvO
	iB5qLweG1bEcDWWGuPR4o9oCa6wNr9zwtgW3TiY+O5h
X-Received: by 2002:a05:6214:5085:b0:912:517b:40e7 with SMTP id 6a1803df08f44-91b557ccb37mr349370616d6.46.1792098692267;
        Thu, 15 Oct 2026 14:11:32 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8b6865sm5673036d6.2.2026.10.15.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:11:31 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Thu, 15 Oct 2026 17:11:27 -0400
Message-Id: <QDISC-MD1X.v3.r0.20261015165943-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue was caught by Sashiko (nipa). A producer-side path cap is
already merged (ea4d4b5dddb5); this patch adds the matching consumer-side
cap.

The issue:
The tx queue is picked and capped in netdev_core_pick_tx(), before the
__dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
that store is never re-checked. bpf_convert_ctx_access() bounds it only
by NO_QUEUE_MAPPING, not by the device's queue count.

On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it with
just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
allocation on non-lltx devices such as ifb. Drivers that index their rings
from skb_get_queue_mapping() (ex: ifb) go out of range the same way.

The Fix:
Cap the mapping at the consumer and write the capped value back, so both
the qdisc's _tx[] lookup and any later driver read stay in range. The cap
folds into the dequeue path instead of a separate walk over the returned
list: dequeue_skb() caps the head, and each bulk helper caps the element it
appends. netdev_cap_txqueue() already logs a ratelimited notice and selects
queue 0. The single-packet case pays one extra compare against
real_num_tx_queues.

A bulk-dequeued list is transmitted under the single tx queue lock of the
head skb, so every element must belong to that same queue. The fast bulk
helper (TCQ_F_ONETXQUEUE, taken on BQL devices by the per-queue children
of mq, mqprio, taprio and htb, and by any qdisc on a single-queue device
such as the prio root in the reproducer) must therefore compare each
capped follower against the head and requeue a mismatch, exactly as the
slow helper already does; appending a follower that caps to a different
queue would send it under the wrong _xmit_lock.

Conditions to recreate the bug:
Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapping
(a tc BPF action is enough), attach it to a transmit qdisc (for example a
matchall filter on a prio root), and send a packet. With a 1-queue device a
store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=1
the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so the
trigger is root.

Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 -> v3:
- Considered Comments from Simon Horman (hunk counts did not match the
  diff content; patch did not apply):
  https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/

v1 -> v2:
- try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) capped
  each follower but appended it without comparing it against the head, so
  a mismatched follower was still sent under the head's txq lock. Compare
  the capped follower with the head and requeue a mismatch to skb_bad_txq,
  matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
 net/sched/sch_generic.c | 49 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..6b548099b55d 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,31 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 
 #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
 
+/* A tc BPF program on a transmit qdisc can change __sk_buff->queue_mapping
+ * after the tx queue was picked. Re-cap it against the device and write it
+ * back, so a driver that re-reads skb_get_queue_mapping() stays in range.
+ */
+static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_buff *skb)
+{
+	u16 queue = skb_get_queue_mapping(skb);
+	u16 capped;
+
+	capped = netdev_cap_txqueue(dev, queue);
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return capped;
+}
+
+static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
+					     struct sk_buff *skb)
+{
+	return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb));
+}
+
 static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 {
-	const struct netdev_queue *txq = q->dev_queue;
+	const struct netdev_queue *txq;
 	spinlock_t *lock = NULL;
 	struct sk_buff *skb;
 
@@ -110,7 +132,8 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		/* re-cap: real_num_tx_queues may have shrunk */
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -208,6 +231,7 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 				 int *packets, int budget)
 {
 	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
+	struct net_device *dev = qdisc_dev(q);
 	int cnt = 0;
 
 	while (bytelimit > 0) {
@@ -216,6 +240,15 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		if (!nskb)
 			break;
 
+		/* Re-cap a mapping changed after pick; requeue a
+		 * follower that no longer matches the head, which owns
+		 * the _xmit_lock for the whole list.
+		 */
+		if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=
+			     skb_get_queue_mapping(skb))) {
+			qdisc_enqueue_skb_bad_txq(q, nskb);
+			break;
+		}
 		bytelimit -= nskb->len; /* covers GSO len */
 		skb->next = nskb;
 		skb = nskb;
@@ -233,7 +266,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
+	struct net_device *dev = qdisc_dev(q);
 	struct sk_buff *nskb;
 	int cnt = 0;
 
@@ -241,7 +274,11 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 		nskb = q->dequeue(q);
 		if (!nskb)
 			break;
-		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
+		/* A tc BPF store may have changed the mapping after
+		 * pick; cap it and keep the list on one tx queue.
+		 */
+		if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=
+			     skb_get_queue_mapping(skb))) {
 			qdisc_enqueue_skb_bad_txq(q, nskb);
 			break;
 		}
@@ -286,7 +323,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +359,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	skb = q->dequeue(q);
 	if (skb) {
 bulk:
+		/* cap the head; the bulk helpers cap every appended element */
+		qdisc_cap_skb_tx_queue(qdisc_dev(q), skb);
 		if (qdisc_may_bulk(q))
 			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027748;
	b=4DST2V8DF2ysAzv+iSsJ8hsPQDBE7jS13KVAqPhERHLsf0+W5LbDeEWZLeozjbzAVKfH
	 7E71/BAK5f02SuB7cubYCCInXy95vuOgHRyPWVGwTRJ8lsvLdTi+wRsCbbhYtNAN7lxR6
	 GkitOrQy05XcVCoXQX/KH/Xo7i0V2KNyYbZm2hILjcqNGGn66o+5caMp9Y6OYr3H9fkr3
	 BApS0XClO2JwvB7OF3993G4DzpbR+ccyY8t25BMhZY/z2RW2hKdOrpmLkl0YQkGTmGYzc
	 PErGt++aRrn0AaOUAUMi1sJfuyJipEfz/7bQRhiF/Xw3sEif5AV5kmiLh+Edb6F3VHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
	b=18k56z4Us5RAuTvuPCaMLj7hiv0S6pXM3RJEDRWH2XxbatLDoFGC7H2hJdpqvdnX9qX8
	 VdSRE3lfwxF2siiqyt7OpVtBWWOAW2eMXaVrLr05dJY9qyZKlCdDOOKGREcIoe8qVX0oh
	 cPZ8wcVG8ItcAqRSlvs03VmEHWBjly8ASygGwKeIZ/oFjiunfA3oDl9s5QuQYU8jzSztM
	 CGRMNAUqZSo5pFLQZU7uM2Pk6M09Ftz6OgUf+0X1xly+c66oSUxSsw6YxtU5Dd1B7KNqb
	 hyu1mktTdSiXAE62kCi8hhUa3mo97qlIPLT4cwkCfWfJEygwlyRBxNZmUSOyYNm0F1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ct0a0XEc;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0522606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0522606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ct0a0XEc
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93a40a9a01aso162885a.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793027746; x=1793632546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
        b=ct0a0XEc/nenkWFneYT1Lzoh/M1nXpe/Dou+E3bVRkdY8gbgv5mnREqm+9WkouGUZ4
         atfnk8FmZ0JCkwR/q4Kj6z7fK7sbDAmNavEaO/46DEMfFqt0ImhYdgsdJOTGylripq1v
         udStlBZ3Z016zm94f8fT6s1D4jCvtJkVH1w9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027746; x=1793632546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
        b=XXiL1Vh0Asm8X6Tl7+swyitUL/g+Nx9aNfDpbwYiLr6q+wzTnPf17w+3mEtdzRzZuL
         pk6waGSdyT8ZYJNKADx+pd0jRVm2rVnkgtuKs0dckSOMkV66ZqI41PywA0ORLmMzSSCf
         mhZaWZb/UmiJh+URV4H38ywurE1bmnngaHEndKuHqmYFdiQWVPOaoZB2l67b4Kaytt73
         XQuoOAXw+147riHfAe5dva2ftgLSFiBbbqbLrYJvJBzkoiA8DyQb9kSmvfmWH0Dgri3U
         HxVfFR1fvbDoRwQ8AaatwZeWQkbOcPx+h3NUhVggExPMEu/fB21wKDLGe+lR1AF14qqM
         PdKA==
X-Forwarded-Encrypted: i=1; AKwUvBwgJHyIAQLToArDfqfY8UvZx74dSO7B4JG/HqOgdt0Qu6oAq/DTXzeUZ/CkqmW5nNTMUDY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIdIhjqlWgsji9RBd+dBSoin9+idiqyNmJxxJrqASx1Sd8AJYM
	MofiFw2hpD7SiMvH4FQClvdDFBSnRm9SqSEyZtkvd6EMztctZVQ7vhB77KnkZCjAwQ==
X-Gm-Gg: AYBFou1VtXU6Z2LFpSGxPKVMSNhjGG+S4MV3qDZvWHYRL3+LI//OeYEpz+vvq8ey3cH
	hHuSG5CTL6ifqOE3LZVAvptZjmPUlvpdMrJOoiwKErgHS90l63W6RAUoHWpy4lkNnyu9VAo26LG
	v5vVkWo3tBtSto+lSDNyKgWXE3rqVasuV5O5o6gx+5BS17yNeXAghbhVQIHD2/CZZbIdDbIKPWY
	4SBPcVBfO2VqijMJGm1xr+RkCyVMOlnBrkmgQNWdoVh4UwuOE/W0Nea/wvI8PKrHGNi3pF+ufAr
	Gpf+uspPNQGyCFfy6XEN1b1kbfK5lGCN5+JuPtDsc5UuYs0yU1DgzP1x3BOddrSmxVBPYYk4naX
	1Jbq6e7HVIbj7AtQS0iETE3ShcpPIAW47fMtFGuMHWgOV4YOUBhT/b1vpIeAN3YeoMycmwrlFsN
	hTzwBw/r7GoG81D1BaItFXcx2rQomZ059xR9FE9KdlJzXlUwfMg8uKL+ThZd4kpoakPFEOvD8Cd
	lMI4e43oL1LVXl72DKVWtXDDcRPhf28SPNJylqTfpE54tWYCEAIwr7D+/c6wVHvsIHF1K948INX
	b/9n40FWiLpmjGwI20yi6MNdUhGd2g5Ua8YWwgxF5Q==
X-Received: by 2002:a05:620a:450c:b0:93e:4c1b:a084 with SMTP id af79cd13be357-940efaacc56mr985762685a.7.1793027746468;
        Mon, 26 Oct 2026 08:15:46 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067e3f0sm712706685a.22.2026.10.26.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:15:45 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Mon, 26 Oct 2026 11:15:41 -0400
Message-Id: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue was caught by Sashiko (nipa). A producer-side path cap is
already merged (ea4d4b5dddb5); this patch adds the matching consumer-side
caps.

The issue:
The tx queue is picked and capped in netdev_core_pick_tx() before the
__dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside an
egress qdisc (not clsact) can then change __sk_buff->queue_mapping; that
store is never re-checked. bpf_convert_ctx_access() bounds it only by
NO_QUEUE_MAPPING, not by the device's queue count.

Two consumers read the stale value:

  - On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
    indexes dev->_tx[]. netdev_get_tx_queue() guards it with just a
    DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
    txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
    allocation on non-lltx devices such as ifb. Drivers that index their
    rings from skb_get_queue_mapping() (ex: ifb) go out of range the same
    way.

  - On enqueue, taprio_enqueue() indexes q->qdiscs[] with the same value;
    the array is sized dev->num_tx_queues. A duplicating netem on a child
    qdisc clones the skb and re-enqueues the clone at the taprio root
    (qdisc_root_bh()) through a direct rootq->enqueue() call, so the value
    reaches taprio_enqueue() before any dequeue cap runs.

The Fix:
Cap the mapping at the consumers and write the capped value back, so the
qdisc's _tx[] lookup, the taprio q->qdiscs[] lookup and any later driver
read stay in range.

On the dequeue side the cap folds into the dequeue path instead of a
separate walk over the returned list: dequeue_skb() caps the head, and
each bulk helper caps the element it appends. netdev_cap_txqueue() already
logs a ratelimited notice and selects queue 0.

A TCQ_F_ONETXQUEUE qdisc is bound to a single tx queue: dequeue_skb() uses
q->dev_queue for the frozen check, the BQL limit and the trace point, while
qdisc_restart() transmits on the skb's queue. Capping an out-of-range
mapping to queue 0 would therefore send a per-queue child's skb through a
different queue than the one it was dequeued for. On mq, mqprio, taprio and
htb offload children, a stopped queue 0 could then park the list in
q->gso_skb, and the later wake would schedule queue 0's own child instead
of this qdisc. Pin a TCQ_F_ONETXQUEUE mapping to the qdisc's own queue to
keep the documented invariant.

That also keeps a bulk list on one queue by construction: every element of
a TCQ_F_ONETXQUEUE qdisc, including a follower changed by a filter, is
pinned to q->dev_queue before it is appended. The fast bulk helper
therefore needs no head comparison and no skb_bad_txq requeue; the slow
helper, used only by non-ONETXQUEUE qdiscs, still compares and requeues a
mismatched follower, where a wake on any queue reschedules q.

On the enqueue side taprio_enqueue() caps the mapping against
real_num_tx_queues and writes it back before selecting q->qdiscs[queue], so
a duplicating child cannot steer the clone out of the array.

Conditions to recreate the bug:
The dequeue path: load a SCHED_CLS or SCHED_ACT program that stores
__sk_buff->queue_mapping (a tc BPF action is enough), attach it to a
transmit qdisc (for example a matchall filter on a prio root), and send a
packet. With a 1-queue device a store of 1 indexes one past dev->_tx[].
Under KASAN with panic_on_warn=1 the unfixed kernel faults with "BUG:
KASAN: slab-out-of-bounds in sch_direct_xmit". Loading the program needs
CAP_BPF/CAP_SYS_ADMIN, so the trigger is root.

The enqueue path: on a multi-queue device, install a software taprio root,
graft a prio child with a duplicating netem on every class, and store an
out-of-range queue_mapping from a matchall+bpf filter on the prio. The
duplicate is re-enqueued at the taprio root and indexes q->qdiscs[] past
dev->num_tx_queues; the unfixed kernel faults in taprio_enqueue_one().
Same CAP_BPF/CAP_SYS_ADMIN requirement.

Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://lore.kernel.org/netdev/179293123940.3134.1149128679923234677@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r0.20261021042722-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v4 -> v5:
- Fold in the enqueue-side consumer: taprio_enqueue() indexes q->qdiscs[]
  with skb_get_queue_mapping(), and a duplicating netem re-enqueues the
  clone at the taprio root before any dequeue cap can run. Cap the mapping
  against real_num_tx_queues before the lookup. Reported by Sashiko (nipa).
- Call out the TCQ_F_ONETXQUEUE steering change for stable users: an
  in-range mapping set by a filter on a per-queue child is pinned to the
  child's own queue, restoring the documented invariant. Reported by
  Sashiko (nipa).

v3 -> v4:
- Cap a TCQ_F_ONETXQUEUE mapping to the qdisc's own tx queue instead of
  queue 0, so a per-queue child of mq, mqprio, taprio or htb offload keeps
  the documented invariant between q->dev_queue and the transmitted queue.
  Reported by Sashiko (nipa).
- With every element pinned to q->dev_queue, the fast bulk helper no longer
  needs a head comparison or a skb_bad_txq requeue; a mismatched follower
  there could otherwise be stranded behind a stopped queue that cannot
  reschedule this qdisc. Reported by Sashiko (nipa).

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
---
 net/sched/sch_generic.c | 41 ++++++++++++++++++++++++++++++++++++-----
 net/sched/sch_taprio.c  |  5 +++++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..5dc1d47f811a 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 
 #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
 
+/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue. */
+static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb)
+{
+	u16 queue = skb_get_queue_mapping(skb);
+	struct net_device *dev = qdisc_dev(q);
+	u16 capped;
+
+	if (q->flags & TCQ_F_ONETXQUEUE)
+		capped = q->dev_queue - netdev_get_tx_queue(dev, 0);
+	else
+		capped = netdev_cap_txqueue(dev, queue);
+
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return capped;
+}
+
+static struct netdev_queue *skb_cap_tx_queue(struct Qdisc *q,
+					     struct sk_buff *skb)
+{
+	return netdev_get_tx_queue(qdisc_dev(q),
+				   qdisc_cap_skb_tx_queue(q, skb));
+}
+
 static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 {
-	const struct netdev_queue *txq = q->dev_queue;
+	const struct netdev_queue *txq;
 	spinlock_t *lock = NULL;
 	struct sk_buff *skb;
 
@@ -110,7 +135,8 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		/* re-cap: real_num_tx_queues may have shrunk */
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -216,6 +242,8 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		if (!nskb)
 			break;
 
+		/* Every element of an ONETXQUEUE qdisc is pinned to q->dev_queue. */
+		qdisc_cap_skb_tx_queue(q, nskb);
 		bytelimit -= nskb->len; /* covers GSO len */
 		skb->next = nskb;
 		skb = nskb;
@@ -233,7 +261,6 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
 	struct sk_buff *nskb;
 	int cnt = 0;
 
@@ -241,7 +268,9 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 		nskb = q->dequeue(q);
 		if (!nskb)
 			break;
-		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
+		/* A tc BPF store may have changed the mapping; cap it. */
+		if (unlikely(qdisc_cap_skb_tx_queue(q, nskb) !=
+			     skb_get_queue_mapping(skb))) {
 			qdisc_enqueue_skb_bad_txq(q, nskb);
 			break;
 		}
@@ -286,7 +315,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +351,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	skb = q->dequeue(q);
 	if (skb) {
 bulk:
+		/* cap the head; the bulk helpers cap every appended element */
+		qdisc_cap_skb_tx_queue(q, skb);
 		if (qdisc_may_bulk(q))
 			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39ac5b97aa3a..0eb0803047a1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -632,6 +632,11 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	int queue;
 
 	queue = skb_get_queue_mapping(skb);
+	if (unlikely(queue >= qdisc_dev(sch)->real_num_tx_queues)) {
+		/* A tc BPF program may have stored an out-of-range mapping. */
+		queue = netdev_cap_txqueue(qdisc_dev(sch), queue);
+		skb_set_queue_mapping(skb, queue);
+	}
 
 	child = q->qdiscs[queue];
 	if (unlikely(child == &noop_qdisc))
-- 
2.43.0


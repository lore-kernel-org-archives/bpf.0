Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306196;
	b=BJd3n1cXrPWBWEpdhrVZgZsXqhEIdpDFr9VIWeYgDkB24wNrHA48m29mFLnX2v8dM7uH
	 49qnS5Luud5ZoTjrb5HB1PR56ZrO7FnzUh5qc7M/4DSTlqRJFfMCU5yqi8BPx28GgK6Zy
	 6NCd7/hJ67r1WB/fcXGuphozRxNclBxs5gPUfvAdSZ78HqbUwAdqSgPmCaG1CEqX7TmZD
	 mlAbFhKV3giY6v4SaslDgmC8v6RNEM1P3lrNQ75ZNVVkzIHBPHZK/qIuf/ywId3nCjz/B
	 eKGTh6oyHdG8WpllDsCRwcAR2PTB8M6i0VvfZNTFuRatIHYxqfr9OBJP4Lmpf571GXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AuIb6GGgaOQAFc0N/8ej5YAVB0d0El1YMXuRgdGto0M=;
	b=KE73FIVL4nALvMIhImfbEdwpVGuQ4vwfaMJkaRAvmT04HQpn0BsF/2tc8ZHUGA/AWY0y
	 lswchriLP58sjmcJup/LjG4/TTBBB3t5kBECmPWA4kqtqQQ6Gz4XW/syHf5kKc0RYB9aJ
	 DDq8kWJh1EilqwgK7jDz8XEnlIFSKmoN2+0dpyYtWzkSuv2d9H2CbSVhH+K9SMlyQ9AvQ
	 +84S6aQJsUW/gqZNbnl4luW508NyviEdeNKbWHexJ3Uayo4/PHBy6f5goTHPpI+rQf1tb
	 SbsN5q6N2xPyUOYpZ+5SRhv34Wy66mv2ig6ebGYny6x8UWOR89I9ySg5cps+wZ3iPJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="EN/712Yl";
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC64606A324
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 20:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC64606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EN/712Yl
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9440304604aso5954985a.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793306195; x=1793910995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AuIb6GGgaOQAFc0N/8ej5YAVB0d0El1YMXuRgdGto0M=;
        b=EN/712YlYzEuqQTvmZJ4l04bhee3YnJGuwjWPYDUw6xPXyJS3SRBSqG4V6suH3+ovD
         ld293FIamD2CdgivfhfmZOd52DIF2cJ/v7uP+4zYkiHOc83qFopwzfEgg79kDZdHVHFi
         P1Y+sct78IU+zQH+kyOhZLfiYTY4rZnMC8uwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306195; x=1793910995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AuIb6GGgaOQAFc0N/8ej5YAVB0d0El1YMXuRgdGto0M=;
        b=pADwIxPjWMyWAG4AcIJlhoT4nkU9SbLtEIaH4LUh31jtxpsr+eA0WxZ5kAVPN8zfxl
         wjhEOoIjiDGUyFvO8FVckcQcjjV4U3978Q/80rsqP+2LSn+rMly6gUWMHI+WXf7K+tkz
         GtgieTiqZ9XLx/6oyxj+q+yHSznArHUVqAEat6uoiJxx3te/wVPIT8tO+Vt4Wl1lZfKR
         vbte5otUE3wtJ+TJWf6XQA4fZpV8z4VvDHAYG4wj3LoSNSstAy0P5ErOy0tEwgO+0qqT
         fbjh3QcN1KrH9+YuH7HQbRgzSAJgXtkU143UYJwTjGrD24wo3Xfw89Dlrwu6dnHYZdn3
         uRsg==
X-Forwarded-Encrypted: i=1; AKwUvByRE9r/Y/Ir6aQ1Bslv7AMMiZUC58KAYyUZWmS4ah6SH1agXke9PKpg22l3G8cN1TNYjEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIYZC9ocf8+ksbGhZbyON2bGl8yFwCXZNA8GPOgvcjmy8DTxUg
	HxpumlJIXRDxvJeosQAGg+FtpK+ZZIYxFJFTBj8Vht96DaBOmNAFu8C1OqF4tjTfhA==
X-Gm-Gg: AYBFou12Fyfv6H4dlHmh/UpqPL1irUcRdPxK4OCviuttG5pOOTV9mgI2JULAvEk1bH7
	0pevhzmDS/7J0ERhptbq3akXvP7df7RxTVQwvVFL5xKOrF3cHZzVBE3DUMB47KoYZypOoe94XFQ
	KSZWlOLvBdhsA8JDLl4bYOM/SeZrD8xTNOz7FZTvCIZuPMllFWr26yvBVKxD1rvVgKus4DWyCAr
	qbFrUL11CC09XuZbocwfEQvLOaVBxNgeN3UWIAwHKRy16Kz7HFcO/lGeV8bWIKJo5kHJReA8zkJ
	31BrDuUrTSapsI1kzVLjyf+XamtrNFrI6C+A95DebutuMDkzocPNCBf73P9lOPd2K+0odRwRYo1
	rzvNWg7rwPhVoj0r6/GMO53ZbZ2HbGbss/yghfcOlRGeUkMk630uXnUNsIG0MdBCnnTgEDHPsm1
	Oen+TRc3137W5pkCarY5qTcmdb6IA3aCOTvGTTeXmbpUJzg+yMltcYZGXZ5TlOmSIHsn+Z/lbIz
	yW0yWecL4yt1/urlEApr6k/ezs1T2zXZl0oed5hWFDljBEkAdOOEgJzZw0BisFkAXyobdMJMnWa
	g57RPZ13LUJvHVKPp5bOkhy79PPvAzgTJ19sgyWZOkObt4g1k9r7pGI36G21EY44vQYSa8Q85l8
	=
X-Received: by 2002:a05:620a:46a8:b0:943:7e61:fd9f with SMTP id af79cd13be357-94413267f0amr567415385a.1.1793306194969;
        Thu, 29 Oct 2026 13:36:34 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-944211e2b4asm34696885a.12.2026.10.29.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:36:34 -0700 (PDT)
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
Subject: [PATCH net v6] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Thu, 29 Oct 2026 16:36:31 -0400
Message-Id: <QDISC-MD1X.v6.r0.20261029162633-1@mojatatu.com>
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
each bulk helper caps the element it appends. For a qdisc that is not
TCQ_F_ONETXQUEUE, netdev_cap_txqueue() logs a ratelimited notice and
selects queue 0.

A TCQ_F_ONETXQUEUE qdisc is bound to a single tx queue: dequeue_skb() uses
q->dev_queue for the frozen check, the BQL limit and the trace point, while
qdisc_restart() transmits on the skb's queue. Capping an out-of-range
mapping to queue 0 would therefore send a per-queue child's skb through a
different queue than the one it was dequeued for. On mq, mqprio, taprio and
htb offload children, a stopped queue 0 could then park the list in
q->gso_skb, and the later wake would schedule queue 0's own child instead
of this qdisc. Pin a TCQ_F_ONETXQUEUE mapping to the qdisc's own queue to
keep the documented invariant.

The pin covers every mapping, not only an out-of-range one: an in-range
mapping that a filter sets on one of those per-queue children is rewritten
to the child's own queue, and this path does not call netdev_cap_txqueue(),
so it logs no notice. On a single-queue device qdisc_create() sets
TCQ_F_ONETXQUEUE, so the one-queue trigger described below also takes this
branch and is corrected without a notice.

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
Link: https://lore.kernel.org/netdev/179329777513.3134.12135506558709584471@kernel.org/
Link: https://lore.kernel.org/netdev/179293123940.3134.1149128679923234677@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r0.20261021042722-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v5 -> v6:
- Describe the TCQ_F_ONETXQUEUE pin for stable readers: it rewrites every
  mapping, including an in-range mapping set by a filter on a per-queue
  child, and that path does not call netdev_cap_txqueue() and logs no
  notice. Scope the ratelimited-notice sentence to the other qdiscs.
  Reported by Sashiko (nipa).

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


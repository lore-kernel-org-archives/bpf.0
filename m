Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DB4F3EA1
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569352; cv=none; b=CLwx54tSOGNWEzWmRj7jbBSPX4LBOV8TOXwUBImArJgm+XaG6lxN1IX+dwJJGhGAYwDK6hFlX5eGJCPE6oXCrgzV9/HMqiQ96Co6aHIWoMz65Dv+VHWQtcJuFNwpOn8uZJPfq2on8XRERz18pc5LxbYZ64lHpnsajBl7fn9Pquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569352; c=relaxed/simple;
	bh=7Uosb9Zcj0EuJ9/AeETYiueCovxfBDks8QS+romqhkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suWPn3kvOUO27DARJ0wAxKx+gNjEEU77nWkJR2jb18GUHvbKhEeGIIbBR+WzYly4mPY1aagWZ5sM/imNpNb7Voj6wqS86/7EmkVkXOpbIopPA1eL7dRdI2PciXv+BSQap65XBYS5um5gQVXRqYo66NG/OyXks4hzYOPaH0jqZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=fwF7O3hu; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="fwF7O3hu"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91054f537ccso1208096d6.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 11:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791569348; x=1792174148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x4zLqaLOwYeBrjRP7ipUvDwTZueZzw1YjG5Ql3Qu6KI=;
        b=fwF7O3huaCxWbwvIqOsX/PrIdB2xm6CkHqyB13etDYWWFL367Gorim2enn1H/Pxwth
         g4pw9tLFbyPjdnHTwh+2q1GYoXGiw0qCBFDRV9aUJiwr4yT4Ud2n0M7+buBCamft+Kt/
         iKsRsJwnzDcsVVInpjkJoSlkCNuv8rIQDQUHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569348; x=1792174148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x4zLqaLOwYeBrjRP7ipUvDwTZueZzw1YjG5Ql3Qu6KI=;
        b=uM8rEaKP0Eu4A5Z4SIOngiHXz2Df4yWVUf3DW5cOF+kE93eOrw7ln7TLh6WznodvgK
         n8ZtneZrJDpUrKcbcH4r1O+7Q/cLsy8G6ONxkcTxaU99jXawBhS6OmgtXWcaLXmJpfo3
         HrTvEny9NswJiSnvfPfzeGtHLlyrfMowGrsfFMkMOecxIHP5kM2SNPg9lhBLS4tHerFa
         J2I5RrGw6IuBPrXUDrINBPOpWE/kYLTVHxAP3GUKW39UGhBPIynqWNLAC/IjuR8ZvGQg
         1tA5YPbtfq+GqJC+AD5J/MHs8OPnHeOzTAxSlSH7VcP7jTYkmESZxp7rUy3YImaXyZfX
         d4Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzptUvrJ/lHUstIbOHirWtvlTbK4mGxoe1WimC2SI/mEk3dTXx8mYz7l6VPu2JszH/79U4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1/MxFV2vOcrEuyXtJuUbyCoaqCG7azQpqmAzMBXXpC+8i80w1
	EuNbzEV/9IpDUOfJ/R6DZ39Pr+Hx8e39L/OZvnd5aCE19gn109ePgMhqALkP/RAjng==
X-Gm-Gg: AYBFou2REyuE6DLpqzo+wmMYX2iV8+kN37+zqFXqiyZhTuPRiMWAY3uyCp8UpcbA+2M
	ZcPCaKEBXnaun+NADRRONhcluQYX+e2WTKf5KaLXyi9LOv/RWeyxAHkm94mMJrflu2Qq5blmMUG
	3Ms8PIEd7P1L0+PP0ZMIqocx3QIg0kTyV89hPyd1+JqqPb5szZw4P9X/Vocv7HVmETByLuusAR/
	EIsEytAzQaHUFRi1b5LSnIrj10sO6cUcQ2qL3k5BKPt9NY6WUzIIBNWKYPSyd+wKULWSVSyCsBK
	84EG9oj0EYW60Py67sjyyiB4mtva4ot3SHgXHTKdL+zm4FPVn7v9NXfBZXbYQU/viKULYcE7qjF
	SMoz08+ADBL7b/W5ZHXx+TwrBdECnkak6KTsfgtkB/xusLVaKm1PKAb0WIOkCfFmwkGMULlqQ1n
	hrWA0V08E6J4zkrE52PiY6tRdvHWy7N4sG4iKvoS8Cr1ArfsH/2sjhF+Ydd0jsxF2/3LaD+pYgv
	TDunYxz6ts13m/JPpzvWFozS3R3qPFMIzs2PoIvfxrq
X-Received: by 2002:a05:6214:43c2:b0:91b:5d3b:4ac7 with SMTP id 6a1803df08f44-91b5d3b4d8dmr33796596d6.48.1791569347775;
        Fri, 09 Oct 2026 11:09:07 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5511fdecsm24476976d6.48.2026.10.09.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:09:06 -0700 (PDT)
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
Subject: [PATCH net v2] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Fri,  9 Oct 2026 14:09:03 -0400
Message-Id: <QDISC-MD1X.v2.20261009135842@mojatatu.com>
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
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) capped
  each follower but appended it without comparing it against the head, so
  a mismatched follower was still sent under the head's txq lock. Compare
  the capped follower with the head and requeue a mismatch to skb_bad_txq,
  matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
---
 net/sched/sch_generic.c | 53 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..b65bec7e2643 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 
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
 
@@ -110,7 +134,8 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		/* re-cap: real_num_tx_queues may have shrunk */
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -208,6 +233,7 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 				 int *packets, int budget)
 {
 	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
+	struct net_device *dev = qdisc_dev(q);
 	int cnt = 0;
 
 	while (bytelimit > 0) {
@@ -216,6 +242,17 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
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
@@ -233,7 +270,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
+	struct net_device *dev = qdisc_dev(q);
 	struct sk_buff *nskb;
 	int cnt = 0;
 
@@ -241,7 +278,11 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
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
@@ -286,7 +327,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +363,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
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

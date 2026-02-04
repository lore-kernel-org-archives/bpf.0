Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8E346E5E;
	Wed,  4 Feb 2026 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224588; cv=none; b=hcPWFAU0Z5q3kNqk2cPK441dWX5Ow7IZmI2YLh/Yf4LIdf1TD+IUqb/CGH8jBcwpaAVA1fxLfH5ZMHl0Pj0dUI+8HPK/uokmkAMwEWcjUA8i+LrRNWvZdn0CmBLGvPgILILa9+Wy0kA3lvvvSuVoQaBQ9Zs9BA3Z85B8ewr8fvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224588; c=relaxed/simple;
	bh=z81NQV5x/XtshDxPXORrCcidhxsYV4xJSVhUGc4VeMA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgbBVyCuJTjoHfBS2hA8Bt8EOl6RADejZA5/51EIPcYB4uc71mgd+flFw5y5r1U1MIW0he40CdpTWhL0FmWHakB6G5hd7QqZxMLnLT3dZnFnLZB6x0rE6MCVrJra0zqrrYpeOc8mVwLrixLZWxMkB27l2kfA1pSerWdMjOYtkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8RoyRHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8RoyRHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93063C19423;
	Wed,  4 Feb 2026 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224587;
	bh=z81NQV5x/XtshDxPXORrCcidhxsYV4xJSVhUGc4VeMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a8RoyRHFjIdSboxV7B5hdjhIflZlv+j+3tOzF8rmJxlDpQWbaiwc12XrSVz8d3YbZ
	 LsDHzjSqHrw40C3vY+XPHw+d81HO7BdpQeBzRKW4AxmRMq+OvGmM5axbpT0hN3tdks
	 Zcx58UnAsi5bbXwxu5LGAnc+ZJSA8Rk0hthXRH7QwlwcFLD+ZTCCPFG1vq1d8G/+8a
	 zdWDmN8NKGipCf9Hk3hJnv04nlhOAuqzzO7QqHy2GVguiBmnRN9cBXzYYk4KnjaNkL
	 2Ka4cAVj2wmbx6pR2tQX2bMXYNWg5sC720QRfQJE+kExIwYeRWdqOicslzWahZ6lnB
	 5goze9kRFMVvQ==
Subject: [PATCH net-next RFC v1 2/3] net: sched: sfq: convert to qdisc drop
 reasons
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
Date: Wed, 04 Feb 2026 18:03:02 +0100
Message-ID: <177022458258.1827734.18192185731352302528.stgit@firesoul>
In-Reply-To: <177022452988.1827734.5121740962985640333.stgit@firesoul>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Convert SFQ to use the new qdisc-specific drop reason infrastructure.

This patch demonstrates how to convert a flow-based qdisc to use the
new enum qdisc_drop_reason. As part of this conversion:

- Add QDISC_DROP_MAXFLOWS for flow table exhaustion
- Rename FQ_FLOW_LIMIT to generic FLOW_LIMIT, now shared by FQ and SFQ
- Use QDISC_DROP_OVERLIMIT for sfq_drop() when overall limit exceeded
- Use QDISC_DROP_FLOW_LIMIT for per-flow depth limit exceeded

The FLOW_LIMIT reason is now a common drop reason for per-flow limits,
applicable to both FQ and SFQ qdiscs.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-qdisc.h |   22 ++++++++++++++++------
 net/sched/sch_fq.c             |    2 +-
 net/sched/sch_sfq.c            |    8 ++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index 2175ab34921e..2c0a5c358a5f 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -8,10 +8,11 @@
 	FN(GENERIC)			\
 	FN(OVERLIMIT)			\
 	FN(CONGESTED)			\
+	FN(FLOW_LIMIT)			\
+	FN(MAXFLOWS)			\
 	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
-	FN(FQ_FLOW_LIMIT)		\
 	FNe(MAX)
 
 #undef FN
@@ -51,6 +52,20 @@ enum qdisc_drop_reason {
 	 * congestion to the sender and prevent bufferbloat.
 	 */
 	QDISC_DROP_CONGESTED,
+	/**
+	 * @QDISC_DROP_FLOW_LIMIT: packet dropped because an individual flow
+	 * exceeded its per-flow packet/depth limit. Used by FQ and SFQ qdiscs
+	 * to enforce per-flow fairness and prevent a single flow from
+	 * monopolizing queue resources.
+	 */
+	QDISC_DROP_FLOW_LIMIT,
+	/**
+	 * @QDISC_DROP_MAXFLOWS: packet dropped because the qdisc's flow
+	 * tracking table is full and no free slots are available to allocate
+	 * for a new flow. This indicates flow table exhaustion in flow-based
+	 * qdiscs that maintain per-flow state (e.g., SFQ).
+	 */
+	QDISC_DROP_MAXFLOWS,
 	/**
 	 * @QDISC_DROP_CAKE_FLOOD: CAKE qdisc dropped packet due to flood
 	 * protection mechanism (BLUE algorithm). This indicates potential
@@ -69,11 +84,6 @@ enum qdisc_drop_reason {
 	 * packets with unreasonable future timestamps from blocking the queue.
 	 */
 	QDISC_DROP_FQ_HORIZON_LIMIT,
-	/**
-	 * @QDISC_DROP_FQ_FLOW_LIMIT: FQ dropped packet because an individual
-	 * flow exceeded its per-flow packet limit.
-	 */
-	QDISC_DROP_FQ_FLOW_LIMIT,
 	/**
 	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 058801fefca1..ca615d5433db 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -580,7 +580,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (unlikely(f->qlen >= q->flow_plimit)) {
 			q->stat_flows_plimit++;
 			return qdisc_drop_reason(skb, sch, to_free,
-						 QDISC_DROP_FQ_FLOW_LIMIT);
+						 QDISC_DROP_FLOW_LIMIT);
 		}
 
 		if (fq_flow_is_detached(f)) {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 96eb2f122973..efb796976a5b 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		sfq_dec(q, x);
 		sch->q.qlen--;
 		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_drop(skb, sch, to_free);
+		qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 		return len;
 	}
 
@@ -363,7 +363,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (x == SFQ_EMPTY_SLOT) {
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_MAXFLOWS);
 		q->ht[hash] = x;
 		slot = &q->slots[x];
 		slot->hash = hash;
@@ -420,14 +420,14 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	if (slot->qlen >= q->maxdepth) {
 congestion_drop:
 		if (!sfq_headdrop(q))
-			return qdisc_drop(skb, sch, to_free);
+			return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
 		/* We know we have at least one packet in queue */
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
 		slot->backlog -= delta;
-		qdisc_drop(head, sch, to_free);
+		qdisc_drop_reason(head, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
 		slot_queue_add(slot, skb);
 		qdisc_tree_reduce_backlog(sch, 0, delta);



Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EDB32A3F0;
	Thu,  5 Feb 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326529; cv=none; b=UE+4iG+ydmB8pgIYCegLIKgZTErPn3oomFjPYBHIeABFTUzSKcFj/b93RBHNikj1YRkGuTZTnjx38WMKeAOHooITaUUWnFHuYd8Ikfvb5VMkjf/Fkii3hg+70Lo01MWMRagJNRNiBXQxWBGe75UfYSPcY/Pf4aZmormyMIDDmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326529; c=relaxed/simple;
	bh=tTJULhq6AhxnlFw35rWcDPeqfAJX40qQR3Vb3tQfHSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFQxTDHPMsU/rkwfSfTk0tDpHqADdX/ziWVmIQ4OLMUi3SB/b2Hy53FvtOUM6WWcs1lm5a4iZN5KCoVwBeuvm6UoS5o2DtnRpf5QcG8dMwMJck1GWxBVSx8nLmj2DiSc8uhZaoNSW72ChK6H+f2eemZ19QUtmywWWiXJqDBYeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asteifsn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asteifsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17FAC4CEF7;
	Thu,  5 Feb 2026 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770326529;
	bh=tTJULhq6AhxnlFw35rWcDPeqfAJX40qQR3Vb3tQfHSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=asteifsntJpG3xv8K1sOOG9yPHc/MvrUYMphmrL1tHhEiYIi5Ft7ZG7pe8HFZ5LC9
	 7L+ECfl1vaYtvBFP/jrPEW+Wlq/4VJWLeWmMRckyC8TvHzAomjWDBNjCWoysF+Rfd+
	 FhjOrwyplwqHBJcu1bv8asAWbeZG93uvCOrl5VVT2XB+ktng9b9Czg/C7n/ZNOVUH4
	 5+P+MqVeg1Xjhxx4UM4zz7JO4RW1tenlMk+g6ttjompvNcEw+o2CypUB2f+hoMMf51
	 p38mFX8ljO1A8rswNIAM/stoZJHYv5xgclKXhruWDPC0yJ/YORU5IPGC6Jzz85PMb0
	 YwWUu7QzJ4g6A==
Subject: [PATCH net-next v2 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 05 Feb 2026 22:22:03 +0100
Message-ID: <177032652354.1975497.2269771162710918590.stgit@firesoul>
In-Reply-To: <177032644012.1975497.16411100029657607833.stgit@firesoul>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

DualPI2 drops packets during dequeue but was using kfree_skb_reason()
directly, bypassing trace_qdisc_drop. Convert to qdisc_dequeue_drop()
and move DUALPI2_STEP_DROP to the qdisc drop reason enum.

- Set TCQ_F_DEQUEUE_DROPS flag in dualpi2_init()
- Use enum qdisc_drop_reason in drop_and_retry()
- Replace kfree_skb_reason() with qdisc_dequeue_drop()

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-core.h |    6 ------
 net/sched/sch_dualpi2.c       |    9 +++++----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3d8d284e05c8..5c8c2eb3d2c5 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -121,7 +121,6 @@
 	FN(CANFD_RX_INVALID_FRAME)	\
 	FN(CANXL_RX_INVALID_FRAME)	\
 	FN(PFMEMALLOC)	\
-	FN(DUALPI2_STEP_DROP)		\
 	FN(PSP_INPUT)			\
 	FN(PSP_OUTPUT)			\
 	FNe(MAX)
@@ -579,11 +578,6 @@ enum skb_drop_reason {
 	 * reached a path or socket not eligible for use of memory reserves
 	 */
 	SKB_DROP_REASON_PFMEMALLOC,
-	/**
-	 * @SKB_DROP_REASON_DUALPI2_STEP_DROP: dropped by the step drop
-	 * threshold of DualPI2 qdisc.
-	 */
-	SKB_DROP_REASON_DUALPI2_STEP_DROP,
 	/** @SKB_DROP_REASON_PSP_INPUT: PSP input checks failed */
 	SKB_DROP_REASON_PSP_INPUT,
 	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 0b6a38704a3b..d7a59eefd070 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -571,11 +571,11 @@ static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
 }
 
 static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
-			   struct Qdisc *sch, enum skb_drop_reason reason)
+			   struct Qdisc *sch, enum qdisc_drop_reason reason)
 {
 	++q->deferred_drops_cnt;
 	q->deferred_drops_len += qdisc_pkt_len(skb);
-	kfree_skb_reason(skb, reason);
+	qdisc_dequeue_drop(sch, skb, reason);
 	qdisc_qstats_drop(sch);
 }
 
@@ -597,8 +597,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 
 		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
 			qdisc_qstats_drop(q->l_queue);
-			drop_and_retry(q, skb, sch,
-				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
+			drop_and_retry(q, skb, sch, QDISC_DROP_STEP_DROP);
 			continue;
 		}
 
@@ -915,6 +914,8 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	int err;
 
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				       TC_H_MAKE(sch->handle, 1), extack);
 	if (!q->l_queue)



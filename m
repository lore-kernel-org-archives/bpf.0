Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5272D59E8;
	Fri,  6 Feb 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395101; cv=none; b=IveabWbT7v+cpuFSHLegyEVoYsa5ziV1epm7GkqymDJFPlmTgdujf/pRuMPZgMHyyVUekW+VaAdlxQSFjE+n12blZsMnh/Hzb+fsizvc2v18sh8icaSdd+leqWl4k2Rzfp2Q9/jWy/Oxogm4nHu/CU650VQ/ON96rA1jlGuygGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395101; c=relaxed/simple;
	bh=EH3jKT654Ffxi2le59xSbhdhq0MLcuZ3khvM6t4FAd0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+REQ1wLvIZO/9+YRPTo9kE/291Og+SADwelec558KRyevKEoQPd56YSUXWOFxcgwDWfOKogWrMk4q2nXRCiCp9/7+mab43WOHmvqdaxAspA8cAYFz7NJeS3GYAdlnGh6xvcZmH4MT2E9dbmSpBRCFDUa44yr9A9Xp7SYKoH6Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItB5mp4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItB5mp4C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83582C116C6;
	Fri,  6 Feb 2026 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395100;
	bh=EH3jKT654Ffxi2le59xSbhdhq0MLcuZ3khvM6t4FAd0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ItB5mp4C8OIOVx6VsYlLdbunCV+UrYFYxSwA8qs+wc4pcOn/IiO8RgPQKKm1G9MoH
	 dOa505Rv8GdGJlDzSlbXwylUZy4J1JbROrlLnJ5CNkYGvMvOS/0oY7M6QNQ5C3n62h
	 /nSnGypqoh5USe3Z8dyW4ULnxByBY2eRjMOEekOvCdvveW4ozB/iSgfSkWxmFpRoX6
	 R9v90dKjlwAiLpd5ApA5dB8nWupBtH4D0kCafhVHTWlK08qsAP8r81xlNaCuL0GMwd
	 WTyFbRmwVoxbOhXZWykot+e16we33+96Tr+rzT8vX8qqCbItHeDaEg3F8T0f2TaVkU
	 L857tg50BiHeg==
Subject: [PATCH net-next v3 6/6] net: sched: sch_dualpi2: use
 qdisc_dequeue_drop() for dequeue drops
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Fri, 06 Feb 2026 17:24:55 +0100
Message-ID: <177039509565.2258217.3624858167198291525.stgit@firesoul>
In-Reply-To: <177039500964.2258217.2989656069254156812.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
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
and add QDISC_DROP_L4S_STEP_NON_ECN to the qdisc drop reason enum.

- Set TCQ_F_DEQUEUE_DROPS flag in dualpi2_init()
- Use enum qdisc_drop_reason in drop_and_retry()
- Replace kfree_skb_reason() with qdisc_dequeue_drop()

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602061240.CRDtcOeX-lkp@intel.com/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-core.h  |    6 ------
 include/net/dropreason-qdisc.h |    8 ++++++++
 net/sched/sch_dualpi2.c        |   12 ++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

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
diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index 8661797193b1..c08ecce2d76b 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -14,6 +14,7 @@
 	FN(FLOOD_PROTECTION)		\
 	FN(BAND_LIMIT)			\
 	FN(HORIZON_LIMIT)		\
+	FN(L4S_STEP_NON_ECN)			\
 	FNe(MAX)
 
 #undef FN
@@ -94,6 +95,13 @@ enum qdisc_drop_reason {
 	 * Used by qdiscs with time-based scheduling (e.g., FQ).
 	 */
 	QDISC_DROP_HORIZON_LIMIT,
+	/**
+	 * @QDISC_DROP_L4S_STEP_NON_ECN: DualPI2 qdisc dropped a non-ECN-capable
+	 * packet because the L4S queue delay exceeded the step threshold.
+	 * Since the packet cannot be ECN-marked, it must be dropped to signal
+	 * congestion. See RFC 9332 for the DualQ Coupled AQM step mechanism.
+	 */
+	QDISC_DROP_L4S_STEP_NON_ECN,
 	/**
 	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 0b6a38704a3b..fe6f5e889625 100644
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
 
@@ -590,15 +590,13 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 
 	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
 		if (!q->drop_early && must_drop(sch, q, skb)) {
-			drop_and_retry(q, skb, sch,
-				       QDISC_DROP_CONGESTED);
+			drop_and_retry(q, skb, sch, QDISC_DROP_CONGESTED);
 			continue;
 		}
 
 		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
 			qdisc_qstats_drop(q->l_queue);
-			drop_and_retry(q, skb, sch,
-				       SKB_DROP_REASON_DUALPI2_STEP_DROP);
+			drop_and_retry(q, skb, sch, QDISC_DROP_L4S_STEP_NON_ECN);
 			continue;
 		}
 
@@ -915,6 +913,8 @@ static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
 	struct dualpi2_sched_data *q = qdisc_priv(sch);
 	int err;
 
+	sch->flags |= TCQ_F_DEQUEUE_DROPS;
+
 	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				       TC_H_MAKE(sch->handle, 1), extack);
 	if (!q->l_queue)



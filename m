Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6440328241;
	Fri,  6 Feb 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770395094; cv=none; b=NDVg9lZdjXwHlrJ54W2tjPSLF0DEQcm+RWsJCW9PSmefPROXq34bt5T338duAcaEhZxSaDViVTplzGuo862UTh+WzGKlAIzbgYR8ehq9QQDmc6rhWTRd0KrO0Chi5sphpSlQ9SQAy86Cw9LAYTulgwXGi9WPN8AJzv+TofWgljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770395094; c=relaxed/simple;
	bh=oPaFIWbWQE4GIVRfIpLl62TlVj5wxjXtir+SGxEuow0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZCtCWTZObYrir6DMJ0ob21QUb+CsApkpO/SglrbY3nU5O3FzvRiemHhvWJbHv+3PBFC+HIrVVLEOaSxJHqpC6YGi46t/PS6/ys1+4UUYMzwj3IFQVDC6GCZbyCOURgUh5bx6YYC+9/c+oahzDZI3n7iyo1k2J4CHo0Eh5WkKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsfebKqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsfebKqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12077C116C6;
	Fri,  6 Feb 2026 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770395094;
	bh=oPaFIWbWQE4GIVRfIpLl62TlVj5wxjXtir+SGxEuow0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dsfebKqDaoO1HBVIjZ5/p7El70DJs5mln1A/ejt4Flx0fKKYqdfEvfdjCzLynXcsI
	 6kZ3tQpa7F1TEN54i0ygTEk+5kRqhAHr2y5qPSWFklQNXN5QRQZ4IV6P3oYnnriZTr
	 0udlvo+sUUnGwznB4v0zpvQ87gxtaDjewZKHMVpbCyox+vGoLPZyzZ3H8QdGeWRTiF
	 57Go4jXUneNehZ+k8OjeRFNqwUrpC8Lu03WoTKjN1ZPnmWJE3k0gg0lhKgunmR0TUk
	 wf119HQJrFynnCL/M3M9M8bERe+g1/Zrk9VdgyIl2SrCkdTcUCDxnUU3ve5ihQjBdc
	 zUaafb37Lg1dg==
Subject: [PATCH net-next v3 5/6] net: sched: rename QDISC_DROP_FQ_* to generic
 names
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Fri, 06 Feb 2026 17:24:49 +0100
Message-ID: <177039508922.2258217.2724637003148631081.stgit@firesoul>
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

Rename FQ-specific drop reasons to generic names:
- QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
- QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT

This follows the principle that drop reasons should describe the drop
mechanism rather than being tied to a specific qdisc implementation.
These concepts (priority band limits, timestamp horizon) could apply
to other qdiscs as well.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/net/dropreason-qdisc.h |   21 +++++++++++----------
 net/sched/sch_fq.c             |    2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index 2e2f4fc36e0d..8661797193b1 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -12,8 +12,8 @@
 	FN(FLOW_LIMIT)			\
 	FN(MAXFLOWS)			\
 	FN(FLOOD_PROTECTION)		\
-	FN(FQ_BAND_LIMIT)		\
-	FN(FQ_HORIZON_LIMIT)		\
+	FN(BAND_LIMIT)			\
+	FN(HORIZON_LIMIT)		\
 	FNe(MAX)
 
 #undef FN
@@ -82,17 +82,18 @@ enum qdisc_drop_reason {
 	 */
 	QDISC_DROP_FLOOD_PROTECTION,
 	/**
-	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
-	 * the priority band's packet limit was reached. Each priority band
-	 * in FQ has its own limit.
+	 * @QDISC_DROP_BAND_LIMIT: packet dropped because the priority band's
+	 * limit was reached. Used by qdiscs with priority bands that have
+	 * per-band packet limits (e.g., FQ).
 	 */
-	QDISC_DROP_FQ_BAND_LIMIT,
+	QDISC_DROP_BAND_LIMIT,
 	/**
-	 * @QDISC_DROP_FQ_HORIZON_LIMIT: FQ dropped packet because its
-	 * timestamp is too far in the future (beyond horizon). This prevents
-	 * packets with unreasonable future timestamps from blocking the queue.
+	 * @QDISC_DROP_HORIZON_LIMIT: packet dropped because its timestamp
+	 * is too far in the future (beyond horizon). This prevents packets
+	 * with unreasonable future timestamps from occupying queue space.
+	 * Used by qdiscs with time-based scheduling (e.g., FQ).
 	 */
-	QDISC_DROP_FQ_HORIZON_LIMIT,
+	QDISC_DROP_HORIZON_LIMIT,
 	/**
 	 * @QDISC_DROP_MAX: the maximum of qdisc drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index d36da3918b55..f8f360d28da0 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -541,7 +541,7 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
-#define FQDR(reason) QDISC_DROP_FQ_##reason
+#define FQDR(reason) QDISC_DROP_##reason
 
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)



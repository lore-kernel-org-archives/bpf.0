Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150C32D7DA;
	Thu,  5 Feb 2026 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326522; cv=none; b=J/yL5tgbaYqClDfxW15iHKkiRp9NTJLyqOSMzxhD82Z6Ud1nx1ApwbSLs6Dp+Cz93c1R/WhHJsiQ5oXMDcGUvO1SVg34XeOk1JrvPhqzfXGoivuK4ashsk6gJF9nLnrwPWQehZPx1wyAEMsGS3gX3IDZ7tETZXVLPVsbd/shJKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326522; c=relaxed/simple;
	bh=qBLQJYrsmvwSKRzZ/UCjQCpA9GUDMTG2FiusiPd87U8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNLdF8HNhqhZ1NwNBfRDcoI8Dj3rsqa+JYjOzTB/zG+Gg/Mel69+G0bKQjBoWHkmBzgTa3uYF/q7pj50NWt61oR148GNsx2MjMycjEtkax9WRGYN2IQTbsDVUuFGOjnAiBGZBvGq7NU/vqh64EwLEO0XhuQ5eEKSO8+/YmE6adY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAgdXVA+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAgdXVA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1263BC4CEF7;
	Thu,  5 Feb 2026 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770326522;
	bh=qBLQJYrsmvwSKRzZ/UCjQCpA9GUDMTG2FiusiPd87U8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dAgdXVA+tIG7ShmqcolJdVos3fxG14LNhOA9mbkBVF7b75Z5aoVz5As4MRJAohcBe
	 GgLh41ZIWHZQvgjM/kd9t4GGggjEWOK4sDMHdHiZnMuYaSTa7JiSm2QxK36HnatrhC
	 zocnBfpitccwtdwf1WKqXIbfI2SeN744FCWVbrqpu480kepzjWeeVYv5S7cjVnDrxm
	 xPSC25x8n7YjXAcraYwmqVV0jyalzkDvQfoUS0jMYOJ1SKrj/p31D2q3mmsF+Qo5d8
	 VxjjtBV9g+RHk3lDWlTdR/zuNJytW48SGYniacL4JtzGMIy13ch2zZAHsvWqkIwIiz
	 yOyEyjKKJ9uJg==
Subject: [PATCH net-next v2 5/6] net: sched: rename QDISC_DROP_FQ_* to generic
 names
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 05 Feb 2026 22:21:57 +0100
Message-ID: <177032651701.1975497.17267547145694969895.stgit@firesoul>
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
index 3759a801bddd..031fd8a0bc8c 100644
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
@@ -81,17 +81,18 @@ enum qdisc_drop_reason {
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
index ca615d5433db..a8432b63d496 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -541,7 +541,7 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
-#define FQDR(reason) QDISC_DROP_FQ_##reason
+#define FQDR(reason) QDISC_DROP_##reason
 
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)



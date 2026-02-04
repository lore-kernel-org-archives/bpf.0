Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197A346E5E;
	Wed,  4 Feb 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224594; cv=none; b=uL92f54ZjlqYhbSnoQ3Dn5Gy7aynu2KCOU/6Dh0wqztlfqUW1I7/rYQ1mkMs8vw8bW6vLCvYOablxvvbbLy4F5obzxplJxLChXdwdse6pms/z8tDNLx4qIjvVOaYmsr4Xmm5MaoK8G5e2151uIZLRJBg7Fp+eHEpHeyemZ4Ctvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224594; c=relaxed/simple;
	bh=Bup6bqy51nLskK4r7e6B2aiti4ZAaB1Rsbevgd7k5i4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1UikeRK6vWl/7Q6KadOX/jLzQBhhaVflOhL9A5z9N1BCo6VnSllZKrKjpfJj1aw115MmdWDTnXN8yWwPXmuY2dmna6rEptr7PDPU1YGuREA7vOSV50+grTvF1c7/0Hjlzgq0IIyV7h4Lt8IfS4tgOdg7T+x0DHmBzCOXWr3CDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTE96xyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTE96xyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A363C4CEF7;
	Wed,  4 Feb 2026 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224594;
	bh=Bup6bqy51nLskK4r7e6B2aiti4ZAaB1Rsbevgd7k5i4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YTE96xyp/EE1COaNo5DRklyrrilmfkflPJoC330ST4Fma/DaFkxLa8BXp08fyDv1c
	 vrYRyMrZELi3K+U7M0n4hjnQj56G0NbN8+ST4IcZpbwxDpH+SV+9OnWQcypBJeKuC3
	 woGJRRLkwrP5eSC8vqQGwQ++MqetNRM02y4FXa1DTLL87UKa3rgcBLGydhaErifWDl
	 qALg4UZwezCFzKXR8TfvNJi+u4TSweDv5aU+zZxP4LEnIn+UA/lZ0y3QRDTk3GmUoa
	 7KFrpnQXwacvPzdNU+q9UzPOCOLRlE/vbd37KXJ0nU3m1Gqt8kwh+rPZhLq/HAuAnq
	 jxetGvgEUXPYA==
Subject: [PATCH net-next RFC v1 3/3] net: sched: sch_cake: use enum
 qdisc_drop_reason for cobalt_should_drop
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 carges@cloudflare.com, kernel-team@cloudflare.com
Date: Wed, 04 Feb 2026 18:03:08 +0100
Message-ID: <177022458894.1827734.4335287797377732478.stgit@firesoul>
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

Change cobalt_should_drop() return type from enum skb_drop_reason to
enum qdisc_drop_reason to fix implicit enum conversion warnings.

Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
comparison logic remains semantically equivalent.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 net/sched/sch_cake.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index a2d1b292600d..da3c347574d2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -497,13 +497,13 @@ static bool cobalt_queue_empty(struct cobalt_vars *vars,
 /* Call this with a freshly dequeued packet for possible congestion marking.
  * Returns true as an instruction to drop the packet, false for delivery.
  */
-static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
-					       struct cobalt_params *p,
-					       ktime_t now,
-					       struct sk_buff *skb,
-					       u32 bulk_flows)
+static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
+						 struct cobalt_params *p,
+						 ktime_t now,
+						 struct sk_buff *skb,
+						 u32 bulk_flows)
 {
-	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
+	enum qdisc_drop_reason reason = QDISC_DROP_UNSPEC;
 	bool next_due, over_target;
 	ktime_t schedule;
 	u64 sojourn;
@@ -571,14 +571,14 @@ static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	}
 
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
-	if (vars->p_drop && reason == SKB_NOT_DROPPED_YET &&
+	if (vars->p_drop && reason == QDISC_DROP_UNSPEC &&
 	    get_random_u32() < vars->p_drop)
 		reason = QDISC_DROP_CAKE_FLOOD;
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
 		vars->drop_next = ktime_add_ns(now, p->interval);
-	else if (ktime_to_ns(schedule) > 0 && reason == SKB_NOT_DROPPED_YET)
+	else if (ktime_to_ns(schedule) > 0 && reason == QDISC_DROP_UNSPEC)
 		vars->drop_next = now;
 
 	return reason;
@@ -2004,7 +2004,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
-	enum skb_drop_reason reason;
+	enum qdisc_drop_reason reason;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
@@ -2225,7 +2225,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 					     !!(q->config->rate_flags &
 						CAKE_FLAG_INGRESS)));
 		/* Last packet in queue may be marked, shouldn't be dropped */
-		if (reason == SKB_NOT_DROPPED_YET || !flow->head)
+		if (reason == QDISC_DROP_UNSPEC || !flow->head)
 			break;
 
 		/* drop this packet, get another one */



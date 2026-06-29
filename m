Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80F3BBFB0
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728537; cv=none; b=SIK5H0HtvqXIuNqcFDQFmAng5/oOd1TMIEWL7oMO9ZXH7aCKR+GgdVO7OIcVpPTlmQVW7S8WAN0TDBWR0n0UvhkFaEIMtJPWn8818fFt33I8oOv1vHqoSRf271GWmjK+eC5RJ7zNEu9uqNgdmgyHCoNwTYXV9d1pgkZr3wn9wu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728537; c=relaxed/simple;
	bh=LQyuk+2XvgHA9CRUQzSGIGOjO95syCUcsge3kwP89SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q03bqbpvhmjyjIOK69XhioZO3P2bdqMZ86i8K7ZQLmmTLEndGxP1LQPdzJkmexjkA6lMCKwnPl+Dwi3LAYybHTKFqgk+98En5Z1IbOLVo6H/IzpA/i/AUt7Lub+J3huQlNFTotPToH5XljuMoSXIZu0JoSZz0wMcB8k1C3kJyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ddB2d7eO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ddB2d7eO"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeb4508f29so17742186d6.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728534; x=1783333334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=ddB2d7eOFDQ1MbIGX5Etgcyp9FHFkwTarOXMACSOo3kJTRsC5JSSLU4YU9UYRnGwW/
         9wVfrW3xDp9S1RCELOczU9T92KdEf6kEmKpLSyf+jisuRfLDwi+9vxkChlRrXAtEHnQX
         CJxxLdmBR/t8idmoJApioWzu8O1Z97YqlqAQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728534; x=1783333334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PKvM1smkzYAQlLOUZpGNh94x+wzWvVAEpjlRBYbmxwA=;
        b=SXVDDhCtlNWuRwkX+uwzdjDDehun6PusLstSRj9mNXciSggZ7kl8bnQXGDuwZ5pZ6t
         67fyfemFc2vu3KcNGHYccv3vfEzUvQj+2jlA8ggZEXk3f8uNHSuPegqLkztet+UMf+ru
         UqNK6GMdNBIXNmitdF4Hof73o1ZEA3hVakdif0OwnmO+wyryjicCTeQTCKpuMM8dfUMC
         U99U2kEovY7LLv2eix5yofFQ+27iGy9bhH6hfi9fRuiQhigm5bodqs7bh9m/VAp4q4gv
         mizh3hHMyhqbRmJ8vk652t+j9UsApGClML7YrDv/ycv+wzXgdOqLFOVd7y8Ad1pRNHsp
         m/pA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1vb6BLjSLVAPMnA67Wu4R+dZO39D/p79b5JZU5neZ+ct9C4Dqj54BSa7MM1bZaqtHAPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkjD5cfdxnrBm9g5oNH+pCzpOaqCu2tWvGMqFjZCWWc6eAXu8
	9BuAbTuEvaKYTPrlXdMmDAKeNHMvapFDq/4L0Um40espCuWny4Qk2bD42wgib8Z+9Q==
X-Gm-Gg: AfdE7ckylDpvPryApZr3GyOezgMINT2u9E5DEtumU3i0OKKOKrlXKSCoa0HJFzu3U9N
	d0cZxW11M5KntnhRWRUlXqRzn+ttQojCiS+wcSqHH8vXYQNLywtf3WZn4zt+5vB/yU6cmApWYdf
	DjhedanyzyqbxRjC5LijQJY0fHto0s0cv+kte0plKM1Gso0AeIjuVkrKfibe7lSQ5/KmR9jt4PS
	RJnKs1kp0JjdsMdm7covv94e0gGRsJ8mJCkALXCv6DDTtGKiCC5iRYZYFSbscVpMMETG4rZO7r8
	R3BDf7Q+WTpLYdMaYlKBRfub0oBnZYzgZJyLtpJbNcCjWYqA2U0cA+zBgZyZ87g6Y7SifyZdmzq
	gWKSLLG8oA0tXD4OJy/KS38uj4JvrRvMr+g5cEDhos2rgcOyVbDZAfbWOiraA3HnMkS/SNVWifG
	mZB8eDaA==
X-Received: by 2002:a0c:f00a:0:b0:8e9:f5de:d5c1 with SMTP id 6a1803df08f44-8e9f5ded9fcmr144265496d6.56.1782728533809;
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net 1/3 v2] net: Extend bpf_net_context lifetime to cover qdisc enqueue
Date: Mon, 29 Jun 2026 06:21:55 -0400
Message-Id: <20260629102157.737306-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629102157.737306-1-jhs@mojatatu.com>
References: <20260629102157.737306-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
down in that function returned. By the time tcf_qevent_handle() runs
current->bpf_net_context is NULL.

When a filter attached to a qevent block (e.g. RED's early_drop or mark
qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
bpf_net_ctx_get_ri().  That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Note: The same holds for actions that invoke BPF redirect helpers
(e.g. act_bpf running a program that calls bpf_redirect()) during qevent
classification itself.

Fix:
Move the bpf_net_context lifecycle out of sch_handle_egress() into
__dev_queue_xmit(), so that it spans both the egress TC fast path and the
qdisc enqueue.
Note: The call is placed outside the egress_needed_key static branch
to cover the case where clsact static key is disabled. Unfortunately this
adds a small unconditional penalty to the code path _per packet_ only
guarded by CONFIG_NET_XGRESS (two writes and one read).

As pointed by sashiko [1]:
The same context must also be set up in net_tx_action()'s qdisc drain
path, since qdisc_run() -> netem_dequeue() -> qdisc_enqueue( RED child)
can trigger qevent classification asynchronously from softirq context.

This keeps all bpf_net_context management in net/core/dev.c i.e the
existing boundary between tc core and BPF without requiring any net/sched/
code to know about BPF plumbing.

Reproducer:

  tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
      avpkt 1000 burst 100 qevent early_drop block 10
  tc filter add block 10 pref 1 bpf obj redirect.o

  traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
  on a redirect verdict, a NULL deref in skb_do_redirect().

Fixes: 3625750f05ec ("net: sched: Introduce helpers for qevent blocks")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..b95a8b153c76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4527,14 +4527,11 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 {
 	struct bpf_mprog_entry *entry = rcu_dereference_bh(dev->tcx_egress);
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_EGRESS;
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int sch_ret;
 
 	if (!entry)
 		return skb;
 
-	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-
 	/* qdisc_skb_cb(skb)->pkt_len & tcx_set_ingress() was
 	 * already set by the caller.
 	 */
@@ -4550,12 +4547,10 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		/* No need to push/pop skb's mac_header here on egress! */
 		skb_do_redirect(skb);
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	case TC_ACT_SHOT:
 		kfree_skb_reason(skb, drop_reason);
 		*ret = NET_XMIT_DROP;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	/* used by tc_run */
 	case TC_ACT_STOLEN:
@@ -4565,10 +4560,8 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 		fallthrough;
 	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
-		bpf_net_ctx_clear(bpf_net_ctx);
 		return NULL;
 	}
-	bpf_net_ctx_clear(bpf_net_ctx);
 
 	return skb;
 }
@@ -4767,6 +4760,9 @@ struct netdev_queue *netdev_core_pick_tx(struct net_device *dev,
  */
 int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 {
+#ifdef CONFIG_NET_XGRESS
+	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx = NULL;
+#endif
 	struct net_device *dev = skb->dev;
 	struct netdev_queue *txq = NULL;
 	enum skb_drop_reason reason;
@@ -4795,6 +4791,9 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 	skb_update_prio(skb);
 
 	tcx_set_ingress(skb, false);
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -4898,12 +4897,18 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 
 	reason = SKB_DROP_REASON_RECURSION_LIMIT;
 drop:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
 	kfree_skb_list_reason(skb, reason);
 	return rc;
 out:
+#ifdef CONFIG_NET_XGRESS
+	bpf_net_ctx_clear(bpf_net_ctx);
+#endif
 	rcu_read_unlock_bh();
 	return rc;
 }
@@ -5815,6 +5820,9 @@ static __latent_entropy void net_tx_action(void)
 
 	if (sd->output_queue) {
 		struct Qdisc *head;
+#ifdef CONFIG_NET_XGRESS
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+#endif
 
 		local_irq_disable();
 		head = sd->output_queue;
@@ -5824,6 +5832,10 @@ static __latent_entropy void net_tx_action(void)
 
 		rcu_read_lock();
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+#endif
+
 		while (head) {
 			spinlock_t *root_lock = NULL;
 			struct sk_buff *to_free;
@@ -5860,6 +5872,10 @@ static __latent_entropy void net_tx_action(void)
 			tcf_kfree_skb_list(to_free, q, NULL, qdisc_dev(q));
 		}
 
+#ifdef CONFIG_NET_XGRESS
+		bpf_net_ctx_clear(bpf_net_ctx);
+#endif
+
 		rcu_read_unlock();
 	}
 
-- 
2.54.0


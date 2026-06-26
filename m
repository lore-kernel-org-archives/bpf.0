Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC713FD960
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492729; cv=none; b=uEivTQGIPKzCf+ZFat+796uoEO2W75e+MYlK+gcQ2kgKkOYBnZriMkX8R1Pfa+kyvOmGgNLHdEYScGY9hWwiYq4mnRK6JDXVjoMCdnqeqsJ9RGtG7EztF0EjAKldoPAVAj+e3ueSvxIiCc94QzkBepJWrJ9mzm6lzZ0oPjbshcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492729; c=relaxed/simple;
	bh=Kv1pCNa4AGxs+0GNCCLsz+zl6t3qjPAshD8fX4AsOXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR6VGQml9aNsL4ft3TNQTrudM76DVrgtzuEMqhIChEWsdR7RaXMXkb3+y3cUMb2Zhzwa4wuRcGjbSluIqbHypvY9HUnu3JwFH85WQjeBS6MWsgnRnsK1HyyLdhIIxExRpfggMfp3vjQgEiY/Ci60/G8gX9N8zB/DAeZAVfckot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Flxz4pdM; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Flxz4pdM"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915d64fead9so227596785a.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782492726; x=1783097526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz+L1/Su9AEPUILxJxLQJzJejPxQKg7ou0p4PQtWgUQ=;
        b=Flxz4pdMzARAo07Ct2ZuD7rONzUQ2ZoBABDcCQCiAztpLzwFJu8OV7I96y9khfamSd
         TcRCtubmq/3Sy0C1kACOEzf/yfuL1S+SzNnxWAPARUZlQyPAYFMFW/IDo+2PLGz+KO73
         soaGHtKtSZnQyF5KUs1f9uENsvZxKL5v3vrng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492726; x=1783097526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xz+L1/Su9AEPUILxJxLQJzJejPxQKg7ou0p4PQtWgUQ=;
        b=ry5JRH5ANmF7bJEp3ADpEi5g8Cn7p+Dxfx++jreOT2Ld7+ANO6RUUfOStpH4WvMAe0
         ByFifg9Qb7c1h9jXTIM7Z4E5g9s2S3bcpnstkUwu5hQ8F1hTuepHA4JJa+VI+cNxIcZ0
         6OT2wB3XW3ZGruSM01x76uNqmCICCpS/JmLMjbbk6McDYMgszzeZ1/eUG1+A9mSQ/nVP
         YiUHLwPxxyxzhFOJP5NXGVBQ9UO/RmIMbchfjybUrBeSTparv5gcwwlHTzbBcpUk0I66
         uE94iwCcH3/vMsqRKCIULYT1rqQRlhbROu7bxE9832+waSeFX3oqyclyxQSRgjekWX5N
         vL6w==
X-Forwarded-Encrypted: i=1; AFNElJ8JXtOHtFarkaZ60zyC0Q71bGHRwjUTScHN0Gujxh9lxAu52GVq+Hh0j2pCzMzt0Sk+UoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2E8CyJ7yFYRUPX7xqbnC16b7PuKjFcPQuP9zi3TG6pQWQJa/A
	sMgVzWrnWYjl3HoO+Q+LEbuma6l5U5rZwwYryz+TNqaiXXAHO/dqDR3bwXk+qHyllA==
X-Gm-Gg: AfdE7ck5+mOcgkoEJa/Xv5V7XEgPcFtk3NGT6XtnURAM8NtwlujODNv9Dj6RgSR38fF
	Ryl7lWgDkUpLLX1dWe2RfKtsIDKfZ7z/FcBa4sCWR07Vz2HQcvvkI+QmtgIvPzP7uHvac1UE8X9
	eysoKB3pecbZrt9XoSLuxUPTdjmQMZHVbD1CpPadjPJRKeF3X16rOfgM1hlGYk1Kww8+wXXV52W
	Sbt0wAaA70IJAhSzpzyMZWmuQM5wg1Z/cRKbDMVpeCpbI5GC3Ljudwhk8NMNvhNmMBuwRddzqvz
	6uKF6y0LH3UvaZeijwQy6Xa3YHeq5wZpROUDZjVcIG4ixGoaj5ySBoxc+F6hScdTpkLTkxD8j0k
	9amdWi9NtHoedgHk9YSBTN17fzEablAtd4EvQSVbjubJ6fk4JZTPgPTuy/ghieSJeh2NmCvQ1Sc
	2aFSjbl7Pt9YWDMpSl
X-Received: by 2002:a05:620a:40c3:b0:92b:67e6:4b77 with SMTP id af79cd13be357-92b67e64fa9mr110327685a.33.1782492725576;
        Fri, 26 Jun 2026 09:52:05 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004abe29sm1216957385a.33.2026.06.26.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:52:04 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	toke@toke.dk,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	kuniyu@google.com,
	sdf.kernel@gmail.com,
	skhawaja@google.com,
	liuhangbin@gmail.com,
	krikku@gmail.com,
	mkarsten@uwaterloo.ca,
	victor@mojatatu.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover qdisc enqueue
Date: Fri, 26 Jun 2026 12:51:54 -0400
Message-Id: <20260626165156.169012-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626165156.169012-1-jhs@mojatatu.com>
References: <20260626165156.169012-1-jhs@mojatatu.com>
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
bpf_net_ctx_get_ri(). That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Note: The same holds for actions that invoke BPF redirect helpers
(e.g. act_bpf running a program that calls bpf_redirect()) during qevent
classification itself. And as a matter of fact the same assumption is
made in the code outside of tc.

Fix:
Move the bpf_net_context lifecycle out of sch_handle_egress() into
__dev_queue_xmit(), so that it spans both the egress TC fast path and the
qdisc enqueue. The setup is placed outside the egress_needed_key static
branch because qevents are independent of clsact/NF egress hooks and
that key may stay disabled when only a qevent-bearing qdisc is
configured. Unfortunately this adds a small unconditional penalty to the
code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes and
one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).

This keeps all bpf_net_context management in net/core/dev.c i.e the
existing boundary between tc core and BPF without requiring any net/sched/
code to know about BPF plumbing.

Reproducer (see the accompanying tdc test):

  tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
      avpkt 1000 burst 100 qevent early_drop block 10
  tc qdisc add dev eth0 clsact
  tc filter add block 10 pref 1 bpf obj redirect.o
  tc filter add dev eth0 egress protocol ip prio 1 matchall \
      action gact pass

  traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
  on a redirect verdict, a NULL deref in skb_do_redirect().

Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4b3d5cfdf6e0..8c214bfff8aa 100644
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
-- 
2.54.0


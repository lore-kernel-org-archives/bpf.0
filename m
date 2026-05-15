Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25505481AA3
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853557; cv=none; b=de/2IudStoryEiv3FYMClXYORRWZMwISTFE2XKh30A+jcZzP+KEh3mEABaUot+Tx5uWhecRTo7sugAya4EwxysD/hLJnJ1FTXK6pHbQSIMrgRIOzmkgf/65x8Y016ovede/7xBVhjwBh+F1cehptPhChQEUSUWy0vbIlGqiY6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853557; c=relaxed/simple;
	bh=c2A8vEE2A3EOtpSYwg0f125Ondvt0pIyQEAXqLz0mvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSHfBvw7fgnEVy1y4ik590HbgaIzBW5cbMsXeIA2oyFNdgXj4C3lkkVBWAxG9l+OJmA+c3THeoGiuAoUfy4VZ691PTtf9YGQDYD997Es7T3O2zzu6pW8FzvONDzHunj3OnBEOwSOqifg+ueVprcocK0EISy9rCw2aHkyw73vLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=fmNcj47c; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="fmNcj47c"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso84404706d6.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853554; x=1779458354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PSh+GRhXVkv5mk3aFGVuPSlHgL1BMdkj34hW/QwWJ8g=;
        b=fmNcj47c5EueFa+UmKZs/YWQSZ82fffK5kruWWXcjecYBoiQfjUy6u4484nzTqEjcY
         UQ7QCe1oWs8LGt85+Y7j+imQZB8O+t5y/b2zATpSeTlZ74F0p9cJDGeehMCFN3im1djI
         mg6f4UIg1aLMw3t+Fp0nLOOqu/hi6X2P7AiHYnvn5Mfn/5F3O4C+0aobIMeky1HYi3Vl
         0BYeMn6G7vcFM4QsbK5I6Dac51H9NmYg6U6PSp0IoRZWLP3lk30wjN1+laMFY2kF5F4b
         ynpQ8OGXV40UmPGWaQMITicRCDp50d5yVDvYSieRJluq33Buddf0gZOkud/VZTDdGhTm
         6uwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853554; x=1779458354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSh+GRhXVkv5mk3aFGVuPSlHgL1BMdkj34hW/QwWJ8g=;
        b=YStlcoDd1OSyx7CKAH2YN6B4f/2JBQmIO0U0ESpalTaaiw++8JmRryEn+82DESbC7F
         Ti1LLvz6UD71S0Uc+3Ef5cp4Hp72wqvOfr7wbCRCkUdqDzxbthz6YhVLV34MMie3HG+e
         lvoFiKPuQpmqRuzSrRlabSZ9BGmOxpb6trbmEdrhq7i+tOoMK8J40tw95uJv4uFC6U1M
         5nZFgzKwyE5OwYsU2f1vzmRXuZnf1BflvwS6vBc7Lc0RI5auWv2TkwNjGLcb7GUW1FJ6
         u6tW1vU6WmZd/RxZ2bBLAcBGqdtIVQx/PESGNEM5jY76291WAo9fPrTgXHrjNlkg2lC7
         lhKg==
X-Forwarded-Encrypted: i=1; AFNElJ+k+lisRVeisBuFX/WO7sudVUYL26Ehlei7VfFl2o+iTA5e8nmKtQmdHTAidfn7CrAnNkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynw06h7EiYyQ1UGar5OEJUl71qdMqeO0t4jICVpFycrw99qZ0b
	1eQbccgnWceOPJcXYC3SqDdFtBSW6Y1pEwFgY4o5aEXQu69MnijhrpV7KJ//3Fr+Ubo=
X-Gm-Gg: Acq92OFedhqMfxy6TYFInwjfW8CVjDgrEMsJldes8HTFpoB+INKhRiNA0/r+1uJBv3Z
	7tFM07n+C+j2Vt6UepKsKsqdTq+oKmuMR2OQ7OwV/t6AJbdl3B8XEJsHv5VSZPzAUzWf3+kA8Xu
	zvxHtNTzOLBAc4nqzJplxj91X1HT4K+3rmL8S28b5nT/wXlSwcbRV3vRypxQBHsbMCmO/Zktcqd
	6Q+JBreIXCHhOLULRw5uDl4BpUqWWQlEvWNKkVMNHxymFo7/KCIUEF79fiDHy9T2EDEFEhdh3k2
	yNZyTQQbHKCBjwprcDhmeSmlEr/CQp+wf0vl3bkcVSO0MHvv1n3hs9z5pyETq+x7bYjY9o8GVZu
	olng/ZOIH/5ztdJpJ9ufAGLjphYJxxTbFtcrPoV332HGEKgXS/yFddntYisNx0WojQvpmn3VyBJ
	cmCcn1XQFsr0Fhc2KeN0A5beFizBOs
X-Received: by 2002:a05:6214:600f:b0:899:fd8c:55c3 with SMTP id 6a1803df08f44-8ca0f690ff5mr65423206d6.22.1778853554129;
        Fri, 15 May 2026 06:59:14 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d19csm52839666d6.13.2026.05.15.06.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:13 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 02/11] net: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:09 -0400
Message-ID: <20260515135909.2238774-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 net/core/dev.c             | 2 +-
 net/core/xdp.c             | 2 +-
 net/openvswitch/actions.c  | 2 +-
 net/openvswitch/datapath.c | 2 +-
 net/sctp/outqueue.c        | 2 +-
 net/tipc/node.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 8bfa8313ef62..12a583ce4d95 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6482,7 +6482,7 @@ void netif_receive_skb_list(struct list_head *head)
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
 		list_for_each_entry(skb, head, list)
-			trace_netif_receive_skb_list_entry(skb);
+			trace_call__netif_receive_skb_list_entry(skb);
 	}
 	netif_receive_skb_list_internal(head);
 	trace_netif_receive_skb_list_exit(0);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9890a30584ba..3003e5c57419 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -362,7 +362,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 		xsk_pool_set_rxq_info(allocator, xdp_rxq);
 
 	if (trace_mem_connect_enabled() && xdp_alloc)
-		trace_mem_connect(xdp_alloc, xdp_rxq);
+		trace_call__mem_connect(xdp_alloc, xdp_rxq);
 	return 0;
 }
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 140388a18ae0..7b7c93c3bde4 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1260,7 +1260,7 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 		int err = 0;
 
 		if (trace_ovs_do_execute_action_enabled())
-			trace_ovs_do_execute_action(dp, skb, key, a, rem);
+			trace_call__ovs_do_execute_action(dp, skb, key, a, rem);
 
 		/* Actions that rightfully have to consume the skb should do it
 		 * and return directly.
diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index bbbde50fc649..f2b6688f18d6 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -335,7 +335,7 @@ int ovs_dp_upcall(struct datapath *dp, struct sk_buff *skb,
 	int err;
 
 	if (trace_ovs_dp_upcall_enabled())
-		trace_ovs_dp_upcall(dp, skb, key, upcall_info);
+		trace_call__ovs_dp_upcall(dp, skb, key, upcall_info);
 
 	if (upcall_info->portid == 0) {
 		err = -ENOTCONN;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4..4025d863ffc8 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -1267,7 +1267,7 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* SCTP path tracepoint for congestion control debugging. */
 	if (trace_sctp_probe_path_enabled()) {
 		list_for_each_entry(transport, transport_list, transports)
-			trace_sctp_probe_path(transport, asoc);
+			trace_call__sctp_probe_path(transport, asoc);
 	}
 
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 97aa970a0d83..6cfe4c40c82b 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1943,7 +1943,7 @@ static bool tipc_node_check_state(struct tipc_node *n, struct sk_buff *skb,
 
 	if (trace_tipc_node_check_state_enabled()) {
 		trace_tipc_skb_dump(skb, false, "skb for node state check");
-		trace_tipc_node_check_state(n, true, " ");
+		trace_call__tipc_node_check_state(n, true, " ");
 	}
 	l = n->links[bearer_id].link;
 	if (!l)
-- 
2.54.0


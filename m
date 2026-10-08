Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D209370D5C
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429373; cv=none; b=FEUovXaSNd5OAalE79ueHZGXtfHvRyZRPjpoigSaUO5e9PsNWRr/0u+exDj4a6Kw34q29J3TBwMGMW/OlCrQWnFutEBAv/uEwKiVVW3eRAvISmNK0XhpKi7uZHWy1X9tXIyTTNrBUBoT+y2weDYqkBCR+k1GBIxOUKnRmgHtzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429373; c=relaxed/simple;
	bh=Hcai1EE0pstKt3N5uKmaIo3Cb2ZWJeMB6FnrkCYUcBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FXFwpQCQrrd7UcFOXTx8F9m+o/XtPQAd6CYIx7krZSPYe1ZxKAd3atWzSeaWCKsCM9ochJPcEof1qggvjbGnQzGtz2C7QsLA/tIPVVipPLkJ/tIjKI7ArziNgUYbOd5lMamg7PyJBkanc6JvkP1I7ZQnDo3cKCXjnqvEWyw/Tak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AizmbNzq; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AizmbNzq"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so7963167a91.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429370; x=1792034170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dfZ0QARD32bUDrtGvSUo+dcc/PtX3iqxVb/bS0GXxp8=;
        b=AizmbNzqEFRGl5pP8VH8yvhpUGfUGqoUHIasHdsk0rnuz9zaqk2d09Tah3SD9WFyi8
         kiEXJyH2iv7RWRCxrS1M2gUrdJUkehT7AgrV3CckAi55yVfPhxvij5lM7eQjn3yvdMgM
         ae7k+IDc+7dA8h5Md8yL2Vdjip3vsKFjqUpUCt51fURvQeKLIqOhegJEFdkmPks0f4rQ
         y60a5/NznZYxVLpZJeQZ9VKF2O3K3XApSgBrpj6zxQFMOo93UP+ldLgQhhOAQYqYOG0T
         E3D5/+EIlL1Gs6vUh+K76Nkzz8WMdal+Ec/HNME/qGcKiM5xKs1gbNtddf1hUbbXP+GN
         UR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429370; x=1792034170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfZ0QARD32bUDrtGvSUo+dcc/PtX3iqxVb/bS0GXxp8=;
        b=dsjWLG20qOPjDK4tjKX7gxjpobP2uuZK5/qybfK3GXAP9J+8Vh8uCP3Q1G+jtqDC9F
         0vNA218bccz1BuG53noHnn9JLB67uk7OO0C0fWenbnR73zZm0/d+o7whjkHOBvWmH5s0
         Z08qMMsmsCS4reEkXOk2FRrdhWKSFMWGH9VkiRHxVKBHP38hsI86TJJ/fys7qB2lAXpb
         XPY3GwwjQvS/EIf0KKDA6qxNYPWUTM4k+RdMEMQYeUc69IUyfkzjgAfjWo4Z2c+UXA+G
         1MZ3QEVFsD5FUnHC5RuQMIuzD6Clrur0FKoBNKXnno0s846Y8VzVREP7X5s8JxvT3CTB
         e0jg==
X-Forwarded-Encrypted: i=1; AKwUvBzZdTm5fzSSA7GrFLHUAuNQbqrBXq1Z5cghc48D+BSUGCdxYD/KK/Wq3fXQAaqR0kew9gk=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6Vb9B3flxMTS++/M29e985sQJI1kzf6u/aWNLePIs1OHAK8i9
	uarj4aVa1duEhzZykfM6jqsjoNCgyC/M0SEhOkTWvoxGteYuknGqAQawn65bK9jqEvCzZ07yp+R
	P15kvmg==
X-Received: from pjbhk4.prod.google.com ([2002:a17:90b:2244:b0:3a6:edea:f58f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d00b:b0:3ab:4f1:4f7e
 with SMTP id 98e67ed59e1d1-3ab04f15107mr268175a91.28.1791429370209; Wed, 07
 Oct 2026 20:16:10 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:24 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-5-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
incoming / outgoing skb.

bpf_tcp_ops.rtt is called once per RTT, which is every
incoming skb in ping-pong workloads like tcp_rr.

Even attaching NULL callbacks in the fast path hurts performance.

Let's guard them (and write_hdr_opt) with the new per-socket flags.

__bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.

Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
checked the static key both in tcp_established_options() and inside
bpf_tcp_ops_call().  Now the static key is checked once at the
beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
tcp_established_options() is removed.

tcp_bpf_hdr_opt_len() must use __always_inline, not just
inline, otherwise Clang inlines bpf_tcp_ops_hdr_opt_len() to
tcp_bpf_hdr_opt_len() instead.

  $ llvm-objdump -S -D --disassemble=tcp_established_options vmlinux
  ...
  ; 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
  ffffffff8251270e: 41 f6 87 20 0c 00 00 40      	testb	$0x40, 0xc20(%r15)
  ffffffff82512716: 75 47                	jne	0xffffffff8251275f <tcp_established_options+0x1ff>
  ; 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
  ffffffff82512718: 0f 1f 44 00 00       	nopl	(%rax,%rax)
  ; 	return size;
  ffffffff8251271d: 44 89 e0             	movl	%r12d, %eax
  ffffffff82512720: 5b                   	popq	%rbx
  ffffffff82512721: 41 5c                	popq	%r12
  ffffffff82512723: 41 5e                	popq	%r14
  ffffffff82512725: 41 5f                	popq	%r15
  ffffffff82512727: 5d                   	popq	%rbp
  ffffffff82512728: 2e e9 42 03 43 00    	jmp	0xffffffff82942a70 <__x86_return_thunk>

bpf_skops_write_hdr_opt() is still not free, but it can be
optimised later if needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5: Always inline static key to tcp_established_options()
v4: Check static key first and then flags
---
 include/net/tcp.h     | 44 ++++++++++++++++++++++------------
 net/ipv4/tcp_input.c  | 12 +++++++++-
 net/ipv4/tcp_output.c | 55 ++++++++++++++++++++++++++-----------------
 3 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 55ad9db99596..b7c0f1a8797a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3064,22 +3064,33 @@ struct bpf_tcp_ops {
 			      u32 opt_off);
 };
 
-#define bpf_tcp_ops_call(op, sk, ...)					\
+#define __bpf_tcp_ops_call(op, sk, ...)					\
 do {									\
-	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {			\
-		const struct bpf_prog_array_item *item;			\
-		const struct bpf_tcp_ops *tcp_ops;			\
-		struct cgroup *cgrp;					\
+	const struct bpf_prog_array_item *item;				\
+	const struct bpf_tcp_ops *tcp_ops;				\
+	struct cgroup *cgrp;						\
 									\
-		cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);		\
-		rcu_read_lock_dont_migrate();				\
-		bpf_cgroup_struct_ops_foreach(tcp_ops, item, cgrp,	\
-					      CGROUP_TCP_SOCK_OPS) {	\
-			if (tcp_ops->op)				\
-				tcp_ops->op(sk, ##__VA_ARGS__);		\
-		}							\
-		rcu_read_unlock_migrate();				\
+	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);			\
+	rcu_read_lock_dont_migrate();					\
+	bpf_cgroup_struct_ops_foreach(tcp_ops, item, cgrp,		\
+				      CGROUP_TCP_SOCK_OPS) {		\
+		if (tcp_ops->op)					\
+			tcp_ops->op(sk, ##__VA_ARGS__);			\
 	}								\
+	rcu_read_unlock_migrate();					\
+} while (0)
+
+#define bpf_tcp_ops_call(op, sk, ...)					\
+do {									\
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))			\
+		__bpf_tcp_ops_call(op, sk, ##__VA_ARGS__);		\
+} while (0)
+
+#define bpf_tcp_ops_call_flag(op, flag, sk, ...)			\
+do {									\
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) &&			\
+	    BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), flag))			\
+		__bpf_tcp_ops_call(op, sk, ##__VA_ARGS__);		\
 } while (0)
 
 #define bpf_tcp_ops_call_int(op, init_retval, sk, ...)			\
@@ -3115,7 +3126,9 @@ do {									\
 })
 
 #else
-#define bpf_tcp_ops_call(op, sk, ...)		do { } while (0)
+#define __bpf_tcp_ops_call(op, sk, ...)			do { } while (0)
+#define bpf_tcp_ops_call(op, sk, ...)			do { } while (0)
+#define bpf_tcp_ops_call_flag(op, flag, sk, ...)	do { } while (0)
 #define bpf_tcp_ops_call_int(op, init_retval, sk, ...)	(init_retval)
 #endif
 
@@ -3150,7 +3163,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
 	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
 		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
-	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
+
+	bpf_tcp_ops_call_flag(rtt, RTT, sk, mrtt, srtt);
 }
 
 #if IS_ENABLED(CONFIG_SMC)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 209db8effcc4..4478d3f3d4b0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 
 static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
+	const struct tcp_sock *tp;
+
+	if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
+		return;
+
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 	case TCP_SYN_SENT:
@@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 		return;
 	}
 
-	bpf_tcp_ops_call(parse_hdr, sk, skb);
+	tp = tcp_sk(sk);
+
+	if ((tp->rx_opt.saw_unknown &&
+	     BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
+	    BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
+		__bpf_tcp_ops_call(parse_hdr, sk, skb);
 }
 
 static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff *skb,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac465513bf5..313dfe70a386 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 	 * writer's bytes). The writer finds the append point by scanning from
 	 * first_opt_off + nr_written to the first NOP.
 	 */
-	bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
-			 first_opt_off + nr_written);
+	bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, req,
+			      syn_skb, synack_type, first_opt_off + nr_written);
 }
 #else
 static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
@@ -613,11 +613,12 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 {
 	unsigned int remaining_out = remaining, reserved;
 
-	if (!remaining)
-		return 0;
+	if (!BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT) ||
+	    !remaining)
+		return remaining;
 
 	/* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
-	bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
+	__bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
 
 	reserved = remaining - remaining_out;
 	if (!reserved)
@@ -630,6 +631,21 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	return remaining - reserved;
 }
 
+static __always_inline u32 tcp_bpf_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
+					       struct request_sock *req,
+					       struct sk_buff *syn_skb,
+					       enum tcp_synack_type synack_type,
+					       struct tcp_out_options *opts,
+					       u32 remaining)
+{
+	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
+		remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, req, syn_skb,
+						    synack_type, opts,
+						    remaining);
+
+	return remaining;
+}
+
 static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 				      const struct tcp_request_sock *tcprsk,
 				      struct tcp_out_options *opts,
@@ -1089,8 +1105,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 
 	remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 					  remaining);
-	remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-					    remaining);
+	remaining = tcp_bpf_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1179,8 +1195,8 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	remaining = bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 					  synack_type, opts, remaining);
-	remaining = bpf_tcp_ops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
-					    synack_type, opts, remaining);
+	remaining = tcp_bpf_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
+					synack_type, opts, remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
 }
@@ -1193,8 +1209,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 					struct tcp_key *key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	unsigned int size = 0;
 	unsigned int eff_sacks;
+	unsigned int remaining;
+	unsigned int size = 0;
 
 	opts->options = 0;
 	opts->bpf_opt_len = 0;
@@ -1224,10 +1241,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 * left.
 	 */
 	if (sk_is_mptcp(sk)) {
-		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
 		bool has_ts = opts->options & OPTION_TS;
 		int opt_size;
 
+		remaining = MAX_TCP_OPTION_SPACE - size;
 		opts->mptcp.drop_ts = 0;
 
 		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
@@ -1244,7 +1261,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
-		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		remaining = MAX_TCP_OPTION_SPACE - size;
+
 		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
 					TCPOLEN_SACK_PERBLOCK)) {
 			opts->num_sack_blocks =
@@ -1277,22 +1295,17 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
-		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-
+		remaining = MAX_TCP_OPTION_SPACE - size;
 		remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 						  remaining);
 
 		size = MAX_TCP_OPTION_SPACE - remaining;
 	}
 
-	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
-		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+	remaining = tcp_bpf_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					MAX_TCP_OPTION_SPACE - size);
 
-		remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-						    remaining);
-
-		size = MAX_TCP_OPTION_SPACE - remaining;
-	}
+	size = MAX_TCP_OPTION_SPACE - remaining;
 
 	return size;
 }
-- 
2.56.0.360.g66cac248cb-goog


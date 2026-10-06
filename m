Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F34AA586
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314786; cv=none; b=gB71T6oyerQLU5PxnKDJw5MlqBv2fzk9oBoAb7+pxpn4AZrxacpuHy6+9e/mDZT7MBtNT8nekXNEkgMuJd/2vuzGTFEfkqDQz/COaAUPEHVdcJoZaBRFDAhoMrFhrlt8hvevF/qSWo2hUpCYqQbMPnw2fOZ6VkeqCfn6RmLyxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314786; c=relaxed/simple;
	bh=6uVm94FU0Y8vFKur90aJBjdGiUNDRWjGVUanCf8ODGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOpscaBMH8tBIhJTPUtYzKg/o/2DY0NinzeACjHd+lcDoYaDlt83uavN5rPSga+5Jl8D1n9VCACE73nr7NNV1u++JKoqGJzon+Ety0lenD55cWx/SLA5LCHyaU/pR3cUGgrUMLzI4sVwgsY/VfxOK4ToaHz1vBByxZis/wQZRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PjS7GRc4; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PjS7GRc4"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc795ad1f5aso2166855a12.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314783; x=1791919583; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRPwcQVkqoLv+tAvCyjkuwsA49XBcClReddj7MbNUSU=;
        b=PjS7GRc4Ttyl/wL2CQlqDWXBit/IMKyO0H+obt9F9X9Kz47Lff19uKNdm9XwD+NzSc
         9UZtBZHkJskR/mxiWaR6XN1VEYmqYfJXdaCwt8nxrE/NKGQmhMIxxojkUk/UGpI56vmQ
         DvHEtCY8Z60VGXJQ4QjDnXuX+rR+TKExcm2WX03tT0MJuOPLJkYGMTL5Qi7I3uuK3Eul
         07KpAB+2KJ/NKTRHx5XSKyL8FSpqYH8kF/9u33x4ksk60FMtLD6p/2AdMU9Cpy1cX1XX
         QVWXHQ9nfFDcqr0dH91Fyt2EpdAMIp+BJjg7ro/X9rcIctPRdVyQ5/rLl8heP4jIgW0v
         TGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314783; x=1791919583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KRPwcQVkqoLv+tAvCyjkuwsA49XBcClReddj7MbNUSU=;
        b=E/YT8pO3FEB8TQA0EQwck7gVaGMVDARkvDHpBZK+Gxs6+tqatIifqYMykvwHppneZo
         kB+fS6B8PQMIkvXvxWWJtSWlwmMv1rloYsiOx1mUd7mOfVfdUdfowIR8llWhZEFJNYDG
         6E8LTnxR8nY4pMIJSzadFEmBD50RHaC7QJFCM2hpT++KMQCG921R8KhggOxVniN3qaKa
         /WGFeir64VXHPTTtWz+fl4rkcznKkli9dAe791prAnIyFkdLd2fNa10vqwrssFaWmKZQ
         DFcSqsX3laCPsuxMNXpnOJYTdSkXp1miahMLbdYk0/TWYmkguPkkqHczirjAlycv0NyZ
         6J9g==
X-Forwarded-Encrypted: i=1; AKwUvBwbWMtf8SKjGGLiKPGT6g9D0K7kIUfsxBMs4yVXYhR05zksz/P9DKNOeZFaPzITjDtIJLY=@vger.kernel.org
X-Gm-Message-State: AFuF++nZBfZ3aLB9CLmSetY9WcXWY8PIZXrJBtMv7ajs85b4H+VLmjDk
	dLOlHv6+zMA/pXSD6m+DGgnHi/77G6WU+EGm8w66mkn9gDX/d7zhenJx+SoGSkP5BTkwcD/CyKP
	kF6N2BA==
X-Received: from pggs22.prod.google.com ([2002:a63:dc16:0:b0:cc9:fb50:9e3f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c70b:b0:3e0:d91b:6c3
 with SMTP id adf61e73a8af0-3e134026ff5mr54934637.20.1791314783285; Tue, 06
 Oct 2026 12:26:23 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:30 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-5-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
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

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v4: Check static key first and then flags
---
 include/net/tcp.h     | 44 ++++++++++++++++++++++++++++---------------
 net/ipv4/tcp_input.c  | 12 +++++++++++-
 net/ipv4/tcp_output.c | 34 ++++++++++++++++-----------------
 3 files changed, 57 insertions(+), 33 deletions(-)

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
index 3ac465513bf5..8770f3084efe 100644
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
@@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 {
 	unsigned int remaining_out = remaining, reserved;
 
-	if (!remaining)
-		return 0;
+	if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
+	    !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
+	    !remaining)
+		return remaining;
 
 	/* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
-	bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
+	__bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
 
 	reserved = remaining - remaining_out;
 	if (!reserved)
@@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 					struct tcp_key *key)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-	unsigned int size = 0;
 	unsigned int eff_sacks;
+	unsigned int remaining;
+	unsigned int size = 0;
 
 	opts->options = 0;
 	opts->bpf_opt_len = 0;
@@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	 * left.
 	 */
 	if (sk_is_mptcp(sk)) {
-		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
 		bool has_ts = opts->options & OPTION_TS;
 		int opt_size;
 
+		remaining = MAX_TCP_OPTION_SPACE - size;
 		opts->mptcp.drop_ts = 0;
 
 		opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
@@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
-		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
+		remaining = MAX_TCP_OPTION_SPACE - size;
+
 		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
 					TCPOLEN_SACK_PERBLOCK)) {
 			opts->num_sack_blocks =
@@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
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
-
-		remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-						    remaining);
+	remaining = MAX_TCP_OPTION_SPACE - size;
+	remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					    remaining);
 
-		size = MAX_TCP_OPTION_SPACE - remaining;
-	}
+	size = MAX_TCP_OPTION_SPACE - remaining;
 
 	return size;
 }
-- 
2.56.0.360.g66cac248cb-goog


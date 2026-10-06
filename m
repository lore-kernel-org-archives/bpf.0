Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20714AB1D1
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314786; cv=none; b=qzFRrs77ifOO1qc7Caj/jFQexafb2iJO7VcWFjnkVg6jMxBL7cq3HEKYwW7LfXtO23qwAd5r+XjIJAgTLjYne6jYVZ/mNhltVCHIbNAaiUvWdouMPOaMnd9Jtq5pGe97pVLoPTiUfXl7jqLs074ApfAUUSa7qvE3rSQjdKzdO+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314786; c=relaxed/simple;
	bh=9yuFnigQCFlzJ06upnMsOHp/Od+u3UiubkoEfWP0N7U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+28zRc1jgKZSLDsPYjIZ/uZxBKEzmzyzGPQzFxT3P11MSTQ6JDqMkIVHPY21Tvh1OghK27sYa0sz35w8oDF/eHkNQkkvfni3wP6b6zf8SsARHUMI6OjdY8iHeGiWojYVC3ud/IcsKLz7WJAarZhYwBqHCAkmgwbvvF6peOyev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2Ri19u9; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2Ri19u9"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df8484f12cso33671305ad.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314784; x=1791919584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kq2NZtEFejmTaEIUH4QfBvTp/c57Pw0XwVcGqB+bQBw=;
        b=h2Ri19u9kNbgehJBdG3vo0vKweqtuOxTdrwoW5zko5KYp+Mt9qGGVdLtKG6usVNJKF
         /IqhDQca/sD52b34FAhxlFpernK4nREX95pNyYehvBYfeeHiGdn/hv6dG6qKGC2V9S3k
         8eOuCnMkTgorIkjQ1Co1XDejd3BEhBgS/vXZWXkHitk1Zl/Sgw8OdY6FPoLYyA8eovGS
         KAfIm3HO6Wx5O10Pu1sBwHMQn8K8ikLRXtt/WthGHKjYdYO2CrwjeKZC6N5mexbOewdL
         FWukQ9JSEOpYmlCMhyswIKPsB4xkAzDt2kOM8an42zZuPkLJCJDqInpwMdzvNd+H1Bh5
         mWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314784; x=1791919584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kq2NZtEFejmTaEIUH4QfBvTp/c57Pw0XwVcGqB+bQBw=;
        b=2YOtskKnCetn66uEgDWeQTUEUNISZSedos7gUrsQY0V8hMaBUZzqK5QpG32OoOZloB
         nzjPrqALgw3B8wJQ8HV9+Ky7polooSEYguWnD9nLq9liVLBnJ9ChCQNSij5mU2qKpsFZ
         nZZ73xKdfFOG06XtCSJO/9WCAVrfJI06LIeHMQzyWPNFBMz2RnCTbqPk5rTW6ERCJTXj
         ysoixox+CVL4V9Tzkim1rLTGvISZ//TC0qiVnuBwMA6kLZQjoQOvgQ0BCQEOaJqO/cW3
         TRpeoT8yufbSlqfhi+d7rQLhcmx664pYY2gFcJzBHZ4/LNnC55+lk4Zo20XucWcKAxO9
         lU+g==
X-Forwarded-Encrypted: i=1; AKwUvBz8b8LQhWQ6rEElMxUZmcJurG8KzN/gyKf5VTzrD2FYrsUzLE5k0S1T8hCrD1+YBV+6rMc=@vger.kernel.org
X-Gm-Message-State: AFuF++kvPjs09fWi878PmCoqEhXqUqKsFJn38Upz9CoNCPU04kTa2Gct
	Q1+XO7BRMHy4RSRmnap7buwUoAKpjE1O6Slq9tHLako+luECf4IoCuVd44BIxAvZfcy499fr1we
	313breg==
X-Received: from pgp4-n2.prod.google.com ([2002:a05:6a02:62c4:20b0:cc7:9b89:2a72])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3418:b0:3de:53c1:b627
 with SMTP id adf61e73a8af0-3e1340996a6mr41449637.43.1791314783965; Tue, 06
 Oct 2026 12:26:23 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:31 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-6-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
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

BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
with cgroup_bpf_enabled().

However, even when no SOCK_OPS prog is attached, callers still
initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
from a cold cacheline near the end of struct tcp_sock.

Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.

Since all direct callers of tcp_call_bpf() pass 0 and NULL for
nargs and args, they can be folded into the new tcp_call_bpf()
macro.

All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
and do not need the return value.  These are replaced with the new
tcp_call_bpf_flag() macro.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/bpf-cgroup.h | 36 ++++++++++--------------
 include/net/tcp.h          | 56 ++++++++++++++++----------------------
 net/ipv4/af_inet.c         |  2 +-
 net/ipv4/tcp.c             |  3 +-
 net/ipv4/tcp_input.c       | 21 ++++++++------
 net/ipv4/tcp_nv.c          |  2 +-
 net/ipv4/tcp_output.c      | 31 +++++++++------------
 net/ipv4/tcp_timer.c       |  6 ++--
 8 files changed, 69 insertions(+), 88 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8a75a6cd7309..02ef7f899b3d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -345,27 +345,19 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
  * calling bpf_setsockopt on listener-sk will not make sense anyway,
  * so passing 'sock_ops->sk == req_sk' to the bpf prog is appropriate here.
  */
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(sock_ops, sk)			\
-({									\
-	int __ret = 0;							\
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))			\
-		__ret = __cgroup_bpf_run_filter_sock_ops(sk,		\
-							 sock_ops,	\
-							 CGROUP_SOCK_OPS); \
-	__ret;								\
-})
-
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops)				       \
-({									       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) && (sock_ops)->sk) {       \
-		typeof(sk) __sk = sk_to_full_sk((sock_ops)->sk);	       \
-		if (__sk && sk_fullsock(__sk))				       \
-			__ret = __cgroup_bpf_run_filter_sock_ops(__sk,	       \
-								 sock_ops,     \
-							 CGROUP_SOCK_OPS); \
-	}								       \
-	__ret;								       \
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(sock_ops, sk)				\
+	__cgroup_bpf_run_filter_sock_ops(sk, sock_ops,				\
+					 CGROUP_SOCK_OPS)
+
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops)				\
+({										\
+	int __ret = 0;								\
+	typeof(sk) __sk = sk_to_full_sk((sock_ops)->sk);			\
+	if (__sk && sk_fullsock(__sk))						\
+		__ret = __cgroup_bpf_run_filter_sock_ops(__sk,			\
+							 sock_ops,		\
+							 CGROUP_SOCK_OPS);	\
+	__ret;									\
 })
 
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access)	      \
@@ -529,7 +521,7 @@ static inline int cgroup_bpf_struct_ops_attach(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b7c0f1a8797a..85b4bfe963d3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2891,7 +2891,7 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
  * program loaded).
  */
 #ifdef CONFIG_BPF
-static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+static inline int __tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
 	struct bpf_sock_ops_kern sock_ops;
 	int ret;
@@ -2908,7 +2908,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	if (nargs > 0)
 		memcpy(sock_ops.args, args, nargs * sizeof(*args));
 
-	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	ret = __BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 	if (ret == 0)
 		ret = sock_ops.reply;
 	else
@@ -2916,20 +2916,23 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	return ret;
 }
 
-static inline int tcp_call_bpf_2arg(struct sock *sk, int op, u32 arg1, u32 arg2)
-{
-	u32 args[2] = {arg1, arg2};
-
-	return tcp_call_bpf(sk, op, 2, args);
-}
-
-static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
-				    u32 arg3)
-{
-	u32 args[3] = {arg1, arg2, arg3};
+#define tcp_call_bpf(sk, op)						\
+({									\
+	int __ret = 0;							\
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS)) {			\
+		__ret = __tcp_call_bpf(sk, op, 0, NULL);		\
+	}								\
+	__ret;								\
+})
 
-	return tcp_call_bpf(sk, op, 3, args);
-}
+#define tcp_call_bpf_flag(sk, op, ...)					\
+do {									\
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&			\
+	    BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), op ## _FLAG)) {		\
+		u32 __args[] = { __VA_ARGS__ };				\
+		__tcp_call_bpf(sk, op, ARRAY_SIZE(__args), __args);	\
+	}								\
+} while (0)
 
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
@@ -2938,21 +2941,12 @@ static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 }
 
 #else
-static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
-{
-	return -EPERM;
-}
-
-static inline int tcp_call_bpf_2arg(struct sock *sk, int op, u32 arg1, u32 arg2)
+static inline int tcp_call_bpf(struct sock *sk, int op)
 {
 	return -EPERM;
 }
 
-static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
-				    u32 arg3)
-{
-	return -EPERM;
-}
+#define tcp_call_bpf_flag(sk, op, ...) do { } while (0)
 
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
@@ -3136,7 +3130,7 @@ static inline u32 tcp_timeout_init(struct sock *sk)
 {
 	int timeout;
 
-	timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT, 0, NULL);
+	timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT);
 	timeout = bpf_tcp_ops_call_int(timeout_init, timeout, sk);
 	if (timeout <= 0)
 		timeout = TCP_TIMEOUT_INIT;
@@ -3147,7 +3141,7 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 {
 	int rwnd;
 
-	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT, 0, NULL);
+	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT);
 	rwnd = bpf_tcp_ops_call_int(rwnd_init, rwnd, sk);
 	if (rwnd < 0)
 		rwnd = 0;
@@ -3156,14 +3150,12 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 
 static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
 {
-	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN, 0, NULL) == 1);
+	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) == 1);
 }
 
 static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
-		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
-
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
 	bpf_tcp_ops_call_flag(rtt, RTT, sk, mrtt, srtt);
 }
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index cdcfc7d3c6d2..035c83338e0f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -226,7 +226,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
 		if (err)
 			return err;
 
-		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
+		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB);
 		bpf_tcp_ops_call(listen, sk);
 	}
 	return 0;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fa69961c47d3..5d9d3bcde8f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2994,8 +2994,7 @@ void tcp_set_state(struct sock *sk, int state)
 	 */
 	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG))
-		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
 	bpf_tcp_ops_call(set_state, sk, state);
 
 	switch (state) {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4478d3f3d4b0..f374257013b1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -146,14 +146,16 @@ EXPORT_SYMBOL_GPL(clean_acked_data_flush);
 #ifdef CONFIG_CGROUP_BPF
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
-	bool unknown_opt = tcp_sk(sk)->rx_opt.saw_unknown &&
-		BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-				       BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG);
-	bool parse_all_opt = BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-						    BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG);
 	struct bpf_sock_ops_kern sock_ops;
+	const struct tcp_sock *tp;
+
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		return;
 
-	if (likely(!unknown_opt && !parse_all_opt))
+	tp = tcp_sk(sk);
+	if (!(tp->rx_opt.saw_unknown &&
+	      BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG)) &&
+	    !BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG))
 		return;
 
 	/* The skb will be handled in the
@@ -176,7 +178,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
-	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	__BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 
 static void bpf_skops_established(struct sock *sk, int bpf_op,
@@ -184,6 +186,9 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 {
 	struct bpf_sock_ops_kern sock_ops;
 
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		return;
+
 	sock_owned_by_me(sk);
 
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
@@ -195,7 +200,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
-	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	__BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index f345897a68df..7b0dae23d9aa 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -146,7 +146,7 @@ static void tcpnv_init(struct sock *sk)
 	 * within a datacenter, where we have reasonable estimates of
 	 * RTTs
 	 */
-	base_rtt = tcp_call_bpf(sk, BPF_SOCK_OPS_BASE_RTT, 0, NULL);
+	base_rtt = tcp_call_bpf(sk, BPF_SOCK_OPS_BASE_RTT);
 	if (base_rtt > 0) {
 		ca->nv_base_rtt = base_rtt;
 		ca->nv_lower_bound_rtt = (base_rtt * 205) >> 8; /* 80% */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8770f3084efe..db4fd1825d99 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -476,8 +476,9 @@ static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	struct bpf_sock_ops_kern sock_ops;
 	int err;
 
-	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS) ||
+	    !BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+				    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)||
 	    !remaining)
 		return remaining;
 
@@ -518,7 +519,7 @@ static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, 0);
 
-	err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+	err = __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 
 	if (err || sock_ops.remaining_opt_len == remaining)
 		return remaining;
@@ -543,7 +544,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 
 	first_opt_off = tcp_hdrlen(skb) - max_opt_len;
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
 				   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) {
 		struct bpf_sock_ops_kern sock_ops;
 		int err;
@@ -567,7 +569,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_ops.remaining_opt_len = max_opt_len;
 		bpf_skops_init_skb(&sock_ops, skb, first_opt_off);
 
-		err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+		err = __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 		if (!err)
 			nr_written = max_opt_len - sock_ops.remaining_opt_len;
 	}
@@ -1279,16 +1281,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		}
 	}
 
-	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
-		remaining = MAX_TCP_OPTION_SPACE - size;
-		remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-						  remaining);
-
-		size = MAX_TCP_OPTION_SPACE - remaining;
-	}
-
 	remaining = MAX_TCP_OPTION_SPACE - size;
+
+	remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
+					  remaining);
 	remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 					    remaining);
 
@@ -3725,9 +3721,8 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
 	}
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
-		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
-				  TCP_SKB_CB(skb)->seq, segs, err);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RETRANS_CB,
+			  TCP_SKB_CB(skb)->seq, segs, err);
 	bpf_tcp_ops_call(retrans, sk, skb, err);
 
 	if (unlikely(err) && err != -EBUSY)
@@ -4355,7 +4350,7 @@ int tcp_connect(struct sock *sk)
 	struct sk_buff *buff;
 	int err;
 
-	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
+	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB);
 	bpf_tcp_ops_call(connect, sk);
 
 #if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3d49adc51766..00debcba122b 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -286,10 +286,8 @@ static int tcp_write_timeout(struct sock *sk)
 	tcp_fastopen_active_detect_blackhole(sk, expired);
 	mptcp_active_detect_blackhole(sk, expired);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
-		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RTO_CB,
-				  icsk->icsk_retransmits,
-				  icsk->icsk_rto, (int)expired);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RTO_CB,
+			  icsk->icsk_retransmits, icsk->icsk_rto, (int)expired);
 	bpf_tcp_ops_call(rto, sk);
 
 	if (expired) {
-- 
2.56.0.360.g66cac248cb-goog


Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF536F914
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429372; cv=none; b=dPMhSaHzOTZoHNErMwAgenkpe82s+BfevtxJe9PahD8p8rX0ItPscLnweuOPVqmPiiIfrE7u5klC/UjqtBUTUfq47Kqg626ggCgYPfe/xVB6CW37mJZ1x/B8CuQkSRlsCnfzmmcLpmPtzW1ycBeEOBW74sd/nO3FzGW/ZGlU9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429372; c=relaxed/simple;
	bh=L/Gve3d6fJChejXQHIFSpof0NtkIU3dD87CrAVPfmcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ieJZwmuh6QRlYbKc6srV534CqGNcsLjl5DVn04q2MhbfKIiAsWEAvk++uBrb384GiDIXz7gZ1lBJYlPnRgbf4DTvkQocp5gaBA4sr4CcLrgRpq7BtbeEL4oZICOJTng7nsHGApKMfzzsX+A0ZMOG2s+UER93bV40lXmdpm7r5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njh//CW3; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njh//CW3"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2df5a65671eso3404295ad.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429370; x=1792034170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW4J1cktdrGp6U910rfCG+2wJ07QSRd+mxo56lz/YuQ=;
        b=njh//CW3WTigFk74KiY40nTvgiy8sOtmBu7OBkJ24PjZ0YIwZku6UaK9eh1saXqfyO
         u0uKLXaNdEz08Q75A5LvqQMa4O6Ud/vp6vkzdXALDsUHUFUqLebQ0/vyHl8UM8QpDPWM
         YQgS/yfn0rcd52dJMVaH5N5ULqu+L4picjuRb+v3SNyzV/uznZySvNy3VpTBT6TQX8I4
         7FaZJR9jnJsD+5fvpQPaIjA8RvXCq7WE/pWYT8t9iKrmqi4B73S5ruOI1M8ubjnG6LN5
         votwRgTbbhLcBQRsjn3zIM/AezFUFxdxjIVsMOpoDNC2vZbLY03w7WTDbwoID8lHIwWP
         XX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429370; x=1792034170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SW4J1cktdrGp6U910rfCG+2wJ07QSRd+mxo56lz/YuQ=;
        b=Mfi5pX9fj6k6zJ3SAKCppnKcrwTDtl+iRTQxs8GB+csA/jVIPVeSWvLvYs9E7xaKJx
         aP8KdZfEn+wn/c8q14WidvyaPiyCkGLDsnjfyPtAqyXw7bp5u5WakbR8E2Mi0/evrUZ3
         dzJOeqJq+LuHdyyrr5UvKUiB8Kcl6lAP8IRo+XSY658puydtMRhuXbaS0wERpf8uAbiZ
         ob1pyZDkZ4lXn6V3C2EMXPaBWxkZRN24YkHCes61MEGuPAFNNiOZHh/cMBgNj8Bu4SAP
         ZP6qj0sAZuQc6s0NPxivAP0jm6KCFjPXV7tvImPlDJgA+TKSZc5uMkcPe5otGxpnybCa
         yStQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+d9/biHHezg12LqxjP78MW1Q28MIs6BDKcRPENW1KdGq0mkmXMo77MoAI8bhiZnJ+OmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUiIvaHDbOndSPtgag0KLZI8NrfqOe0o9rMVs7eTmJMUplCPKw
	Yjbw4uiYl2nrNisj0kpWg4dnj+sBxFAnGfkceSOuN/nU42dTjQ8yew70kscQ4e9tXpCMxftSoZP
	nwDeh6w==
X-Received: from plbja7.prod.google.com ([2002:a17:902:efc7:b0:2e5:73a6:1b6c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea11:b0:2dd:86a3:232d
 with SMTP id d9443c01a7336-2e7ffed37e9mr6267275ad.8.1791429368525; Wed, 07
 Oct 2026 20:16:08 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:22 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-3-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 02/10] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
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

The legacy SOCK_OPS guards some hooks with a per-socket flag,
tp->bpf_sock_ops_cb_flags.

In contrast, bpf_tcp_ops was initially designed without per-socket
flags so that users can simply define only the callbacks they need.

However, it turned out that even attaching a bpf_tcp_ops with a NULL
callback incurs measurable overhead in the fast path. [0]

We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
1 bit left for a new opt-in callback, while not all of the 7 existing
opt-in hooks are in the fast path and really need a flag guard.

Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
update it, both of which require sock_owned_by_me(sk):

  * bpf_sock_ops_cb_flags_set()
  * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)

Both helpers only overwrite the field, which leads to reading and
modifying the flags in the BPF prog and then writing them back
via the helper.  This prevents use from the fast path (tc or
cgroup_skb) hooks where bh_lock_sock() alone cannot prevent races
with process context.

Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
tcp_sock_read_txrx cacheline group, along with a new kfunc,
bpf_tcp_ops_set_flags().

bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
disable and updates tp->bpf_tcp_ops_flags atomically via
try_cmpxchg() without relying on lock_sock().

The kfunc is exposed to bpf_tcp_ops, BPF_PROG_TYPE_CGROUP_SOCKOPT,
and BPF_PROG_TYPE_CGROUP_SKB.

The first argument is struct tcp_sock * so that bpf_tcp_sock() etc
is required for cgroup hooks, but not for bpf_tcp_ops where struct
sock * is promoted to struct tcp_sock * automatically.

The fast-path callbacks will be guarded by the new flags in a later
patch after updating the existing selftest to avoid breaking bisection.

Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
---
v4:
  * Allow-listed BPF_PROG_TYPE_CGROUP_SOCKOPT and _SKB
    in bpf_tcp_ops_set_flags_kfunc_filter()
  * Add doc for flag enum and bpf_tcp_ops members
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  7 +++
 include/net/tcp.h                             | 11 +++-
 include/uapi/linux/bpf.h                      | 23 +++++++
 net/ipv4/bpf_tcp_ops.c                        | 61 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +
 tools/include/uapi/linux/bpf.h                | 23 +++++++
 7 files changed, 127 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 0f6088c4ab8b..420fc6278148 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -151,6 +151,7 @@ u32                           urg_seq
 unsigned_int                  keepalive_time
 unsigned_int                  keepalive_intvl
 int                           linger2
+u32                           bpf_tcp_ops_flags       read_mostly         read_mostly         bpf_tcp_ops_hdr_opt_len,bpf_skops_write_hdr_opt(tx);bpf_tcp_ops_parse_hdr,tcp_bpf_rtt(rx);
 u8                            bpf_sock_ops_cb_flags
 u8:1                          bpf_chg_cc_inprogress
 u16                           timeout_rehash
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322..24bb751cc65a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -233,6 +233,13 @@ struct tcp_sock {
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
 		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
+#ifdef CONFIG_BPF
+	u32	bpf_tcp_ops_flags;
+#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) \
+	(READ_ONCE((TP)->bpf_tcp_ops_flags) & BPF_TCP_OPS_FLAG_ ## ARG)
+#else
+#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) (0)
+#endif
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4ecabf4989de..55ad9db99596 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2934,6 +2934,7 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+	WRITE_ONCE(tcp_sk(sk)->bpf_tcp_ops_flags, 0);
 }
 
 #else
@@ -2989,7 +2990,7 @@ struct bpf_tcp_ops {
 	/* Called when the retransmission timer fires. */
 	void (*rto)(struct sock *sk);
 
-	/* Called on every RTT sample.
+	/* Called on every RTT sample if BPF_TCP_OPS_FLAG_RTT is enabled.
 	 * @mrtt: the measured RTT, in microseconds.
 	 * @srtt: the updated smoothed RTT.
 	 */
@@ -3016,6 +3017,10 @@ struct bpf_tcp_ops {
 	 * Parse the TCP header options of an incoming skb received on an
 	 * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load_bytes()
 	 * to access the options.
+	 *
+	 * Called if BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL is enabled, or if
+	 * BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN is enabled and an unknown
+	 * option is received.
 	 */
 	void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);
 
@@ -3023,6 +3028,8 @@ struct bpf_tcp_ops {
 	 * Reserve space in the outgoing TCP header for options to be written
 	 * later by write_hdr_opt(). Call bpf_reserve_hdr_opt() to reserve bytes.
 	 *
+	 * Called if BPF_TCP_OPS_FLAG_WRITE_HDR_OPT is enabled.
+	 *
 	 * @skb: outgoing packet. NULL when called from tcp_current_mss()
 	 *       (MSS sizing).
 	 * @req: request_sock on the synack path; NULL otherwise.
@@ -3041,6 +3048,8 @@ struct bpf_tcp_ops {
 	 * Use bpf_store_hdr_opt() to write; it appends within the reserved window
 	 * shared with legacy SOCKOPS.
 	 *
+	 * Called if BPF_TCP_OPS_FLAG_WRITE_HDR_OPT is enabled.
+	 *
 	 * @skb: outgoing packet.
 	 * @req: request_sock on the synack path; NULL otherwise.
 	 * @syn_skb: incoming SYN on the synack path; NULL otherwise.
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e0ed44b1bbcb..6963c146311e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7340,6 +7340,29 @@ enum {
 					 */
 };
 
+/*
+ * Most callbacks of struct bpf_tcp_ops are placed in the slow
+ * path (e.g., one-shot connection setup or unlikely events like
+ * timers) and are invoked simply by defining non-NULL callbacks.
+ *
+ * Callbacks in the fast path, however, would incur noticeable
+ * overhead even when set to NULL, so they are disabled by default
+ * and must be explicitly enabled per socket via bpf_tcp_ops_set_flags().
+ *
+ * The flags are per-socket and shared by all effective bpf_tcp_ops
+ * programs.
+ */
+enum {
+	/* .rtt() */
+	BPF_TCP_OPS_FLAG_RTT			= (1 << 0),
+	/* .parse_hdr() */
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
+	/* .hdr_opt_len() and .write_hdr_opt() */
+	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+};
+
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
  * changes between the TCP and BPF versions. Ideally this should never happen.
  * If it does, we need to add code to convert them before calling
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 1ada3b781bf1..aaf96304c69f 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -328,8 +328,67 @@ static struct bpf_struct_ops bpf_tcp_ops = {
 	.owner = THIS_MODULE,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock *tp, u32 enable, u32 disable)
+{
+	u32 old, new;
+
+	if ((enable & disable) || (enable | disable) & ~BPF_TCP_OPS_FLAG_ALL)
+		return -EINVAL;
+
+	old = READ_ONCE(tp->bpf_tcp_ops_flags);
+
+	do {
+		new = (old | enable) & ~disable;
+		if (new == old)
+			break;
+	} while (!try_cmpxchg(&tp->bpf_tcp_ops_flags, &old, new));
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_tcp_ops_set_flags_kfunc_set)
+BTF_ID_FLAGS(func, bpf_tcp_ops_set_flags)
+BTF_KFUNCS_END(bpf_tcp_ops_set_flags_kfunc_set)
+
+static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *prog,
+					      u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_tcp_ops_set_flags_kfunc_set, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->st_ops == &bpf_tcp_ops)
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT ||
+	    prog->type == BPF_PROG_TYPE_CGROUP_SKB)
+		return 0;
+
+	return -EACCES;
+}
+
+static const struct btf_kfunc_id_set bpf_tcp_ops_set_flags_kfunc_id_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_tcp_ops_set_flags_kfunc_set,
+	.filter = bpf_tcp_ops_set_flags_kfunc_filter,
+};
+
 static int __init __bpf_tcp_ops_init(void)
 {
-	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_tcp_ops_set_flags_kfunc_id_set);
+	/* BPF_PROG_TYPE_CGROUP_{SOCKOPT,SKB} share BTF_KFUNC_HOOK_CGROUP. */
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
+					       &bpf_tcp_ops_set_flags_kfunc_id_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+
+	return ret;
 }
+
 late_initcall(__bpf_tcp_ops_init);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 650a2e89950a..fa69961c47d3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5217,6 +5217,9 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, lost_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, sacked_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, scaling_ratio);
+#ifdef CONFIG_BPF
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, bpf_tcp_ops_flags);
+#endif
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e0ed44b1bbcb..6963c146311e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7340,6 +7340,29 @@ enum {
 					 */
 };
 
+/*
+ * Most callbacks of struct bpf_tcp_ops are placed in the slow
+ * path (e.g., one-shot connection setup or unlikely events like
+ * timers) and are invoked simply by defining non-NULL callbacks.
+ *
+ * Callbacks in the fast path, however, would incur noticeable
+ * overhead even when set to NULL, so they are disabled by default
+ * and must be explicitly enabled per socket via bpf_tcp_ops_set_flags().
+ *
+ * The flags are per-socket and shared by all effective bpf_tcp_ops
+ * programs.
+ */
+enum {
+	/* .rtt() */
+	BPF_TCP_OPS_FLAG_RTT			= (1 << 0),
+	/* .parse_hdr() */
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
+	/* .hdr_opt_len() and .write_hdr_opt() */
+	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+};
+
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
  * changes between the TCP and BPF versions. Ideally this should never happen.
  * If it does, we need to add code to convert them before calling
-- 
2.56.0.360.g66cac248cb-goog


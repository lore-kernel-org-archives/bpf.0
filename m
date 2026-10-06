Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424449E15F
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314784; cv=none; b=ZWoQM932baj32vIdiR5S2cu6OLlira5yUOD7hQ70hoUhIFAXhmVbgiflSSzaVV9x1KpCDRO5icMyHTfuIpHmKUKMjuci6MGDA0VxgrSsyW7BaaIJEcq4G5FmlbOMyAP1WR3LbBxUm9ME9vZ4H/mJH0vKdYiWHYp5BA4jDbgbllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314784; c=relaxed/simple;
	bh=ZOAoRc2M50njJUUKykOU0bdHrAdfDOL+fbjBMwNHAo4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KL5LfsBIK4tWi/EGikIxvsU/iUkwwObYWqIJq3U4OnA32hd/ww7D/5B0iploy+OzPw8hjzE80FSkVZPYw3hn4huMNHM4fRuZl//MKtrrHu6//Cr2wUr46sMImuOLGYweIVcn/9tShkxLKUhJKa72+VtH50lh9GgG+xNAw4LoRGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AtjlCQdX; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AtjlCQdX"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a4f7eb79f2so3182494a91.1
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314782; x=1791919582; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/EUGJz4R5SHZ2UsbobMqtnsDm5Nyfhf0/nXlO7pomQ=;
        b=AtjlCQdXtNMBQRpm4pzr6txHrLbFkD4JLqchXA6NrDAzv8tcyyVM8rVtAASoxHY0BW
         6ocAbEfhF5VgKfkVXrJKM8XwG+ThPcBejgh2aLvNu9CZ97Qksed1Puiyi6CaIHN2WyP2
         ktLgJxW0MV+SSG+YqYRrWHRybIr4wcTpQOmYd4nJisOiJeDGzC/xxDG5ICKRoId8u0iY
         Qf3shoddFPIywNdQP3O223MMw/U/KcC06a02Gbm2wzLHij3K0IDVQyhFKx4YlCg+5SHu
         CQ2ULGcNcEeWKDbSuq46kdNHRImr9Sguhe7uI7Ym1pHvki9HkKSkJvGYEGIrUouVY3qn
         Yurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314782; x=1791919582;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/EUGJz4R5SHZ2UsbobMqtnsDm5Nyfhf0/nXlO7pomQ=;
        b=zGfsntEOB9iLf5O0AkpnUtZDf9gIMAYF9qRes+2IjcMg6h1BhvZWZ758S155d6B2wt
         sZXOXbR2QT8UmpwWJDuPpHQ2j4hn2EVrT8UHmpfZ7IVH3pEnls5jh6bwDXARk6DmV3Vv
         30vRkGXybeI2dokzHR8XvHQA6OnhEavxkmZ8zTsKLyLnP4SuitTIgAM6RSsV0CcmIcEy
         hDpTIjnT+fsF8pYXV415FS0OzyaMndlipdK35l1Qh+pSBW8cwsKYmfrfaRCpJh9FAWYE
         qBY4jh6qncTHdcBg9NEB/UIBt9fMUG1XhMVU1iE/9YpuY807PRKnRu4YsGDsqHWP061O
         wiqw==
X-Forwarded-Encrypted: i=1; AKwUvBz6oAtS2SRI6j03ut3OzlVmQgfokCQMOpBlUhAYKq/7KSXfvqWk3ohGjgY/lgIT5DUey/g=@vger.kernel.org
X-Gm-Message-State: AFuF++klJc5RRDPEMlmnyL3CbL1xEa9nnVekmRUTYMFrHDG83ZBNtxJB
	FAxXsSLyIIJS+ln5jt0SVyjyQfJw/KGq4aviXT8tKDMpBQDJxXbkGHo4hgRmJ6Wi9Pw8C4yU/5o
	5wtiMKw==
X-Received: from pgbcu9.prod.google.com ([2002:a05:6a02:2189:b0:cca:4550:d5d6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a82:b0:3d2:df:1854
 with SMTP id adf61e73a8af0-3e133d95b8emr58953637.6.1791314781635; Tue, 06 Oct
 2026 12:26:21 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:28 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-3-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 02/10] bpf: tcp: Add a new per-socket flag and
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


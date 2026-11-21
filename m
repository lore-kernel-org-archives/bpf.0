Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257237;
	b=22VUnwmEeJ/Zyq+r4/osAaTLtS4rUJzWPFlpABAI32e07bTgOhU4dkH8iQtA3WmKnR+r
	 GztEJNm3mlYR54DbavO6nMq5ite6RVWIBvMYI0MaIZ4gJnnmlzdcTXSD7Q9HwU8nDPMDq
	 p/NlW6o3/eLpPAf20egsj7C0XYmk5hC/F3j4YjHwTnUJql+yE9qq8u+N5b2fN9jorhKbi
	 zItaCKQgAFTdG66X1Ih2lk+E2CXgrCF06Y7DhQVC4fJ9QADBSPHPnMO5PMcLJ4vYjKUYd
	 YtDA1TjBzHrj4slYNgSNQOV0DYRV3xtt4cmF9ZFC5WvhwkqgHYrVjwILwracIXJzavQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257237;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YPWQy6tXZ2BtrJnEU05o+nAPOoRyOLYxRxI7hlvqBFU=;
	b=PW1M3qnHh5ZxvQzReUpx7ouoE/leIDdXNhnVtZ1l9lBk8HPk0/JTcFVs+Y0ivfQ5zZRd
	 BJ6UTEexZdXc3wPU8MhO9v4LgjCNGaic1a8GC13mM0k6Iy/yp1GoU7niyxU1B3EZgVTU/
	 bhPDG33xrizFnkoQyZhDyL2l8RAGF6ZHXWVnoAxZZMlLQXUv3E7dDiu6jzVLhAqjBW3Xm
	 BSGpf2hvtLRAe8Xh71l5JzTpcMYVVim2/U6SS/WHa3xU2ivMywbuJDTlzTgPYzoTT12lV
	 YratSK5EfAVdCy7GcbIZ3+C9/zsE4c+IkfJkMDN5Vg0jzOJJECmiUbaqzxOs3hHMeOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YUnFNcoO;
	arc=none smtp.remote-ip=91.218.175.226
Received: from mta0.migadu.com (out-226.mta0.migadu.com [91.218.175.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E9606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 10:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564E9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YUnFNcoO
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ecquvy0LLbyxzPk3DVJ6KSO95ySs2S2dxgtgRE1YmDE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795257234; v=1; x=1795862034;
 b=YUnFNcoO3SnXODFAALEIEaBSFjg8Rbykeq6RG1vxspHBvxBoJ0aqhykFEAWDvEhFPUK/MdYO
 pas3SwnUsNBuwo0d4Do2c7RyznU5Ipy5S/wiqcwj+T6zwBn2hM+VSElZfoRWIiSPBOoUwH8/jmZ
 NE/UCh13zGKEi7VMFSLC1t/k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 046055c0217f7f62;
	Sat, 21 Nov 2026 10:33:54 +0000
X-Mizu-Trace-ID: 046055c0217f7f62
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mattia Meleleo <mattia.meleleo@coralogix.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 03/11] bpf, sockmap: Fix strparser reinit after the parser link is removed
Date: Sat, 21 Nov 2026 18:30:04 +0800
Message-ID: <20261121103222.88209-4-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121103222.88209-1-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A socket can sit in several sockmaps at once, so a psock can outlive
the link that brought the stream parser. When that link goes away,
sock_map_del_link() can only call sk_psock_stop_strp(), which marks the
strparser stopped. strp_done(), which cancels the message timer and the
work and frees the partial skb, needs lock_sock() and sync cancels and
is only run from sk_psock_destroy(). With another link holding the
psock, destroy never comes and the strparser stays in that half state.

Adding the socket to another map with a parser then goes through
sk_psock_init_strp() again, because progs.stream_parser and
saved_data_ready were both cleared. strp_init() memsets the strparser
and reinits its work and timer while the old timer may still be on the
timer wheel and the old work may still be queued. The partial skb is
leaked. Once the timer fires, __run_timers() unlinks a timer_list that
no longer matches the wheel and delayed_work_timer_fn() dereferences
the zeroed wq:

  BUG: KASAN: slab-use-after-free in __run_timers+0xa7d/0xab0
  Write of size 8 at addr ffff888001ed40e0 by task systemd-journal/148
  Call Trace:
   <IRQ>
   __run_timers+0xa7d/0xab0
   run_timer_base+0x107/0x190
   run_timer_softirq+0x1a/0x40
   handle_softirqs+0x251/0xa70
   __irq_exit_rcu+0x1a8/0x260
   irq_exit_rcu+0xe/0x30
   sysvec_apic_timer_interrupt+0xc2/0x110
   </IRQ>
  Allocated by task 756:
   sk_psock_init+0x187/0x850
   sock_map_link+0x7d8/0xcf0
   sock_map_update_common+0xbd/0x6c0
   sock_map_update_elem_sys+0x324/0x460
  Freed by task 684:
   sk_psock_destroy+0x847/0xb30
   process_one_work+0x93a/0x1b60

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038
  KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
  RIP: 0010:__queue_work+0x94/0x1850
  Call Trace:
   <IRQ>
   delayed_work_timer_fn+0x5d/0xa0
   call_timer_fn+0x17d/0x510
   __run_timers+0x4e5/0xab0
   run_timer_base+0x107/0x190
   run_timer_softirq+0x1a/0x40
   </IRQ>

Finish the strparser when the parser link is removed instead of waiting
for the psock to die. sock_map_del_link() cannot sleep, so take a psock
reference and queue sk_psock_destroy() on psock->rwork with
SK_PSOCK_STRP_DONE_PENDING set. The work then only runs strp_done(),
clears SK_PSOCK_RX_STRP_ENABLED and drops the reference. The work holds
the psock, so the normal destroy cannot be queued before it finishes,
and the final put may requeue rwork for the real destroy from inside
the handler.

sock_map_link() refuses to attach a parser while
SK_PSOCK_RX_STRP_ENABLED is still set, under sk_callback_lock together
with the bit updates. sock_map_update_elem_sys() flushes the pending
work before taking the socket lock, so userspace can remove a parser and
attach a new one back to back without seeing -EBUSY.

BPF programs updating a sockmap (sockops helpers, iterator, sk_lookup
and sk_reuseport programs) cannot wait and may get a transient -EBUSY
if they add a socket to a parser map right after its parser link was
removed. Before this change the same sequence reinitialized a live
strparser, so this is the better outcome.

The psock now also lives a little longer after the last link to a
parser map is removed, until the work has run. A TLS upgrade attempted
in that window is rejected like for any socket with a psock.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  6 ++++++
 net/core/skmsg.c      | 24 ++++++++++++++++++++++++
 net/core/sock_map.c   | 39 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index f0e27b4b929f1..276692e060d53 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -68,6 +68,7 @@ struct sk_psock_progs {
 enum sk_psock_state_bits {
 	SK_PSOCK_TX_ENABLED,
 	SK_PSOCK_RX_STRP_ENABLED,
+	SK_PSOCK_STRP_DONE_PENDING,
 };
 
 struct sk_psock_link {
@@ -459,6 +460,7 @@ void sk_psock_stop(struct sk_psock *psock);
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock);
 void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock);
+void sk_psock_queue_strp_done(struct sk_psock *psock);
 #else
 static inline int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
@@ -472,6 +474,10 @@ static inline void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
 static inline void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 {
 }
+
+static inline void sk_psock_queue_strp_done(struct sk_psock *psock)
+{
+}
 #endif
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 16f84dcb5acd9..43dc128841e98 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -879,6 +879,18 @@ static void sk_psock_destroy(struct work_struct *work)
 {
 	struct sk_psock *psock = container_of(to_rcu_work(work),
 					      struct sk_psock, rwork);
+
+	if (sk_psock_test_state(psock, SK_PSOCK_STRP_DONE_PENDING)) {
+		/* Parser link gone, other links keep the psock alive */
+		sk_psock_done_strp(psock);
+		write_lock_bh(&psock->sk->sk_callback_lock);
+		sk_psock_clear_state(psock, SK_PSOCK_RX_STRP_ENABLED);
+		sk_psock_clear_state(psock, SK_PSOCK_STRP_DONE_PENDING);
+		write_unlock_bh(&psock->sk->sk_callback_lock);
+		sk_psock_put(psock->sk, psock);
+		return;
+	}
+
 	/* No sk_callback_lock since already detached. */
 
 	sk_psock_done_strp(psock);
@@ -1208,6 +1220,18 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
 	strp_stop(&psock->strp);
 }
 
+/* Called with sk_callback_lock held while a link still holds the psock */
+void sk_psock_queue_strp_done(struct sk_psock *psock)
+{
+	if (!sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED) ||
+	    test_and_set_bit(SK_PSOCK_STRP_DONE_PENDING, &psock->state))
+		return;
+
+	refcount_inc(&psock->refcnt);
+	INIT_WORK(&psock->rwork.work, sk_psock_destroy);
+	schedule_work(&psock->rwork.work);
+}
+
 static void sk_psock_done_strp(struct sk_psock *psock)
 {
 	/* Parser has been stopped */
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 282c6a4b2b05f..6747b3cc1cac1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -115,6 +115,33 @@ int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 	return ret;
 }
 
+/*
+ * Wait for the strparser of a removed parser link to be torn down, so that
+ * a new parser can be attached right after the old one was removed.
+ */
+static void sock_map_strp_done_wait(struct bpf_map *map, struct sock *sk)
+{
+	struct sk_psock *psock;
+
+	if (!READ_ONCE(sock_map_progs(map)->stream_parser))
+		return;
+
+	rcu_read_lock();
+	read_lock_bh(&sk->sk_callback_lock);
+	psock = sk_psock(sk);
+	if (!psock ||
+	    !sk_psock_test_state(psock, SK_PSOCK_STRP_DONE_PENDING) ||
+	    !refcount_inc_not_zero(&psock->refcnt))
+		psock = NULL;
+	read_unlock_bh(&sk->sk_callback_lock);
+	rcu_read_unlock();
+	if (!psock)
+		return;
+
+	flush_work(&psock->rwork.work);
+	sk_psock_put(sk, psock);
+}
+
 static void sock_map_sk_acquire(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
@@ -169,8 +196,10 @@ static void sock_map_del_link(struct sock *sk,
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready) {
-		if (strp_stop)
+		if (strp_stop) {
 			sk_psock_stop_strp(sk, psock);
+			sk_psock_queue_strp_done(psock);
+		}
 		if (verdict_stop)
 			sk_psock_stop_verdict(sk, psock);
 
@@ -297,6 +326,13 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	}
 
 	write_lock_bh(&sk->sk_callback_lock);
+	if (stream_parser &&
+	    sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED)) {
+		write_unlock_bh(&sk->sk_callback_lock);
+		sk_psock_put(sk, psock);
+		ret = -EBUSY;
+		goto out_progs;
+	}
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 	if (stream_parser)
@@ -597,6 +633,7 @@ int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
 		goto out;
 	}
 
+	sock_map_strp_done_wait(map, sk);
 	sock_map_sk_acquire(sk);
 	if (!sock_map_sk_state_allowed(sk))
 		ret = -EOPNOTSUPP;
-- 
2.43.0


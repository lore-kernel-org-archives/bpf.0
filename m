Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB490471403
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934199; cv=none; b=QvAAkUYNce7Ct6whGWGb3ndK9AnkvEgHs+TId98IbrGm6lecxCphBfAUvcgxIVAv5YS9uqZa1MVwQsrK5v75Hv25nSM3vD6magwEejQ1rcXymvbwFAeMFw8bniDlRKPH70Q04T4ehfpNTCuf7cuRWh0laI/X3t/2XMd8FWVBjT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934199; c=relaxed/simple;
	bh=OybbpMMcf4rExNIML6mp/CnvlY+tNHk4+xENgK9qbts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n9OmwNNNzrrvqyJQzgRfP4pmgYVRf3uLhCkZ5GQ6jj/Dp3qp5DHFd1RCAeSqf0DdQ9498dq4YHdi0jAXqxUrq4vR4YUpY4LULbetWzEQy8anhQyo/4jvsxIsNeJvDwOcyKhJXPP12M56j75gKmrA5T/iRf0raT7KkQlnXNePT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0iXzX7O; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0iXzX7O"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so3265216a12.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934197; x=1790538997; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TAOTdhfs/9pA0Z1K21+dXM6H8m/XRBM7LQ9zKefKlnU=;
        b=Z0iXzX7ORk2lhPfQq5Lmlj/AbaDrMC+yzfu5tgVNBQPAH+2mZQ80zZvfVXn41yxLYz
         KvYWrU9WBkcAMNlM80rdf/qaDr0nkFNhVVh/hc3JqsQuFPK+YQVGX3E+0EvLNnv/5/e+
         ghmmsauIoZSlYGcCoGbX0PsnY+5RA0noCMPZZwakILjrxzFgOGae38G+FrC8bZJ5PhNY
         LZW0+6BObXiyqc4rk/wpyOuPd9VgpuipVTv27rZoUjjW6Hop29nbRlamDEZVQRFJSxi1
         ps4AoQRdoSiSiK9YvDYFjFPzMFIaCJAOKWSFB2f574UHraGtnj/3gShbG9LKh/O8ZYbK
         BGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934197; x=1790538997;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAOTdhfs/9pA0Z1K21+dXM6H8m/XRBM7LQ9zKefKlnU=;
        b=y4dsbbjFT/23iFp2tOgW89+PxirZPAkeKWp01wPx+WsiyvURuWpGdLpiIiK2zeUgfx
         1tM2WuJf7Z4gmCF4FQLxbjbFAdD5fV2ZjwJQP80+gxqNV+1WFf3FWzvI0m/l/AYBELCG
         rCuvtxdRY4z79Qa927m9otI84vlLZFQ3mfY2qFVl5sU9J0kLVsSJ3QPsFl4PZ+7A+4Pu
         Tyd+Ba2nim83xAiouCTnJw42DSXAcyMrOV4xFLCCxY8WiIoeoZEWWgDAP7ISw+KykEqe
         V8uYTlap9KlGa0Ba4VM3oo76fHgFZONiLTa269JKtwvL9OLZCjAJQxUhyKZybjYnSYP/
         oZ2w==
X-Forwarded-Encrypted: i=1; AKwUvBy/erTUGaqjuocQC6F22lWlNli9zlD9YJjFNJpwVex8sDb7pmZsh/W2UqA8X9TS4Z/vHy4=@vger.kernel.org
X-Gm-Message-State: AFuF++n2aa8t6M+/g/luKBuq3SdnH6gbeZnmGt+SundYyOxiKrsTMPvy
	44URtv8goTIjU+kPR4YK5TO8H4gwLY76fZmGwCTiVVfJzjvpzdjpn3jfFyFQzqRfOSfVARFCKXz
	hPb6tFg==
X-Received: from pgvn22.prod.google.com ([2002:a65:63d6:0:b0:cc5:1d1e:ec90])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a1:b0:3c3:a3fd:db0a
 with SMTP id adf61e73a8af0-3dd8c44c5c6mr12189547637.16.1789934196781; Sun, 20
 Sep 2026 12:56:36 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:11 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-3-kuniyu@google.com>
Subject: [PATCH bpf-next 2/7] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Waking up a thread per packet is expensive when an application
processes variable-length frames (e.g., RPC) that span multiple
packets.

SO_RCVLOWAT can defer wakeups, but because the frame size is
encoded in a fixed-size descriptor at the start of each frame,
the application has to:

  1. wake up and recv() the descriptor,
  2. raise SO_RCVLOWAT to the payload size via setsockopt(),
  3. wake up and recv() the payload, and
  4. reset SO_RCVLOWAT back to the descriptor size via
     setsockopt() for the next frame.

This requires an extra wakeup and two setsockopt() syscalls
for every single RPC frame.

With SOCKMAP, we can parse skb and suppress wakeups in kernel,
but SOCKMAP adds overhead and also kills zerocopy.

Let's add lighter-weight opt-in callbacks to bpf_tcp_ops to
replace that.

  .enqueue_rcvq(): invoked when TCP stack enqueues skb to
                   sk->sk_receive_queue

  .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
                   is dequeued from sk->sk_receive_queue

Those callbacks can be enabled on a per-socket basis by
bpf_setsockopt():

  int flags = BPF_SOCK_OPS_RCVQ_CB_FLAG;

  bpf_setsockopt(sk, SOL_TCP, TCP_BPF_SOCK_OPS_CB_FLAGS,
                 &flags, sizeof(flags));

or via the bpf_tcp_ops-specific helper added in the next patch:

  bpf_sock_ops_cb_flags_set(sk, BPF_SOCK_OPS_RCVQ_CB_FLAG);

Later, we will add a new kfunc to adjust sk->sk_rcvlowat from
these callbacks.

This will allow the bpf_tcp_ops prog to parse each skb and
dynamically adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN
wakeups until sufficient data is available in the receive queue.

The placement of bpf_tcp_ops_call() in tcp_ofo_queue() and
tcp_fastopen_add_skb() is chosen to provide the same snapshot
as tcp_queue_rcv().

For example, if bpf_tcp_ops_call() were called before updating
TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
need an extra branch for the unlikely TFO case to strip SYN.

In addition, the TCP stack can queue overlapping skbs into recvq.
Once rcv_nxt is updated with a new skb, BPF prog can no longer
infer the previous rcv_nxt from skb->len.

Lastly, dequeue_rcvq() is placed in tcp_cleanup_rbuf() rather
than __tcp_cleanup_rbuf() so that it is not called for sockets
in SOCKMAP, where calling sk->sk_data_ready() from the new
kfunc would otherwise trigger infinite recursion.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h              | 18 ++++++++++++++++++
 include/uapi/linux/bpf.h       | 11 ++++++++++-
 net/ipv4/bpf_tcp_ops.c         | 10 ++++++++++
 net/ipv4/tcp.c                 |  2 ++
 net/ipv4/tcp_fastopen.c        |  2 ++
 net/ipv4/tcp_input.c           |  4 ++++
 tools/include/uapi/linux/bpf.h | 11 ++++++++++-
 7 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d61ee00052e3..f2d838bcb0a7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3053,6 +3053,12 @@ struct bpf_tcp_ops {
 			      struct request_sock *req, struct sk_buff *syn_skb,
 			      enum tcp_synack_type synack_type,
 			      u32 opt_off);
+
+	/* Called when an incoming skb is enqueued to sk->sk_receive_queue. */
+	void (*enqueue_rcvq)(struct sock *sk, struct sk_buff *skb);
+
+	/* Called after data is dequeued from sk->sk_receive_queue. */
+	void (*dequeue_rcvq)(struct sock *sk);
 };
 
 #define bpf_tcp_ops_call(op, sk, ...)					\
@@ -3144,6 +3150,18 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 	bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
 }
 
+static inline void bpf_tcp_ops_enqueue_rcvq(struct sock *sk, struct sk_buff *skb)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		bpf_tcp_ops_call(enqueue_rcvq, sk, skb);
+}
+
+static inline void bpf_tcp_ops_dequeue_rcvq(struct sock *sk)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		bpf_tcp_ops_call(dequeue_rcvq, sk);
+}
+
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6330b7d745c5..fe122242b096 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7148,8 +7148,17 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the TCP stack enqueues/dequeues payload
+	 * to/from sk->sk_receive_queue.
+	 *
+	 * Only bpf_tcp_ops is supported.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 681fed642999..c68d1fa32305 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -76,6 +76,14 @@ static void write_hdr_opt_stub(struct sock *sk, struct sk_buff *skb,
 {
 }
 
+static void enqueue_rcvq_stub(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static void dequeue_rcvq_stub(struct sock *sk)
+{
+}
+
 static struct bpf_tcp_ops __bpf_tcp_ops = {
 	.timeout_init = timeout_init_stub,
 	.rwnd_init = rwnd_init_stub,
@@ -90,6 +98,8 @@ static struct bpf_tcp_ops __bpf_tcp_ops = {
 	.parse_hdr = parse_hdr_stub,
 	.hdr_opt_len = hdr_opt_len_stub,
 	.write_hdr_opt = write_hdr_opt_stub,
+	.enqueue_rcvq = enqueue_rcvq_stub,
+	.dequeue_rcvq = dequeue_rcvq_stub,
 };
 
 BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a4456b419412..a714b36a7494 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1610,6 +1610,8 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	     "cleanup rbuf bug: copied %X seq %X rcvnxt %X\n",
 	     tp->copied_seq, TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt);
 	__tcp_cleanup_rbuf(sk, copied);
+
+	bpf_tcp_ops_dequeue_rcvq(sk);
 }
 
 static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..4939bcbc81d1 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
+	bpf_tcp_ops_enqueue_rcvq(sk, skb);
+
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 6ac6f9d5b6c3..c60c61bb0a71 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5344,6 +5344,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		bpf_tcp_ops_enqueue_rcvq(sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5547,6 +5549,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	bpf_tcp_ops_enqueue_rcvq(sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6330b7d745c5..fe122242b096 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7148,8 +7148,17 @@ enum {
 	 * options first before the BPF program does.
 	 */
 	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
+	/* Call bpf when the TCP stack enqueues/dequeues payload
+	 * to/from sk->sk_receive_queue.
+	 *
+	 * Only bpf_tcp_ops is supported.
+	 *
+	 * It can be used to adjust sk->sk_rcvlowat and suppress
+	 * unnecessary wakeups before sufficient data is available.
+	 */
+	BPF_SOCK_OPS_RCVQ_CB_FLAG = (1<<7),
 /* Mask of all currently supported cb flags */
-	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0x7F,
+	BPF_SOCK_OPS_ALL_CB_FLAGS       = 0xFF,
 };
 
 enum {
-- 
2.55.0.1082.g2b9226bbc0-goog


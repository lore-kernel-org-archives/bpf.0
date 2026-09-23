Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6B476694
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199447; cv=none; b=XCG/loRudj3bQx0X2n56D5L7epXnjuCYn4X2ZnjijRIcaUtPFNwOBslmlCVgpoI0JzyY/Fo6SgR2yxSqPpDrfmf+i7PFc90VMShWkZXssdNMjZanBq7h7BBLZmPfkd8wDRMe8os+sD2qxyMVQVntcxQdqinWlP8+BFZA+UJ+B7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199447; c=relaxed/simple;
	bh=w5t/VeO1HYxmt9TESUZcwn/X1V9QXo2jo46IqK2bQ9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cy/R2PstThm5nyleZ8ul9fwcfz7lH3PnSyxEVLe2tX5ycpXYldjbxpeZ2g9FXsYounvKy3nm/d5sNa2qehuYHXq+M+DypNbmuBgWWFNNMdk0TkjpY6Qjj0b4vZv9idv2LDba/LqPVVoQ1SINl4gUcAH4wTa/TwAz//S8oa7jU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYEETzec; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYEETzec"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-869b8d63e28so1456988b3a.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199445; x=1790804245; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tmd6lhSoqSRxVADC0yh2DGHZ7ROJgi5nE+fvLgA7U4E=;
        b=IYEETzecjY3rSNcdnEWnXImQuZdHquz77UnBaMpoObX0FJKy/N1avpu7JGf47FzY1/
         1GuH9xCQ54YW8fDy2RnYZctrJbF+k1Wn+1nXXKWKb4XUBgluq78GVvP38QzQV/2g66mN
         AIWzmiq1GW4GJC/hsSC4Y3mhASEWtVOr4+wDLYlZozJWoKQdZ7/tfodXUPfwJx7rzCg6
         GTFTQboICwWOR6VWf/pSGzPvSkgK1oaPhR6Q0dJR/qcgd7ibsXhvnczsly8JfuIXz5F6
         wDqmTuFFU1j50YsJF/uraC5UKY74DFDs70nFmjRtLChj1jB5wzBnsyix/q+fbblAp1aC
         EqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199445; x=1790804245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tmd6lhSoqSRxVADC0yh2DGHZ7ROJgi5nE+fvLgA7U4E=;
        b=q9ZebJaw4Te1Dobs8qybM3ugDjA2TsLB02C7yih+Z4h/UaQvIY/OFCreLpiJb9961P
         ojZvDiR3hpr4ssyeYX8/nWexNOTUMBc3GLLsAGCYY20tN8sytHQowbgvjGUSWUfI9a9h
         4A9D+x8NjMDe3y20X6/V7Zl4Aw8jHc79sBoNjqPCxOtJNjoDGEKQ28HwEh76LcA8o5H/
         wtvHLl9JHyRS/tTHJb8KdytW0mqTNaEkcywQFDBcIVTMza0btchtFJrDFb3kc4jxZ+bW
         PQiWuwTK/3tMUJhJMRSA/YB6tfWKaA4ltf3Q2ml2Swz/OJ8F+pTtQg4gEwj0WDYnRZC0
         XM1A==
X-Forwarded-Encrypted: i=1; AKwUvBwXfhPqogBRVNO9RqmR0+7foBe/LT9jmXsTFvmznLD3DeUMt/4YSDVP1SD/IAnUXoLj7vw=@vger.kernel.org
X-Gm-Message-State: AFuF++kr3nrvCkmQkYk1VGMSL0KwXkxpGY0HDiwXCk426958wZEQLpUq
	3BLMkajOIrX00d2XIm01aVVoIr8KjK2CUCyCD5UjCGD8du1LgEwtnLkk1T3Q+hj3xr5cJ4vaTUD
	2jyDo1w==
X-Received: from pfbdo9.prod.google.com ([2002:a05:6a00:4a09:b0:87e:5fdf:ca99])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e26:b0:84e:9257:d0c2
 with SMTP id d2e1a72fcca58-87e989907b8mr331493b3a.9.1790199444605; Wed, 23
 Sep 2026 14:37:24 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:33 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-4-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
index 1ada3b781bf1..c963e2cc21b5 100644
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
2.56.0.rc1.315.gc6ed9934b7-goog


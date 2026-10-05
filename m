Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B14B0E3B
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215151; cv=none; b=RcGr8oe4W3zzhqwjshuSij1VsDSI43ZAQF4bbA6CTSukwr2BH8EHnqQQ63HaRjQ5K43EWwhFtrj4jN51O2fsyqMPDw2yW3KvoAzgzhXnq3j41v6SR93qGWu9jbOpSXtHAzmcFin5Bf+KgaOPsZ+r77GDlYcxkyFirEBtxl65/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215151; c=relaxed/simple;
	bh=KhvzwdW6Kfg5VRTm7MBL4K0RhOAeiNG1Lh0I3DfYu0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XhS1ZIMEhcaXuYfrucO4ThYR31Dk9VB7RnDinPqUh5Z3eaobA8vJ42pxQu4fSRJobRyUX6XL+r/0qvu6kBaKMkerxZxmthqsNmnoVGQaFQKOCIH6Q/2lXDJ16uaHwJ+RtLZahe5kAZrHz0enb5kE/FC8/LwurMBlEAhgNEkfOIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCyL6Vh1; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCyL6Vh1"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e4ade8670dso26151355ad.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215143; x=1791819943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8dxI2uNVYrxH6C2ULRtwLqVFUQ66a+Q8nHFkKRkQjVI=;
        b=aCyL6Vh10fj6EH1tE7kFyrwISEUBkWFfzFQT9wGxUgigabwVz9clXQ0aGtRrRDXPwn
         Fx2WsB3kgU8135eSglKwYIHik7Iz+6xzIret6Vi2cYryJeIknZgh5knw2Ijv42rUyGGO
         JqWIF1MYLfv62vaUpyJZO0RLPMnNhgLR3jpHqfEZCA5febQ35hv4L1QGong/ENXRR9+x
         Wg2/HyjY+6rX8ykvI68s7JpV7ZRX4oAsCaYk3Lh8vdgWGK71L2A8A4ZBOEB/2IhJTTO/
         toocIRQer7VmX48tql9xmmzP7X5sabHj1l0RcdVSWMnsPt48EPT9S9pOnWRxOXcJOsIg
         x/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215143; x=1791819943;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8dxI2uNVYrxH6C2ULRtwLqVFUQ66a+Q8nHFkKRkQjVI=;
        b=x0LRYz7uify9WWMAmh+bCpdDAqgctzW3/5FgWmntZ40xH2JQ5eedixWDNvFBzp/Ify
         P4gnvpYUB186ITxaGQSRsPW9l+OyJmOOgZVGS8uOsUvKXyek9h+Urbz9F2d0odbwCXbB
         QDuE2alOEJxFo22Yp0BXzUcm0lnLn+HsP/HaBunK3JVocwrZQMw0qh5CjR8qsvOJOKva
         FmpuWqse07Urfun836lP/osr6fR5ENl7vm8fGcAe/JpfB9gfkorN22u3fO0IZAtRhHww
         wQ0gZmDXKotELehDDkVEsza4rMTVWPbYvbkxAlBKDtvmXpAHeXZ7Ep43vJCoyiqpFFed
         ZoMQ==
X-Forwarded-Encrypted: i=1; AKwUvBze/Wjy9sLjvB0kyhbq4JZVQ149YU0kZDJu0YDqcAzHpSYDcOt+8asi9CffD3foV2caL1k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2ZXTWDAilYe/ecB4n+Kk0yjqtgWxt9L+zJ+mu6nG7XmLgsq4f
	j5WubVZSEt63b2YDYlAwum/9DqWw5AcwRUOIEcspG7NZyODx15PXGPdjCeHOvKyFZxene/MOQSO
	sPIp6dA==
X-Received: from plbd7.prod.google.com ([2002:a17:902:f147:b0:2e2:f517:75b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e884:b0:2e4:b37a:d573
 with SMTP id d9443c01a7336-2e4b38a20acmr87803715ad.47.1791215142984; Mon, 05
 Oct 2026 08:45:42 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:47 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-6-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 5/9] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
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
bpf_tcp_ops_set_flags():

  bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
                        BPF_TCP_OPS_FLAG_RCVQ, 0);

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
v3: Switch to BPF_TCP_OPS_FLAG_RCVQ
---
 include/net/tcp.h              | 18 ++++++++++++++++++
 include/uapi/linux/bpf.h       |  3 ++-
 net/ipv4/bpf_tcp_ops.c         | 10 ++++++++++
 net/ipv4/tcp.c                 |  2 ++
 net/ipv4/tcp_fastopen.c        |  2 ++
 net/ipv4/tcp_input.c           |  4 ++++
 tools/include/uapi/linux/bpf.h |  3 ++-
 7 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 48487135c076..7f4ab50f08c7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3054,6 +3054,12 @@ struct bpf_tcp_ops {
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
@@ -3146,6 +3152,18 @@ static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 		bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
 }
 
+static inline void bpf_tcp_ops_enqueue_rcvq(struct sock *sk, struct sk_buff *skb)
+{
+	if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RCVQ))
+		bpf_tcp_ops_call(enqueue_rcvq, sk, skb);
+}
+
+static inline void bpf_tcp_ops_dequeue_rcvq(struct sock *sk)
+{
+	if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RCVQ))
+		bpf_tcp_ops_call(dequeue_rcvq, sk);
+}
+
 #if IS_ENABLED(CONFIG_SMC)
 extern struct static_key_false tcp_have_smc;
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6ff90b73dd38..ded3ac8df9ac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7339,7 +7339,8 @@ enum {
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
 	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
-	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+	BPF_TCP_OPS_FLAG_RCVQ			= (1 << 4),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 5) - 1,
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 5693857e764e..dafe2337f9fc 100644
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
index fa69961c47d3..a1e2bb3974ce 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1609,6 +1609,8 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
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
index 79d721215f52..8518c744aa17 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5351,6 +5351,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		bpf_tcp_ops_enqueue_rcvq(sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5554,6 +5556,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	bpf_tcp_ops_enqueue_rcvq(sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6ff90b73dd38..ded3ac8df9ac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7339,7 +7339,8 @@ enum {
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
 	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
-	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+	BPF_TCP_OPS_FLAG_RCVQ			= (1 << 4),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 5) - 1,
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


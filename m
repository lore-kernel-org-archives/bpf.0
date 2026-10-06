Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBB4AC166
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314787; cv=none; b=Md3QUx0C5jS7zC/sOtQVFYzACMFbtfG5nJhKzjCFMfig5n9Dfo2JMDGBx/Ua88aaabGzHebtucYK9O1KGkhAZRzVFNnYK0HY+4spd6mFwFmPUQJxSXRXPu6ntW5uaZP329iHwwLUM8/1HEURtdNAEr9iCCmJJZ7JA3OLUVF+kZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314787; c=relaxed/simple;
	bh=DUVBS/qlm1/+JiN+uQj/Q6c+NfsmGfljTy7l4nqwELM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AuKQZLkOQQ8gdb+cUscc5qs6U4N0Enhkyi9az6L27Vszq9TeG+s5bIAYBwClPxe71A1e9PWCke0N4cSoK7s8yNJNxCUfZu1eY77aTEhp/qAQHU1MsM1lcGnPU3F+13HyqDsuagjyFZSJUC76I9a87m7yW1Cv3et1H6moqHdaPi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tf4ygHkn; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tf4ygHkn"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfc52ddc55so34809685ad.3
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 12:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314785; x=1791919585; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GZnV5veudeeZHeD2duQrZkETqwlmYB0W6QpxwZzPHBE=;
        b=Tf4ygHkndKwh7Pj51xN5hF2le6m4WDryuljuaE9+g9hhsMVXWS/A2dutG01G3I7Qce
         lSB03JfUmV7Yn7ZoVCqlx/KEV9RP9tLYWIm2CGjs+oL0w6jcKqrKMLi3Am7N/TTx/EOW
         4a/kVFEFoBKEcpH0+i3zmnha9yZB6FVFRORVNJ+eQ5/32ZZQrtvQIQWM+z3H0ZMEjYuY
         k30vPCYqSzD5FR+cQuCcFaIxT71BLvNvA4ud9DYicZ1KVeBKM6E6hjT1FDwoHFJerWiM
         66ZoUbAkGCrk5FPLM5fpemhpp2M/F0im9UMDVyizd/d/SxGOvHnQL1BJ2hJoRatRH2i/
         5wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314785; x=1791919585;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GZnV5veudeeZHeD2duQrZkETqwlmYB0W6QpxwZzPHBE=;
        b=P+qC4E0h3r8mxbAT28URCmbTJRYuP6AxCFtDR5+3VeUiCPGPuoH236u/uV6RApISSX
         hefGoDE1AHaavjZhNBjGZMfLCvwsyiKGymAuyg1hoKgKAu/zNFY/ETXBY9vGIquH4WGU
         Vh9Y1W7WEYt/GRutxMAzHfn/4kKXTEjzMS4KwE+ws6QJ3QFLNDlB8Nid2/6LmywTaein
         wybmilmz+XENbpN0hfHtt5jH3F1/QH3xtVESig6NgcehXNwDGL/vwe9aVJduFgrcvjPT
         1lDjuDO9hRMWGajDjuokCGubpHhn1rm6Po8RqofwYCtZKqpYYG+vzy+05MiihzaqQ1RX
         eGsg==
X-Forwarded-Encrypted: i=1; AKwUvBxHUR3IOYDQolAopMhLNN7eizqVZj+KwygJxrPZhmCNo+XpSB6MeSXv1gdQFAFcv2n2J84=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEOlO1CgWjM2MzagGh30UdWBVByYjtBjHcc0SbpxWk4+Kx+1sG
	qgHoOKAPHJfhmwB0qucmxFflnfoH34TMRWv/maZzgoO5WEIgaeKmbJ1rq0ONlxDjQb+6S0ONqR+
	zUcJ5Kw==
X-Received: from plbmz15.prod.google.com ([2002:a17:903:350f:b0:2e1:2a93:3745])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:9a06:b0:2e4:4eed:5cc5
 with SMTP id d9443c01a7336-2e60051d494mr1917875ad.38.1791314784807; Tue, 06
 Oct 2026 12:26:24 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:32 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-7-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 06/10] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
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
v4: Use bpf_tcp_ops_call_flag()
v3: Switch to BPF_TCP_OPS_FLAG_RCVQ
---
 Documentation/networking/net_cachelines/tcp_sock.rst |  2 +-
 include/net/tcp.h                                    | 12 ++++++++++++
 include/uapi/linux/bpf.h                             |  4 +++-
 net/ipv4/bpf_tcp_ops.c                               | 10 ++++++++++
 net/ipv4/tcp.c                                       |  2 ++
 net/ipv4/tcp_fastopen.c                              |  2 ++
 net/ipv4/tcp_input.c                                 |  4 ++++
 tools/include/uapi/linux/bpf.h                       |  4 +++-
 8 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 420fc6278148..e4776905e882 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -151,7 +151,7 @@ u32                           urg_seq
 unsigned_int                  keepalive_time
 unsigned_int                  keepalive_intvl
 int                           linger2
-u32                           bpf_tcp_ops_flags       read_mostly         read_mostly         bpf_tcp_ops_hdr_opt_len,bpf_skops_write_hdr_opt(tx);bpf_tcp_ops_parse_hdr,tcp_bpf_rtt(rx);
+u32                           bpf_tcp_ops_flags       read_mostly         read_mostly         bpf_tcp_ops_hdr_opt_len,bpf_skops_write_hdr_opt(tx);bpf_tcp_ops_parse_hdr,tcp_bpf_rtt,tcp_cleanup_rbuf,tcp_queue_rcv,tcp_ofo_queue,tcp_fastopen_add_skb(rx);
 u8                            bpf_sock_ops_cb_flags
 u8:1                          bpf_chg_cc_inprogress
 u16                           timeout_rehash
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 85b4bfe963d3..d95cbe4da96e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -3056,6 +3056,18 @@ struct bpf_tcp_ops {
 			      struct request_sock *req, struct sk_buff *syn_skb,
 			      enum tcp_synack_type synack_type,
 			      u32 opt_off);
+
+	/*
+	 * Called when an incoming skb is enqueued to sk->sk_receive_queue
+	 * if BPF_TCP_OPS_FLAG_RCVQ is enabled.
+	 */
+	void (*enqueue_rcvq)(struct sock *sk, struct sk_buff *skb);
+
+	/*
+	 * Called after data is dequeued from sk->sk_receive_queue
+	 * if BPF_TCP_OPS_FLAG_RCVQ is enabled.
+	 */
+	void (*dequeue_rcvq)(struct sock *sk);
 };
 
 #define __bpf_tcp_ops_call(op, sk, ...)					\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6963c146311e..6f70db7515dd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7360,7 +7360,9 @@ enum {
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
 	/* .hdr_opt_len() and .write_hdr_opt() */
 	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
-	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+	/* .enqueue_rcvq() and .dequeue_rcvq() */
+	BPF_TCP_OPS_FLAG_RCVQ			= (1 << 4),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 5) - 1,
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index aaf96304c69f..9a6e1c47d7c0 100644
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
index 5d9d3bcde8f7..5d907a0a0461 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1609,6 +1609,8 @@ void tcp_cleanup_rbuf(struct sock *sk, int copied)
 	     "cleanup rbuf bug: copied %X seq %X rcvnxt %X\n",
 	     tp->copied_seq, TCP_SKB_CB(skb)->end_seq, tp->rcv_nxt);
 	__tcp_cleanup_rbuf(sk, copied);
+
+	bpf_tcp_ops_call_flag(dequeue_rcvq, RCVQ, sk);
 }
 
 static void tcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..6dfe40322fb5 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
+	bpf_tcp_ops_call_flag(enqueue_rcvq, RCVQ, sk, skb);
+
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f374257013b1..46f5c4fafa8d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5365,6 +5365,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		bpf_tcp_ops_call_flag(enqueue_rcvq, RCVQ, sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5568,6 +5570,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	bpf_tcp_ops_call_flag(enqueue_rcvq, RCVQ, sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6963c146311e..6f70db7515dd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7360,7 +7360,9 @@ enum {
 	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
 	/* .hdr_opt_len() and .write_hdr_opt() */
 	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
-	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+	/* .enqueue_rcvq() and .dequeue_rcvq() */
+	BPF_TCP_OPS_FLAG_RCVQ			= (1 << 4),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 5) - 1,
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.56.0.360.g66cac248cb-goog


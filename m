Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A83A48C8
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429376; cv=none; b=L/ID5Gxdmmk0LOVrFmiixVjsbro3HrUa+vM8f0p5wzKPJvyc6dRlJ68xSQ6MHUObO2RRrivUNgSQuR82DHhewwe9iKDsRoplg+ync+I6oRja8GyqMTlyHKWCTDAH9izAAbp/B2XOxY/dAU5fUG8rGMBevUVyBD26oDZjch+DKBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429376; c=relaxed/simple;
	bh=bZT3sntUE76Lo8yNqQJ6fmpU9kk+3Lw3nveUM9BsmeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lC4VGGSeUixQ/1B8qbGjHCuVCdExf+6lTnvPrjC2c7Cc9cfc5r6SvNRvI5ngIuVj9BogihkmGuADPEtAAsSypAa6SNMdSBNlvaHv6tMYZXUk0Z5fbfRYO0FrGCqmHXKK5FIm04UpXq5vfSq0W2oA+nb45w1EyGBJrLxnHh//aqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVwjkAZx; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVwjkAZx"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so3802362a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429372; x=1792034172; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HwJ97tnEJQSQ27KxoIR8zl8kDgXY37xbV3Lk0qGw3M=;
        b=oVwjkAZxmXwg4VRcJmG1zySYYi/wKTSW8rATWq21LhAdr9dgJjig0O2EeQr0EwX/0F
         OpU0JOMnWhb48JUYnSMPi1sQvA2NupRj5VFH2E57DH+386GPVgxZQUk1iYbKBDKoPjiS
         D3xFYrp4IV6tefIBZP/zckXpb4skgWAH1zpGYeuolcM/bnAns+lLn90b2lvseMaEG4k1
         NSyJx6+UxXNPcgTTp3vFGctweAO/nf7cIxxig6Qi302bH5VOmubgZ1+rWR/JKamaoQ9u
         ig1LDDKOjqniXaRDbWR8mjefspB0yjyMk6aYEim6qaF6tNMvj+ptPEe1IZdXJRvrxZ5G
         bu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429372; x=1792034172;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3HwJ97tnEJQSQ27KxoIR8zl8kDgXY37xbV3Lk0qGw3M=;
        b=FvN4hkGU53YOVFmtwu5kZ2YHdvT+P0jzv+JaNIeL8yNPFXHEOs0Ox/vonfEUdne3Jo
         ZfNI4Wo97gnnawB/Gs+HmqQd0JDehC99hK7zH2EIok+ROkS7/JRzmAA9uApLrCRf5SEb
         DYe3jCnCLK979WXPK0muqhUmUpTy/6Mg++n3/BS4xc8hzA0Xo2ug1gn1Nuz67A6i/PxJ
         XtFjTIsAFGXuPUnuM+ZsySNftDzfBlHQh9MPWNLGCajnDI7n/3GPoXnaIys5j5etCDYw
         HmuSfrXYO6HhHAVldG1PKaeKgbu4ZVx+qBtzTxdKk1mUGOOHph8rlMsI9xaFsl+7eVcg
         cTgg==
X-Forwarded-Encrypted: i=1; AKwUvBzNOlXkIXxWgDb15GAmuDHbmat8F2rtp6gQ8GMm7L3VjXVP96+lzn1W0xCYsR4kAeLhkCA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKngrMPlV+3VGWWeICdxg2h/MhfI9V2lrH4We+2l0O76MV3t+nC
	LEWkke8qPIcDmequS39nP5p2+PVlk2Y9vZfKfXLmyilx+y3MsVKW+HlXIA9ToXhY92fdHoLO0j8
	TfXYYdQ==
X-Received: from pgaa11-n1.prod.google.com ([2002:a05:6a02:648b:10b0:cc7:b626:d7f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544b:b0:3a8:5d57:a5e7
 with SMTP id 98e67ed59e1d1-3a8a0ba18dbmr2933806a91.28.1791429371737; Wed, 07
 Oct 2026 20:16:11 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:26 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-7-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 06/10] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
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


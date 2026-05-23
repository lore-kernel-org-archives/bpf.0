Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569B35EDBD
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525015; cv=none; b=QC04KBPKo9o14Uk1UC4FCHGx8lqCvIOU9Pk5x5eLYxBrs17jJyei7OfqZJB4aUz2+grY9OI3e9lKz1gYDwngsYYTRrVzCmwr0pQI0Q93e+Gl1GIqwntwd2xEMpyA04cYmJrmo5p/tX6QXnuaao0E/zIjtIuUBcrEZmyth5bIl/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525015; c=relaxed/simple;
	bh=BlsIsH9FQ9GF4la9NIyQzM+R3Dfl557EAcuHojlSDXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ouIUz8cOe1oSs/vTHincE8Z180ykPFkMOYRQoRzc0ea5OgEyXaufJ4fSJkaTNPvcRs7LdoYx5m9BEpGmLGFMwPddTWb4dEJ1UUF1wwazsA+2q9Mh0L4oNT6HswxgQgU6Nz+IpkiRQcSPruHXhFuX96vlMPVAMsVaBEFGTEOFpOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmB/72X/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmB/72X/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2be9e0905a9so34906685ad.3
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525012; x=1780129812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvkOpWFwrZ9Xd+mRQSjxq1OsGG4db3MKsVmsdhKqYWs=;
        b=RmB/72X/yVMLyVDYCb93+CZu/qBTr5VDvJK6ONdIlnh00Glt9umDL4dHOmlkBSL7qN
         /FgoGPxcKMoSdfViko8h+cE0nVbFU7LXrfwfJwxuww2p177YsJV1ml66+PGQy39c3y8A
         fGKsEjf9Rsksq7QUpn1TuD6kO9DSm5JJEI5qhi/OXiv5rwugKd/Mgxg4PZoesHwG5uVw
         3fpETPyPrtqa+TnkCSHOlIRhaHQjj1njSCadqZhZl7Opl1LEiUaWkugvnvktrSUg1xdG
         bx5ORTniMvjjx6+iO+TkY6CXSAEatHKcw1XzHAWPzsZqr5FPaOnqlVOGYo6icuH6Pia1
         hXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525012; x=1780129812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvkOpWFwrZ9Xd+mRQSjxq1OsGG4db3MKsVmsdhKqYWs=;
        b=mPraq06WYALFU/UBymJlMPXvG+EACiYx8S13Q7tnSGVu0qBnF8/oGBv2Tcow4APeST
         k9Cnj0OK5TWmtgsYrye1AGeZlbMiDi1p7IoH1NAcxBV1luxGmryKrJLFNbd/tW/LKJTG
         LkAkx2M7Gjm2GYHUhtnSFLgT1Qv/9Q8GVcNK/msyJJPfIYe/SZGDSoVcHvVziSaqIhkg
         0ubs5Kv1gdOO5b3T4G0igqULEGROmAA88vK7wsa8e849II6f/aWXo7xEmHxINuzOTgy0
         AxhdzN+uhS7cuIpzPTVaUQjIQjmrN62/jA9Rktk5VQQAWAoh35ptctO/HkoTE2iu2heK
         hIng==
X-Forwarded-Encrypted: i=1; AFNElJ/RXr0A3fV+OMVkwcUEFS8w0J2ZQuTis4oNdRMUJpJNS+YcOu/7YYWYqhZa+SylXDMHY5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzwDcRg3PmnyGeVqrimJxPT44u+A+L3cozUGKmVCpEqJnlIa+
	QCMRN036smdzsXSSCtQQE0StdpBzQf83XasFnHtbqZfziDC9ch8cIiVzmN0QySPAe5N40Mr/QP0
	wq4nIxQ==
X-Received: from plbbf3.prod.google.com ([2002:a17:902:b903:b0:2bd:a529:4b4e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19e8:b0:2bd:b6f4:4500
 with SMTP id d9443c01a7336-2beb038c123mr76711625ad.11.1779525012420; Sat, 23
 May 2026 01:30:12 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:39 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-11-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVQ_CB.

Let's invoke the BPF SOCK_OPS prog when

  1. TCP stack enqueues skb to sk->sk_receive_queue
     -> tcp_queue_rcv(), tcp_ofo_queue(), and tcp_fastopen_add_skb()

  2. TCP recvmsg() completes
     -> __tcp_cleanup_rbuf()

This will allow the BPF prog to parse each skb and dynamically
adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN wakeups
until sufficient data (e.g., a full RPC frame) is available
in the receive queue.

Note that the direct access to bpf_sock_ops.data is intentionally
disabled by passing 0 as end_offset.

Instead, the BPF prog is supposed to use bpf_skb_load_bytes()
with bpf_sock_ops because payload is not in the linear area
with TCP header/data split on and skb may contain a RPC
descriptor in skb frag.  This also simplifies the BPF prog.

The placement of tcp_bpf_rcvlowat() in tcp_ofo_queue() and
tcp_fastopen_add_skb() is chosen to provide the same snapshot
with tcp_queue_rcv().

For example, if tcp_bpf_rcvlowat() were called before updating
TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
need to implement an unlikely if branch to strip SYN.

In addition, TCP stack can queue overlapping skb into recvq.
Once rcv_nxt is updated with a new skb, BPF prog cannot infer
the previous one from skb->len.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Add explanation of tcp_bpf_rcvlowat() placement.
---
 include/net/tcp.h       | 12 ++++++++++++
 net/ipv4/tcp.c          |  2 ++
 net/ipv4/tcp_fastopen.c |  2 ++
 net/ipv4/tcp_input.c    | 10 ++++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index bc95d8e7b62e..a409f2ea710f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2889,12 +2889,24 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 	skops->skb = skb;
 	skops->skb_data_end = skb->data + end_offset;
 }
+
+void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
+
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG))
+		bpf_skops_rcvlowat(sk, skb);
+}
 #else
 static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
 				      struct sk_buff *skb,
 				      unsigned int end_offset)
 {
 }
+
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+}
 #endif
 
 /* Call BPF_SOCK_OPS program that returns an int. If the return value
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3afeb69a547a..f7e32891bb4e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1602,6 +1602,8 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 		tcp_mstamp_refresh(tp);
 		tcp_send_ack(sk);
 	}
+
+	tcp_bpf_rcvlowat(sk, NULL);
 }
 
 void tcp_cleanup_rbuf(struct sock *sk, int copied)
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..91bf421fc5b6 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -281,6 +281,8 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->seq++;
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
+	tcp_bpf_rcvlowat(sk, skb);
+
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 	tcp_add_receive_queue(sk, skb);
 	tp->syn_data_acked = 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c4ba4f1e9d9e..477bcf2ba89d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -204,6 +204,12 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	/* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect */
 	bpf_skops_common_locked(sk, bpf_op, skb, skb ? tcp_hdrlen(skb) : 0);
 }
+
+void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+	/* skb is NULL when called from __tcp_cleanup_rbuf(). */
+	bpf_skops_common_locked(sk, BPF_SOCK_OPS_RCVQ_CB, skb, 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
@@ -5306,6 +5312,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		tcp_bpf_rcvlowat(sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5509,6 +5517,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	tcp_bpf_rcvlowat(sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
-- 
2.54.0.746.g67dd491aae-goog


Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9814537DE99
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225663; cv=none; b=ZwvcUo9Cc9YAdLO0pBGj36DH5ZbhTQ1eNgPHHSuNnnj4b5qP1FZkjRHC3r1jMNUBLl4skHC2gPotAOl8ltrzvjzqUN9FP+4xZt91DpOinIhB9KF7ltgR3+TNVH08vUlQMp2inYA2LjcfKEZNn3JDS015y4if3Ml1Gb6uA2kdrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225663; c=relaxed/simple;
	bh=nbAGrZ/PdVCt3bMy++Z7SIhc7IEScyO8VWwJ0qZSwX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwBU8ShUWuqojhiuHDPnoR7dN+zG3Je7gHRdf0RI9HLJMfWLU5w7SA8GQTAZdZOD/rjgBSefE0pOVzZBP7L2lAp1gtsx5uI1GQPnA+Mkbn1gOk9xQid5nIdsXZ5GHXEqb8ZkZ+wQl27QA2/fG7BlYrsWBTKBL53wiRVKbTtOpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFJpbe3i; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFJpbe3i"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b79f4b35b7so17043685ad.0
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225661; x=1778830461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mxSkUqDoYCLZ3rL+h+d07WuJ1fP4jPjPq45vL3UZAc=;
        b=wFJpbe3i+kTwAtBMLreJd1Wnn+cpbT120A4fDnR+axeMok5vPG5HwaETTd9PraHnui
         kgNuQI4MTrmjc4NcXXdRD52N3IAYcxiKCrr32f0jxja/sQQ6gS/9olkpHgRB9xSVsjoT
         HhxU1BBuMWXoFutoIo7U2FAEs8rJocQ2Ent7WhkBvHk8KFovaOlVYByGN+AlEIur4YRJ
         jVOoM+B9685onTmg/1u0FpkMfUnfHlvJTt6f7onY85PcEcPG9i1tRO+kGD2zJnrglkGy
         Sj32J7iIHoD7OKls2GdI0EEe2JYP2yRPq88DjwVL2jRaGDxs92d8Scp7WlrBcPenwjcO
         Q0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225661; x=1778830461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mxSkUqDoYCLZ3rL+h+d07WuJ1fP4jPjPq45vL3UZAc=;
        b=ggAXW6R6fZ3sYp3y7LATfSIQ34GVUR1LVIC/rGFD7FnY8jtDK1fDo+vx+aJviSgtfx
         GtazKrOuamDbpACwdMYC/G/g/BNSaebbp2mYU+pfMXjKBpZIoNP9rzCPkIUfL6v3x3H/
         P0rD0yZvt4FCG4PiM/EwDHvTJz9qVFp5azVHqYrg7SYNW6fJiHqokGad+z0cgAfubko7
         9nlG+9rgGXjqajDssX0K7R6JCC3T8LI+3ip1AbQbdY+HumM+leNXDYJ1clmUsJuc4skF
         f2kHOiqnTuqle1cCPbrX0TIRKEkDQQnETjp6UoxqCIhKmICASUSNMLAJ158MX7HlvZRN
         JWPg==
X-Forwarded-Encrypted: i=1; AFNElJ8mgjMfsqztYxJW0syDtwZ/zHYFVbDLhpcdobQtUy5yDKpmMwc+nmjazteyUpZmkQg+rRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBf7ImPGNrxGHnn4ezNb9+sV54hiU4h/fqONzFgAOFjpbmwN0
	1z9d3BHJHaZxJfBZ/3maU6BH90lU8KVNEWFvq1Kjs7r5G8QqxNzKXc2dXZtklq19zMwT4mNqH5L
	16pIOsQ==
X-Received: from plgm17.prod.google.com ([2002:a17:902:f651:b0:2b2:4290:7fb4])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec8:b0:2b2:ebed:7af5
 with SMTP id d9443c01a7336-2ba794bb46fmr117504695ad.13.1778225660804; Fri, 08
 May 2026 00:34:20 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:28 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-8-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 7/8] bpf: tcp: Add SOCK_OPS rcvlowat hook.
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

Now, it is time to add the new hooks for BPF_SOCK_OPS_RCVLOWAT_CB.

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

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h       | 14 ++++++++++++++
 net/ipv4/tcp.c          |  2 ++
 net/ipv4/tcp_fastopen.c |  2 ++
 net/ipv4/tcp_input.c    | 10 ++++++++++
 4 files changed, 28 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4e9e634e276b..003e46c9b500 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -737,6 +737,20 @@ static inline struct request_sock *cookie_bpf_check(struct net *net, struct sock
 }
 #endif
 
+#ifdef CONFIG_CGROUP_BPF
+void bpf_skops_rcvlowat(struct sock *sk, struct sk_buff *skb);
+
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVLOWAT_CB_FLAG))
+		bpf_skops_rcvlowat(sk, skb);
+}
+#else
+static inline void tcp_bpf_rcvlowat(struct sock *sk, struct sk_buff *skb)
+{
+}
+#endif
+
 /* From net/ipv6/syncookies.c */
 int __cookie_v6_check(const struct ipv6hdr *iph, const struct tcphdr *th);
 struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1d9e52fc454f..80144b97a87a 100644
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
index 7e26503fd96d..a70a8f583025 100644
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
+	bpf_skops_common_locked(sk, BPF_SOCK_OPS_RCVLOWAT_CB, skb, 0);
+}
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
@@ -5300,6 +5306,8 @@ static void tcp_ofo_queue(struct sock *sk)
 			continue;
 		}
 
+		tcp_bpf_rcvlowat(sk, skb);
+
 		tail = skb_peek_tail(&sk->sk_receive_queue);
 		eaten = tail && tcp_try_coalesce(sk, tail, skb, &fragstolen);
 		tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq);
@@ -5503,6 +5511,8 @@ static int __must_check tcp_queue_rcv(struct sock *sk, struct sk_buff *skb,
 	int eaten;
 	struct sk_buff *tail = skb_peek_tail(&sk->sk_receive_queue);
 
+	tcp_bpf_rcvlowat(sk, skb);
+
 	eaten = (tail &&
 		 tcp_try_coalesce(sk, tail,
 				  skb, fragstolen)) ? 1 : 0;
-- 
2.54.0.563.g4f69b47b94-goog


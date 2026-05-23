Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E85B1EB
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525009; cv=none; b=E9dM3+0ac/u1nmlPyV2T12/ih9NU2fbRcVXdVKVhk3iph1lhyXT/1klzRyOZEeG4SRS4aDZHJm+IfurfBQ1TcnGEAkss21OVvvajjo1AONkZtjPT7s5Wxb+FrGudzi5JSFNtigwjGBD6/is0Yj0CD550WpzP3VStkXwqeeB49Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525009; c=relaxed/simple;
	bh=kIv6gMdGhCbK7oa+mQvZvqU1S5H4TI4D7YmZRRwaok4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqSk/x1TS4OJctp6Fnd0Jd2uWdznDYiBxUvx7ywWou7iIk1ELgrWLHTcGDTZi+SxDaIAb3oZ9488UL+dEyPX9I6K5JVXomU9S4nZEM61d2G0SrEQ3SeG8SFag3N4DltEvp2uNeTxnLhMGRxqLMWFm4lfO32EdQ5Qv+pStC5xBwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEg1pw2f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEg1pw2f"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so81555385ad.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525008; x=1780129808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=aEg1pw2fjyNbgrsC93E/jgErM96ihpVbALnNtrhkRqFWHi9ey0FS5Hu3Vhm3zvOLRj
         ULBDmj660OVCmPd92PS3Z6m/Ry9kH55g6VFA9Y9BKFgmwYFEI/QCP6E2L44T6DDqGRui
         3q8JPxL3KoWOAAJVYDZR5ARl3b+FAyue/4EWc7EmeKwUWAPt1Qm7uSuWzFQ2UwOLQlaQ
         yCMOyrPg+LlzjX9KV4uNHUp9kjsutUh0WQzGQIrBVKqwfzh8K1CbGHoL+qqKmgLySoTb
         /DendmmwHH8WaEhlRzb2buMMvKiGh5jf1wEsNwl3/PQoFwsmJ2lN+Wpt8AI8Br0jhDOf
         DWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525008; x=1780129808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=rzJCDM9NpgbS6m5R/O07dVEQib5wwbo3idUWKzv90BHSrCorLH/W6sMaz8cQCft3dA
         tRLZeEmfY/dmqT3a9Ng4+6mOn+FUzetWsme9y3pcjREpBpq7XLDrNa1tu4MkhGMRqUIS
         1mOWJe9nsgw3GL+wvEFA999W12+i5SC95FMEAodq9wi2UdtnU66SZr43H4YJpJgsVPHX
         jNjDbCfz2Gb/ihBdfLkyBBZ/4TK3OKyLflwVtEdREsbiEEUTnh8MgaK42/KuC2eS9SYF
         GX5aeadm5/hlrB5ejmEE+MngOtRd22Dq6lHQa1eCh9yqFNsPtxwTRWcNxc5RSPcZbwsm
         PLHw==
X-Forwarded-Encrypted: i=1; AFNElJ9IW81d7g379Gz7qVblBZ0MwRfoNO6P+xbhMVrRgLm7cMnBV+B7RihKlggldu6p9mC1xGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTK4I9GxhazT6OcpK1d2bLQ1BF758VklP+HjzJJ8BYIaPKDLw
	RxmRRjmOd4qw6uy3r4IUtsgBNTIrU7JpAsC7qsMpJg/tD9hGkNWKasrH+OV31ZKxwqplTYlNNeI
	ufWpeVQ==
X-Received: from plbkt3.prod.google.com ([2002:a17:903:883:b0:2ba:3ba3:73eb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc4:b0:2be:9659:591c
 with SMTP id d9443c01a7336-2beb031ae09mr82252225ad.4.1779525007415; Sat, 23
 May 2026 01:30:07 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:33 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-5-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 04/11] tcp: Split out __tcp_set_rcvlowat().
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

We will add a kfunc for BPF_SOCK_OPS_RCVQ_CB hooks to
adjust sk->sk_rcvlowat.

These hooks will be triggered when:

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

In the enqueue path, tcp_data_ready() is always called
after the hooks in tcp_queue_rcv() and tcp_ofo_queue().

If tcp_set_rcvlowat() were used as is, tcp_data_ready()
could be called twice for the same skb, which is redundant
and also confusing.

Let's split out __tcp_set_rcvlowat() and add a flag to
control wakeup behaviour.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ecbadcb3a744..c6a6853909c4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -515,6 +515,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 432fa28e47d4..3afeb69a547a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1829,8 +1829,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1843,7 +1842,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1858,6 +1858,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	return 0;
 }
 
+/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
+int tcp_set_rcvlowat(struct sock *sk, int val)
+{
+	return __tcp_set_rcvlowat(sk, val, true);
+}
+
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
-- 
2.54.0.746.g67dd491aae-goog


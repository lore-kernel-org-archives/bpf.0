Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098D3911C9
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435971; cv=none; b=jbvAQbukgV9/cIArWr+GmPBvmb6d8GAjhQzq5E3/Td6HQwsQ1YRjNJJDrpQ3WdJFiLqNESUtjE/nwP+LR62kvMVqREJDzGTIx3n7c0QOr2+5/a+2M5RJlCX9KjOBGDoxyGJp4GVgWTsNZbEE+C+uKNmIgyT257hAYpFg+aeFko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435971; c=relaxed/simple;
	bh=kIv6gMdGhCbK7oa+mQvZvqU1S5H4TI4D7YmZRRwaok4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dP36Cmv/+xeOu/sHVfa0KK8EyWJZ9hwNa3NUA45gbjY8IyMM3z0M25shlf2Mi4WlZjFUN3vmKASaRlxLEo/jdKo9uk/9R9p7Yceyg8nr4ylFwdS1sY8f+IG3BWkPSDu6cOi5DiImftx/TK9Wf+bMzlTmxK60CLXvX/2UBwbEJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYnV+H9d; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYnV+H9d"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368b68a33adso10577196a91.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435969; x=1780040769; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=vYnV+H9dayCKE7lgtqIHtm86FI/eZCG+5/9RJ1Et0eDSLChphFi/qjOFtgxoncN0sq
         ZBA2tJfu8eg4Ydc3Pka/XZJHK3JcJbvuzWenj/xU9pg49f3xKuYfPgX5aB1M8XeOQfIE
         0vlPhJffuMW8YYEXrfoEQZTdCHqCeB0k282mIt9zjS2Pj/EN4Jm6It4ItMp+xSdFk9ow
         etOL2cPD3wDhVJ3kqBCxT3TTyO8d0BLACGkfvQljtuYljaX9H48UZTWg96MBxr0If+x1
         Re4RJGGrrJY56yxJ+PaaYuvczISa+xU12GDHWv9HD7lA5ROpBmkj4Q7MEPlrNxmHdU/l
         WfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435969; x=1780040769;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owxhD9mQnHUJh1ExIyWD5qidKDlNDQsR0/L9BsuO+yM=;
        b=GU6oBxkjZiNMH8J1HhYL3gG4iIwf3bxp7wWjKBUT2UVTmKOfyHh6CaREV4A9A7T/aC
         6nJef4Lht4Aq6MblamLIMvB3dWNs9MMKTBU73wzGPnM9vyq5fApm54F+ld5zGb8SPeJM
         i/WbA3DmuhnHsG1mbstw8/GBK5Cbhf5c3LMPU37deS52RwabzaS+wsC03z5pnpw5fzET
         vQLHaENGQXzOLrKuIlOpnwyjc0XvStk4/IkHtsk9zJg79cEaNbnAHcn8UO2a1w8CQqxB
         DQq9TTyE+ejGw6D6i6omXD9nH1aq84qRnRuFeBvHfzv45AwhEt62IVCR+vu4JyWy1vta
         A2AA==
X-Forwarded-Encrypted: i=1; AFNElJ/2K4liFljJvUIWq5GyGCZNpJ18FGMVbr4FPePqDuLhdHZfUWYvPcYtZzaDPEgQVT/EpFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JjuKQ3zIsB1fdss7LoqitTEiRL8lkWYCVr2PQhOivqka1XlW
	gPrEqx6uW38rIpIdKcTuwezDDri9YdkiTB+8nh7Q04I+FckEPmC15n/fTjamRDJJEFo/+GiLaMS
	mkxzvUg==
X-Received: from pgmm20.prod.google.com ([2002:a05:6a02:5514:b0:c82:7c27:98c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2983:b0:398:a060:a967
 with SMTP id adf61e73a8af0-3b328cb9b95mr2606936637.11.1779435968667; Fri, 22
 May 2026 00:46:08 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:55 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 04/11] tcp: Split out __tcp_set_rcvlowat().
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


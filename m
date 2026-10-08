Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DC36F8E7
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 03:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429377; cv=none; b=Pd7e3cT7N0UDmXbZhfMSd2rrPDM4OOzSYDiYeSi0WoazwQ3ordEGnNcVEk9IyaSHAjDKylVlxZgIygoLbz3i5eihPhSYwbEfNEDBFnWbCanW1HvbDki9R/JUo9tHhhACf1yn671pmLcxknud/XNwf8dESK5aqT4Mbpra1FP+EOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429377; c=relaxed/simple;
	bh=KHHaPzZVKubNoT9YptdIlzqqUm9ePekz0Sgj8eYfuyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LNy0SblnFkdWhrTzOJNThWdgumHGMe22ZHPf8VkxQ4ojrdZEJsN8TQ0MF0dgn3nVYeubsZ3UXF3bNdDO4hiwa+vWw/FXiWcttUnx/VuW2H3/PtsfoUjps3C4ygcrBgr93UwqLqlQRXOwptx4Z6GR1h3jU/Bzl6aB+ga4bwn2uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldcoW/1R; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldcoW/1R"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so6302634a91.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 20:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429373; x=1792034173; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHALJ6NF/mjRkO8ypLgn1SGUUyeW9FBhOzw3U5tE0kw=;
        b=ldcoW/1RvoKm09VyCU4A6R53JX5vBIVecNy5f7GWoiER0C0zin4Nk07fh8X8CGnCsu
         85xqaQVdCQhVQ2/tM2JVDz+fUOreanJVTpimc92CeqLFY3G5Nq0gKjutSFllJaJn29vl
         +gL1G0wMUehHTCclW7D0zktJMKaywa7Ro83bnpND2HFz4M8RroUwGZSXDGh34oddMdNE
         a7jsfcnc1tOCg0eICkXNLmfNjRcep1A6DcFiE5hmG/Eiaw+yI99m0OHXH+0FjwS5g3DD
         eYwoVPMZnZVo/m1HLM/Kn1Bv5q5UFDex25yV/Ik5Zp87AyFAMfAupIjxPSz1vW3I8Jz+
         Y2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429373; x=1792034173;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHALJ6NF/mjRkO8ypLgn1SGUUyeW9FBhOzw3U5tE0kw=;
        b=XtsBVd960rRmSh/LM5/1wASJkOtujijAZjuj+Ls0Cj2QblHhR9QekQ8pMpfnjnZtYq
         bwCjr7g7FAMV9Fbn763yJgd+aZWcbtR8B0y7j/PQOifQOsoUtGvTfftNUAnxsW2tszVD
         83iwEBkP0j1hM+MWQxyuvXAKT9tligw7CtSDjTOBz9GfjvgshTWrl5BZR7UQPsNnAWs2
         A+EUnjWHez+IlP3fW3rrZdRbSN5F9C45TFPSb1xza/bYXdCgCnRa19T/YdqxU3sAFVCN
         MDQrk8IjMidfPn68kMYYMLSMZDkTE8UM3t1XcSJdG4sAuv0kHg+oulNLuyRwQgXf8dtO
         Ws/Q==
X-Forwarded-Encrypted: i=1; AKwUvBy74oUkKRQnNo/cbXqLksc2d51KBkAOpGJMU1sBFO5YR7cLc5TbIOvRkOw3sthBYNaeTlA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwTP1vMAEd7XMq/cfyBU83cZKeuupsNsfNEsZ8aEafNxWNI7u1
	MUGjXlpbYZC9DDu/g8NkBC1vI+PPHpvUuToOluCzGZFIlB+i1/IhQRoDMOJ7ZZnTwPj39dvniZ2
	/4lfYdQ==
X-Received: from pgby12-n1.prod.google.com ([2002:a05:6a02:650c:10b0:cc7:c4cb:69f3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fc5:b0:3a0:345a:3646
 with SMTP id 98e67ed59e1d1-3a8a0f410a7mr3758321a91.45.1791429372510; Wed, 07
 Oct 2026 20:16:12 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:27 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-8-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 07/10] tcp: Split out __tcp_set_rcvlowat().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
to adjust sk->sk_rcvlowat.

These hooks are triggered

  * when the TCP stack enqueues an skb to sk->sk_receive_queue
  * after data is dequeued from sk->sk_receive_queue

In the enqueue path, tcp_data_ready() is always called after
the hooks in tcp_queue_rcv() and tcp_ofo_queue().

If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
be called twice for the same skb, which is redundant and also
confusing.

Let's split out __tcp_set_rcvlowat() and add a flag to control
wakeup behaviour.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d95cbe4da96e..f7624ab9b420 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -512,6 +512,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5d907a0a0461..c3c756a1ba8c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1827,8 +1827,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1841,7 +1840,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1856,6 +1856,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
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
2.56.0.360.g66cac248cb-goog


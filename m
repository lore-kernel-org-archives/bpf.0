Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10447533C
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789934201; cv=none; b=iyT1sgALg1Nep4DeXdFn+vzQEabzrOMMAv3nDgNsPkoUkw/DrAyQBNouze+lBtuNptVEMeX3oddpqH6Fayyb+Ag23CmEaFTaKmdZmKG6Rsm9Ie6N7TYxaW6/GjJpWRchOd7Ea7UqhKmrwoSzGJitfadrEBxNZrwwfpo5+/cbsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789934201; c=relaxed/simple;
	bh=VdEUWFAROoBW1mn9/iUi+EkcjCaqtkC7SrKl2K/C83c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pYV2q8fVipFi1tCopnVO0L7B9qClIs1RKpr6HgTnwCuZ01NaLHjiXm54nweDrQqWJD0Cn1AxLNb2uBaqOcfQ4JTthaICBtrE1Sn87k47+DyBhHb/9z0u4scXYnM01/AeVbGrFhnpbgRdwbX3kcHkiAQtupEtvLUwjN31zjwBlJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyaWZHFC; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyaWZHFC"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8679cfe5019so3489034b3a.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789934199; x=1790538999; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wlt7yDBa7UXqEQO8AbcaMmeDAj7eaDlLAeZVbBJ2ZL8=;
        b=XyaWZHFC0kxGGD0dLz44RE/fj7+QZYqpn3xz5HkcSfbWYUhq3EIYhnkcz69eM+9pZJ
         x8xQCLonwgSqExtweWPeVKV7voqhDsqlAyLaVpufUpCkhSIVpAGJ8vT4r2keweDEAFGp
         ++jvLB8eEuLq77v1ZJ0FM3SthiiP/1wQ2D1QSRBueQ7/Ezkgj6zWQ3tvTBnVNX7cEL/m
         jg8bndY2iZPMWBfxfhlMmmIV9DMmvQdi3m2GjtFUgs7ORWknm8vnsX/4mAN9FBhBta+f
         GBBqfNafjgesGT4kl6Ax6QeDQgd/FQX9/G2L6Qj9oqB9WE9l6Qm3qK68aezsSNQaEm1M
         WkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789934199; x=1790538999;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wlt7yDBa7UXqEQO8AbcaMmeDAj7eaDlLAeZVbBJ2ZL8=;
        b=LCk6FdMoWLKoZUX6pV+Jr5yoRvB95pPCnnz4ejXYu2rn2Y6qG3bwlyMhjkxBGX4ltY
         wSn5CS/atkM8sxpaNaFTUsWI+7QuamHo9k5N4/Qpc0Sp07Jh9ap+YnQK4mdEpUo5qhGV
         BkQi4geeONE/YYLi965/TU3w8DuSxucM5PpChdUX83oaZt/pngRcIEGpzJs06iChjUte
         d70zyjxCVVEZefDcAhh3qTdqjbsciYyQAUAGsgCqIKAvFGv9lTc4mFSvEYRtw5XLh/M3
         SudZN1Gh9Q+70tZ0Ol15MVidh/lbNC1JiEn5obZKg4jfl1Zoy0ZRW3Ne9vWnz0kTex4J
         r8sw==
X-Forwarded-Encrypted: i=1; AKwUvBxBqWXrPSW6W7/py5yhW4V2t3ob5FsSbh3nSMhpJJLcA1YSoANMoJhIh3KijByXQEKmtlI=@vger.kernel.org
X-Gm-Message-State: AFuF++lWyZqee5cjR+Jhl9E9oytMWsFq7I+/VdTo008DP1R9wxC6NKiI
	Kru8NBwfRSu1qCAuxZhGcMkBivlv+47TAG1jL1PUo3KpxT6VN/LAIDkyu8jAg0flH6h9n1uGrd7
	6ERRmnw==
X-Received: from pgvc11.prod.google.com ([2002:a65:618b:0:b0:cc1:c12a:92cf])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:140a:b0:3dd:a196:69ec
 with SMTP id adf61e73a8af0-3dda1967806mr7542081637.71.1789934198583; Sun, 20
 Sep 2026 12:56:38 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:56:13 +0000
In-Reply-To: <20260920195633.3033620-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260920195633.3033620-5-kuniyu@google.com>
Subject: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
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
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f2d838bcb0a7..07426e8641b7 100644
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
index a714b36a7494..aa7593fc8334 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1828,8 +1828,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1842,7 +1841,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1857,6 +1857,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
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
2.55.0.1082.g2b9226bbc0-goog


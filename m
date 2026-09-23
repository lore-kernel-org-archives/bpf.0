Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EADE4772A5
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199449; cv=none; b=puM4wb3emp1sTjTD5MC4t+lBc3OJeozO8bAElhg2OezRGfw0/EpZe9C+vcsg/WlpqHIqz7+bQ2ye0XjLb1yrXlHIMVDiLDaQIqOK9XdCgqKNiE3iOB0u5T24oaAHaC97hhFGr5eaQQNtcSzWEN2MkmDOi7EvHIciyoSv526pvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199449; c=relaxed/simple;
	bh=ZLfFJUyQhbCn0VIpvqEOWx/FFsgFzf5MjDx2M3I7+z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQYEFgn6G9W6DZaaZ8g8WxFDaSwOiH1sa9GPmAifE7qVZg/FgfOKzSlu0nBLZGdNdRDhxCEoPPl8f5WCSxRHx5IW0QpGNjjMTExO0TTBctR0TH81FqO9WqiLEPvxSkM9p2wIIlWxvTS8UIeHJBPiI1yG69889KlO3UJl+3XQBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOuxlERO; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOuxlERO"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1a439db36so945346a12.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199446; x=1790804246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OdmBjIhiMnkr5qSI1UbyEyABXjtUpaeaqR9TtxvSC/Q=;
        b=IOuxlEROCr3NpKR/EnqKG+yJCeGe+3ygEC88fDn8vTij0XQQQmGdTOVRTfd+yYVMF1
         abIwmuUdlZ821kvKuZkS91IF2QbOfFvDBw6M848HKlcom2DuFUf3Kq02EJmIEuFndjYi
         9VirXol+3t/dSgww6Ny+KlINjlzdNT51mk19b1/Sc4fR4uWDZgso8wnnedL6bi8L1Av1
         aVftLQh8AsRVW+6+U39+F1B2gtqt2xxxt0QRZ3D9aLCgvWDs+LYfgj/cN6x49ZAd30uv
         BmiaUWjqP21b8SNgqSkyfNwzYhWGrfpgHQDuI1iGFvSxC/RIzg2QnUflTIofZx6udUwJ
         ObIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199446; x=1790804246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdmBjIhiMnkr5qSI1UbyEyABXjtUpaeaqR9TtxvSC/Q=;
        b=yVSp6nuJY9WSjrGP6VasXfsDr5DGGSb7o7Ht0SjoSWjIPehJYfz89rhNrSkSRYKcEM
         ZlqE+7E61E8r7Am237RAbbTCeMM3DYEt339NOHKRoFawDdPiKQBnQegiw2SU96Xta0/t
         R50bmhFOnALRftU7KjScpjt+X+dWWXeVs3UqITFP5rppc1QWv0WPs/7Dqf7rzHP+AxE9
         1bZvc8pK9jTtJBEaxUY3/kACqpOmyMKpYzY4xQIe5OmBOOntQxQ7uqngkpe+X/L+9pbN
         Q/0avI5or77KGyqMDlSC0qqTn0TROOgrkokZyVGYnxQiP3ZzOZBk8AenVq7FZIirPQip
         Lzog==
X-Forwarded-Encrypted: i=1; AKwUvByFSYrbY4l0zjckeXKdFmgqI6U6vTKxSZyS9+reYLJwIZCC8ErkogzoJ3ohbe0lno3cxiI=@vger.kernel.org
X-Gm-Message-State: AFuF++kgtWlFgK+Y4hzXIpMwRbepHPT3APQhnctLwbfbwAPKeJMs8mtP
	lifLGOGc+FHeTWvQcJhKPHTWI3/4TbqQ2DmRYPJ96wRqcP4uuv3mnDiS6DmkTypnIlOLpVLtU0Z
	wtVCNaQ==
X-Received: from pffz15.prod.google.com ([2002:aa7:990f:0:b0:877:2ab9:a8a2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:398f:b0:3dd:85aa:d26a
 with SMTP id adf61e73a8af0-3de0e7f02e6mr371675637.34.1790199446314; Wed, 23
 Sep 2026 14:37:26 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:35 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-6-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 5/8] tcp: Split out __tcp_set_rcvlowat().
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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
2.56.0.rc1.315.gc6ed9934b7-goog


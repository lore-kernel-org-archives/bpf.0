Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75AE34EF15
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303636; cv=none; b=g/kPvELr/AUA05hTyooUjMy0Lbx3I9/Egi2ai1fD6P+L1lq7gmbQR5s3g1OgmKyFfZ90kJR5lxgjK1IYgLbDorsjUoY6aQFO0FyB9aNCI7XTopzsVdIWPSEWEtdFv/w1F8vNjDXNyOx19SdciIb5LIKyabWTb/+8SUDnEUI6HGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303636; c=relaxed/simple;
	bh=s3q9wJaNCd4aqGAfSgzhEmwkY7JI4EZuWLp6kixzQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp9p/TI+IgveZLGwpE/B5jMjRF+JIY3PNaYn3PtTjI7dn4eASMw4kbq14NJKha+x9AYECkj+6zbJ/NLY4wT/EpMhor1DRnakRGx84ucrApGB+S3O4amTkWzkSK6SCINEtK4a0lDMaq++lEae7w1yeKaquijW8BRLUZdJs+TxNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3FmyOuP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3FmyOuP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-474560436c3so3422858f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303633; x=1784908433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=N3FmyOuPDYgK/grqBKI042mNXyrc/hEqM3Vmc4F13S2pLYIdCKLT2tr+bA/V1ve6WY
         hbk/iJexhTgzzc35d9bJ+a0B0dsWYNfajKvhxpatMVGMMaX0JCzsQ5RBA7oGB9T/N5r0
         taCqj2S0CDTcmgtG9YA45J7ql3qa8w9V8WDZkWaDeCaGUIU4PouYKZbv5QnAJHnl2Xt5
         gRyXHjzOINgvBmz0ud+o5l872WI1LADH8xEhWpMR+rYyEtV9UPEtAdJVlbxabb3846uG
         +VuK1oyJn2CWVxWEvE6UmCfX7d+tG9wuz1CK3EXW9LQ7DP62JcfdSnSAv0zhEtVlaTE5
         I1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303633; x=1784908433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=Jv8FsPRawEFvdpfSJcCMfnljYuNC/+v+OIcW7H0vn+cjrbuT5qnQLItNBjVRJPvbFo
         HhJQl8eh19OFMVBNFQQUYZ674JroPp/YON2IvnFOtjK/mc0OOFvfOHmlGFuD8umr2ILY
         dXR0VQuSu62k7PjiZ+sB2XJAUAPKvlW8e7oerl3P1ayrKwDRwyoU9vBPcoYlJ7KZY5j+
         XWlk7oyp48rndMKKQyRHDmM22IQ5+XhF5AnHEKBe+EUWJ17eedeOuJ2TmG2Y4pCSzY3E
         Wm+nrLg762NhKXD8plwQ5CR9tmRhDsL8l5u2+cX7dgCbeah4awCphIKbHhf37awXq0j1
         lDQg==
X-Gm-Message-State: AOJu0Yy8G5Lli3f5Pi3QvFn239fDv68e0ylOD29KqQt7q5eDTsgoZqxS
	U3MBWHjWZjLTBeo3Xr0KgWi227p33GYnZSGai37Xi5iSOexkmaBPmtVJ
X-Gm-Gg: AfdE7clDQ85l5VkTiWlot4QXo3dB6CmB5E6Skk00tl7Pxw/3hJkUD02O4a/141eKdSD
	HUjkf5K4cGvA16x2abXlMveO3VvueFbafagKpHAK4xYxhjFK3H44XlYXV12GJdcEHU0UPkDPlMd
	ZyTthHWpzYb0jM0Z3dC0/3nTFdVj0xCTBbOT7cCB8lPDz9mhLH2H+8ruA/aVqy622Jgwv/sWhEd
	xyGJnxh0e+tEn0Vt4HnTLWGoo7GE0swp8YFGQfaLegARWcMR5SyaPK97+vqcGnkyoz3yT2gdlhV
	Lb2tyUIKy6qzA7VYVOl2pwLDL7ozCeWUYlZnG/jsWdmtjr2Zzgp3FPBgeDIRNsa+GZpfUTtXNmO
	MAl4q2TM5rGwZ0TaunKODZ229DQxmjPTgP9ltBZ6KND3MXrS0WvvVdEfc1g1YWpVYVxvdYBZ2yD
	hOb+vfnOEA4maP6BjpHxW2Hb0Op2RShYrkSG2EbPyO1R6dDACcWwT+u+s3jid2RWM5UbLMrLNu5
	Cby
X-Received: by 2002:a05:6000:2302:b0:47f:487c:ce7b with SMTP id ffacd0b85a97d-47f622f2c3fmr4212975f8f.7.1784303632688;
        Fri, 17 Jul 2026 08:53:52 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63edcf8dsm5321369f8f.27.2026.07.17.08.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:52 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Fri, 17 Jul 2026 16:53:47 +0100
Message-ID: <20260717155348.54975-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260717155348.54975-1-nnamdio@gmail.com>
References: <20260717155348.54975-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
when they have a receive timeout configured.  However, adding a blocking
ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
sporadically.  A socket with a receive timeout may return EAGAIN before the
timeout expires.

There are 2 code paths affected by this:

  1. tcp_bpf_recvmsg() - Used when the socket has been added to a sockmap
     that has no verdict program attached.

  2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to a
     sockmap that has a verdict program.  To reproduce this issue, it is
     enough for the verdict program to do nothing but return SK_PASS.

In both cases this happens when tcp_msg_wait_data() wakes spuriously
(returning 0).  To fix it, we now loop back to msg_bytes_ready instead
of returning -EAGAIN on spurious wakeup.

To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
wait excessively long, tcp_msg_wait_data() now takes a pointer to timeo,
allowing sk_wait_event() to update it as appropriate.

The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
socket errors and closuers in its loop was also added to tcp_bpf_recvmsg().

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..aa5c5d741599 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
 
 #ifdef CONFIG_BPF_SYSCALL
 static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
-			     long timeo)
+			     long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int ret = 0;
@@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		return 1;
 
-	if (!timeo)
+	if (!*timeo)
 		return ret;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	ret = sk_wait_event(sk, &timeo,
+	ret = sk_wait_event(sk, timeo,
 			    !list_empty(&psock->ingress_msg) ||
 			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 	}
 
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
@@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 	seq += copied_from_self;
 	if (!copied) {
-		long timeo;
 		int data;
 
 		if (sock_flag(sk, SOCK_DONE))
@@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		if (!timeo) {
 			copied = -EAGAIN;
 			goto out;
@@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			copied = data;
 			goto unlock;
 		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 out:
@@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	struct sk_psock *psock;
 	int copied, ret;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		return tcp_recvmsg(sk, msg, len, flags);
 	}
 	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
-		long timeo;
 		int data;
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (sock_flag(sk, SOCK_DONE)) {
+			ret = 0;
+			goto unlock;
+		}
+
+		if (sk->sk_err) {
+			if (!sk_psock_queue_empty(psock))
+				goto msg_bytes_ready;
+			if (!skb_queue_empty(&sk->sk_receive_queue)) {
+				release_sock(sk);
+				sk_psock_put(sk, psock);
+				return tcp_recvmsg(sk, msg, len, flags);
+			}
+			ret = sock_error(sk);
+			goto unlock;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			if (!sk_psock_queue_empty(psock))
+				goto msg_bytes_ready;
+			if (!skb_queue_empty(&sk->sk_receive_queue)) {
+				release_sock(sk);
+				sk_psock_put(sk, psock);
+				return tcp_recvmsg(sk, msg, len, flags);
+			}
+			ret = 0;
+			goto unlock;
+		}
+
+		if (sk->sk_state == TCP_CLOSE) {
+			ret = -ENOTCONN;
+			goto unlock;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto unlock;
+		}
+
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			ret = data;
 			goto unlock;
@@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
-- 
2.52.0


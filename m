Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774E3C8717
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061587; cv=none; b=HmWjzNvFXrxwWtnuZkep526xDqDRt03ynbx0QYViWtKpdIoru9ZSqtO/T6vtG9uYzKvqpHh/EFzwZ8RHtJ9UKABxDLrhJIh6/12jSRTmlA6Q/SCVAjyGIHSFdbiSzZRwVETZClXObhyHrmtqRNZdM0DB3qyKP+B1pQiHosmJ6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061587; c=relaxed/simple;
	bh=FBBa9dhL9917F3OcmR5Tscs1K6cFUVbxn1jGmTddpkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqf/y9O+9NGaLCvYBVPyHXKsRUTI5mUYf+rZnP053hpKV4MJsdoXFiHiY1otvzbYmazliDlThHOIb+Z+Z6xzLN4/H9PT1+J+csh2fKsKLQAO0L/QADQe2fsR/efgf506MX0fl502HB22G20z33Wc3rOXEOTLFUiadkZ/Xpz91hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9UG+WU4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9UG+WU4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b7612475so36632815e9.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061583; x=1784666383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/u8DsZ0eIRa2g/5SoCaTvebv+Ssy+0KgOmxxIfNFxNA=;
        b=o9UG+WU4FE25ADehgev7na3V9ncvklEkqYvLGO5DX8fjGEB4M9P7dV5EOmwSIWXu7n
         Z2t0hnX9/lJSj5YWxfFTiv7Mh06dEh8t7PYQNUqlfxJ2EcNM3I0/YIk/CpASq7HCbfwh
         h23PyqYzFTa7k3q1aO2XoP5lNzuFlUogX/ChIKO0I6wdSWbaCu1zuvWhu3pnDN5CGBE3
         EYXO8tGGBACpJBXrq3/rTymYxggKuByluRgqOQL45SRiRrLj85onlJ+HyQKsuaW8Siby
         1t6M+Ase+11FVvKK2CvAAM0jEMTWkWVoyezNjPAuPN4hZzZIovqhhrOZQurBOr7KrD6V
         Du3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061583; x=1784666383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/u8DsZ0eIRa2g/5SoCaTvebv+Ssy+0KgOmxxIfNFxNA=;
        b=DflTzB7Sl0DPyDRS06TXoaFzerh+foaEmoi0BN/gahYmXmchufo7DDeb15hy8RmsKH
         h4kJiWH4YRWM4bMMei0bZ40iUO0fwMtmBMlQTOl25/WTjfv0ML4xNqGTzwX6LnereHUR
         lvVF3DFnumxm7btXtUvuF+alLtjOurzkDPFuQPBS2belWPu6aragG8WcRrboPBjT7qVV
         ogJHnvbrnXYejDa52PMe4p+ELRXMDAjQ7LjKHiyOY2aOhTI0AOxeFhbAKzaItEBjeIC5
         Y5X5rlGKGjR/LqG+fb6dDtqY9Fa4llbaAhViVhstSFZfRVtmbegQO6V10EDAnIdxfL4Z
         9cwA==
X-Forwarded-Encrypted: i=1; AHgh+RqVpCsJU4R3qHLIKPgUOrz9KgvYnlLWMGd6dtQR1aHW8D4Vj83mP9xQdr6nCcfpFqaObDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtuGAzqLWZk0FN1mm6exYa68EfyB16iT1Ie5yTw9RbyYWbj9ld
	Bt9TZ3QwDEgu5dStPvH2yadmIrbK1t8UUGcXlb+cyBMERS0WNJkDqMws
X-Gm-Gg: AfdE7cnIQl8kyBIF4zrriPbUcaaIpGA6QjUY/cIQdSD+50oHEhROX63pc3aRM0xKCyJ
	EJJ1+pPKrCAIewwVdjmYiSitp1m3qWZlHT16GNv5qlQgH8Ef9OuoLfNGzVuvUI7Yp4sCkMEG8Sc
	tov/vZoiWkEb8V7lmanJ+8AN/st+aMWivVsT1p7y4rRS+6MnL++cb1vk6zup6Wk24PanE8xFlJb
	0X0ksvMOPRrbFM350qnL6fLooMNxFIN0nq1XqCuCrWS5strLjIzMVMU4YaDcNa+tMqSVsHnyaF9
	yS1DQjyAmOX9BTofOR50hTtxdsjMWYvR7cgW7PzrzDV6C2OJjyAHFxL1sa3zuK4mfJJoZFIAT+h
	ctzwWiJT2YeEegij1O1dR2o70j4LPG8aSk3C0z2pRz1t3uzNWvsDxsuo7bzoDVBgK4B/HKRYwa0
	d5OpYdGp7avH/NwmGnnOZZ+/AZBn5oHLBQOcs3Be0dzyVIWEtABFN5+92SebpH/3XvbXMYu3yvp
	kUY
X-Received: by 2002:a05:600c:c16e:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-49515904fa9mr60720155e9.19.1784061582835;
        Tue, 14 Jul 2026 13:39:42 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm98894115e9.14.2026.07.14.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:39:42 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: nnamdio@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v3 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 14 Jul 2026 21:39:26 +0100
Message-ID: <20260714203927.32289-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714203927.32289-1-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260714203927.32289-1-nnamdio@gmail.com>
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
 net/ipv4/tcp_bpf.c | 55 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..e58ab2d1ee94 100644
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
@@ -371,14 +375,45 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
+			ret = sock_error(sk);
+			goto unlock;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
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
@@ -390,6 +425,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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


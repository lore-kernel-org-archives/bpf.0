Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9881F43B6DB
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567748; cv=none; b=Hk7NjPlGYAhLvcfGjUp4DfMGHOda6BLXih98WiX8Gg0C1ZK3ZsE5JCHZ8BoMw3IuXGHSxyFQ0dSieWP7gD2RPJKEdU1wwLQRP8hpmPAjdX79ma5zNHbrhzFto7pxcxNDx20CzgB9bZX8uAAinh5X0LaxqKc2KIBY01sPYma0bng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567748; c=relaxed/simple;
	bh=s3q9wJaNCd4aqGAfSgzhEmwkY7JI4EZuWLp6kixzQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBX2vC623Qhz9ozGWsyHXL+q1hGlRZKWCRUUoD+59KafLkPUuvgKRvdNqj41hdCiZsvNUc1Ki7jkjNHTHhrQkxtby6dP8WQZ5kcgPAjKZ6foErtuNz9ofA0eC7NIlHMOoC6oxEomfNMZ7Q8YmgIZ3AiYj1nCQ9lURhUidLBl7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJE/aLy+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJE/aLy+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so16017825e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567741; x=1785172541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=MJE/aLy+n80Qn8eLMtQUA/z+7+7ItLAeV6oiuk/7083Fcdl1QBRd6KtMX2yM6zU65P
         ekSwc3wzkWx7ZrRfPipG/Q4/eKu6ULxiiXG8jzOZPzn2yYhDkTKiPrpMjIGy+lRJweNC
         NzWd4sPunNBMjZu08ITIADwiE435M++jcSw5EAFcQWFGn4CcFlfi8zs9YetMnQBJU3gU
         iv74pnfDjScIe4+hQm5Knfzb9Uv1fgiu+huAyhT0XsP8OZFfuNHmFuNQ6GmSn+cpnojo
         eQH/IqabGi9pLptY+ddmNSZZlPdNYUr2vCNyipIPXti1NupQAP9FA/dKi9VwBBcOvsAS
         6vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567741; x=1785172541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=XWMW0ack1ZQdaLorbf7cF11VNUgAxcJwkoiqsyeqgF5PZNP6qXiHGYHMSop2AWjxn1
         A1VFmK3sGGt0GzeqhhJ8gjofN2ZvMjkM9a1Q2TFHVaAL8WbhsfoT7v4l9cBtRNYXD9i/
         jaRIDOGaX7NznOla0DM3u2ahjWBoTX4RAEAfVv5y/cLWZotsHQCk2MQa+1wEUrja23WR
         LJKDOjWR57u6gC2K/oWKSBY9tZzjk15mrzbF2B61BKtZQ7bz3QLbbk8e1BKu1DO3o61b
         F6IHrzQhBxO3EKGCpNy8iN5pJHIB2b2o2skFl4HrXainM8aGlfIBMXF3Q/K0pXJBB8cG
         4Skg==
X-Gm-Message-State: AOJu0Yx1WQmJTACfI0APRCDn+u6Q3lnUx2DTT8Ulgs336jw22oqukFX3
	Cl3J7ZdMjm0bcbD0NhRZwRlwbiW0X/UiX3OZjJ6hh6mFFFscKBwolg6n
X-Gm-Gg: AfdE7cnkSGsITs0fUaiX9bT8x9rcPNAnzU+79onuju7qGu1xAEicmlnELPKMadSGecr
	O5rbRNTxUhshylYgDbUKdkGHtgEdpCNQjr9BzjdAfn4IEK1mFP8mh9/EPVb2gbjcmzzZAcnQ5Gb
	qdV9eD0dO6mqQSySlxB3WfXnjFjbWFAGewieTfbQKqcME/1wE/EnwzpJ9CpaRl66BljDitIMxjh
	3a/r5RB/RnvHZ9Myhhe7kmz+7I1V8aBfVhPmks+99bBVySADnB9YIV/JPqngsn97jQcZJXAT1da
	WnDAGabIFxAkqp+LySWHo0pmrqO5N7YcmTcc6YTsnQ5A9KCbnzgz/ni/bdDe+jvyD+lTMJIfohH
	VTvpq+Dmz82trF/seGkL9q/v1NeVCDBtItam/xKFsJBh7SyZWe0DKNg3fjqe4oTyKvdJ0bWXpoE
	0bwaq+e3vWMp8KXpbzQdf0o5ePPDLGnaFujWiVfhcjNFEOZ/M3IbgsbgDEd3lMT+x3qA==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr143514195e9.5.1784567740489;
        Mon, 20 Jul 2026 10:15:40 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm2304865e9.8.2026.07.20.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:15:39 -0700 (PDT)
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
Subject: [PATCH v6 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Mon, 20 Jul 2026 18:15:34 +0100
Message-ID: <20260720171535.67867-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720171535.67867-1-nnamdio@gmail.com>
References: <20260720171535.67867-1-nnamdio@gmail.com>
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


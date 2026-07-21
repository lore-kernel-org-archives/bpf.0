Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623A643E495
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673505; cv=none; b=JUgmDSm7kHHPxYOgVsNmzykzZJcUXwXnVlQic8P3qVKdu+XNSeMLp5V1Sov4ZPlbo0SKkwtVDMNcnnuJgOKAkz3AL1D4zb1f2GDh5Krf2yXBpseS0Bp7mU08i0DotbUUvhTXdwcGaif0rwNtue6uqvyXd6JAHl3Lypy0NyCDMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673505; c=relaxed/simple;
	bh=uQ+F/GDx2k+rZa43OcCjQHAPPId7y4rF1PfHE0gi9Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsOL5th1ukleCbHWzogT60NmcKr/9+iiihxdT8l6AWct+m8Db3tW6jsd8hBFEr3AejdyHyf1iBeUVf+WVvA6/98aW1ZPQnyNoDB/Jm9BtUJbiPkyANWk/7dNQvHBL288bGIfQAH8FD/YbOkWrHOHWVL+A6iFk9qu/wIJ+l26ABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPx4PHpc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPx4PHpc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so85774425e9.1
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673492; x=1785278292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yr1536DE3VKasNzBXuW54z7w/XcJshRbpQVnWBAXxn4=;
        b=sPx4PHpcRonJ6KT7EtbY9PVNBtY+yR2K0ryy/WSoFlOPwnDhUe+NJz78/qEft9GzP9
         E9hYN3F5AOElFuJSQ+YytHtj+pfH2/8BRz8QhqMkL4olzyDmI4XiRkrTyI5RjadD1/sO
         Jhzt8Q8XdGaEWDSPU2LvSREWJETHDSSQFKC8VOmy6BAoFLA3AO0lCF1t68GxwNdz4JYc
         6SodbumqgLaEc2+9cfsTz/A+vDL9pCxjUuovhgBasvWAg30rVqP5322DJBd2zlJN4GkD
         cnxX3wbOY5n6Z+9kBMzTqelG9nHFrEeA8Aeb02abzYUcVxnw9qC8RiLfhUdu5QVHGU2Z
         2NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673492; x=1785278292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yr1536DE3VKasNzBXuW54z7w/XcJshRbpQVnWBAXxn4=;
        b=q/SEVMYMBESzSQzFgw7jHL2Bu5m0xxbPwN4aspKMLM6nAEJc1fpbUf+gmZLt+RKR9a
         7fJBz7/hFutVPBiM/5e7xF99VfrNJIRbLmgGhYWRw0uK2d3H1sMk9vDg/B9icb/GBuE/
         GoB2ZB+Q2D9irHlrkSqviFzQLTu0xqOUSosGWYIFlhI33fjPbJHcuNnf2OaStXgSfTMd
         HBdog/X0HpO5PmIc1qOkpsacrfplnvwYvOe61FIul9ayIYj8P8qw8KyxBZOpBAxod6iO
         +E3rqcqEfiBKsFdPQ1VOwiJTOjXoummHpaxiVm8eyqWtD9AKVOSQIKaz4f5hufmtVExq
         TQ+w==
X-Gm-Message-State: AOJu0Ywe/se2nsXwwatcTOula6zba0C9BE0GsAp+FQ9r0vTzm91RlEq1
	SkCWa3AVuQtww+t+gXAPfOAlz68YZGfK7TmlHmoUd3jZY0S9wHAAa8mD
X-Gm-Gg: AR+sD12j3UAulX7BSatDxjR/QXUEg59JJyuCxw5InI9QGw7f0XnnT92jlPCFbHQaotV
	JiF7uHSLLzDoZ+hJfuKW68MsajdBHr7VDyTxjDuvW50ii8jQFYHX82cUZAsPLrD69Qa/xUjafeb
	c1WyLDf0Q71bWEbner6d7belB2HG8FX3WlwYkyeO1wSTOrRzuflHS85QdHXf2OiasB2K+3n0Out
	hXfm0KLOIS7p1W1sGjaCwM1xfEIZkyNlWR4TTg1lC/kCK0nqJn7B6mqhFykyC8T+H8UDPV+EKFz
	mUTf+95iXTOi1TbwQBkbRlZJPVuTZlJzuNEUZ+koVsFPy12GLW8b3wYQS34bT2Yic8lsZEoJe3H
	sKB1iaOJ+SRB2n2VdQTaUn/w3tp23gqQxLw0qXeXep+Ktx06dIkGVNtY4QmlL8SbQzU0GiLVwwB
	g4rXrrKIRWUwZ1ERPicG4+NVMJIjfUllLXtMx+95Z1MjqQQlDu3k5b3vr7p4TCOrTh0SY2R/oxo
	opU
X-Received: by 2002:a05:600c:3b2a:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4955e86514amr111000995e9.12.1784673492483;
        Tue, 21 Jul 2026 15:38:12 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm101290455e9.12.2026.07.21.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:38:12 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	emil@etsalapatis.com
Subject: [PATCH v7 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 21 Jul 2026 23:38:06 +0100
Message-ID: <20260721223807.75101-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721223807.75101-1-nnamdio@gmail.com>
References: <20260721223807.75101-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recvfrom()/recv() are documented as only returning EAGAIN for blocking
sockets when they have a receive timeout configured.  However, adding a
blocking ipv4 tcp socket without a receive timeout to a sockmap will cause
EAGAIN errors sporadically.  A socket with a receive timeout may return
EAGAIN before the timeout expires.

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
 net/ipv4/tcp_bpf.c | 72 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..1755fcf726fc 100644
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
@@ -371,14 +375,52 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
+			goto check_queues;
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
+			ret = 0;
+			goto check_queues;
+		}
+
+		if (sk->sk_state == TCP_CLOSE) {
+			ret = -ENOTCONN;
+			goto check_queues;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto check_queues;
+		}
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto check_queues;
+		}
+
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			ret = data;
 			goto unlock;
@@ -390,6 +432,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
@@ -398,6 +442,16 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return ret;
+
+check_queues:
+	if (!sk_psock_queue_empty(psock))
+		goto msg_bytes_ready;
+	if (!skb_queue_empty(&sk->sk_receive_queue)) {
+		release_sock(sk);
+		sk_psock_put(sk, psock);
+		return tcp_recvmsg(sk, msg, len, flags);
+	}
+	goto unlock;
 }
 
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
-- 
2.52.0


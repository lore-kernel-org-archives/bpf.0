Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560904;
	b=koG5vmMjYb+lT6/1xsTLYQTUyfvIDBW6m3XfZm0wHimk4kgP9Ku+9zGOPAwpWuKWt46T
	 iM73/E1G1IJuf7uDJ+dhd0spLutdJZMD8YnW4VodJpyBJEYE8UuQb4Xv3xgystSbDSJhm
	 szrGFyBxbK587onKWUeq2Bpd+8ytFJSxURMFkzn8XjJAI6kyO3bfsKdpCZTFE/d9ROb31
	 h9I0Z7y49FJt5Jf1RnV0gbe1iM9i6IWom3AC1FWqP0DsJpVCjN8CPR0YhlX3w0cJpTCGf
	 vJCVgZrgfMIpFz1gpbcxlq/zLvyTDpnqlhzYITgtTefB7F9ZKcaKf60QehW4aATtSLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
	b=uh6AdUNtH0efI6fqIX0OK3pdhUU35N71FMvy1DtmpDrKzSoLrpCFbuqRoxIIXnV5429L
	 6zdq8HqkD2UTZ2fYxSn5dqinerHhkWKiJKfV8iIIlCbOiarTWWWIRtFOzoBvqd5h7+gwu
	 HYsVxcgiIQjOKOW4sQMEAwmbIaJd+eBNEQgenNHlm+pFaSVx4AWY+VMf65Hi7q56zN/5p
	 lHY5TzAZimtrYEZQelZsfnJoL8cV+b8wgAjUU588OlZWWjlCYO6V8GgXh00nw/W3fPEkj
	 FVP/NHtgwJT15P47s9Uhsbc3zYH5kgV/8IRoi4GQXZMSrPSAhXWoq3A7a5on612UAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSgROHw9;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54A606A32C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F54A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSgROHw9
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1384217a91.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560904; x=1794165704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=ZSgROHw9aXybdC9AvxaM0B5aDD1dANvb1oT0epfbMui/6C+0gkwf//63wGzwnDab7F
         cnH/oaD4HSpsUAmFXGzF0xvbCdFh0TyEGNO1kS+8HVeJH/jsf5+0zzRavr47VHewdj6D
         Mcw29PmsOY2mxnei/XpHPWXDhWsiqm3H0DFXzLHL1v5r2Oorg/lstYVEFCJBH5lHcLM3
         yjmGSkAnjcViM2cqwn1/bh6lnJOdXcxqGQyRbq+xgkcoK4QvrvXVnl1VUKj03CWBDX1o
         KJMk+XcDCHhRih4s+B4hIynETrtoDD19cY/zr1Pr0BWL8I2YvUwAfEUHj5mD6pwTEvLu
         B18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560904; x=1794165704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=whJivxACtCuew6pA6BJI+Uc5+HoWcLJx+8S1QCFPLugvXXuEJTk2d1b9ARL/VHtxBR
         xCV51z7U1a7Bkj/GTB+YUaJVy9kmC4Z4r/aO+/d5tCBGFiF9eNmsXu1aZTq0FgGo4sTz
         IVdtLgembwX+0J8rTfCG2I49ZdAOLCvJddJ92W5mj1jghoweZ8IfHpd0GcZZgVSuIrui
         dsAtyWWdNucoovd5sCd3K7l/B6JqRoYDLqYkIrsMgyvH9JUt35UPbchaMTufertL9ud/
         mGGgwaJZz3QsJivGBtYVCA/Tc4MaOYSkSNxVyi4gy1I8yyuzVjfG7cl5oMFgGejXzvQO
         K7Ww==
X-Gm-Message-State: APuU4Z9+orjdhA9Yz7ADlui1ytiUPI2DfEGFLPAFCdzWCp6nPK/Squkn
	6bBiJvmCKrmMLc1pEsaXg7EU0TKb0ZZuS15cDYkIbMNsOEI3cMbGnqioh0yN+g==
X-Gm-Gg: AYBFou1cfBO4O1D0zeOJpOFOcNrnxjij9T8hhGpIUE4o3evzQbyGKbu2ubGJDSB31BT
	62USva/hkgryL47pQFlBtpYHDbxo9Q280dJby9kvxcYYh0ddyYbty30HhZZFE29KgcIClIJk3NH
	jpV7QCYy5ljO5k3CvuTTEOfYJJc5oV+pSVGuRSHBoKD2kp756K3u+S/128ZnN4ztcgeaHvHhpOp
	/5J90Jpn4u3AcEEhaStKL38662hTT1cSqJOuGDCI0ERsgmA0rq6Vfj5UKie4DPf3RnGA+5GjTu+
	lACnO/jE5Z3ih6J/4yyOKh1ixWFkCqFSxw1q1DgIaqy7hqqRS5QD4Fz5CNMpsUIfZQdN+JgYxi6
	IZbCgv1+IpAQdbDIaD29LyM7hUzki9TsVplVZuT7/n1t3L7LaN+po2xZOyY8nhPThdAa6mqWs0i
	eMIlJrYkIS1dDeRllaMW9hqqhOqRL+ZcxGlXF0w/5IPDT3IPp5Mh6/3VLyyQ7pfTOw95ye4SxjQ
	xMugLadHL9leaswuGoZ0JO1As3HrVlKa3s+fBhfjii09yJYRVZM/I1jmVQbDaipQMkdOf9AWZRF
	FAOVIdSwBPlSYebcruXRxaNOwnQPFCgzEL37DjwQqyoUIq/E0dEDWCM9FGtm+1yCL/5cMqGbjvW
	HscnGTbEJautJ1V5NcyMnaU5e9bfVCFcZU4PgDcBYzl9ZlZDkUzvvogpfAX9+Id5AIfm5lMjDaQ
	==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr6425348a91.11.1793560903588;
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb1bfdsm7009849a91.0.2026.11.01.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Sun,  1 Nov 2026 19:20:49 +0000
Message-ID: <20261101192057.2296489-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

tcp_sendmsg_locked() expects a caller that has the socket open. It uses
sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
sk_msg prog the sender calls it on the target without a reference to the
target's file. Both pointers are NULL before accept() and after close().
close() can occur while the sender sleeps. Then the kernel crashes.

Fail the redirect when the target has no struct socket, or when the sender
has to wait for the connection. The error is EINVAL. After close() it is
EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
still use sk_wq after the sleep. This patch does not change that. The
target can change while the sender sleeps there. Thus do both checks before
each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
does not call the connect code of the target, which uses both pointers.

Today the sender can send before accept() and waits in SYN_SENT. send()
with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
redirect of a cork fails, send() returns success and the kernel drops the
data, as today.

The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index aa904ded816f..b635d3ebf4fb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
+/*
+ * The target of a redirect belongs to somebody else. A child that nobody has
+ * accepted yet, and an orphan, have no struct socket and no wait queue.
+ * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
+ * The sender holds no reference to the file of the target, which can be closed
+ * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
+ * inet_wait_for_connect() go back to the wait queue when they wake up, so the
+ * sender must not wait for a connect.
+ */
+static bool tcp_bpf_redir_allowed(const struct sock *sk)
+{
+	if (!sk->sk_socket)
+		return false;
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return tcp_passive_fastopen(sk);
+	return true;
+}
+
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
@@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		page = sg_page(sge);
 
 retry:
+		/* Only a redirect sends data which is not charged to sk */
+		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
+			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
+
 		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
@@ -547,7 +569,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0


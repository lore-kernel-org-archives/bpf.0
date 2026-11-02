Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604124;
	b=vrSfQyIx1cEDQFmae8VuFFI65PX3pjuxu0XO7lxUSzHYzN1SwANDbBJ/gnetxrh5kUUe
	 gQJaUuds3GCv5uRcL2Mu7SdCo9UhjRwKxpsRX02npNpe3+cYCsOvpIE1XMpN41VfWK+mG
	 kKea3AuKtNrh3DdttdulQS/fI3uuZ5xBRmNjJnAscEEcK+V73vjI8V/LvmSr/fkUnX/uB
	 Zr5oQ/kOqZ86Y2bD5NkjKV2k/5PYWBOf93Fgsd3OfiQPAQUJGlpjGeDDYvHKkQj6RmSyh
	 QsmD3q+pfpVhr6LhDGIScyBaPF6OW1EE2fIGAfYewEje7CTqwHSgbaV69GrnEAYgGZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
	b=ggMMJkVwl8CRd2Aw68zDe+fJ+hSJNA6EylzbnIkm46HeoF9sbwqwxs9xrLsQhVF8cxTT
	 4ckJUpH8Fe6YK7uI5m+23fQeEZq+GUAqCeGTfIqu9Vjv99bhi9BSJKh/tY7C7dbM+XckS
	 BCZhz2Wp3ODYNKj/S0kObboc7nSdrS3sFKrSEMCscP3zEUEvETYSVGW0o4VgoF9TD63kY
	 Awjyv4nRO7naDyAIQ25x7Anxc0ZC145CgOo9CSGz8QCkjkwjxDbqYQrXJDICAW7Lic8sw
	 /xO5+3mr7wvU02nBJKyy0rUMOCbzGnA47O5stcg0QuDj2QC7JSICiqF5+6sGrl5fJuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPVJmKNs;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A9606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPVJmKNs
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc7e79c1eaaso914185a12.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604123; x=1794208923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=HPVJmKNsgv1fBBRAUjASfLuczKhHW4q2StzVaTdk400aqKf/Cm1HkMNrMPHza+CuVD
         ZapWaU06oawTXkx0vD4p/ltyf4YgiLRPAa1C6QWUcFHOroApVDu9cUPbpHLwj8ATb6xA
         q1hXA4PnLmRVUYUOzn14jDZeqD5KcDNEVGE1iKMU9uYOUU2HzuaLz4R3bA/7dLkmNbWr
         FRhz6VbA/oTxyYSQUhoaCs2YPTz7NB/GIIlxKeOoK8AkDdaR10rDeicRZqT9evJUKbO5
         /YnUGDJENkA3FQUlFOr0KtzhM2+Q6ZO314VMFssTs1FuJ17gk6qjI6r9VT+Z/urObLWN
         Qt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604123; x=1794208923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=ZMae/teND7rRTY9WezmJ12v3y5k4cAJmzngp2fVlK/RUus2bXHbYvk3sLc06Yo+2y7
         pXL5SaqIyBrO9dsktGzF9yBIEscR1HlE//AfO960ACBc4iKXpZlOXuJMU7AhnWC6KeYN
         WfFTS2UxcNI7csohXUqUuzmeHl0yt2mJ3mSpgnf8LeTefrw5XaOcQnZ8+tJheGmI9YyU
         lY5IJlRtiueSnsKQ2XFiSk20TFYTiMvHSYC/bbNPHalxPj1BszqaoiLvBhTLc42Cgs1t
         NiTAHnFaGUwiWmC3baPLjA3z4/EdyrHQsa4q66wObosFqVZOuoQKYyosgVPAn9WDiSbn
         i4zw==
X-Gm-Message-State: APuU4Z9s+GosG0tKu414l4cx7zbOu/RDuDqe0d8h35V9SVOFnT44FxF+
	YSwrRZ5J3aoYgUn2C9Go0qQK8iL8vx48KqWH9aon8GSOAJNHvNbzF86IpQ0adQ==
X-Gm-Gg: AYBFou10ahQQNDztNkHh3PeUDAv/zzTYgaLyU1ju1m+4iX4l/TE+8Tcf5PSGN1LCZiO
	0zIndZOL8mwLIFMLFobt92/YgSdK+DkC9wlhUG89bSZlIxmPI7OMFEVa3mIrF2PUvLN6kuyAWOy
	y60zDQPa54+p1Ga+LXL9XfhKJbz0HyA7/Mp7it3tw5cBnc0iTXNMntJV/Rx0dfXSsbLEHie/0xT
	N103fQWCQ4A+dJB7Se9U/d32hQLCKN45XPtxPBy9EJtp69GEPvQTkshZ35vLUt2lfRu5/rgvVYc
	IQBkqudUlZiwUTcI9G+uT9puuwI4enaykMzOBQfNJBUlEi/y8vnNOcxO14B8GKVX/fN4L7AQnBd
	8IyAVavVugGPEtuqHTBWD00ER7PkXxGu7Llf2XJ1fDjxan49e6uRBxahe+OIGflpEi0g4u8YG1j
	hbEODvGLL5+qz0gPBtmluomOG5goUbYkpxPgsPhvIkaDBj0JpJ3FLksQu2F5bsHXq89D4sQlm+Z
	O9uaL/VbWbYPbv+pEw3eqwnKRFeAqmZgFlBXSValE1VfcuCyODCjAN9dTlMY7rt7W7jNkH3Aqsm
	MR3mEuqYfzrxd+Tevf5iOnX+p3euVnl0V9XehbllMwFenvYijTw/9LojWIZnuHByuSaWYxHnjgU
	rzaou9pNR9E6eKPbcJeJysfLuny/CXxMz1eWi53s6eEcj5J+ybib3ZcEbkVxsZMzSAe8t/+lWKw
	k=
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae897c777fmr7064360a91.46.1793604122783;
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17487309a91.8.2026.11.01.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
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
Subject: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Mon,  2 Nov 2026 07:21:04 +0000
Message-ID: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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
index fd443350f9b8..ef2e15de0fe3 100644
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
@@ -555,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0


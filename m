Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7572D7D2A
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769254431; cv=none; b=RRCIFWbDZ6cP6kKSTe6hKTmM+EVklVHCAz7+seIMhCCzgBa8xT6qToW1W3X4ZCY1SrceY+mAQFEpVFIZl2+x0d7cl0IVFjl8sfSCLiLUAc6ijKZq5pfn1RKMlkbcJJgfy7a8Hta3Wh5g9VjZV7GdrftUnYgHVsrFn2+Avb8/OXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769254431; c=relaxed/simple;
	bh=6xSypfncfNY1Nss0vh0kNoq/wXkNJz2RD8yfrY1UXfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVq9Qqfidy6+MPWzSPRaIDwTDLDUiO1DgqRLGk3b4MUa6bpdq6JR4AplrSRVIjv9CepDMEQJZPoJY0KCoeb8AJnhP/tLEw2cYp+IgT74gmz13DAz9ewivb5PA1LrCxi4LZyuj46YCkdH+1TC7KGSYc1/nm2vURYQX0DotNwhb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PNel3P2R; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PNel3P2R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769254426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zqd0TGwTIL3tZ38ebnmi7rts9nq4t1a/C8VA2l7wkV0=;
	b=PNel3P2RqXImPpHZZt6NznKeLC+AxXZ+qCITz2mKTfPMkEbNO/jeb2F/5gKFU1Qrr7Ps3+
	agIEymjwbI8AFI/889dGrQL9u/kqsFxKO0iJGQA/dNq6h6GiQm+6JqNAm7Om4tQk/ddfIG
	WUun12LMp8hkIokCjoKALGB0iu5Xqss=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v9 1/3] bpf, sockmap: Fix incorrect copied_seq calculation
Date: Sat, 24 Jan 2026 19:32:43 +0800
Message-ID: <20260124113314.113584-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260124113314.113584-1-jiayuan.chen@linux.dev>
References: <20260124113314.113584-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A socket using sockmap has its own independent receive queue: ingress_msg.
This queue may contain data from its own protocol stack or from other
sockets.

The issue is that when reading from ingress_msg, we update tp->copied_seq
by default. However, if the data is not from its own protocol stack,
tcp->rcv_nxt is not increased. Later, if we convert this socket to a
native socket, reading from this socket may fail because copied_seq might
be significantly larger than rcv_nxt.

This fix also addresses the syzkaller-reported bug referenced in the
Closes tag.

This patch marks the skmsg objects in ingress_msg. When reading, we update
copied_seq only if the data is from its own protocol stack.

                                                     FD1:read()
                                                     --  FD1->copied_seq++
                                                         |  [read data]
                                                         |
                                [enqueue data]           v
                  [sockmap]     -> ingress to self ->  ingress_msg queue
FD1 native stack  ------>                                 ^
-- FD1->rcv_nxt++               -> redirect to other      | [enqueue data]
                                       |                  |
                                       |             ingress to FD1
                                       v                  ^
                                      ...                 |  [sockmap]
                                                     FD2 native stack

Closes: https://syzkaller.appspot.com/bug?extid=06dbd397158ec0ea4983
Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/linux/skmsg.h |  2 ++
 net/core/skmsg.c      | 27 ++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    |  5 +++--
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 49847888c287..dfdc158ab88c 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -141,6 +141,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes);
 int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *copied_from_self);
 bool sk_msg_is_readable(struct sock *sk);
 
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2ac7731e1e0a..d402da5caadd 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -409,22 +409,26 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 
-/* Receive sk_msg from psock->ingress_msg to @msg. */
-int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
-		   int len, int flags)
+int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		     int len, int flags, int *copied_from_self)
 {
 	struct iov_iter *iter = &msg->msg_iter;
 	int peek = flags & MSG_PEEK;
 	struct sk_msg *msg_rx;
 	int i, copied = 0;
+	bool from_self;
 
 	msg_rx = sk_psock_peek_msg(psock);
+	if (copied_from_self)
+		*copied_from_self = 0;
+
 	while (copied != len) {
 		struct scatterlist *sge;
 
 		if (unlikely(!msg_rx))
 			break;
 
+		from_self = msg_rx->sk == sk;
 		i = msg_rx->sg.start;
 		do {
 			struct page *page;
@@ -443,6 +447,9 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 			}
 
 			copied += copy;
+			if (from_self && copied_from_self)
+				*copied_from_self += copy;
+
 			if (likely(!peek)) {
 				sge->offset += copy;
 				sge->length -= copy;
@@ -487,6 +494,13 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 out:
 	return copied;
 }
+
+/* Receive sk_msg from psock->ingress_msg to @msg. */
+int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
+		   int len, int flags)
+{
+	return __sk_msg_recvmsg(sk, psock, msg, len, flags, NULL);
+}
 EXPORT_SYMBOL_GPL(sk_msg_recvmsg);
 
 bool sk_msg_is_readable(struct sock *sk)
@@ -616,6 +630,12 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	msg->sk = sk;
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
@@ -909,6 +929,7 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
 	sk_msg_compute_data_pointers(msg);
 	msg->sk = sk;
 	ret = bpf_prog_run_pin_on_cpu(prog, msg);
+	msg->sk = NULL;
 	ret = sk_psock_map_verd(ret, msg->sk_redir);
 	psock->apply_bytes = msg->apply_bytes;
 	if (ret == __SK_REDIRECT) {
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a268e1595b22..5c698fd7fbf8 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -226,6 +226,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int peek = flags & MSG_PEEK;
 	struct sk_psock *psock;
 	struct tcp_sock *tcp;
+	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
 
@@ -262,7 +263,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 
 msg_bytes_ready:
-	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
+	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
 	 * shutdown with a FIN pkt. So check here the other case is
 	 * some error on copy_page_to_iter which would be unexpected.
@@ -277,7 +278,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 	}
-	seq += copied;
+	seq += copied_from_self;
 	if (!copied) {
 		long timeo;
 		int data;
-- 
2.43.0


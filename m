Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1C3101A0;
	Wed,  4 Mar 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606284; cv=none; b=VedTlIVx/FrtgGoseA+FePkz4pFAzjrjbJf5OeYAgNrF5AFxL4RcbXyqm6BxsSx1TW7tyz4IY/8eW/k9nd5stBKlDRBOYVdDT9CehSRG/p10CMgNOI+q39CFLsj41sTVHE88hBBBob1aHoW5xIlFxXkSj+PdrmnHh/6Efkxrivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606284; c=relaxed/simple;
	bh=VBHqTt/FhWZsMO+m6rPxjyAbdZ7icfdYuGxRqnevfCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtcrtYUhrScpFhLlfwW95n0yLYLWjOoKX1VbaigS6bNgh/3qhLjqYlYYfYIp4lGGn73uadVKf026B4TWBdNvQMSIcATvgoUyVv7l/KhDcOY9gFssTHRcZ4aDIGOTPbERxuVly1YGjQ7vwyHfd7sg+VsIL4PLcEvK2+n8gKEOA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vsdHcr/h; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vsdHcr/h"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGZj5xXe+WPvDUb4thRq5WQY+Pyy46ij4fOCKK+Ii00=;
	b=vsdHcr/hO21XNvsSTo6Q0FVpU3e0DLphACPRp6pdWkVH3xMla7vZkvOWbDqxRogzwWYDnU
	ONtC7XuICoEQLTAlxAd4sBjhPOB6+TG9+Grv7E9KKW114rNrn8EWMfGii88UnVXcvrmKxz
	9Yaov08wwGzxYNZBAwBFei8o2uhL+M8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
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
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 2/7] inet: add inet_splice_read() and use it in inet_stream_ops/inet6_stream_ops
Date: Wed,  4 Mar 2026 14:33:53 +0800
Message-ID: <20260304063643.14581-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add inet_splice_read() which dispatches to sk->sk_prot->splice_read
via INDIRECT_CALL_1. Replace the direct tcp_splice_read reference in
inet_stream_ops and inet6_stream_ops with inet_splice_read.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/inet_common.h |  3 +++
 net/ipv4/af_inet.c        | 15 ++++++++++++++-
 net/ipv6/af_inet6.c       |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 5dd2bf24449e..84f2744d57f8 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -34,6 +34,9 @@ void __inet_accept(struct socket *sock, struct socket *newsock,
 		   struct sock *newsk);
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
+ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags);
 void inet_splice_eof(struct socket *sock);
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		 int flags);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 8036e76aa1e4..2c7b35d9c62d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -876,6 +876,19 @@ void inet_splice_eof(struct socket *sock)
 }
 EXPORT_SYMBOL_GPL(inet_splice_eof);
 
+ssize_t inet_splice_read(struct socket *sock, loff_t *ppos,
+			 struct pipe_inode_info *pipe, size_t len,
+			 unsigned int flags)
+{
+	struct sock *sk = sock->sk;
+	const struct proto *prot;
+
+	prot = READ_ONCE(sk->sk_prot);
+	return INDIRECT_CALL_1(prot->splice_read, tcp_splice_read, sock,
+			       ppos, pipe, len, flags);
+}
+EXPORT_SYMBOL_GPL(inet_splice_read);
+
 INDIRECT_CALLABLE_DECLARE(int udp_recvmsg(struct sock *, struct msghdr *,
 					  size_t, int, int *));
 int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
@@ -1079,7 +1092,7 @@ const struct proto_ops inet_stream_ops = {
 	.mmap		   = tcp_mmap,
 #endif
 	.splice_eof	   = inet_splice_eof,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 23cc9b4cb2f1..12256b0234ff 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -705,7 +705,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.splice_eof	   = inet_splice_eof,
 	.sendmsg_locked    = tcp_sendmsg_locked,
-	.splice_read	   = tcp_splice_read,
+	.splice_read	   = inet_splice_read,
 	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
-- 
2.43.0


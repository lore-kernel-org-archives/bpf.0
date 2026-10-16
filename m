Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68B29BDBF;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121498; cv=none; b=YsTB4GmIF0ogp/wSEfmPpfB+2e4CLdvK78pTwtVNV3Hq9TUAsKsq3WAQmcUQ6y16GKBTC5/PDGLm41CXpQzRKnukBXU+eHmHdpzT40Y/ojyWscg+wl766D9eHHlhvMwRZkRl9ywBBEE/K7k6HtRKvoPcIiR7aaBIlNPeO/sTHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121498; c=relaxed/simple;
	bh=6Pnkji9+C3LHn1Eo3bFDJpcSdQKou14K0FEREsN4rXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o3MotAy3/w6L9nlWYVBbbxdFQJw1XliB4Srga28vZjivlda6m+S58ldwU8OuIBh3JkXqO4MoB8KL/vvInaSlllzZKDS+EQhVe4X3z/RONlKxmXApy6Dxn3905DUKFktHFKnBjqZdCa76hjLSJ0dSystB5Y6bS6Wo2LhzhmiIj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6ij9QUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6ij9QUk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C13C2BD00;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792121498;
	bh=6Pnkji9+C3LHn1Eo3bFDJpcSdQKou14K0FEREsN4rXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H6ij9QUk1EZSg+MO/cCTArfVkhAOFQwNuVFgYmaw0T0aWxUy5zakdHZgYo4NeqIW2
	 BTFS2Ixu+3qmnvsQ2Eyds40j29XK6eZLLZCL2ALrutkx1GmoCMZhyXcdCqy8cr8VfK
	 8VgM00JX33BpzDPB5mLvLf441dWeKI2gYu+NYCkGZKCFIU9sUygFd4d1QyQsy+Ci18
	 ckgZdjsXZfV5vE9DOYSB9q5lHOIBt2v6YoHPTm0d7KsUchusjCiThbfbmzowU8SkH9
	 4cqaBOF62ZcIyTqs7Zi0Azor7fv9JY7dv04r0nITuas8amXfrL3RyHHiO40mVz/ypw
	 9Xs7v8EeQlQ6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCECCA46C;
	Fri, 16 Oct 2026 03:31:38 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Thu, 15 Oct 2026 20:31:37 -0700
Subject: [PATCH net-next v4 2/2] net: annotate lockless writes to
 sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tls-fix-sk-kcsan-err-v4-2-391d788327f3@proton.me>
References: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
In-Reply-To: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792121497; l=2452;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=xhyr/APrQP/DN3UvFtImVGyApw1ErZ/6ymmTvs2y5mo=;
 b=CXBCdVyhtyWn/0xpLp3zsnaOxdBxRg2WPxaEYq6Vk+ZZoX/BNlI9IBijWfcr6oI63qPVIj6j4
 ybX52q7LCWQBwrYh1cFLgnUbkD0bZeBINaQUmoOtvACXVyHT+lvduD0
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

do_recvmmsg() and getsockopt(SO_ERROR) clear sk_err with xchg()
without the socket lock. TCP, MPTCP and kTLS already peek the same
field with READ_ONCE() or consume it via sock_error().

sock_dequeue_err_skb() still uses plain stores. tcp_recvmsg() can
call it via MSG_ERRQUEUE before lock_sock(), so those writes race
with the annotated readers and with sock_error(). The same unmarked
stores exist in strp_abort_strp() and sk_psock_report_error(), which
run on the TCP/TLS socket.

Annotate those writers with WRITE_ONCE(). No extra ordering is
needed; this does not change who wins when ICMP error-queue entries
overwrite sk_err.

Link: https://lore.kernel.org/netdev/3d9d442f-f168-43da-87b0-010ad5a78365@redhat.com/
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
---
 include/linux/skmsg.h     | 2 +-
 net/core/skbuff.c         | 5 +++--
 net/strparser/strparser.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index d5e35f24738d..52ce45f25f5a 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -429,7 +429,7 @@ static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 {
 	struct sock *sk = psock->sk;
 
-	sk->sk_err = err;
+	WRITE_ONCE(sk->sk_err, err);
 	sk_error_report(sk);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d56f4f0102f7..a6c9cf57bc3b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5539,12 +5539,13 @@ struct sk_buff *sock_dequeue_err_skb(struct sock *sk)
 	if (skb && (skb_next = skb_peek(q))) {
 		icmp_next = is_icmp_err_skb(skb_next);
 		if (icmp_next)
-			sk->sk_err = SKB_EXT_ERR(skb_next)->ee.ee_errno;
+			WRITE_ONCE(sk->sk_err,
+				   SKB_EXT_ERR(skb_next)->ee.ee_errno);
 	}
 	spin_unlock_irqrestore(&q->lock, flags);
 
 	if (is_icmp_err_skb(skb) && !icmp_next)
-		sk->sk_err = 0;
+		WRITE_ONCE(sk->sk_err, 0);
 
 	if (skb_next)
 		sk_error_report(sk);
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 9c1559d7923f..5f1da32b152f 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -56,7 +56,7 @@ static void strp_abort_strp(struct strparser *strp, int err)
 	strp->need_bytes = 0;
 
 	/* Report an error on the lower socket */
-	sk->sk_err = -err;
+	WRITE_ONCE(sk->sk_err, -err);
 	sk_error_report(sk);
 }
 

-- 
2.55.0



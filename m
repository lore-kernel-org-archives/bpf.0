Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938541DE04;
	Fri,  2 Oct 2026 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926171; cv=none; b=rJoSHWxjSfKY6552E2ivKcqH9PRGj8hqPlFyD70S+74gLsOcBCxi+/vbc3ePSbIJ/R3VlckBLEVtpq5UvAdQdtTPDqjjfeLhymRADojkYXm0nD31yTPf+Ho75c7Qvq2x2lJUjkcu69rrYh9sXXkwwVk2xThTuxzwhbKeYpIY9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926171; c=relaxed/simple;
	bh=gLGpyK9tPVpPXT3cU2AVjIxx+T72331DDlJqVnTnvio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teX8TYK1mAHGxqkIn1U0aYYsdJnX0RD/gSRuIHLByjQb8BX/KZdZHmczzDB6LbwJjmve7bV+oIw3asvM4l69tzv89sYq7zTg99fvjk2H2fA5I8C6yI7iFpVisbnjvI2fdWo+tIMXiaRDuuRW36sx6doZyoONmHhzvTxhJiqu5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1ZPgwLi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1ZPgwLi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2407EC4AF12;
	Fri,  2 Oct 2026 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790926171;
	bh=gLGpyK9tPVpPXT3cU2AVjIxx+T72331DDlJqVnTnvio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U1ZPgwLiOfXE0NyN2SGlC2tuMWoWZdJbSgfqGujTbL7d/rxeODbD+pjklbxkexq4w
	 9HADoKJLAFy1fOGHbdK+lWX7HmvgaKcQNM6D23G+yITLMB8AeaWk7og4dgY06tnAW3
	 ghrR8PbXb8NyuMEOW4AV9SCaePhIfE3jYuUs/5Kl3NkoztZ4JnPBHRegz3jn4cUuCZ
	 lPwQWDGIGEMdemaX8jgkv58iyaElCeEe2ybyAAUUFbFZFysBjRcAQhQvFcHBxakRLe
	 qimfTJ9zTr+H3dWt02MruooJGvWljpgaXAIMSJ/8OfkYFEbeuI1xo2kSRNVNivlDzN
	 rl6zXMAWzxJ2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8330CA5FE0;
	Fri,  2 Oct 2026 07:29:30 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 02 Oct 2026 00:29:27 -0700
Subject: [PATCH net-next 2/2] net: annotate lockless writes to sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-tls-fix-sk-kcsan-err-v1-2-baa0ba056323@proton.me>
References: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me>
In-Reply-To: <20261002-tls-fix-sk-kcsan-err-v1-0-baa0ba056323@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790926169; l=2416;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=K/co0bqQ7iNM1L5ByfBSbB0henAPROl+oW+6On5Cxro=;
 b=dQHbhXpU4+Ri8VKOLtG8MZRuAYJWnpw1xzkB6Gs9Q3S/0oYbbfNSPVeql98336UcAvgBt1QzY
 FYvNvzht9KfAlN9uONodQwNZyRd1w2ZMz2Gk/yrU1X3xL2eDNprKaXx
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
index 5c4024a03e10..51e3cf1ea985 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5535,12 +5535,13 @@ struct sk_buff *sock_dequeue_err_skb(struct sock *sk)
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
index a23f4b4dfc67..e5d5d755e532 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -57,7 +57,7 @@ static void strp_abort_strp(struct strparser *strp, int err)
 		struct sock *sk = strp->sk;
 
 		/* Report an error on the lower socket */
-		sk->sk_err = -err;
+		WRITE_ONCE(sk->sk_err, -err);
 		sk_error_report(sk);
 	}
 }

-- 
2.55.0



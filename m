Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFB36E467;
	Sat, 10 Oct 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643596; cv=none; b=Mu9GODmwzPYtZRu3KikP140Hel2PBEE/YlBqaRC1m0L4ZCtJ5N9XmYIbZq3RbInKoxwylfociXJzntiyHB5Ht0gs3rwFzmkBwh+mtlJDjrIuGeC0Mp2sL8OQroib0TGkPX3dilOTt4Yv5EqG5qEUai07g03bALwQkYJ+Gzw0ZcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643596; c=relaxed/simple;
	bh=6Pnkji9+C3LHn1Eo3bFDJpcSdQKou14K0FEREsN4rXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYELM9obrGh6CGflKPD7DJLb3wDbcUkUb3e3rp+2EU2Kgf5/GOkmQIsvw9Atj1UpTLlJwhmVC7gOaXdbrcolfYxHGjxY9tkeIkCVVTjUixqSdz6Zuu2MRcgFfL3hVd83YcK2s6Kr7Ga4FgtQNxe5VTodepnMoRrKlKvaaxaNGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baT6hvbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baT6hvbX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D410FC2BCFB;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791643595;
	bh=6Pnkji9+C3LHn1Eo3bFDJpcSdQKou14K0FEREsN4rXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=baT6hvbXEyek5oPNh7FlCSnc1B6LQgbZpogf2uTqOdRsC2Z9JYo5FICL90yBjpoSb
	 8wf1WTIqX4QDWo4bulVPqlihiqE04jJfdukaxE1g25WPCGVwAkfy+kr0enLdPGY+6s
	 6Ok1Rvjx6P8SKk4ngbrspak+pGBHM6L/PpDDWkm0nKruRYi8otbN0BgfCCig1N8Pc7
	 qHgkB7KeDjryz7ghlmfN1tR1qkCHm1rEC+kB5pi4nUxQGzMZpZmXhqJVS+lClVdlZf
	 84I0GtD42H2SdklLr2PXuywmFTDPealmTXslOscCtv2wPIXcy58+Xj5H2+oHpuhzlz
	 8lIFas2VGYiRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676ECA9EC7;
	Sat, 10 Oct 2026 14:46:35 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 10 Oct 2026 07:46:29 -0700
Subject: [PATCH net-next v3 2/2] net: annotate lockless writes to
 sk->sk_err
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-tls-fix-sk-kcsan-err-v3-2-e28aadeb31ad@proton.me>
References: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
In-Reply-To: <20261010-tls-fix-sk-kcsan-err-v3-0-e28aadeb31ad@proton.me>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791643590; l=2452;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=xhyr/APrQP/DN3UvFtImVGyApw1ErZ/6ymmTvs2y5mo=;
 b=RXyTgZ1n6sPdCnsPGG9dt2sqeO9ID7CGpiC7zAyDMpjM3ZcKsUaM8ufrvG8o0oqZGlcBx5syE
 OrIT4y1rpbkAJBdIdiaVYKrBcjEp4J8T3b3TrfXliWSg9PmO+FXXHvE
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



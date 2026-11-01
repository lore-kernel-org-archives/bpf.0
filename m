Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560929;
	b=X9lwZO944TYxV8aRrvY88AeF0wXGaylS59n+aDmkw6SjeyV0lhFMhJwCTKGy0V+cpfiC
	 mXH0V5whUJYXm/N9c3dmGtcQXwzA5ts0LB8vo/L8D+YUAxPaZnJfROx3MqfYvMtkcPiMf
	 7aprk7ZMdPpYlzctzzIY//9LJk9F0C4fm7M0Fb5UZoWZyR4neK3AQAswkdge++EA7pAiU
	 J+xm2+pV2y40jG7BQVCRTNA9vy7EbPtMPREkbumLEa36VfETU8SqrgPQCN4Jf6oOF+w6k
	 paDhH1hpOkt0jxhe9M0kZa3hNPbC0XO9dMSDl19RHa+7KsPz0xV5g8pqhqC1VMpvm0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
	b=fTg3pJOkJYHoNITQiP3fn+v6/LvZmM4f1dSaLbbrQiAW0bPSgW6y+FUngTli2S1cmFNP
	 3flL4IjUJBNgQ3/gsyoNGNUkO9sZcprtbjhM9lzte+ARrQh7Glido98fgCkjrd4EN4MOl
	 hrYoqUHQBAIkenSbLjuu4V2XNmtKJDUyyjMAJ+mD02oIxdsenxIEwnGT2acilKvgNBw8M
	 SP6YR4MSuYL/V3X+2epW0ENV4AoCdmUQ5ggygcl2tFVhyhAO61KH3S4boNx8WG7vuLTS1
	 PCC+N8WOOVFaWMjSSivrIZ1YeCwCMjdGEM2OxgD+MKLe/bjNAXmdNrFVI0PnDzDiAcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPgy3HlT;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A55606A329
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A55606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tPgy3HlT
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso764241a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560928; x=1794165728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=tPgy3HlTeayvX5KW1y64gvoAsMeqEH/3fl3Zm+t5kRsDrUMW1vXzEGVUan0IigECWP
         bveTbSgp/iEs/V6dFqAqDBHS95Qgd9utyE3x82RBLrFr7bQsEDYe8vlkXNmQZkI+XvaT
         5vIgXKGMCL4J4bC8YbdORLXs72TqanOIu6mZlJJ9k1Uv4xszY5yAbVuUf+Oi6FuUqT+/
         zf2eTCL4rvmVqnUu7zRuhC/REgWimEGwCGmzbQTLF9Ig3hGjMUYx3jckfo5JWZWyVw/U
         siGPpwK/8GLESd61rQhoyDs7EoUYsMgZGjr1p7hvUx2ouTSGklU8M10LB2iGVluYMgGN
         bUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560928; x=1794165728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RP1aCEqwa+3rqWDejhsGdqflKxU5qcv1t4TwDR4XEcI=;
        b=NKnC9CihQ3G9OTDQ1jDLMYg45wYhUH0oRv+pH7KZliBsUWf8YntYx6IeNmj4UZuBjt
         4Kt7oD1+K9QH40LqqWTQ9LXrzQCv5brWq15IoZgjfC6bafyuVouiwSJfBKB8Rqr2L3zY
         ujd0PmlX0KxW0BBO4Lyx5zfuhgZ/d9O+couKKsIKETrtkwv4OZN+EMu1MgypAiFonC5y
         6PCVlYZ9bL0ZiONKYPEPn0i9ad3g6kxop8VnGNR4vw7GDyiBfdFTb3IAAql8OuXVi/O2
         B6EBGPr7gbC/qdqm96PMWMq6AzJZNG+QqXhqUTDtmdEXVM2e1GYH2RqUC1cRjHLMeoCH
         PXaQ==
X-Gm-Message-State: APuU4Z/QrXK4zNAsXKvwW9vXzxGG5lM9A2BHEQzpTZ2UDZCkcLRx4/Qr
	HdBH7hrdGTF5CLUgQpnksJPGHB55WxEDmKhmRSBdR/DqXhNHZhtVuxqmvEsd9g==
X-Gm-Gg: AYBFou1+LRnbrIKcj1nns6TWiV9KvTL8je8o2xAows3dSMyD3eCziebXKQs0N4SML38
	Yuei8BrfwYv3hGrKgJeR5ao9d9ZtTM8JqRFFXvIFthieGhDO3jnlJ96uOlngH7w4gt/nHCv/mYY
	Z/MNo/T10DyW2QWgRTFoveLKooezEISKLlinms8ST2VVqjs/ox7hSHIbCoR0jn0MtCllzcGBrQE
	ualrkoVWjrdfVHe3rViERk7AoNvsziqVHZ0auElUxhumh8bNtLVITqMARKBlIPm3VmBTtlJUR44
	TzUca04Wd2reHg/xkLYuDNmRzhuS1MHee3VY5mNbQ1ltw28Dcy5bNDNWhX6GVJiIIHWrUJJMhoj
	FadYuPYBSxIruZDgXiSSwqei6BJqOi53MhLacWkBBn9kLj7SrcBqepXSteDvbG9QFwurQ7cIIbR
	/wDiUpYMY1lxlJT5X1JRA2yKImBED5O1uvVnxlVuDAR5nSk48eadFqODodvkSyuaFAH2wopNXXc
	p/IKr3wsQA/mdLfD8/WWn0l1w9nvq4fqQurhM7dNDbMMEsKvdKiMjLnlpqeAJNZbDdehejKJSF8
	F/JVtTieB8rUkbZkHiBuRb2vzZDx2Ixl1YxqjbFhDANHYG9R6Cn/EDRP387oopXS1qhDQJzxTII
	URX0IQG4jOvDjARCDxECS+4VWoeBnZhh3LIaK23L30hlIzjgrMMOZUVaynZfXO+u88g57kxYcTw
	==
X-Received: by 2002:a17:90b:46:b0:3ac:a11a:7c91 with SMTP id 98e67ed59e1d1-3ae8983f065mr6222829a91.44.1793560927932;
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8805ebc8sm6392012a91.3.2026.11.01.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:22:07 -0800 (PST)
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
Subject: [PATCH bpf 11/15] bpf, sockmap: Don't copy 0 bytes into a full cork
Date: Sun,  1 Nov 2026 19:20:53 +0000
Message-ID: <20261101192057.2296489-12-alexei.starovoitov@gmail.com>
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

psock->cork is a ring. sk_msg_memcopy_from_iter() writes at sg.curr.
sk_msg_alloc() adds room at sg.end, where a full ring has a spare element.

When only a part of the data fits, tcp_bpf_sendmsg() copies this part and
flushes the cork. If nothing fits, it copies 0 bytes. This copy writes
nothing, but it moves sg.curr to sg.end and returns -ENOSPC. Thus sendmsg()
fails without a flush. sg.curr stays at sg.end, and from there a copy moves
it past the spare element. Then a copy can skip the first new element, and
the peer gets memory that nobody wrote.

Skip the copy when sk_msg_alloc() adds nothing, as tls_sw_sendmsg_locked()
does. This pass of the loop flushes the cork. The flush empties the element
at sg.curr, thus the copy in the next pass starts at the first new element.
Now sendmsg() on a full cork does not fail with ENOSPC. The prog runs on
less data than it wants to cork, as it does when a part fits.

The first Fixes tag is for the -ENOSPC without a flush. The commit in the
second tag added the spare element. Since then sg.curr can move past it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 031097d9e079 ("net: skmsg: fix TLS 1.3 crash with full sk_msg")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d24ebcd7633b..a450b1ff3cfb 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -611,8 +611,15 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 			copy = msg_tx->sg.size - osize;
 		}
 
-		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
-					       copy);
+		/*
+		 * copy is 0 if the ring of the cork was full already and its
+		 * last element could not be extended. Flush the cork below,
+		 * and let the next pass take the data.
+		 */
+		ret = 0;
+		if (copy)
+			ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
+						       msg_tx, copy);
 		if (ret < 0) {
 			sk_msg_trim(sk, msg_tx, osize);
 			err = ret;
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560892;
	b=BG5Du7wTFw+X4L2hU+0GWAncPJ6q5W6dIFNKI8xpuAxQwSXNGKIfhNt8uXuti/g+BAXP
	 pllEmsjxDCGztfinzuur39xsNIWWxLfNQwp/8MniilHBGkItHjr1FD03gAPQIDUUNZJQx
	 xGHPGMgxS/3txgqihz8h2nPpa3O1jiLVdmhfSrNR34rIVHK+gFU4ZzzBSwvNUzKqH1SNk
	 a8ZxDsXaeIs7oEi+sNNvi38c63G14fzF+fv/cz6HkfpKjDcTMBi96BfnHt8uD4mTxuYFx
	 uyjbHpZqF3IB6tAJDGd7ZE6A2xxLNFFgkL4lbQeuvxw+6/lpOtmR08w3ZSpPmQ5zXfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=KBpaOfvENF+P5zZls7qZ5OmdXyQo15Tpz58XNDCmM0bVss8RojhYC5qXN49/bAOoXpjX
	 qCQoz7lePOaOlPHTOarQywfIu8M7jUQ+IAC9w+B9KPJbgVfljvYBJjTF8XPrfQFKLXIQT
	 lyzI4WB7i8Suw5cq5yEyWy95mxqH+fIQXEGizmsDgqBk6zm/LmFwacaBVMFJ71IEDKhKo
	 MfRzFb96DZ4QJUjXEv2Wk20DdsXNDO8ZrR3jiNU4mZur08H1GZXJ5ppN5wWfFgRW854gl
	 voNpgkgwcYLABuuvDfILofIR1PK6yjDnPoM2QLtRL1VPjxcGlYGy+oywG3K6f1JiyKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+GOKGNN;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76889606A32C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76889606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r+GOKGNN
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2eac4877accso7439795ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560892; x=1794165692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=r+GOKGNNS60DMc/LKDFnqtHAQT/kDfV0JBumv1Y+EMzDQWPz30ElureYT+n2N05qI5
         fk5lDACxZUQFvgmGzvdoQq5vDWdrXjFh5U9HsFnafQ36bcsyeM2jprdTypSylj1mTqiK
         mFykJwUQlwyEX3qPcDt1XR755tk9RrLMBKmQ4k1GIZ4vNNmvzc63sumFv4wB47jz1tCf
         BHu1c7smkjVoesQEZnDio3gSqMRz5XwzoDS1kdnHvo6NJL+wi3KzE+PY7uSq8wBA9cov
         iHy131TrP+UAqeLJtIeFIGvKsYcwPPlpdoW/3zv0rHUDQiNeQdZSgTi5/BCVknTbp917
         6eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560892; x=1794165692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=SWmc2UVNoGaEv6RDKyTbAY6brLrFnGkqYpuuNj/PIU06yjPiywMnbtAKUJDDLa+hPQ
         +pul76wIsnU1wOoa4S7bjuM4JBqWBtrNMc56zGsEnRG95mr2KfEdO5O1xeULcCmwWgpv
         kl8Edo7ml5fuR9G2buWMNk/WQL7SYQ9vIp42QZ7jlhMeANDFPHoUOsWN5BKiYX0hqJ5A
         JkEnIIDdeMzL71dTyj7V9szW3hR37RXbXeA8RbhkZu2nYuZSSBbQHnLemUuTohZT5X/9
         j8us+6cufLR3uBVpWjNoNQY25TtYpcxIIneVowv2zGKFtnICEIjRpIaI/2EdG6Nw0nzM
         mV+w==
X-Gm-Message-State: APuU4Z8obqDGbU9M4YTLn5+q2g4eXhMZh0DKVRT+RPL4v+3NGlMoKRsR
	rpYoAGCCxcFCmozB1yW0cpiB9QhiIhG0wclj7bU5uZye6QJIFH3ShoQQp6U0Kw==
X-Gm-Gg: AYBFou3nIWhaxduvq22FZbQd/4/qK4V99tY+0LXI7NaiErT2BjXhp8A7b+JZEOcRzWf
	IbE9tP6JzVnaO5xyEzzQlofF3aiOTOeiBPZmDLbbH58Cro2Xxiu3oSzERRdWPk+M3BjAlB01aAO
	HGt7uJwtyFiZaphAZWd4PBf6GpBzwoxMflIY9kAXKO2uWHA3WgWVzkdVrA3gVejHvYSvPUqyhfL
	/eJeARxQZSatL+3Fu6wzXvGmjmgBVZNB5AQN3RKoqA6gm3CvMmWRH/REIaldIqmc5tnk+0jMIyX
	blkz+ts9ru5Htvst6TTXEjqKahFAFf/nMXTBvl2iuBUx2oJ4gGrlgwDvQAZfq8WujNbOqYatM/k
	n9eyXVKfZjVTF6W23skzGbU+Qmv/UmJK1y5LyRQAVpQ+x22TpfSzDoiv84j5i6e+wcROqPV7sJe
	xR76CXfwSIVSzrd4nu8VIQxVc5tcszv5i4DdCIbi+BPG4NsKmnpGoN2Q6XpidOOyg/OZouMXiJY
	5+nUwKTxl4bQ9Fqn1/Vvi4FUWQtvSmOtlshA+TgRT3fqr8Iz5b18lJbs/nzzHta3dzKfZYkNIJ+
	mxgxdmRU43GpuufxdjROp8yu8869D2i+4b5L3s4ybvJb1l/N9Tg2oKSxkp4CNhV2uFVNycedw5l
	OnjyiUdvHGZFli9e2GEjAjQWQNSLavYfpODTFU4tb05bLd1dAut96qDrQPwCs46lP3Foac45lRY
	jbYBWWGJXEu8C5bSFlV4yg
X-Received: by 2002:a17:903:38cc:b0:2e6:5ef:abe9 with SMTP id d9443c01a7336-2eb364b6332mr64259095ad.37.1793560891567;
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248621sm18975285ad.28.2026.11.01.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:31 -0800 (PST)
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
Subject: [PATCH bpf 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Sun,  1 Nov 2026 19:20:47 +0000
Message-ID: <20261101192057.2296489-6-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
the psock. When the socket has no room, the function saves the length and
offset of the remaining data in psock->work_state. A later run continues at
this offset and clears the state when the skb is complete.

sk_psock_skb_state() saves and clears the state, but only while
SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
each skb. If the socket closes during the loop, sk_psock_stop() clears the
flag. The loop continues, but the state of the completed skb stays. The
loop uses this state for all subsequent skbs and sends only part of their
data. A closing socket may lose the end of a stream, but not the middle.

The state belongs to the skb at the head of ingress_skb. Always clear the
state when this skb is complete. A stopped psock still saves no new state.

Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f03519468ad1..a5d498982848 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+	/* No new state once the psock is stopped, but never keep an old one */
+	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		state->len = len;
 		state->off = off;
 	}
-- 
2.55.0


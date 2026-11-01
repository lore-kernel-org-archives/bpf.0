Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560880;
	b=eW5ctU4VH3c7yLBjcAKg3ur8d4BlERKSDpxyDQBcdZ4XpKhbClu0Pig/sYVCQgx6kp6i
	 czgjpDcnTT6u+bgCRwhYhD3QlEPtZa9Ylp1GQFgy1czX9X6rzJSH4Z3V2OMdJBnOh6BYD
	 kIXdRFhDM/4Fe1uhkk4a7wwL8DPTtgcbfKp3r26Ty+PC88O17rUcHtqSZ49tS4CvntqtU
	 pbSNU8mR46vUr8ZYJl8rct37tDhR8ZqQKgxI7LnYjznWEgmrfSiipXuMjECKaJ4OrTnkr
	 ldEujhvlh5Kupu6uAYy3fovGA+Jjgz4OmVv/wpygovlL3Gh8GPvvuFjfRybEjIVD8RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
	b=UVlWqmaaX/SWQmTqjrOsHeh1mLiuxTUHOj/mBe3DOspMTcDe+BODn9cguOMZ47WOwOur
	 4pMbjveM7GtcUADUugfQaX55XRN1mSDUBK7kip72xf28CbEUsxXTkQcmG1kGQyaCFjUhK
	 GqfOIg4VIf++jfumFu+K8LURUl4QAJcUL1MA1Q9V9pcgcCCP6lo/e+a3ISKpjU7178ZUF
	 j9Tpi5UrM9nTY/18UN2ZTP0Cbw8TCiYtI7NwoNgtyyxK/yr8d8vyBVfGgE7me3kPNyQh2
	 l8yNG885xdD5uzOV630brAIPRso0ErhVZAGsiPCSIJhhoNpF/II4PU54etbXfDXWhPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0k6C5UD;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A13606A331
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A13606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0k6C5UD
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a9f9473029so1567321b3a.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560879; x=1794165679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=q0k6C5UDMNe1C6d3mTmkiZKi0BWsORdfyjICBG73Igf1sUZT7WmjgV/a6q5XYH/SEt
         YTx+/WYzBGG2oTcLyb3QokYl7UKPC0/XfaWfJX9/LFqtIxmqN+mQx1J98DDJBt26lFOY
         XgUK61lM1zT2cULkT1D3iW65SPqJUYLUfRZiBCH4OLPmXjkdTxLvDmTxHAJHRqGEyk5/
         M3nG+pmSGjnDjsujY7RexCuJtfL2NLIFJeyBuCAjZ40wMIiQhTQ2CB+0q8vG3PBZURR6
         lFO8nrq49MVtUVDaKQGlO42I3Ki/YtnAbVjYxg3mY61xd3diYlcQtWNrpL32K3SfRdt2
         Vj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560879; x=1794165679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SU04LGyxjuYA40ODCW0YIdLfmYd9WdxC4UJ8kuxQrGc=;
        b=PQEOxA86W26TSm06TAM+W3KRc15ya/0ZBRUoNOmRhhyeB3h9iPfOUf34NGsW/dJ244
         UIvzXLaurbZTDLaQbcYJQ3pVBM3YGJaW5zLLJmFgnS1Oz5bOb3frDQ+VwyIyzpkqbfaF
         i1STjo9a0TCtUVzbWYaeepnkyinSQfR/tcNCZtJFAzzo31zd+C6EywHhvdA1fIGcMS7G
         utU8kXYv98CQmLTM7KavH1vUe4LVD1KOYVfCZTznnrKma1JimGUYRSsLRWBfi+HFzbSt
         IpVZKQsLxNNRlDuXe9OLONPXFbECxklv/fUKLVpM88Gp2LdOYBJzwtF3hLh9NWHeyTzi
         i9+Q==
X-Gm-Message-State: AFq9FYIxfosX6Igb7FKhyn3gZm7cEq1i6wYxPn7MuFGJe+mAGp+L0YyG
	mmKjxp5RUTZRYhgT8MaiwDELHGM4fnLY1y07qlLglkvOnXJcztHplh1DHTVwOA==
X-Gm-Gg: AYBFou0rdVTszQ3Qq42P1k9++W9fAMFrM5yPE0hX7SOfEeHYu+j7hbi8VmzGK/TX+Bc
	uEOb8W4boM9j4tHBw8G99ad89McZXanWXTUCU4xNJ+JloaNTQ9MghCh4YPZjO04t5pJmG6894N0
	K8tFqj/kKa4+k/MA5iJMUFLfa2NhZxkEUtwNc+rIjpGKilbsDmVyfQB9W3YxAUzxHop5wEd+kjF
	Ve7H2vrQ7XHVwDobmdNGbqeSJfViLO33dlNMogP8+On05I3pYLHGR3NM6jAUu261Wd1l37MJM+J
	q8fqKuxZoxCIFaUBEu4l6I2diWimFi1T1jGbm44BpYEKtUv5zJKhZBNCQ3ZX3Xw1+R+dU8H5ag4
	uxtyXzVWgQRtQ97kjr3wOpGZuOFgBSCMyUTfLc2j5seLlet1xwLUzvyX0C9/1ULd8TTDkXh/481
	lKnHBwGqxrWiWYoa8XVw5gXnACFpFU9jpMK26IKb6aeTwaDC5DIv9lVraLDCTAA0S1J1KaHbg3L
	bgJtjVXQ0xr3pLE/vqRvWu2dTDZlz8ixvR2SqeQo5ILZbAAX29eFH0HxLcUhvFSx8biOCpyuQzZ
	E31Nqc8rfcjWRlVwBALuWJ/Un6JVsXmr0LLnV/rChlVLCCvR3OJZwrB2l3aXAgYdOsv4rps60TZ
	ouULtkUq/7DsmhbpbRv50oCncLrEkRb65NOOkI/3m/W2EVZLEUycxymnF426QEZfjAsUAXpXJU9
	w=
X-Received: by 2002:a05:6a21:1bc1:b0:3e2:1a3e:395c with SMTP id adf61e73a8af0-3e928a51d5dmr7646160637.59.1793560879239;
        Sun, 01 Nov 2026 11:21:19 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963d055sm1140810b3a.14.2026.11.01.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:18 -0800 (PST)
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
Subject: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Sun,  1 Nov 2026 19:20:45 +0000
Message-ID: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

tcp_bpf_send_verdict() keeps the verdict of the sk_msg prog in psock->eval
and runs the prog only when eval is __SK_NONE. For __SK_PASS it resets eval
only after tcp_bpf_push() returns 0. But the push can release the socket
lock in sk_stream_wait_memory(), and it can fail. Then another
tcp_bpf_sendmsg() sends its message and does not run the prog.

With bpf_msg_apply_bytes() the verdict covers apply_bytes bytes. After a
failed push, apply_bytes still includes the sent bytes. Thus the verdict
covers more bytes than the prog requested.

Reset eval before the push when apply_bytes is 0. If this push fails, the
prog now runs for the rest of the message. The same already occurs when a
message does not fit into one sk_msg.

When the push fails, subtract the sent bytes from apply_bytes. When
apply_bytes is not 0, eval stays __SK_PASS during the push, and the prog
does not run for another message, as today. The verdict must still cover
the bytes that a failed push does not send.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..072ffd8347a6 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
 	switch (psock->eval) {
 	case __SK_PASS:
+		/* The push may sleep without the socket lock, and it may fail */
+		if (!psock->apply_bytes)
+			psock->eval = __SK_NONE;
+		origsize = msg->sg.size;
 		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
 		if (unlikely(ret)) {
+			/* A part of it may have gone out */
+			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0


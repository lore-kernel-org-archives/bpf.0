Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604098;
	b=rYAFEhqz2Xhr5VlNEFhY5B2tAdCTepofhlDjvaJlCKT/JXLAqn8X6Ane19zlOPBCde3A
	 gEULErAyJlrO+YigcrwcxjMvolLWPILiWG7kVuDZnwS34oJ7ln3B+ga2az1x4tHClqeQN
	 Ho+4SsxUzThVtUK+7/Ne+BGk+EFv7hWEMarKSrbb4x3JtFevclrTRqC+ybPJWPPxY/M9j
	 ADNZBM/sFN4RCRBwQ1iF8uExY4VXy+cwIuggk1oOFhlqbJs65IA0vguJRrrhIRsg4SKcd
	 ILS4czu+kVcYhMybkq4JkWLoCBlhjUgMWV7Vhu7WsV2ogX4EQvKwCPvYl34rJNTXvPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
	b=o/Y0s3wG55hiSknqwK6ydG1S9XlvdRClkwfw3iDms7Ft/1YfqCpzpmzYCn1uyGCuMlZJ
	 s6+AdvSKRErXDNChzm0fwJ4nxM4pT6RM6NwoAj0Xwi7VM1Tc5MJSHRiHkxdnhb1QWjG35
	 6EV7IDJHGSSe+6RTUJ2oFjADU/IwFntZwN/14N2YdmSERcBkvfW8th1JHxASM2UDGqInE
	 gWu3hoIdUZgnZD96RiZR+x6p5h7CFPUYMgxVl87OvV1QBdP/U//a3NOEZC+8r2baUGkeS
	 ub8nSN/uY/stBPPEsomZIHjNC3kFMRBefFtPocTuOyKfoLZpD7sU62uU4GLkeg6USGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMfdFa2;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AC606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3AC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0iMfdFa2
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8fe8e343fso17596065ad.2
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604097; x=1794208897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=0iMfdFa2E4giR6+L/RbyruUN4ugedAklyuqkewA7kWBIFjtADNmDS7ohqIWv+A18g8
         Vr5JUv+UxVJ7/BaA9BooLtpJi69L2LS22ew2/4UPxWh+tJQ2RJFAqcRcLrAaPb3kSeAB
         QyrHU2T/s1Os9GDCrrkN1864+RxS/qYCSiHUshnroVOxbeZwcGW6QeP278+pw8CkbKQF
         etkP4hJtYvFs+8GoeloS9+bmU4UvMTIroZ7/v/ajesGA2xkkKOSzegcZxgSHJ/jV3LZJ
         POWRp3Vmx+EjHThxTpb7S8LBtQ6j4JmOZ1scqou4VLy/S9IPVWD5+IWhvG5iO6f+zmHf
         fXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604097; x=1794208897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7Peb9UAgZRQMeYI4B90l1wzrMCTNfd6vqfD72GCEUg=;
        b=a7MykUb3Tq0fbTJbX2vibHPRcsZJKCrw9fr5A5gD25uo5KELnoazGojg8nKmSKqxQU
         kqmmUZ8HIQ1nD2orlFEDOp16gRqeM83uax5Lr6xYnMw2P9fHkaEuOioGfPdJNC0uh3wV
         +Sejsukn/wIOdGzrD0xT6MNz0z6CUXQzWZHtbR+E7Br324Y47fvtJLnWGBV1d2kmF5bE
         bA0D7ZOMcKWlak0zbtV8lzCCrOetzby9Hc1lPluQy7kdiBbbV3oIf5KOg6OwB+USuJp7
         MIN+IUjnwsUzMtq1IT5e00qnAU/DntUzt+uzTZVx5Ta1/xI//F28v406FEG8gfFtNL7x
         Zz7g==
X-Gm-Message-State: APuU4Z9dgSRJasCnHEcSmTkFbVgj4S63XbK3rWzh0KVyynU1en/2oZzY
	SQRbSBvw1H5yJ8lKx8R4vL6rJPfVjXeZ1y7wqpt0HaVaQJikzASwhj8Pl3h5RA==
X-Gm-Gg: AYBFou2KHvUoX6s8ETDXJrW+B1kkrZlJnkMTWiDQIHTtpsVQ8mquKxlf/aBvaJldvCf
	KoEm+Y/6Q4C8EjXKuds15DANRsB7E+7sCAfgH5nWamBbi8Zy4jKoZOqQ4qKrOR78F/oNPuoKz4c
	nDD2S9VuaHouTZObyI9EoxB1qrDmYc+qV21eRnlWSvHj7KRlu4/R7qmidtusd0v74fRVhQiJYs/
	p1iststtKjecBbuun0orIKAWNk9KvJfcuFRhGGDBAe8E1xJ++ZsjtFXcPJZOP7Eqnq0vwFhJ4g0
	r3Yd4Gzuh0zcA2ovG+F6y8zOZiShi/YHyjfSba3ddVG9NCI8ZJaPVWb21xM7QOXUPX1xXgRlmf1
	z6QtYoCsWB2ZUL3g2oTTs0ZIeKWJwMoedml/Cca5dwGs2JtjFcTRAEq+tJfA0/jzGJThhhX/RIl
	/PBSZhNOKmgb759ka5Ghz8cvHBGGIezJ/wqNodCp2g9xjs9MgiL31G/dDLQs7o7/Hv5F/+rq4ka
	jjN9TA/4fYeCmYwqOzwKvfk+L7ump1nMi1SyWMfw/l8058BgNGYnb1nQYLn2U+o/1QAK0CWZTZL
	E7yxaSUdxsnTXvhHlKw3RlnlsdJFQBTX+eX9UH7Lop/6gDaTKGjzhrJBMe2rTq/5SzZhD9EK952
	bglOwP3G0CGlJ2MaKytXnsRAzTaGQTNjg3onaCbym/1euWe0u/m5YkOsmhGk6ajx0keDLW8DJEr
	Y=
X-Received: by 2002:a17:903:4b0e:b0:2e9:9a19:c54 with SMTP id d9443c01a7336-2eb3646ee38mr76369615ad.50.1793604096781;
        Sun, 01 Nov 2026 23:21:36 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3924c858sm24478145ad.35.2026.11.01.23.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:35 -0800 (PST)
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
Subject: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
Date: Mon,  2 Nov 2026 07:21:00 +0000
Message-ID: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
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
the bytes that a failed push does not send. But such a message also lowers
apply_bytes. Thus, if apply_bytes is 0 after the subtraction, end the
verdict, as after a push that returns 0.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d90bcc911b36..b016aa419fb2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 
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
+			/* Another sender can use up the rest during the push */
+			if (!psock->apply_bytes) {
+				psock->eval = __SK_NONE;
+				if (psock->sk_redir) {
+					sock_put(psock->sk_redir);
+					psock->sk_redir = NULL;
+				}
+			}
 			*copied -= sk_msg_free(sk, msg);
 			break;
 		}
-- 
2.55.0


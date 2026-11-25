Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577640;
	b=z1YoEXF/GlkIoi76LNOVY0l2q2PEKE5m4UwFho7yWJoukRytL2SyGG2AXAk51mRS0eVd
	 Pe63FcaDb00578B99mWU1oikdFo4NmfU7cLbGsuzUXah3TCDxNa6ncmObwxzOHW7KoAEu
	 Qqpi5TwRJgsLEym5hLVp2dmsEEWE7Ih0bcf5mzFt/Euh4DZaCFNDq9rsfrtGJjsgwRUN0
	 nVT7Q2eXps85Z9ZHrvXkATnmsVVYxKf45Mzhx9GfYhoOPBI+2ZfV1oSt9aOLby4/U/37o
	 1XfYlv+6xq6Zvv/3mleI/hMWMZZb38ZFnG1NyMu6EACx2+SxCOTUFpuHGX8j0s6NgfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3mfZGr+6bmCifHnk7QkuqcoaDhxtYV5y0WVJUG+A1WQ=;
	b=Mz50WbtD8n6re0nsPSDzdAp1YQG4GMTr+kODhGKHQ0gTbjDQnqS/SqE1G5/9TG5wrj5M
	 p/A0TAnLD/1Zt7V1I98sD7LvUD5ltgU1JUOqckrkvjZB0fsxtXCQCUI9Qvc02dRaDpkaY
	 VmZD/R0oXN/CruguH/BiDFZNn56NOh58T49H3Tdqx3Jw2gpdqGpKoRBtf4wnk9V/MZWeP
	 jt8ZXtqm/gBNA+aVwzAWACCIKG7otR6Q+zoMmsX+rVXzX6J6hQfiYk1iwzB6wGfTx4SFa
	 giUrDPRKFx143CB+vy/GY9bryRqVQcu3yhYhSkrYpaH0fQYKnQKVoCRvq2wE+3PTuoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HenepCak;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514ED606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HenepCak
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0918f9e6cso12421025ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577640; x=1796182440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mfZGr+6bmCifHnk7QkuqcoaDhxtYV5y0WVJUG+A1WQ=;
        b=HenepCakaxccoYcT1rqhlCFIg5jUT4yrMgNuOad5wDk2toXJQXmZsacNg8k3gmv7yq
         irnKGV/gNNhPm7Q7xkBnXYo0A3oNB0ts4n+93pb+dEmIE8uM1zXHdNGpUK5lG52kPtK9
         9RD3xMzVUog8+JDgVv/YB0nr5qSBz1iXETNVes5cn5Rt9AM1LkstQFQbDGArTAmHPgl+
         0MvCJ05KWQKbRe2oHgzdjPT7Y3TwFLEStq+DG+pancDtFSP8oISxqkmHLzRqGpR1O+Tu
         92MIL34qQShAQlJkmejTY2r0mbeEgrJQmfJHFaTkgKiRmLu51OemP/6ezE64MpsOokRj
         J4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577640; x=1796182440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3mfZGr+6bmCifHnk7QkuqcoaDhxtYV5y0WVJUG+A1WQ=;
        b=2X1TGkPo123n1JRYZUbGPdON7hXS46SqQoWohMs6m2xEkLbeDq3C7ijvvEnwOjOmKt
         15qJdyzMBY5Zwi8zesE70IUlIuZ1uB9kbyKNiyFLJHmlCodOwCj5n/BfOfqy+EN+3IB7
         FqAQPIGF3i8jQ9ce+NVJR7D+h40ERpQUustYoz75F6HQCYIysKhbFGnYl+mdx3S0krYU
         5EOJKRml1/6nRu/V+NrHcC3qExDgMzB3/pVC2MgXtL5ehqQRDbNBosdN9Bl6AmoL5MZr
         T0SHYFj5TetyraJvZXAcBGBXSX0+0lT86DPf6G4ef/U+gokDci/+gSFZp/XavmWLyZND
         hhAA==
X-Gm-Message-State: APuU4Z/PBGWYQLh5W5ABQqp+7pn28M1B7nuLj6eDarU6vzBIT8ABuJnN
	7HAmceVj/IDebq08jsMbrqsgG9EnK6R35a6pFcP0Y9XWXEoERQ7slitnbK+BWEuE
X-Gm-Gg: AZFdTZfbVbr9AwDeJ8z0vL0X7nVxRyPy9YYhix9jQBPQTWLuWRraLl1iWRvKWqyLUvC
	YWUoe5isOAbzVPuNDBMnrICAbXOP+Mx+otqg00sLimWVsGxOXf1zZsEInjKNe/c0m9reqM5Ioch
	/rZhQRmSt8yGnZg0wMpIbmV6elD/qlL34OnTLeDlflw+NhaKx38M12gF+CvYDuREwcPtIccl1Oq
	QezcAd+labIFfFG+LujVd4YGSUm/pcRA0BGK+f1xx/0TtBQz/3iz9NKM5//Vsqr7u6BBUD2I+br
	QMoJ0JTzsX4LyuPe+oXXGCrAVJUadTR02iWXZ6pmp6xniV+zZzms0wsCx7hn+lGrNDSD5oBtzxK
	ca9peJQPUO2etfmFo6tTRaIMAeM4Hy+GaZBYfBrMMVvakX//98cMEFZgZ2N+Affpya2Jw+4f9ld
	jgkmXKL81H8Gp8WPvLX+AGOUl/sFBvvrDgtWiUFFWW+zmmaQjhP68buNwdthSYmfzejq2gfzS89
	t8+Ys+LW0/3DeEtwQV3qQMTuXKWl3Nb+oC1x9yRP4JWY/gUKDt1s3A9DCJ5zGo6pKmnz/udt6GF
	hIVCWrAqkJIRItU4nePcA4KF1cb/cYyOVkpS4J/h56JC5q9K/MO6xeaq/9Kyq8PNlOo/Ra8jexC
	KyMU+EBvLKeihv86fyvwK+dutzakZIybqpa/bDmpll4Z2ppYfQl/Rh8VylpT5c2aKIEnCIqwHvA
	==
X-Received: by 2002:a17:902:fc84:b0:2f0:3c38:914f with SMTP id d9443c01a7336-2f03f2363aemr154601735ad.45.1795577639483;
        Tue, 24 Nov 2026 19:33:59 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1aa3sm76921465ad.21.2026.11.24.19.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:33:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 44/47] bpf, sockmap: Keep the parser and sk_data_ready in sync
Date: Wed, 25 Nov 2026 03:29:35 +0000
Message-ID: <20261125032938.670542-45-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

sk_psock_strp_data_ready() takes the psock that the socket has at the
call. An update from a program does not wait for the owner of the
socket, so that is not always the psock that has set the callback, and
it may have no parser. strp_data_ready() dereferences a NULL strp->sk
then. Look at SK_PSOCK_RX_STRP_ENABLED, it is set under
sk_callback_lock. The event is dropped, as it is when the socket has no
psock.

A socket can be in a map with a verdict program and not have it, the
program was attached after the update. Another map can start the parser
then. The delete from the first map restores sk_data_ready and nobody
stops the parser:

  WARNING: net/strparser/strparser.c:451 at strp_done+0xef/0x130

Stop the parser when its callback goes away. The psock can outlive the
stop, and a later update must not run strp_init() on works that are
still pending. Start the stopped parser again instead.

Fixes: 0126240f448d ("bpf: sockmap: Allow update from BPF")
Fixes: ef5659280eb1 ("bpf, sockmap: Allow skipping sk_skb parser program")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c    | 12 +++++++++---
 net/core/sock_map.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 8a3b8536c0c2..1a0029f276e2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1149,7 +1149,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 	psock = sk_psock(sk);
 	if (likely(psock)) {
 		read_lock_bh(&sk->sk_callback_lock);
-		strp_data_ready(&psock->strp);
+		/* This psock may be not the one that has set the callback */
+		if (likely(sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED)))
+			strp_data_ready(&psock->strp);
 		read_unlock_bh(&sk->sk_callback_lock);
 	}
 	rcu_read_unlock();
@@ -1157,7 +1159,7 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 
 int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 {
-	int ret;
+	int ret = 0;
 
 	static const struct strp_callbacks cb = {
 		.rcv_msg	= sk_psock_strp_read,
@@ -1165,7 +1167,11 @@ int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
 		.parse_msg	= sk_psock_strp_parse,
 	};
 
-	ret = strp_init(&psock->strp, sk, &cb);
+	/* A stopped parser keeps its works and its skb until strp_done() */
+	if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED))
+		psock->strp.stopped = 0;
+	else
+		ret = strp_init(&psock->strp, sk, &cb);
 	if (!ret)
 		sk_psock_set_state(psock, SK_PSOCK_RX_STRP_ENABLED);
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 0d7a8d9405d1..ac62174e8e01 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -169,7 +169,8 @@ static void sock_map_del_link(struct sock *sk,
 
 	write_lock_bh(&sk->sk_callback_lock);
 	if (psock->saved_data_ready) {
-		if (strp_stop)
+		/* The parser can be from another map, it loses sk_data_ready too */
+		if (strp_stop || psock->progs.stream_parser)
 			sk_psock_stop_strp(sk, psock);
 		if (verdict_stop)
 			sk_psock_stop_verdict(sk, psock);
-- 
2.55.0


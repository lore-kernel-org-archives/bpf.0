Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604111;
	b=prF6oJK/tuXUsdt1DPARPIISXrOcj2JRmkGkMAmknUuMBL9uabEgwwLPEEnjynjM/ZaC
	 jHo92/zqw+JwpJq3o0V4Chq6LkIp6VmaPOsOV8kmkL0J6mMH4xyG4u713X4RWO7U4JaKK
	 ESQcTe/u85wJfN5B2m44TwM3vAFYxakvL69vghnTFTM/pelH2zvdMR4MqeSt3y6MNAagd
	 3rUe176wNFJ31mPbVkoo49ETuWSp4L2v93Q1UUFBqX7ZeqsohKaXiyuTqP+GwQRDk5W2X
	 8R12gk8j5nOD5AEBy8LBBTsVZJU7TMAi9yyujsTyHIijlqaJ+a49mj2sG3bPvXns1Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=jp3VwitydtDd386bPRDCrBuCYrkKJis7Vd2ls8zQUo5AinQZ0Y5HzTmWUbAKIrLB7V6r
	 K4E6Sxs/3Soj8EodtUD2mrVROmyC06Qopb6cyJgynWIB59HMv8nnjEpg+oaWhkNBvarKz
	 wAO9gb6AqrFqDhk6DhZtGR626UZRTOSO4bBR3MU7b28cQasQQ2FEQODFo/vXRtq4+cy6m
	 H2SHCV9SSttk4Wp1ei8PHWrc6+CJLwzOWOgPypYyPjBA1V+zFNIMzcPzQL5h+DiGb6r3K
	 FGaCROB9aUPZU8edV7zVNoRtna+c6TiIebYrdNEDiUSQkNCe0FMx8UNWZJ+KY5QS8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFg87Apd;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB21D606A336
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 07:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB21D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFg87Apd
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e946155442so23560255ad.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 23:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604110; x=1794208910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=GFg87ApdBn73TJ86NfBoPT9YgutNodcefQFgQRBOIe3MMSo/u+i6WYibbpy+LyKgI3
         Jl6Vd8cphaUlw22wVDB8SC3RyFT07Xoaz2rb0/9R6BcnfWQERLIV6pWSOjdpwj4/B9mc
         UA+2iAUXxx0nF5RaI2Op/ijrGF6E9qgHYCa9Fn8wgWhC6ZBa0vfhfMcKCVrAuX4ba/Wl
         ehrOpfAjgpkO7frM4hKubRuSDKJ4kLPQDfyECUleSoGzZhLiHKBBldXPtAthe2hKblbJ
         b6LsjopF98PuJBaof0/BDf3WuuWRUXBmJhEQEuvyjyGd+gYp3joD3f28IY4PgUS76/VV
         I82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604110; x=1794208910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=HGTiHFLnDiniBPFHA03ZLyaeXkN8o8d5Yqvojzep14BSp5rlrwwQbxYtO6J/Rg0lFV
         Qt4m8HArtCymeLff0Qx5AjrX4ewdJX/ZHJ8ShpFckcjbHJUstDUECzOZ2DYubTvaYcfS
         czRDHPGzMnSaBHAJMudVaJWK0+ciUSch5Jcrc2mo8phWL807MYZL7u+zX2WzHkelscw8
         Nd3Kzsjc3tNyJHlyKHUII6MfgzYEVuZWaXuN1vwgVEc0DLdNAbo05N08vClQ3CKUdSx9
         ueW1maPHl/iKT7hktsTtSYHgHlGYwn63vusY5I+nBeVJOhb/mmI59mKSp0AZFvm0Ni+H
         gTOQ==
X-Gm-Message-State: APuU4Z8x2kPiZUaHtylVgOmTD7n5WnFYZhd0wF3Rh6XbUOoAvsAhPkQ8
	XiFpvLUS9EFRn2jrB1wAHbZKyZM3GH9wK9njrs0w8cOz71hUnNCKKotoa7n8Vg==
X-Gm-Gg: AYBFou0F6id7kyLzQCLqpZZal2mXlaxR8p7opfc9nMsexQib8wqz53G65x2wZ5RxtRk
	na/bEt+St9B82O+syzkiy48Q1Ujp1IqKpdV9CN3YUhWoRewRGmr7McXUd6ujsNgkmJeMLiHXlVk
	LiE/TV4hVlIXmDGS9NHiRPdGZJEfHB3b+ll3/WIzwM79h/ZAUDcahBCNCKWAWhAt8QtHi+5fl1q
	rot5ilklqdafJ0jHOLwEPljQRgPCor7/zMrUSqsZuJQXWQCdUOWg+DAEuZlBBilmM45X6TknPkn
	Ydks8Hm/ozsyjg2XGN/NIBdjyO6spifw5RSOCGfqUW/LX6ekplhCSptfTspqOCfIg5uvhs3nVJx
	myYtAfdTl3naUYsBqs12vx6SXdsNlLJSBbnatKZcJCHgedTBm395u7yZY9RAEseUkv5CA2H6OR8
	OrEGCD6cIqoTlHZFzO5UhT+FDMIwd/Vz+HEl6JXqqKwTc7fq8b2uCUVsYtz5nx0D0C1LlQSohPM
	cj1Toch4fL0ujbAoOlpXONeQNV3MqLp+Q1yVSxPHhPF1Q0ehlqP/0gt4sFCdGhgvf6O/wlg50SD
	X5XIbLkhoqnDEYYjDNfA327BJUui67MbGhURk4p7R+U+8ZDDCVTEITq5RQQ9fFInCt37ZFGP3H0
	N6QPzBU1t2mkEUXIwxsMPxQSmQN0asPtX0iKChzH55UHIUjUHBAj9pUh676gNkY/PYiuSwUTarA
	==
X-Received: by 2002:a17:902:fda7:b0:2e9:c569:7050 with SMTP id d9443c01a7336-2eb365116demr91088175ad.47.1793604109917;
        Sun, 01 Nov 2026 23:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae546sm23619805ad.70.2026.11.01.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:48 -0800 (PST)
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
Subject: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Mon,  2 Nov 2026 07:21:02 +0000
Message-ID: <20261102072112.4160195-6-alexei.starovoitov@gmail.com>
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


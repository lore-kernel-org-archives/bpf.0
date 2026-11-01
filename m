Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560886;
	b=eZxq4rW4oKSsGtX0c/Zff0MI36R7yY+BrmxiCaCoLkXm15Bm1VSP7RTripCSHBMwgh0v
	 0P/DOU0oJi71PLriXvXe57LudhhsF3JpY2k6H8CUFy/kxxxkLC+YQn7c9IOqPsrR/YpLG
	 0dLYy16HRyAe0QOmEtBefaH1Xh4Bt2aNYQYUMw2/Hn+f8mx+dh0aIqhaNrlNiuDZWMCxr
	 uJ9WC0yP2G7U6XS+aIduH+ugk8Eakt/Boov0nEF6cePkXnTFNOpKIEAZylbe7yNaJmeNv
	 2H1Hc3uuijKCri9PevZAyPG8Q9oAw6XDIayjtDuXA8PQooKmp1cpUhsEgX7lXf5/7oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
	b=dvTsPF7cEcGWPXGrDZAE54EceXqDeoIGQmTy0LrpIATwDqLeXuS2f8Q7hpVnJRdX4xuY
	 Vli8SAHRN0lBgLBBZyO4AAM3yxfNvtAXjlqszrKsmXxRe5YhOmypzRshidg1CmCVgaQcq
	 yF6RM0s7AvE723ojrgzJFT2YOjyhzU31m/ohJmkY5jye0TnemdWhVrnwHhQcsxedfLHB7
	 jXTHjxC93BTnXix97nFF4gHwacqDlGa9EZ8bhOIO9ZokU9+6yrO6XIDXtFYOqss/rPHbA
	 jCj98dahoIue4LZVn0u/VectGRENLYlXBsxFbA8ryAh033C4FJKDeyRSaj/8FrDmZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHPRMyqo;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC29606A326
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHPRMyqo
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so1006427a91.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560885; x=1794165685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=MHPRMyqoIsk3DMepJwMJiQh56erGBhgHXLKbEURm9bkZWMVHT30zKppI2hHc+JnsJ3
         Q+Pvz4jGDYYHeX8DGKpXZ588ob4QygXkx2HB+lwlZKLUx1S3xh9jA0jsD9VSGFphV5Ha
         h2Znkj9CKN8x73WNuyDpg/ht3OK1955vXU/rn8WFt9x2tNmULuj54TBsLvGOukFmszvM
         U81SbOKNSCjOrk+OoS7eAkJhqw30AyOyN9lHVomsN842AFS3AKCUKBvHTm9d6BeoEfbe
         DrrVQPFBtJvrlkWQ97sX84eq2xwVk1R5u39MRX/ba/8OQtUvK3y/60KfrwCTaQubsl9m
         l2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560885; x=1794165685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lvky38gqrvpjSBWUSg+Q6mjoyF0URntzlHpSfOxGZkw=;
        b=GVp0xUBwDdU9/jkuQ4f2b6L0ajIUeufPhheLGxpwK9RdnTXfcCeHLxms6XaoSqKk2F
         BX3IiIdIDwZyf5v2Mpz2BnEvr45/2aA2EejbEpurIxFnuflQB4ysd+JZM01P6MzhcoOz
         9zOS5968efJVRRQCjD/BY52xaXv2NC/ZrriUXNYlQxeCIHHlH4QDkrhs8e1nk5tIrTn2
         RDsJ2lBFtrVOrrXaUL3J/oO7dPhrV2FZoNFmgGgQL3icq+Xb+oGA8f3bRzXs6UF4Gk8I
         ycEvtxqnfIlSarz+0xR3r9WOyVwu52ZOrk3JQniiP7OMhQ/PTf8rZ4j/SuKDp0FanFt7
         gbgg==
X-Gm-Message-State: APuU4Z/lF5cVi8rLMrE7kddDWvBzuUR+4SJvFxWlrvOcbzJzU8ZYBm6N
	+egTKLT55T1T3AmOm0WZr+fSnJWGrG25yKKtwZCult7DLZfSt+rgi4BGffhhDg==
X-Gm-Gg: AYBFou29s6V7lSqipatIs3+o4rWB8Ik8Rs0PXGr1DJ1tlDIIbNvbQqmcP2XWqjijSO3
	XfAZR0DtWEE4Sv9rgVam2NrBU5tqZfTP+DLlJICQpeO4JidofifTpKAR7+jpCjkBitxKFFLNqwU
	9b4xEkgM96qQrkAM/64i0IfPrTQTK1hVqI2lqZOvOJSuiqvdd1TLFTzcsTW5VSYjMFSVteD9F7d
	izFyK1HzxDz91WnpMstoZN3MU8yuAeb0jVcXtttOJgHhFq0Ja0xg/lVG3epeUnMX6nhrOUKKqzk
	JDnv1SOCPPc86PSY2AP/F6rrxbtr6sOop+E7qJeDgO5ApgAnFjwdtb9AN63/I8K0X2f6cL+SOLq
	tuIt/LKsp+RLQPEBG4u0zgR8iBoMvsHwpUIgpnWGOd7INFKcRou5/Xrbo2FjOLGX3N8qkIPj7P+
	4L7Z4Mt8X/8UPVsZOrjXPgff3xcKzhs9ha88ub48maOtMXw7JvVE5pbDlFmYoQ8I5dj//91JTgf
	pmhOjW36ANW8hkQKnWTtUbn2rErNgLIGpX1XPrlRfc2M8Xv9zt5u0Yq+8g5LkhUGJtk0wtTQeg/
	1mqrK3vl2+TM8kuZQ2azI+CSpC7aieHOcNwHn63yB21rMFEvsUVWiWXWF/GW9rbFhTCHJ6J+LdL
	eqwhLpxiCPXvR/s6c0FF4IUgabBoGKrcQfL5FPhJUTkcyeNNwAo8pgoyVKM4TShCj3J2o0f0xtg
	==
X-Received: by 2002:a17:90a:ec8d:b0:3ac:b7b9:6484 with SMTP id 98e67ed59e1d1-3ae897ae130mr6233275a91.45.1793560885317;
        Sun, 01 Nov 2026 11:21:25 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84596e3bsm11151183a91.9.2026.11.01.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:24 -0800 (PST)
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
Subject: [PATCH bpf 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Sun,  1 Nov 2026 19:20:46 +0000
Message-ID: <20261101192057.2296489-5-alexei.starovoitov@gmail.com>
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

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 072ffd8347a6..b9761af13989 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -513,12 +513,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0


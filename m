Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688402;
	b=rTTtXwOlWIys7iRy2MmgdDKKAfw2kmvI5N/68Ekr7xgjGP9x0bqmQE757yLakIEOjZrA
	 Z8WjbLYMCXgE3+X5l3revVMjycmf2Qq8EDhnbYO0nKb7y7afGl7gefWErstIOMN5omSQv
	 215RYLz0wApw67/tQwfrTLeCg9v7b5ALOu97Mm9VMUOIIp3fyIzfe8r5SVyRaHJAr5Ltd
	 jnYHF7AW0kLUVY7SrB8Xf1LaV/LBspR2W5wMQzveiqLc5grOdszuPrBvblvBJvr3og1X4
	 A5NlUdGykicErtcnjnUQRJsr4mZEbcF0vlXPdlwFGVCh4LOhfLIDWKwY/6/KduzrHsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j6Q6Z09Hui/dS1JTsCKZUo7wukUm5qF65Apk5oQFIkE=;
	b=BTfu6Q5eK1qSnN+oYIsJfDijiSFfDB6q2uxsFd2rxgTl4Q4EvDnCqv9h0AvISppDyCbv
	 gE+t6B1VKoGV73CMLZsLgKMgVOFFB4ej4rzUk1JykVgmpSekuZqc5bUzFy9qlnH+xTD5N
	 x+ytzJAFCM07hiyhcMFNl580+l6SoeusUcdtFrsvjtZ9q6TrWeWVVO8cybtl5YufDsAgd
	 m+6h4vQgOX0DRBFreIoXk3oEdDLdTq1eO46IDfktQ1CWcUcNqzqsvMMH4oU91+zslJ1MW
	 uOOJ93t8btAfCDqWH0p1Tmojz2IT2y4zSHqSmi5OtKbtUYT8YdilZGrLZc5s8cZsQ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G9leAd7i;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25481606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25481606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G9leAd7i
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38692f62b22so8607043eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688401; x=1796293201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j6Q6Z09Hui/dS1JTsCKZUo7wukUm5qF65Apk5oQFIkE=;
        b=G9leAd7itAHyQfMbjJ60qh0Bo65P1g4Q0RBZMZ39eWqm+IpTJcymcID3FIgY9Vq/a8
         voDMuC2oiduBF3LBp+d6C3NFEG3+nXsXfPNoW4KRm6F/Z2nqQo6d2IL+EFQerFAdoOD9
         bXNA0ysbVXJEPXUycs58vANSOIGwMmk+YV678WgPdluIkyijtaejPXjWHaFk6IPRxUTF
         8aK8vhoVonyeSJdhgZW9eE4krRivWI9w8JwmfvkERHL0fr121Oi0bCAx2FAKViZYgRw3
         +1VGHo2KUKCKtoymZUmJVvg0KNLgNSLrxM2hKoWGl1rNvtF2YDmrmByxQo4nnhZ1sziE
         c2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688401; x=1796293201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6Q6Z09Hui/dS1JTsCKZUo7wukUm5qF65Apk5oQFIkE=;
        b=XAAl0FMezIt6bwVG27gdcCeVjqhbIbk500vJBVgaUIynLT4qU9ESKMU/4gQ9rmY2iP
         QY7GTEUl6q0eYdnInNZjkq0uP9B2xLzRJ5tIccziIwPbCWcfw7NTkeInMfuVb+/55AzI
         pO6MbOpwcOVx7DybFEUscLE/694BMnXQEY7IYvbGrrK5meuMu2kudMCLM695qSkXLuMf
         TpMbUeYcRXrfjeqfsXbHKPGNf8uy++HETuLTvsV/SadPCYiCQCoaCcgJkzXAGIuFsV0R
         V3HH+tee6P/KWlqLkO46iFKNTM1kw8sKLEbtpxwl+4gKMQAjy7RC7nKbWZGU6lW8SoNU
         UtuQ==
X-Gm-Message-State: APuU4Z+hhiVE8YQG0MrVa4AykYt13x7EajJLeL/mPutzIdyUrn7xsXNL
	94iXPsgM1846KaaOW1Dz9Xm3HHYembH5k4AqaoqN4xz368T4qJZ5hXnFX0bioA==
X-Gm-Gg: AZFdTZeV4E9o8th+XjG5hJZQxn1xntewcTsdQuMo0Hb4ZUUeKHIbWAUr/JP6FhWqMNw
	Yy4PfDpJVYXULRDH0t84NAm+V+q0rsrLWviYnNt0CK1Qc6Rgw5MgM6SFQl16q0gmwR8QSTMI7lY
	OR06yPQROAuwNWJNtpas+9REEiUmzdiE6LkIFjSDNtc8a+1Fwpdx8eGOCpSyMsPyw5v+ET0TebN
	eE8uhGuEGTx4ds/7hiXjbBTpEpydMO5hU+r0SeXsMoKBBC/n4un/aVA7HaQySw/sRyI6BGrGlIJ
	us5Lv9Y3sSYIrAHGHDLObwKA/WtmelLg5aRvMTTuGhle/SX9JA/GgNrE+mGjwPfYI/Q0nk9Ui5a
	+6nZD4H0QO12bbKTjtKT//SpPoRTlY9pW2UoTJ3BA5aOspM+/0pPPFc73Kx7cWgC5i2cNizfF/E
	ed7GswP44KYN2/8FRFD5v11Hk/QJkRCJjObhluHXZ2LwbAIWtiexYXquZg5voC61QsBIXWADSAa
	uvbXi4bcw+EZ6OurmRyBiTEboQEmc3+ezciecLI575AJ8x0MSN2plMSaNenfRVsRvzVos8Aocdw
	RGlcsup+LaC55r6uictlsQejXsKtLoyRD+4wytycuPq3ICV7kZJSwoEdlbMGj8ED
X-Received: by 2002:a05:7300:8188:b0:382:61d0:f375 with SMTP id 5a478bee46e88-3856e63b050mr31176284eec.7.1795688401293;
        Thu, 26 Nov 2026 02:20:01 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aa203267sm32885813eec.0.2026.11.26.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:20:00 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	cwang@multikernel.io
Subject: [PATCH bpf] bpf, sockmap: Clear the redirect target after the stream parser runs
Date: Thu, 26 Nov 2026 10:19:41 +0000
Message-ID: <20261126101950.1682160-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

A stream parser can call bpf_sk_redirect_{map,hash}(), which store the
target socket in skb->_sk_redir. sk_psock_strp_parse() never clears it,
and it shares storage with skb->_skb_refdst, so skb_dst_drop() later
passes the socket to dst_release():

  KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
  RIP: 0010:percpu_counter_add_batch+0x24/0x220
  Call Trace:
   dst_release.part.0+0xc9/0x180
   skb_release_head_state+0x1cc/0x2f0
   sk_skb_reason_drop+0xbc/0x420
   strp_done+0xcf/0x150
   sk_psock_destroy+0x85e/0xb10

Drop the dst before the parser runs, as the verdict paths do, and clear
the redirect after it. The parser's redirect was never used.

Fixes: e3526bb92a20 ("skmsg: Move sk_redir from TCP_SKB_CB to skb")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/core/skmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 005e09121f00..4089901a9581 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1131,7 +1131,9 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
 	prog = READ_ONCE(psock->progs.stream_parser);
 	if (likely(prog)) {
 		skb->sk = psock->sk;
+		skb_dst_drop(skb);
 		ret = bpf_prog_run_pin_on_cpu(prog, skb);
+		skb_bpf_redirect_clear(skb);
 		skb->sk = NULL;
 	}
 	rcu_read_unlock();
-- 
2.56.1


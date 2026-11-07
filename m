Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071010;
	b=PEtmkVJiiFNCBwWiQbIyueDN2eoe7XKmwdmySO37oHM9AdWg0bDYpEn/PRqY3hsf64xe
	 nDtXBx48Am+iF6UCw3WLKdxsjg81F0QO0uwA6I0zf2vHKbdjXIPZPJWsWwafoCIGdRAP9
	 GhxiEY0jG9ozScHqjXgCDYgrPkw50nXG2c6dL4oMLA6pINEfp2InvFA9tmTkP+nTI9xSK
	 O/86RRiHfOhm384ASXcvV++Kyg38GoaN3uNxlIiOhnldjMxluKRpjMwpR51GppOwgtMTa
	 wIQW7FcTEDFCIsK4f5HE1oc0WW32Ld7ndO5EfB5pNSzjzJSB0pj4zORPtuSa3IjYqDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=59Af186DmXB8XzwtNA3MbwIJzB3ec+dgTez6hv69W1E=;
	b=eu3VRP67FVZyPucCAHDwAXZ8i8UYyFR92WPwMkGwLVdI14K7tuVP8iTNPBVCIuXSVE6K
	 ksy3Y8LIrhEaPatyUFCzcTLR3BI+CLUbEV3+oQcUg5UD5CP6h6hGynGq5vZqS+C1VYVTu
	 dg5kQJ87DOfAnnl+EfGSUqBoFQpNl6HVvADUVVn5zlAI128tvvubttpxvgcCNknRJ8agX
	 KU6ctLrNzx6499HsnySYfLk2LDxECeWq/2a73RI+n+70mwGv4/JVk+hHKoo7agxyjRBHk
	 U2M8LlAI9fnPgq0tm91Y2up7VEM4H/PWIBXKyPBnY2ohzFWadVHW77AV8nv5Sa0/fHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9RIHpOq;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0B606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y9RIHpOq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e985106c0cso12485925ad.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071010; x=1794675810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=59Af186DmXB8XzwtNA3MbwIJzB3ec+dgTez6hv69W1E=;
        b=Y9RIHpOqpZFly3knEdOZ1YsLCe0JMQ/GqRReVrHLeIPyaqWNItRSkRF9JLxMP5/21F
         W88q2tj0BDZTiVb5z7xDLEmSypeutPoSLK5xQhtPzlqhmAOyilgVPt5EqF/43VSNaLbz
         BAqkxTSO38frExSgf4ZtQWjQrDoFy4zEQ7DG5Ea4mrD/s/z9BVDVSu0Nuwkmqf5mfvJh
         hCsj6skiC7vtdBZ/uRWxAxvkvRDVveVQjDV0TJBiye+I0OIZLB1nnRTpQS9haMbzbpRW
         WNj+bOydfk6QJnRSLvsfafio5H3sFDQcy8hUj+ghf8T9yCh+q1YR2kk7gwV3jk9gR2dM
         VgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071010; x=1794675810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=59Af186DmXB8XzwtNA3MbwIJzB3ec+dgTez6hv69W1E=;
        b=2WjfoNXLniMGuKYPvx172MWVz1SO03FmSG12ONoBZd2h9QTn13plWau9T6tVy9DgWu
         Zsa1Jz0jYYhbHVywqoDYzyPmqmy9SNNg/UNHe+oZg71N7gzLW8SETXMvvUnggCUDSVE6
         BE2BhJmG3I+PZtDaxAWne/9pkyFFpPcBbm5CbHlNYe8Vc8wVczhYJDUwblyjNmkLH1Qh
         XIL3e/98Z5ivF3mOayttZCb/9FIpoZn1xB0TzEZEPAwe22TTSKFtkTqsSYjr8YrHHYMm
         fM5UP1XygWXFePzZ7lDLDJVyqS2uFMRSxi9Gw7X6dVV0Ve6cLsxccBTOGykOzPELNwdP
         eDow==
X-Gm-Message-State: APuU4Z8KBplnbh9aPMHf5iSoAgm5hHiXBZ0jvPaZ78TzrzOoGjHkekEY
	WDpfOkh5JSOVSQlI6ElFBtXz2pVRbDNYhGsXcoknEmXiWKU+YX5FNVTGCd00jA==
X-Gm-Gg: AYBFou11WUr1Rlxyj/j45C3iScrCG7GtTIaAGyD7dIt52K7ZZwW0xsshZWzHstivhoX
	GdtBeVUCvv2hAnWS0fxEnUR6bKuGjZR3VHfN8pOibu924DUgkfonWAsGu4xWIrhHg8WVJjUszzA
	MjcA8XRP5mgvolZk/DgmCDU16QYSEC0KnXVWAXfFl90dRnFS/hctTb6AdzQfZXASRTPxbd0fGLC
	Gf1PGwGZZuN9Y8gA+YoEW5CprxUBeaF7OLcHTGD009Ev5LPJ2+lGXHdStNQiG2wk6QFxrCxXvYa
	Yb0EwNFBfEwxOgNRdKHU+bXZtcaJ0E1ITEFoH3Nyl4S8Xr5uoQm2YYtmicgylUeliKcTzsKBU0m
	dd1z4WCyFEvT+ImUFzB3mPwdofXreb5k6g/KxI0jls8gD/ANeymAOEi09X9gnERPZURUX59GS+/
	6KU2INAEnMF1QipQZnfMQ/5+MHy2DP8+bTSXCcoBCaGP3bv0M8XGtQriMxnlEMCFesTm8+GmY72
	IpYySg1ns4jz6/SsbU/SLd913ObYntTl1MPWm5Xpbd29D3xy3VpFLNd1SCl98vDoukaSRqgVY9h
	xGBPgW+0znbngvEduPzl0oxKr2sIfgN3u28XJiH+dMH6lwkA3GZqceQI6vgoqceEvgsIckDhVet
	ajsHT2cUFnppHxNH3RPvMzOpT/rjmYywxlirvXduHaA4WeayjTsn+7Oa/VpKBLHXuBMpWrjoX4w
	==
X-Received: by 2002:a17:90a:f489:b0:3b1:21d9:4c3d with SMTP id 98e67ed59e1d1-3b121daabd4mr245285a91.39.1794071009611;
        Sat, 07 Nov 2026 09:03:29 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10588225asm3799772a91.8.2026.11.07.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/9] selftests/bpf: Test a number that wraps in front of the jump that counts
Date: Sat,  7 Nov 2026 17:02:59 +0000
Message-ID: <20261107170306.2831028-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
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

A number goes up by 3. In front of the jump that counts the loop it moves
over S64_MAX in one pair of progs and by S64_MAX in the other. The store
behind the jump takes it as an index. In the progs that have to be rejected
the store is one byte behind the value at run time.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_loop_latch.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
index 12c1cb2f0384..8b9a2853ea05 100644
--- a/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
+++ b/tools/testing/selftests/bpf/progs/verifier_loop_latch.c
@@ -117,6 +117,29 @@ LOOP(behind_moved, "w8 = 0; r9 = r6; r9 += 2043;", MOVED(4) "goto 1b;")
 BAD("a store behind the jump that counts, the pointer has moved too far")
 LOOP(behind_moved_bad, "w8 = 0; r9 = r6; r9 += 2044;", MOVED(4) "goto 1b;")
 
+/*
+ * A number goes up by 3 and has moved in front of the jump. At the store it is @first or
+ * @first + 3. Moved over S64_MAX it has another residue: 2^64 is not a multiple of 3. It keeps
+ * the range of all three iterations then.
+ */
+#define NUM(by, back, first, off)						\
+	"r3 = " #by " ll; r9 += r3; if w8 == 2 goto 9f; r2 = r9; r3 = " #first " ll; r2 -= r3;" \
+	"r2 += r5; *(u8 *)(r2 + " #off ") = r1; r3 = " #back " ll; r9 += r3; w8 += 1; goto 1b;"
+#define OVER(off)	NUM(100, -97, 0x8000000000000031, off)
+#define FAR(off)	NUM(0x7fffffffffffffff, 0x8000000000000004, 0x7ffffffffffffffa, off)
+
+OK("behind the jump that counts, a number has moved over S64_MAX", "3")
+LOOP(moved_over, "w8 = 0; r5 = r6; r9 = 0x7fffffffffffffcd ll;", OVER(2041))
+
+BAD("behind the jump that counts, a number has moved over S64_MAX, too far")
+LOOP(moved_over_bad, "w8 = 0; r5 = r6; r9 = 0x7fffffffffffffcd ll;", OVER(2045))
+
+OK("behind the jump that counts, a number has moved by S64_MAX", "3")
+LOOP(moved_far, "w8 = 0; r5 = r6; r9 = -5;", FAR(2044))
+
+BAD("behind the jump that counts, a number has moved by S64_MAX, one too far")
+LOOP(moved_far_bad, "w8 = 0; r5 = r6; r9 = -5;", FAR(2045))
+
 OK("a store behind the jump that counts two back edges", "5")
 LOOP(behind_two, "w8 = 0; r9 = r6; r9 += 2044;", AT_TOP(4) "if r7 == 7 goto 1b; goto 1b;")
 

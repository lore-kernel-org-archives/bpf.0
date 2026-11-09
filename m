Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794206845;
	b=TB3BuOxSTqq9oi+yG+H49UtODUOa3OaJ8OfvUGqi/+W0w9IsnGLHtxIxJDf3tK9pm4oq
	 TykizvAMJVtFt3zaauZn0eo2hwqk4DEah1F34mVruajEjLeQtk11koS27mbQNEoaU1eGy
	 n+Y36Tj7kYzWWuiNxrMZPqcgz1qA28M+q69U5d3SOgzuX3KRFqwMmvurLbq+Mwtx4pwsG
	 eNDdoFCS23U0tuDLboe1fBg8znS7OYqa+DTpYryPAYCzzzkg6zr4/ZNzGvfzepy7w4SjO
	 W62JcIhRzFfSwz4kjYc+kaix1sSEv3yKxcGSK0g4+GZ2xUGCECI70n1JFEeFtTIFGuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
	b=IgtRCZX8g0NXHszJyYdW3h5g0S6AXJHA5IhnGhYA1CRp8z58e+Exs6znZmj3qdpN4L76
	 ZJUC9CvAWHQ3IU+B3U0+3Y07m8D8JgoJzO/1cFVidusIBhYYjJ7KeLXti2ermRVoX1nYy
	 vhnS//2mdVMoXCiupqWMTuF5gNGbOdvzmjLV0+xqvXV4PRUzYpVpyPrhO8RH8nSEaeCsX
	 lOORCOxJz8tP97vrp8Hp3VQ6Y3l8L4SlXrqGBN67c0YTtyBdCq4Wyg04n1cQGqelem5Ok
	 r7Xhow4TDc+rybzOcjgehj1DYTEbNn6nvkHAXkILnb7tyCk5Hge0j/lFg8pNUn4dsBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m720QqN8;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B0606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 06:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05B0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m720QqN8
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e977109392so2568935ad.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 22:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206844; x=1794811644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=m720QqN86MaVJW66lxahk5vdzsIOKK6WFYC3i3nPfqTXOLhWX2aifZLWkyDVo2pWaK
         xUh7Roua5y8tOZQss/Qic65bsp0OsxJHWXE3MthBhCfWDts0IdK/JXI7dJv0D9arl/Qi
         uKnZhY1GMIWY0q/Oi+prz0g3Leg01843mFOMDBYXGhEo9ZRsSPU5E9JVbZKeN6WQZVse
         H1Hl3w26yKTxDcATiAli5WEoGSJ6oUXuEQjv9kuMU0Gv02MAi9jr7Wz0W50fwoeMqzAY
         ZsgCAAM4+A5hd8siu1aaoLMyCVMdE4ZBqPlvQEzrsxgPYdp5rvbcxYcMCvj+KZ0eCTNv
         NvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206844; x=1794811644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=1kZI49rW4jJVfFs7f4wyUYHVkXgKSnTjk6MFVWOMbawGnlxut4VJ5M1yBWiPghnLdR
         rVh+1Bn54KBX0abfXkwz1CVtNWEeMfKZectk4nGJFxDv97Va30cpnzA60AIliGnYMG6V
         z5krtTB37gtC2oqnR2gjBi/sW1Zd5mi4Jhjxb3mNIC4SKf27hI7YUwNB+GJ9YRdYyr/E
         zY0XjyF2pnEpxSHNNK/Cc5d1E0fxHLyfncNdl48rvOlcI2z09syx/n1xkiowfqxbTDTc
         1QxoeHZ5PcK2iDkfapTCLZUWtP7yiJjHYbTHsb7yTSIfNLkzzXQchY0CYULCYMZ4NzT2
         IL6A==
X-Gm-Message-State: APuU4Z8mXAeg+7P1DlRS5eSu5mcb90iQF5DwxB+ukUKe1EaATCE4DTiN
	mGQE161bZITZ+uLjVG6dxHSCHpY3jlz51LHpddvjVi6ENheXT1TvwYuMMB6ITA==
X-Gm-Gg: AYBFou1KzMXg027OW3bXIljhnUKH/wB3KZLxfDR1c8tQFJOiHMHMKnMVsry6VN5cuBk
	48bUY8nHrbV2x3MQYXskcnuXllc7zjAH46QwolXU//bH+v1fJ7MY6gZGOmrUU2sPaGhMF1NFyAx
	TT/AlZNs8ahTMxR5II1ov+ScF6epfgiR/RhXXaTgilk9thZpDmswCsP2IYUrbD6IAoXvqukRv6a
	4/bWUoGYJjiEonsF6B1zPt03v0VSMmvaXjIaSrU26kT9zA91Kqgx5shqFWQ5PgJeiZ5n6bs1BQG
	6hxUVIW0YLwr4xE1jhfmAAcbKqpOUaZm2xjIRPShA9zX9a3vzXek5aT0eD68u3u06nGN9P/LHSq
	lu5WfsYR8FK9vsPZHnTmuoa0BAMU+7wpEwEw9qLqgpYbdhSgFrOvBdarNS2FD0ul1/gldkoCjF5
	fCgGa/Zr8Dc+q5aa+NyqpWUBYNfrrOfganx0ZKZ0mQ2TjNIHBkBFdtMu93QRBjSz3tIPSAoRqzG
	M+krNTmTxC0Uf9FJy7ikH04OviDjvmXlMLr0SyruzSdOoj9+p3I+mbPFqkEFPf1ml/8xZ0tmUXp
	3K5RHUAKDhZyGLNTqsRNrMs07JmzX/E1zKXxwaOVqpzUv4ikKxZp7Cyd+o7KS6Msz3Ycgzptcat
	CxiHvJ45PF6tYwepT3B0y6qfgUx7iPsgGT6kruMflbE69O9nXMvfmZzxQoHPLVUytdG6CwpwNpQ
	==
X-Received: by 2002:a17:903:378b:b0:2ed:2776:4e5 with SMTP id d9443c01a7336-2ed83798144mr31291825ad.58.1794206843870;
        Sun, 08 Nov 2026 22:47:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed8146ddd7sm7698945ad.9.2026.11.08.22.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:47:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 01/26] bpf: Keep the 32-bit range across a no-op sign extension
Date: Mon,  9 Nov 2026 06:46:45 +0000
Message-ID: <20261109064715.2382452-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-1-alexei.starovoitov@gmail.com>
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

From: Vineet Gupta <vineet.gupta@linux.dev>

A fix of precision in the main pass. It stands alone in this series. Its
tests come with the tests of sign extensions of linked registers.

	1: w0 &= 63
	2: w0 -= 63
	3: w0 = (s8)w0
	4: if w0 s< 0xffffffc1 goto pc+2
	..
	7: w0 /= 0
	div by zero

w0 is in [-63, 0] before 3. Every value of that range fits in s8, so the
sign extension is a no-op. The verifier drops the range all the same:
after 3 w0 is in [-128, 127], is_branch_taken() cannot tell at 4, and 7 is
verified though that branch is dead.

coerce_subreg_to_size_sx() keeps a range if both bounds have the same bits
above the low 8 or 16 bits. In a range that crosses 0 they differ: all ones
in -63, all zeros in 0. The check before that one is on umax, which is huge
when the range has a negative value.

Return early if the 32-bit range fits in s8 or s16. A register that passed
the check of umax has such a range, so that check goes.
coerce_reg_to_size_sx() does the same in 64 bits since
commit 0892ef2a7ef3 ("bpf: Representation for intervals with steps").

No verdict of the selftests changes.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff574c..5bffc1e288f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6441,14 +6441,28 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
 	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+	s32 field_smin, field_smax;
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
+	if (size == 1) {
+		field_smin = S8_MIN;
+		field_smax = S8_MAX;
+	} else {
+		/* size == 2 */
+		field_smin = S16_MIN;
+		field_smax = S16_MAX;
+	}
+
 	/*
-	 * If value fits the non-negative half of the signed N-bit range,
-	 * sign extension is a noop.
+	 * The range already fits the signed N-bit range, so (sN)v == v for every
+	 * value of the low 32 bits and the sign extension is a no-op.
+	 *
+	 * This has to precede reg_step_reset() below: the base/step line stays.
+	 * It is about all 64 bits: zext_32_to_64() in the caller discards it
+	 * if the upper 32 bits are not zero.
 	 */
-	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
+	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
 		return;
 
 	/* See comment at reg_step_check_unsigned(). */
-- 
2.55.0


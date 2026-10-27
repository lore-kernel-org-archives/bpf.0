Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127885;
	b=t+PEAgAHrQ/RBkHLjafPgZnMUMfBuWIHD01hztvAkH9o/aIhmW/Zqb5hzPmZNqqMMyaO
	 Zsb3Ksvrr69Yp9lsgX+19QmAdk8yJz8kHJ64FtHb+J7NvE4XRs+2MYeammG2s+fi+28pU
	 tMqlBwAnARQXAjLR7xi/9f320xveKDGNcYLzOtUXRJmFsuvWQFmoafYrMcWUZBqvlum8h
	 mBEauLI2uf6QVsz2hi2hba5uW02PF5NdlCAElqQylN3jVWD1Cw7fK/DXNzyCJjsb9EzXY
	 ms+jO/L23i1T8c1OY67RpziboEtsA7qs6Cxhv/rNytpuTq1OqSU7VvRA5a+tBrVsoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2F6pjTKPQlhW5HO8F4BYpSKC6CxKkItQg5MXgowLFmU=;
	b=1626AcH26luRLQ+tcAeLJ7ZlB0u1Z66YPttvG0ezpGw52mhlWJXbVlaDCHJwRvaDtptJ
	 1AWEQ6g16yfk65UbKFWc3uiIlNHZNlR8WtvpKoakDw3U4AmAljEFfRSh98ro2kjaatv3L
	 Y3bMgzccy7b2V0xg+IiH5QmUTvGCZ7Rh2aryXAgB0R3QN9ndsoOSMCcwFFEqroG9uiDtb
	 OZUg6DRckQUFMORbTSeR4d+G/MMLlDrqk0ovNQiVAdK4FBwQrGUh8izy2PqPGTmvFs3io
	 nifOTStT/h9ANH8S2pHrMFk1p9bX35KwpSy43Ucv8S+mgrufjshIkK9NpqUBqekAOlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7SE1NJe;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831D606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E831D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z7SE1NJe
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a60f90a924so101467b3a.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127884; x=1793732684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2F6pjTKPQlhW5HO8F4BYpSKC6CxKkItQg5MXgowLFmU=;
        b=z7SE1NJe0Fj46xugqCKJft/7p9TGyuJd97BW1zlJ3XqugUJZ2yJetQed2bl13OM+uF
         R2ZFncWCngZKE4UKbjhz7eAcgzBvCLlCGkfmiDEjkUgbIyva3sIdxr0qRmpxPhM3sp4J
         lRnQaZAbq/eccmuQoFjH2du2pHmN4iOcYUF92TpLAIyaYwAgWFKYofiyHB2HOIMzWEvt
         gOG4XkJ8ZNOvrtTL2vEfJiuU5PvqreXRQB9pQI+QS+2p3waokP9GOxeE0PPtyQfHPmwc
         162RWpcnIIFj01qObjKAdB6XxegpDd8nTjIMGF0m6eiIavXJk6gQ4fMUSGiJY5hpROHX
         BhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127884; x=1793732684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2F6pjTKPQlhW5HO8F4BYpSKC6CxKkItQg5MXgowLFmU=;
        b=UfMNx0EoOF9zpjVDAU4P+ASB6Ncyah8tQyzct0I0F0TFCRQnCoJi2/RySTIi4HgBIQ
         330vYSlWjk+RIY6fV1NWtubDnMV4ov7ArbGDwW4J//9yWboXJSd3GfEfQe31ue3GoT2Z
         6TSpV8vMwKiQEdybeyWn4eZ1ePeXQ7+tkjITVK6DoHvxmsxGZvS4dg7XfvqDjnoahakm
         dFcTFrj1Y3i134jVNieWGJ1cMymwo5MJtfK3zH06piB9GNe8l0d4nb0mbAFzYNar8DXm
         K64e8asKyGZ7IYf1I0OtqSH1jroN0Q3kBQcvjzgvNe9Q9zvbJ+HfcXFo0kbknZ6Blm8j
         T89Q==
X-Gm-Message-State: AFq9FYJjhg9wjlwag6oAZOPmjGZ+8TkC/CfP6b7DslbajVpOe3UmneQW
	llyR/JvbEy91FtmOpKxKOKJ4Rh9If8yvtWtCydWgzdBHemx0C0LTrvKzwCzd0w==
X-Gm-Gg: AYBFou1TSVT+cpVjhceZpyOUeJQ/qSxhFgmf8nsvrPorbRX7qc8g0BrmzJqPKaciN8j
	e6BpyCz1URkvXhfv7m3B64BOy402+X1FksenoyGEraDY25K70F2uDrzNcEIst//Sm1GKQ6qqBHo
	GzZ/DDWLYLtxgEldK2FFgPon3sbbpOQ0gaTV45jc+uG8n7WJuWZE8+U7WJWQw0xTcxu6Vp7JNvp
	kFrw2VeuPKUDefATt0y9q2EMK6e6YEefvJnC9Od4kVezPZgpE8YM/smzGy3fVKMsNgLF/wSs6IJ
	zxZv5kVmWOP2TMpcWwUKk8963ERNXuJwj54V0lvNiV0aKtQJfnRIGPP5qs+MBcGUFM4gtcdXwmq
	9Paz59TVa21++yZtHEkk1ysKvNfPdw31oJaRXTETadb0ZmaMb1RrAoYhybc0HAJMUGQgCSPFr4A
	+kYLtxkgiqT6lDzHf9n1toMx/JcZX/VdWgc6TvBbzC3WfUXFOsN0U96oduQEdDREM40UFDJUZ1Q
	OKS6owXzn0UjZAcY8qpf2UwHcovOUgxFXwPM+sFDq3tPwNzlAxrNhaS7EJfWfW27UTTm4VDEc3G
	lISrctICNUvbdN4gc9betKVfIDk+HJ0QmlSxif2Fvq+Ye8zm/lyOiehxLMquk8ZM0wjHQ6rCZAt
	erTIGBsbw69Fwa9p5SyepHdxA
X-Received: by 2002:a05:6a20:7346:b0:3e2:b448:ad49 with SMTP id adf61e73a8af0-3e9023e9981mr123448637.68.1793127884113;
        Tue, 27 Oct 2026 12:04:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a73be820sm361093b3a.45.2026.10.27.12.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:04:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 15/19] selftests/bpf: Test the clamp of pointers in scalar evolution
Date: Tue, 27 Oct 2026 19:03:10 +0000
Message-ID: <20261027190314.1440199-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

  test                                    the loop                   result
  --------------------------------------  -------------------------  ------
  clamp_released_pointer                  releases ringbuf memory    reject
  clamp_invalidated_pkt_pointer           calls bpf_skb_pull_data()  reject
  clamp_pkt_pointer_keeps_no_range        compares with pkt_end      reject
  clamp_pkt_pointer_keeps_range_of_entry  has no compare             loads

In the first three tests a flag in a 32-bit spill separates the first
iteration from the second one. Scalar evolution does not widen the flag.
Thus the verifier does not prune the state that returns to the head of the
loop, and it verifies the second iteration with the clamped register.
Without the fixes the three progs load.

In the last test the compare with pkt_end is in front of the loop. Its
range must stay valid in the loop.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_scev.c       | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index cf7916e1fc48..fa01a616af9d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -3773,4 +3773,167 @@ __naked void post_cond_jlt32_copy(void)
 	: __clobber_all);
 }
 
+/*
+ * r6 is a pointer to ringbuf memory with a step of 1. bpf_ringbuf_discard() in the first iteration
+ * makes a number of it. The offsets 0..1 of the pointer are not the range of this number: it's an
+ * address. The flag in the 32-bit spill is not widened, so the second iteration is verified
+ * on its own.
+ */
+SEC("socket")
+__failure __msg("math between map_value pointer and register with unbounded min value")
+__naked void clamp_released_pointer(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u32 *)(r10 - 12) = r1;"
+	"r2 = r10;"
+	"r2 += -12;"
+	"r1 = %[small_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 9f;"
+	"r8 = r0;"
+	"r1 = %[ringbuf] ll;"
+	"r2 = 16;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 9f;"
+	"r6 = r0;"
+	"r7 = r0;"
+	"r9 = 0;"
+	"w1 = 0;"
+	"*(u32 *)(r10 - 8) = r1;"
+"1:"
+	"w4 = *(u32 *)(r10 - 8);"
+	"if w4 == 0 goto 2f;"
+	"r1 = r8;"
+	"r1 += r6;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"goto 3f;"
+"2:"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_ringbuf_discard];"
+"3:"
+	"w4 = 1;"
+	"*(u32 *)(r10 - 8) = r4;"
+	"r6 += 1;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm(bpf_ringbuf_reserve), __imm(bpf_ringbuf_discard),
+	  __imm_addr(small_map), __imm_addr(ringbuf)
+	: __clobber_all);
+}
+
+/* The same with a packet pointer and bpf_skb_pull_data() */
+SEC("tc")
+__failure __msg("math between map_value pointer and register with unbounded min value")
+__naked void clamp_invalidated_pkt_pointer(void)
+{
+	asm volatile (
+	"r7 = r1;"
+	"r1 = 0;"
+	"*(u32 *)(r10 - 12) = r1;"
+	"r2 = r10;"
+	"r2 += -12;"
+	"r1 = %[small_map] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 9f;"
+	"r8 = r0;"
+	"r6 = *(u32 *)(r7 + %[data]);"
+	"r9 = 0;"
+	"w1 = 0;"
+	"*(u32 *)(r10 - 8) = r1;"
+"1:"
+	"w4 = *(u32 *)(r10 - 8);"
+	"if w4 == 0 goto 2f;"
+	"r1 = r8;"
+	"r1 += r6;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"goto 3f;"
+"2:"
+	"r1 = r7;"
+	"r2 = 0;"
+	"call %[bpf_skb_pull_data];"
+"3:"
+	"w4 = 1;"
+	"*(u32 *)(r10 - 8) = r4;"
+	"r6 += 1;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem), __imm(bpf_skb_pull_data), __imm_addr(small_map),
+	  __imm_const(data, offsetof(struct __sk_buff, data))
+	: __clobber_all);
+}
+
+/*
+ * The compare with data_end is for r6 of this iteration: 100 bytes from r6 are in the packet. Then
+ * r6 moves by 100. The range that the compare found is not for the r6 that returns to the head.
+ */
+SEC("tc")
+__failure __msg("invalid access to packet")
+__naked void clamp_pkt_pointer_keeps_no_range(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[data_end]);"
+	"r6 = *(u32 *)(r1 + %[data]);"
+	"r9 = 0;"
+	"w1 = 0;"
+	"*(u32 *)(r10 - 8) = r1;"
+"1:"
+	"w4 = *(u32 *)(r10 - 8);"
+	"if w4 == 0 goto 2f;"
+	/* second iteration: nothing compared this r6 with data_end */
+	"r0 = *(u64 *)(r6 + 56);"
+"2:"
+	"r5 = r6;"
+	"r5 += 100;"
+	"if r5 > r7 goto 9f;"
+	"w4 = 1;"
+	"*(u32 *)(r10 - 8) = r4;"
+	"r6 += 100;"
+	"r9 += 1;"
+	"if r9 < 2 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_const(data, offsetof(struct __sk_buff, data)),
+	  __imm_const(data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+/* A compare in front of the loop is for all iterations: the range at the entry stays */
+SEC("tc")
+__success __retval(0)
+__naked void clamp_pkt_pointer_keeps_range_of_entry(void)
+{
+	asm volatile (
+	"r7 = *(u32 *)(r1 + %[data_end]);"
+	"r6 = *(u32 *)(r1 + %[data]);"
+	"r5 = r6;"
+	"r5 += 40;"
+	"if r5 > r7 goto 9f;"
+	"r9 = 0;"
+"1:"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r6 += 8;"
+	"r9 += 1;"
+	"if r9 < 4 goto 1b;"
+"9:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_const(data, offsetof(struct __sk_buff, data)),
+	  __imm_const(data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.55.0


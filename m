Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800251;
	b=iclvxSvlmUheBrQASOXDcn5r0NdZXI4N8rt9RksuWFHFQNFkNEX3z8evxpL2Go7zXKrS
	 pSuKfFyssMRnLb54Zt8TQpkNJi9WO8byG5Ew5JvtBDNobYhZ4m1AWhnm/wjQ0GHu1G9xv
	 0eb1/5/CO9ArVDUTXL8izJ0FR6BZCd/hBCXqDWHwA5HIfTrxkSLP8iXNfzv3NTssyCr91
	 rxVjXdB+x0Bie0pzbRFf55QiJ7QVVIcBNITDYvfKwxQyvaZozqacSWlvSaWi1J9lGe56D
	 lSY6UuKDgFZKrBdiTUCL06keLbH/wabnhSbNmgkS/vJOol2xPtsNIHsYSqlIOGw7ACQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=wCS5T/2b3NrZp1+b3dn6uTHs4arCEsu5dHbl1PSdqF4=;
	b=xZNak/AflBerTnfbt7u6aQtpwM6YmbHcT1E6ra26iPybUiUX7NR5Z1qzwx7M1w4XJcI+
	 tREE9LUmSUp8CzBDnIy1C7rkcSEfoyNYu/ibkw//OH6Y2F355OT3wGWE84HdH6TC1GNn+
	 mESxwe6fC8Vy+DukhdheJutm3WhHdB+YV7KNBNDuGCItkb6bfsPCZGKXZDt+c7rVfQQyd
	 9XG32qU4HkV7yZcMUhA65qhYs21lM+KFfNyg+qi3rwI08K0bct8IC7TX3fSO5N+l5qu9R
	 fjPD2lXoxOk+km43xYYmflITfG9TPYd0nTuXN1P2uo1nq6VE5ymVNWqFHqLzpYMLRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rFP4xDK6;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B4606A320
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A0B4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rFP4xDK6
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso692038a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800250; x=1793405050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wCS5T/2b3NrZp1+b3dn6uTHs4arCEsu5dHbl1PSdqF4=;
        b=rFP4xDK6F6yKfu5sCyaoltAC0plkcaCaSHCEp7JOq0ZWB/pBrgdEic6YXX/+qBf6Pg
         bpWpsDu89/Gun92YCwDBy0vAE4AA74qN9KcMcqUWqyzrQ051AQeeShptZ0H5nVPPHtQA
         BOeH/cxNaw1uekWijjrGJgIuQarRD1VDt8EsiC+5I3j5zwJIyo1yN91fgy9Q7NpsoeLf
         yxCq1uRphaTP4VwayJ9nsFHatWSrqae2ff+Tzg4vAoVj5UWgkQDhl9O0k8bEPB5jfqP3
         d/8LVhUMcqQvu2ja5qfYppDFftaDjulinwTb4KUFZiCvbHtBPgtELVM8t5QheyzD97Jx
         FH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800250; x=1793405050;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCS5T/2b3NrZp1+b3dn6uTHs4arCEsu5dHbl1PSdqF4=;
        b=dBvrQDjKEPMgwHRtNoKJzuvJKS+Ffxwn3ha+EvFC/Y3XNhE37oQVWxamNafpzaNwKQ
         IcoJWAzgIEx78xacOzK4f2jxhUMtGBoJa5W4yEmLcRH0xOBgalN28gPsT5BftBfbo9M+
         wV8EdRig3AASZVISkiVrmDUQvFr+R02vdtP0HJSe9M9SiZSOzvvW3uTPpebRx7INv6q9
         TrIsdW7MHne02Ot/+YRaJihYjuIMWkmJ/nodBn8AXXcGz7QnjrfoYJjcLFiUK8TUHaVi
         eQNWqA0htt/Nif+2dMiUynv0GO4wTWfwSu1WP78iclOxbhM5Rs0cPL1G4uPezFCzMakS
         Gg1A==
X-Gm-Message-State: AFq9FYI7ip0F8CkABohsmM/QxW5GZcE0/Denavd0m7bFKPQe5Nrq9D1t
	/2DOayDoMFtyk9XW/95MhLmqVe37stybmhTpQkJGbtw1Gr3jsw3Zbfz1aagqseMk
X-Gm-Gg: AYBFou2jnn3wayr/IIJJdrA1mif5YbNxUX5HK3cRIoIoic+o2SIqB9gX7kZY/VcYmT4
	CTaGGPUCxwRiKQEGKpzLKt5CcGsw6EBPxrimAzinuZuuc6+Vo4sDbu9WVuyHCXzpVoeVvWtLPOh
	mXrHSs9GTmeEDtxUrQlIVhxQvSY3+kfo+DldYIlj5BuEdLqGSi9FkihAah3wK+5ffYOYeW+yHUD
	A7vB6ar5AJ8NLJP/zR4K1AY7cm82uvQIL7GH7nkUsRM/M6vt7SGXJlju2BFLVp7ioDICGCh4GI5
	bI4aMu8rRlyY5OizYorWG08i6bdeCaYNfEjPF82IOc7XJmnXy7mq6K2aBtbXLI/jrU7LmmYWYNz
	HbOfr1Z68ZMalQ/zMmONymBoQAp+LDmNDZkyedWwokbx6dO+xWKql8dyYC/+0WTRnLvxB5/7KtZ
	Vr4dyzf2tFdGKV56XGeXaOnIz1AiFZ/nN32Ma4pLl4WN5IsGw+kLD0ZtgBieYXkgPaWKOPvMoJD
	9dTK0k62rXYYAHR2dAFYmZWDT1540189MxfPs76OGd+fHZ3v2QA3V1whXjFFz9O8DzatC4E9nVb
	8oy4EdjVO7/WDKWA2w==
X-Received: by 2002:a17:90b:53cf:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3adeb126f28mr565916a91.65.1792800250084;
        Fri, 23 Oct 2026 17:04:10 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 07/11] selftests/bpf: pointer operands for 32-bit recurrences/latches
Date: Fri, 23 Oct 2026 17:03:49 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-7-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add four tests for pointer operands in 32-bit SCEV analysis.
Check that loop bounds are not inferred for the following program shapes:

     32-bit latch          |    32-bit recurrence
  -------------------------+--------------------------
     r6 = ... pointer ...  |    r6 = ... pointer ...
     r7 = ... pointer ...  |    r7 = ... pointer ...
  l: r6 += 1               | l: w6 += 1
     ...                   |    ...
     if w6 < w7 goto l     |    if r6 < r7 goto l

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_scev.c | 109 ++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
index 96c98443f346..8eeb4d73da98 100644
--- a/tools/testing/selftests/bpf/progs/verifier_scev.c
+++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
@@ -2971,6 +2971,115 @@ __naked void ptr_stack_other_frame(void)
 "	::: __clobber_all);
 }
 
+SEC("xdp")
+__success
+__log_level(2)
+__msg("scev: incompatible latch operands r6 (map_value), r7 (map_value)")
+__msg("loop header at 11, can't compute iterations count at 14")
+__naked void ptr_map_value_jmp32(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	if w6 < w7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__failure
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__msg("R6 32-bit pointer arithmetic prohibited")
+__naked void ptr_map_value_alu32_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	w6 += 1;					\
+	if r6 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 11, can't compute iterations count")
+__naked void ptr_map_value_alu32_latch2(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r6 = r0;					\
+	r7 = r6;					\
+	r7 += 4;					\
+	r9 = 0;						\
+1:"	LIMIT_ITERATIONS				\
+"	r6 += 1;					\
+	w8 = w6;					\
+	if r8 < r7 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
+SEC("xdp")
+__success
+__log_level(2)
+__msg("loop header at 8, can't widen r0, expr is (zext32 (+ r0 1))")
+__naked void ptr_map_value_alu32_non_latch(void)
+{
+	asm volatile ("					\
+	*(u64 *)(r10 - 8) = 0;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[map] ll;					\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto 2f;				\
+	r1 = 0;						\
+1:	r1 += 1;					\
+	w0 = w0;					\
+	w0 += 1;					\
+	if r1 < 4 goto 1b;				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem), __imm_addr(map)
+	: __clobber_all);
+}
+
 /* Metadata and packet data have different origins. */
 SEC("xdp")
 __success

-- 
2.53.0

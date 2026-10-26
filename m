Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984056;
	b=2pfypEhsq9wV3zvTjsVmDNLXSuJpbsaLL0UkpyFwjOiXS3WBmf37+fw3hwPvlf4+xhRP
	 jDZEKmRHVgZ7DhLGqdwManrK6jsMuKjfPK5Tj/JkLTiO38XezAhnp/tH8mDHS4ifUFix/
	 poAdS7wyZwgEigYGPjLtfdvOj1KpfHXYRjCS/1p5F3C68BJW223oHAmY3G9y1vI14hzHj
	 EUlrJUwA/Rl6WFXoxwtc9/1rbynJWcB1ZyEd6d4UAC6/HtpQq2OowrFqOHQogUu48wtwG
	 uyc6vGDgIG5ttIJ4Qk4Q9OsG0mSpReUi1H/QF5il+KZ1wHeQohsiUTDdJg2qR0T4/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=thjbixo9VKbkM0Ooth+VCEPxiUeMKgfxHUkPlT9YMi8=;
	b=3Wpl/lZM02/HKKF+Ve/30qxKO+k9AukTxacyOqgl67+4aHqPeKDS3sKGEy8se9stx9w+
	 +YAFIO5I88xGIirVDGa8EVFRdKXTmlHAZPThvCmd4tBeVKJDYM1msvE3+GXwTn2f478mi
	 s4/dEqzqN8JzogJKnwDTCWaXd3ZLpRK8mN26cU6MT9vQCU8ZbKjGZ4TFZMBcrw1Uxsj3V
	 EK2+JCqbDUGoUg0xLNWSmhR18DwAS7T6hFQwuktxhjvsxfSQjXuiCkw/SJk1nNEN+vJKy
	 Bc1ElWC1Ac+WTdCnBlv+dGrZMxZ7qFEf07M2erMwY5FckS+w18iACEBij6m9fxtORXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ie4W3RN+;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A59606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ie4W3RN+
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so943342b3a.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984055; x=1793588855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thjbixo9VKbkM0Ooth+VCEPxiUeMKgfxHUkPlT9YMi8=;
        b=Ie4W3RN+Jbyo0wbuTlWIcmuM9AaxpIpIPVbYWyIcm+S516fO4/gWFWUAFkvYaFOp3m
         v0VRn5NAiS1bJyg1NTmfXf9cUsIVeS6jZWxe3Drr93slRsL9u+I75gaxxII0eTLy3NwH
         LHbdiEpyKzZQqIwjeiP3yBVwtDWi0MOyv3/U8ZE5UeP8urDQooBzthHDFo+MvbxhhZEA
         1aJKGayB1ohcnxtpI8t+4weAsRPzSWsqmvc8GtL6bWvfM8/nA5N9zOOLo0qVBWNB5IWJ
         hgdccKVxM4cvoHhbHYVCkOnDSi0XD2htPzLMzPSJ4P6hI4EPucOciXYwzAuNYYavn1AY
         cFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984055; x=1793588855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=thjbixo9VKbkM0Ooth+VCEPxiUeMKgfxHUkPlT9YMi8=;
        b=igjwL295abJBp4hPllm8ifIdrAQ0V14TAqvI/SP4DRpTyIaWspiwWPQlbQQqKKD9/f
         Nizmz2+63UA2w8T9gZv731YI43OzdD7WQlzRszNQo1ZS2ctQbNwn4UEKvd1NsHV8jTCf
         C6obsL/W4o6i3CIOTD0cbrwZtC5mcdNSP/42s3/FTJmknbfTXC/DRPqsqLujfjKneigU
         Lrtzz3+pRsi/ozYheWV75lf51XIcebHoCV7Zay8EF7HtTRUR3ACjWp7njBokXvi8SD7k
         ITblXeS3lE+0pnZ0kME/zOMLTpMT/W5+IHvUUuWY7AJ+tJJT5nyBGWbjd9R32nThTJi9
         ZyKw==
X-Gm-Message-State: AFq9FYJSsDoeBNn1zqXzs2FMmdlYTcTQKuFdR4BMnttepYZc6Rb1VAwB
	2Xd+EqjsxIvNWiWUMrR23QIg3jPJP/yPlzwu2ngIqjEox1vFp01WeeClPtffQw==
X-Gm-Gg: AYBFou2HL5lLHEoLLu3cIL9hwVMmScxD4RpXMHdzjUrfisoxKrQyE7JpP4t6G+JOA32
	sGaFa+AZcjUdIAzMqsd++h552fe6527TGlVyl4Pqa1DdUSz6/O7I0skXm7V5lnFXLLxC/g+KQuA
	JupC11BFA2kmzFDr/Y/cLpPejhC3S+/YCwU7LJfOCOnKE26qpW58E3uhu8B6y1v2lvb7KwE3len
	xpJJb+4jqVUT2fplZ1fJnAPPQZ9Rdg39fUhdoZQib1O+GQi/yDFTTidYWOpWsAjKsRTrIl7UATp
	ImgYt6UAInjtvLAOhd0b2gT/M3czdzw2qoypv+5O6ktjlnGxas4qcL0IcOhQWlBxz3fh0Xt4T5M
	MK5w1tEEnf6YmI4QSVQk3t+SoHZkUqidowKmH+1y3KGEt95qPSM0Y8rB7Zuo+o2uKADSdovRtG6
	T6beWxE8iFgieeE5fmCMEGjeEN11VwOqPodc6+UXsD16yfA1tud6ZnCwKVK4M4zjuBX1YYpVqvy
	UehQ0t3LiZwpDAWFmnU+mHCA/M+ByZk61tm1nIKqD8beH6kTQJZL6C4z4TyBPUPkSrMpbyTxcbg
	nkpQ97oSTXGU2cAMPlllAMOCJ62KoNguZssxw3yzT1u1kP2v5PmKpzv4KRBbLPdnHdJV4Z8ZN4Q
	pZ2K0GnFns09qhDAQ+ZSYBoOU
X-Received: by 2002:a05:6a21:200a:b0:3e1:16f8:4a11 with SMTP id adf61e73a8af0-3e7bfc10570mr3090989637.56.1792984055170;
        Sun, 25 Oct 2026 20:07:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a368d867a0sm840408b3a.2.2026.10.25.20.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 80/81] selftests/bpf: Test the stack in arena after recursion ran out of budget
Date: Mon, 26 Oct 2026 02:59:41 +0000
Message-ID: <20261026025943.404450-81-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

A prog can have a second stack in a BPF arena, and r12 is its stack
pointer. A subprog takes its frame with 'r12 += N' as its first insn, and
the verifier adds 'r12 += -N' before each exit. The verifier also adds a
check to the entry of a recursive subprog. When the stack or the number of
calls is used up, the check exits the subprog immediately. This exit gives
the frame back too. Thus the check must come after 'r12 += N'.

  recurses:
    r12 += 32                    ; the subprog takes its frame
    if there is budget goto 1f   ; the check
    r0 = 0
    r12 += -32
    exit
  1:
    ...
    r12 += -32
    exit

With the check before 'r12 += 32', the call that is stopped gives back a
frame that it did not take. Then r12 of the caller is incorrect.

The test recurses until the check stops it. After the call, r12 of the
caller and the value that the caller stored in its frame must be the same
as before.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_arena_stack.c          | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
index 79a4552f1a93..9eafdf032a27 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -213,6 +213,54 @@ __naked void helper(void)
 	: __clobber_all);
 }
 
+static __naked __noinline __used long recurses(long n)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[stx32];"
+	".8byte %[stx8];"
+	"if r1 == 0 goto 1f;"
+	"r1 += -1;"
+	"call recurses;"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(32)),
+	  __imm_insn(stx32, STX(BPF_DW, -32, BPF_REG_1)),
+	  __imm_insn(stx8, STX(BPF_DW, -8, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: r12 after the recursion ran out of budget")
+__success __retval(0)
+__naked void recursion(void)
+{
+	asm volatile (
+	".8byte %[adj];"
+	".8byte %[st];"		/* *(u64 *)(r12 - 8) = 4660 */
+	".8byte %[mov6];"	/* r6 = r12 */
+	"r1 = 100000;"
+	"call recurses;"
+	".8byte %[mov7];"	/* r7 = r12 */
+	"r0 = 1;"
+	"if r6 != r7 goto 1f;"
+	"r0 = 2;"
+	".8byte %[ldx];"	/* r1 = *(u64 *)(r12 - 8) */
+	"if r1 != 4660 goto 1f;"
+	"r0 = 0;"
+"1:"
+	"exit;"
+	:
+	: __imm_insn(adj, ADJ(16)),
+	  __imm_insn(st, ST(BPF_DW, -8, 4660)),
+	  __imm_insn(mov6, MOV(BPF_REG_6)),
+	  __imm_insn(mov7, MOV(BPF_REG_7)),
+	  __imm_insn(ldx, LDX(BPF_DW, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
 static __naked __noinline __used long store_through(long addr)
 {
 	asm volatile (
-- 
2.55.0


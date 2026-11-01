Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494034;
	b=ZzffSSRn8aRJEfbqm5LyDQiCjFh8KC1d7R4ko3ZDGhpmVlgu++9OfNPE1IX2I1sK7HdL
	 7AstANfVCFgwC6Bng5foAH67dDUEXvmgeaKr/wvY2tq83y0UyGSOqSrrZpYP0CsYuOdoA
	 VAhYChAP4oubS6wrRXC/+lYkC41I6zTxxeH2hjRcFcwh6luzUg3n6DmbUefq+7fwb/5cX
	 9GFN+vgnKvZmPFUv19sOtxgmZg2eMn35MXNXUIcxJ7Hwo0gFvzNYXnriP9I4+qLx/cALW
	 A+uZKy8hTrmsgpm+JtZdRHxGY+F4xKdDJVW46qlMRQGRqpciLNZMxYoRtwjRZyC8ojg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EvABP5HmRpAFtlptkIT9RhfhkdzvHFpexkpFablsesc=;
	b=WVl335IQDk7ytaxOn/rlrGktepM/AUrZnSGqN+x6KNn371cYZ6eYlURt5fUmeEYHR+ez
	 Og+lof9S/09R4R+2tCjJ7wm/vS+QSeMMl0M7EJAd/h+yZThSwxPo0Edqw6niJQBukhQrR
	 9Olj+urw5GgZlyrKVP48oY6HsdM0NsxbdNul1Zuthe/oBGyhx7afVBJ7BCqGcEjFtn6Sd
	 94OJQ0bIC0T9eHv4QxK/EiyXiDcA5LBZqjFSa73geGfJqLok2e7W5PzJ8xxxZs8SAtMt1
	 L2HFq7wjv0xJoy8LuYyA5Y80YPqLFnqBH2AeZisP25H/vznLsN4CutK9W33mKbnFEIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DdEaOeC4;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62645606A31C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62645606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DdEaOeC4
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso11601875ad.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494034; x=1794098834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EvABP5HmRpAFtlptkIT9RhfhkdzvHFpexkpFablsesc=;
        b=DdEaOeC4sDzA2LKdcBG8daUcSdeKDi5i1p/ZasgGi5lI935IM+Bl6hnV+5eEnAri6S
         cAslIs/Qdp3WMnn3dp4AYl1LI7UJoZ2ViHDlOU9k70XpdnXzIS63WZu2WeOsxrIP2pgX
         /P3Wyn+JZUtzRADU8HJaLuULhoX+M5q3ZG73IOatd+UgFgK70GifDpFd5msyjRL7weFS
         JIdVVHvfG7dOISc39vDhoyGcMKuyU8f/qVBo+J5kF7W7ZRmtoYeC1KsRoJM+VLP+iG8k
         GEu7z7iwBDAYdld5yU7xDBU8Zd+2exMNRT4ldC0aiNx+gT/kxpLLx4WoD0oOtTfy3wbf
         urbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494034; x=1794098834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EvABP5HmRpAFtlptkIT9RhfhkdzvHFpexkpFablsesc=;
        b=TA78Zj3+Q7BI8pUW1NQIJ82hBKmeERkLOUOV5nSyIxSXD2EchgCJ/+YDH8YgFjIubX
         k8AXEJhkDrDTUwp5ON3S1OFe4+xOQrr5/cszUzILIUAEQCBwabhRhF9jXQaWl0vtkueo
         PTE+k8K39SzsyDZIDSBHJNRYuf6c+wWZrJ/ZAdPRiCNX7E0a8w4uJpuC52d4OKF4jjm8
         6OSk5TNjs7Tw3vxGqbntpEpRNFwsCqklJuzoLNqTzcMr4KZhSD0N4EoQKbFUHXF1JmAn
         qlLPkvTCTRfnb89gxMmXfKKKBbxV5/6ZjDZcnHcM2Iz/MmoQrVZ65VDxjGUN6OMRroVY
         e4Sw==
X-Gm-Message-State: AFq9FYLAsQK4rDwxRIscGYFLcYOXLd2enIqGsphmXsiuwePwhTwaagmU
	92G+HVBGNeXB4yRnhufu30JKIcM1xZJ7v3+CKjkQkP1zJ7Zr2hwPgilmVtZg7g==
X-Gm-Gg: AYBFou0qg5mOF23YhbEmH5BsJ/QyEJNi45P6oeFn4jBL6yEmjITgOih6jufgl42UhqY
	YEDtfXWRZF9vpqbQQTQaH7fFiLxzKMs77N40Gd4YNPAXSoTrdRBuPQlLHCP4jlJNKZVX3UMeVWM
	/7OGNn4Pu0LtqBoi3paY2/h46vPi+btQVR4wSSiu+tiG6CtAajEx20BRz77B9LjOckyr0zNr75A
	GxAriw3+hTS0NMCsLM09hR/zz/3u7cAzXjMYFcGo0wHQ39wKSA1BrC6isqaT+h8YkRQiR0cJlRl
	BxSgk0MJSN/UwQ7UrIHsEzj4MLlk4dT0WlXDopLM5od6ttqrPgEM+UZJiUo29ozoesHicACE2V6
	Vl5H7Ye00oZYCxq+JIZUNaVDCHGGQMkt3+RtmZKK90KuGFZ9lmb9sciY+6a8MntiFAHhh2MRtGx
	3++3AC4Izc5Dmnd2eGkS+rsO4Yb3NxNOZyu8Evsr8Wn4/OIsooRoH5G/EWOnpOINzMZhp/zqEPC
	JMjU1yjsTawDIFHcfPaOnbksFGFK+ZYwuiusAihVrgeNMQGVGhD1NARKGDjz0/OSdwNpjg2o0h1
	FDNINueZOuMHfoNm8uVFyHoOwQ9Kmc5LDgLqb/Hqy7PnIrqZcZvwPy0I+QJ5v1MtjMjOPEUbxXr
	eUgJI4SGBSgWaALCza+3Jo5xTd2/HoYZAQ4XQdZjgMV77XMV8wInr27eta+vXAnF0jMCbYTzpZL
	RjldNBr/7CovkTO1I/vGM=
X-Received: by 2002:a05:6a21:8cc3:b0:3e1:bfb9:55f1 with SMTP id adf61e73a8af0-3e928dd8d5fmr5420785637.53.1793494033386;
        Sat, 31 Oct 2026 17:47:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm1876265a12.24.2026.10.31.17.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 17:47:13 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test a callee that overwrites a spilled pointer of its caller
Date: Sun,  1 Nov 2026 00:46:56 +0000
Message-ID: <20261101004657.3406576-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101004657.3406576-1-alexei.starovoitov@gmail.com>
References: <20261101004657.3406576-1-alexei.starovoitov@gmail.com>
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

The caller spills &fp[-8] to fp-16 and passes a pointer to its frame to
a callee, which can store a pointer to a map value to fp-16. The caller
fills fp-16 and stores through it. That store is not a certain write to
fp-8.

Five valid progs read fp-8 after the store. The callee is a static subprog,
a static subprog that gets a pointer to another slot, a callback of
bpf_loop(), the target of callx, and a function in C that moves a cursor.
Without the fix they fail with:

  reading from stack off -8+0 size 8, slot poisoned by dead code elimination

In callee_overwrites_spilled_fp_hidden_store the store hides a write to the
counter of a loop. Without the fix the prog loads, and it accesses a map
value out of bounds.

one_fp_clear_stack_threshold and two_fp_clear_stack_threshold expect the
fake offset fp+0 in the log now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/verifier_callx.c      |  46 ++++
 .../selftests/bpf/progs/verifier_live_stack.c | 230 +++++++++++++++++-
 2 files changed, 272 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 7e59188d9fca..b2d7659207ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -289,6 +289,52 @@ __naked void callx_callee_writes_caller_stack(void)
 		: __clobber_all);
 }
 
+__naked __noinline __used
+static unsigned long store_second_param(void)
+{
+	asm volatile (
+		"*(u64 *)(r1 + 0) = r2;"
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/*
+ * fp-16 holds &fp[-8], and the callee stores a pointer to map value over it. The store through
+ * the filled pointer is not a certain write to fp-8: fp-8 is live in front of the store.
+ */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callx_callee_overwrites_spilled_fp(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 8) = 0;"
+		"r1 = %[map_array] ll;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"*(u64 *)(r10 - 16) = r1;"
+		"r1 = r10;"
+		"r1 += -16;"
+		"r2 = r0;"
+		"r3 = %[store_second_param] ll;"
+		"callx r3;"
+		"r1 = *(u64 *)(r10 - 16);"
+		"*(u64 *)(r1 + 0) = 42;"
+		"r0 = *(u64 *)(r10 - 8);"
+	"1:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_array),
+		  __imm_addr(store_second_param)
+		: __clobber_all);
+}
+
 SEC("socket")
 __failure __msg("R1 has type scalar, expected func")
 __naked void callx_scalar(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 1fc9984e8e22..ff7c723820a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -1972,11 +1972,15 @@ static __used __naked void grandchild_deref(void)
 	::: __clobber_all);
 }
 
+/*
+ * The callee gets a pointer to the frame that holds the spills. It can store a pointer
+ * that is not FP-derived over them: after the call each of them is "fp-N or not FP-derived".
+ */
 SEC("socket")
 __log_level(2)
 __success
-__msg("14: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
-__msg("15: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16 r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
+__msg("14: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0 fp-16=fp0-8|fp0+0")
+__msg("15: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16|fp1+0 r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0")
 __msg("stack use/def subprog#1 mid_two_fp_threshold (d1,cs2):")
 __msg("14: (79) r1 = *(u64 *)(r10 -8)        ; use: fp1-8")
 __msg("15: (79) r0 = *(u64 *)(r1 +0)         ; use: fp1-16")
@@ -2021,8 +2025,8 @@ static __used __naked void inner_nop_fptest(void)
 SEC("socket")
 __log_level(2)
 __success
-__msg("13: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
-__msg("14: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16 r6=fp0-8 r7=fp1-16 fp-8=fp1-16 fp-16=fp0-8")
+__msg("13: (79) r1 = *(u64 *)(r10 -8) // r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0 fp-16=fp0-8|fp0+0")
+__msg("14: (79) r0 = *(u64 *)(r1 +0) // r1=fp1-16|fp1+0 r6=fp0-8 r7=fp1-16 fp-8=fp1-16|fp1+0")
 __msg("stack use/def subprog#1 mid_one_fp_threshold (d1,cs2):")
 __msg("13: (79) r1 = *(u64 *)(r10 -8)        ; use: fp1-8")
 __msg("14: (79) r0 = *(u64 *)(r1 +0)         ; use: fp1-16")
@@ -3473,3 +3477,221 @@ __naked void helper_bloom_peek_input(void)
 	:: __imm_addr(bloom_8b), __imm(bpf_map_peek_elem)
 	: __clobber_all);
 }
+
+static __used __naked void store_second_param(void)
+{
+	asm volatile (
+	"*(u64 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * fp-16 holds &fp[-8], and the callee stores a pointer to map value over it. The store through
+ * the filled pointer goes to the map value. It is not a certain write to fp-8: fp-8 is live
+ * in front of the store.
+ */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_STATE_FREQ)
+__log_level(2)
+__msg("r1 = *(u64 *)(r10 -16) // fp-16=fp0-8|fp0+0")
+__msg("*(u64 *)(r1 +0) = 42{{ +}}; may_def: fp0-8")
+__naked void callee_overwrites_spilled_fp(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[array_map_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = r0;"
+	"call store_second_param;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 + 0) = 42;"
+	"r0 = *(u64 *)(r10 - 8);"
+"1:"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(array_map_8b)
+	: __clobber_all);
+}
+
+static __used __naked void store_second_param_at_16(void)
+{
+	asm volatile (
+	"*(u64 *)(r1 + 16) = r2;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The same, but the callee gets &fp[-32] and reaches fp-16 from it. */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callee_overwrites_spilled_fp_in_other_slot(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[array_map_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r1 = r10;"
+	"r1 += -32;"
+	"r2 = r0;"
+	"call store_second_param_at_16;"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 + 0) = 42;"
+	"r0 = *(u64 *)(r10 - 8);"
+"1:"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(array_map_8b)
+	: __clobber_all);
+}
+
+/* ctx[1] = ctx[0] */
+static __used __naked void cb_copy_first_to_second(void)
+{
+	asm volatile (
+	"r1 = *(u64 *)(r2 + 0);"
+	"*(u64 *)(r2 + 8) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The same, but a callback of bpf_loop() overwrites fp-16. */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callback_overwrites_spilled_fp(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[array_map_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 1f;"
+	"*(u64 *)(r10 - 24) = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r1 = 1;"
+	"r2 = %[cb_copy_first_to_second] ll;"
+	"r3 = r10;"
+	"r3 += -24;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"*(u64 *)(r1 + 0) = 42;"
+	"r0 = *(u64 *)(r10 - 8);"
+"1:"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm(bpf_loop),
+	  __imm_addr(array_map_8b),
+	  __imm_addr(cb_copy_first_to_second)
+	: __clobber_all);
+}
+
+/*
+ * r7 is a pointer to map value, as above. The store through r7 doesn't overwrite fp-8:
+ * fp-8 still holds &fp[-24], and the store through r8 changes the counter of the loop.
+ */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void callee_overwrites_spilled_fp_hidden_store(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[array_map_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r9 = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = r9;"
+	"call store_second_param;"
+	"r7 = *(u64 *)(r10 - 16);"
+	"r1 = r10;"
+	"r1 += -24;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r0 = 0;"
+	"*(u64 *)(r7 + 0) = r0;"
+	"r8 = *(u64 *)(r10 - 8);"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r6 = 0;"
+"1:"
+	"r1 = *(u64 *)(r10 - 24);"
+	"r2 = r9;"
+	"r2 += r1;"
+	"r0 = *(u8 *)(r2 + 0);"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 24) = r1;"
+	"r3 = 4096;"
+	"*(u64 *)(r8 + 0) = r3;"
+	"r6 += 1;"
+	"if r6 < 8 goto 1b;"
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(array_map_8b)
+	: __clobber_all);
+}
+
+struct cursor {
+	__u64 *pos;
+};
+
+__u64 cursor_seed;
+
+static __noinline int move_cursor(struct cursor *c, __u64 *to)
+{
+	if (cursor_seed & 8)
+		c->pos = to;
+	return 0;
+}
+
+/* The same in C: a cursor starts at a local variable, and the callee can move it to a map value. */
+SEC("socket")
+__success __retval(1)
+int callee_moves_cursor(void *ctx)
+{
+	__u64 x = cursor_seed & 7;
+	struct cursor c = { .pos = &x };
+	__u32 key = 0;
+	__u64 *val;
+
+	val = bpf_map_lookup_elem(&array_map_8b, &key);
+	if (!val)
+		return 0;
+	move_cursor(&c, val);
+	*c.pos = 1;
+	return x;
+}
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829372;
	b=H88qTgV55aN6gdjW/PDLoFZ+KqreXNV7Umrx51uHBCE6h4aPAWeTcxtlVdpzaVr9a06y
	 aZbAJABJK7PT6r3n6o/izrm5STSc6CQ2SCkSBHFWSC5g2G04BmY2JOoAq0V6u7AKjZWk9
	 XC8U9rg7uOUULtSTuBLnFbSt1jQZYk0JjSKK9Dtd4Mor8Kz/ckM/ALzjSMGrg+QncJ94X
	 R/P83HeGhDDMwsGViBNHPOeP9mfdgOVykgmb8u9CHrQiGbEEKnS3xPLZ4F5FEeybvWwf0
	 XNuSydgusLMhpkqyLX7dkIaFECOZCL1QbIlYJhcnb0M327pfZcDzaWlSO5hZzC1Zmiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jo+Zw9Nbq0mbPrKoSCRf5CUgy1nVsLyYn746GJsPu+U=;
	b=dgm0NU4pmwFUTjZr/4r9Lcil7TV9hVpUS7HsfUXwRgt7uH501j2AJF9Lm6FChuBiR/D7
	 ApZAhJFwj5GKm9fkvInHu0RJajfagX0pd7WUNYKiFdjQi7crn1B6uwhDe60VI8Ycek6tF
	 oU49DejqxkV+RYAX3K4ay7LpCzRrRugYdwWtptbnM9JiXqzeh7Cq5zWE3jdpBkNVE7fo4
	 Fkqxvjo7yin6xPUoAgQtWh3uBbme/5o8JE+qsRI8LkiGk56ueunedRA+7wKH5c93DCd0J
	 RFrkOln7zf7cHvZ9+a1195ob3MISaRs7auQiJVVm+Oy+lKBuNnT3V2Vz59B//o0IJ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W/RjnGfW";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2F960BF2EF
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2F960BF2EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W/RjnGfW
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-886e61fa30fso588227b3a.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793829371; x=1794434171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jo+Zw9Nbq0mbPrKoSCRf5CUgy1nVsLyYn746GJsPu+U=;
        b=W/RjnGfWV/aI02yIzXVNOnlcc2E4E7HirlAglCAJVO1IWV+v3Ghhg979l8RZTA6VlW
         0DjkfO0Sku7Y3tl1QMFV3hL3k+XeRmhl5Cixp4mOzYQy6POkuLQdTEFDA0eIBs0F2gkg
         lJknfC4hqZNYfKtvYrUYV1bwMq4oiBZdHb3nVoWBCQu0srv2lkq53CTwEgyfvmkycHv6
         G/u4v4SkWxv58wpg/yFRl1u79C3XMO8pity+ir7+7SzDq0jI/Jyva1LTx0+cNCIYuxCW
         wSw/WuZnYGEibpuCP8APFLvl2UMweIB61pd2OYJ/NAmrOn4tZNyC34J02bynxOPS3qrE
         ZA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793829371; x=1794434171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jo+Zw9Nbq0mbPrKoSCRf5CUgy1nVsLyYn746GJsPu+U=;
        b=YwB2Vbn+WvlsTK6M7y+H3A1mpNQBa6Eo5KyY4w8GGLwZ7efJrIajM2Y4xSVLKeNpz4
         yO1vMeNDmCl/PHgFIuIqg99mcD6uf5Sn9k2LAXjjePUd2WOkXAYpwGtpl7kZcivWUN+C
         TnR9mcDtr6l5sw5pp5XgJBfrAe94YVLmWPjWl2XVOdQZwWUIeGqQP85ZYS/bX6+n6d4O
         Sckh1JQnq6KduqWBn83VDOyhq/DpFerVsxUCZlc1onoSQBldyuskPPI+y8ge74zDm/kT
         qNgRwC6M5MAjqLLGhBUoerpmPgvWu96t3aRCafp3nA5XnjU+eoc9l4+WBrFEFyNEKdZq
         t7FA==
X-Gm-Message-State: APuU4Z+Qd39YL6ihBZ0Rkx9BY1YdhW2ciEalXDo6eUJV5xeGEtWQJEcg
	dDOJco0janJS4DvKrJs5XCdXFXFqfieWV088SjlbfjPqYHp5PyMZBxi22RKnjg==
X-Gm-Gg: AYBFou3tvZW//bFJG11jAxIQCm+oomLk8t+wVh/lQO3wbVcj4tsJXm2AeI14G8xLREA
	gw0a13vkxyFv5h+fENEXEmd6Vg0hPvchAY/zasMkTSd6/aBP7qZbe/9KWnc8oxroK9IeXDBZgkf
	WlS47RdUijP338bMkFQrvizHrHgbgOPueAhzx44JVQFtQW7g1gccYO7/loPEmIjCiKuiXD3DE3g
	1TMYx1GuQFK/uotVw4U9gsBQXj2ijQhWzWF12utmEGrTYiI2WVvLYF+px763RZ1nh/L9vbUA1T3
	6iXPirBNeE9ODk7UdAtx64HJ96FUeIdu2GVbrW4Sxu8szj4g5xY1BiN6D6wIT290yj858sM8PQk
	sWMe0nVM0lJnOv7wAo5XlI1DRCDfhrmQPbxdcRged1hhoLdkWeeRknLhoSs0K4kW2et6eHfXci+
	pRDWLyK47+Vy9RkLFpRj50s2KM/LjNH6jtHOD7iLpEXNfUQIoVtKQcWxR9VdeLXCRHf2pAxWgZ+
	CPdbZ/Pyz4xphAPRrrHlcY8eXFQi/VWmXuM/R+7oEtLcjHAefgHkTsuDHnRvlRYJgJwrfPAwRbC
	DUQD1TVqIwsmIzlFJhGdMkQy/Ia6FcHxOTEede6cN/C5exKHeoMzAh8coZLJju3Y/y+7Er3Dok6
	WJciEh0pIPWw2Jtdn+uoZyS6WGozC1s1r/IbaMLh0yOtdWvhD1C7dwp+nxJSvQpQNSU+jvanMPA
	==
X-Received: by 2002:a05:6a00:a0e:b0:898:efb4:ec4 with SMTP id d2e1a72fcca58-8a9bffd508bmr13249666b3a.55.1793829370725;
        Wed, 04 Nov 2026 13:56:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b66155dsm1339589b3a.42.2026.11.04.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:56:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 7/9] selftests/bpf: Test what follows from the chains of calls
Date: Wed,  4 Nov 2026 21:55:21 +0000
Message-ID: <20261104215523.1852636-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
References: <20261104215523.1852636-1-alexei.starovoitov@gmail.com>
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

Add a prog with 32 global functions that call the next one in both branches
of an 'if'. It has 2^32 chains of calls, and its load took 7 minutes. Add
a prog with a tail call in an exception callback that calls nothing. It was
accepted.

The other tests pass before and after the change. No test looked at these
rules: the number of frames and the bytes of the stack in arena when the
second caller has the longer chain, which frame is reported when libbpf
puts a callee in front of its caller, stack arguments two calls above
a tail call, no private stack for a subprog with stack arguments, and which
of two nested callbacks takes a stack in arena.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/test_global_func_deep_stack.c   | 49 ++++++++++++
 .../bpf/progs/verifier_arena_stack.c          | 61 +++++++++++++++
 .../bpf/progs/verifier_large_stack.c          | 17 ++++
 .../bpf/progs/verifier_private_stack.c        | 40 ++++++++++
 .../selftests/bpf/progs/verifier_tailcall.c   | 78 +++++++++++++++++++
 5 files changed, 245 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
index edb8a223a3cb..3a852809b078 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -92,6 +92,55 @@ int XCAT(f, n)(unsigned long a)                  \
 
 F(37)
 
+#define ASM_FUNC(linkage, name, insns)					\
+linkage __naked __noinline __used int name(void)			\
+{									\
+	asm volatile (insns "r0 = 0; exit;"				\
+		      :: __imm(bpf_get_prandom_u32) : __clobber_all);	\
+}
+
+/*
+ * Every function calls the next one in both branches of an 'if': 32 calls are
+ * executed, and there are 2^32 chains of calls.
+ */
+#undef F_0
+#undef FN
+#define F_0 ASM_FUNC(, either0, "")
+#define FN(n, prev)							\
+	ASM_FUNC(, either##n,						\
+		 "call %[bpf_get_prandom_u32];"				\
+		 "if r0 == 0 goto +2;"					\
+		 "call either" #prev ";"				\
+		 "goto +1;"						\
+		 "call either" #prev ";")
+F(32)
+
+SEC("syscall")
+__success
+__load_if_JITed()
+int global_func_many_chains(void *ctx)
+{
+	return either32();
+}
+
+/*
+ * r1 is the number of calls that follow, so main -> fs7 .. fs0 and main -> fs15 .. fs8
+ * are executed: 9 frames each. main -> fs15 .. fs0 is in the call graph: 17 frames.
+ * libbpf puts fs7() .. fs0() in front of their second caller fs8().
+ */
+#undef F_0
+#undef FN
+#define F_0 ASM_FUNC(static, fs0, "")
+#define FN(n, prev) ASM_FUNC(static, fs##n, "if r1 == 0 goto +2; r1 += -1; call fs" #prev ";")
+F(15)
+
+SEC("syscall")
+__failure __msg("the call stack of 16 frames is too deep !")
+__naked int static_func_deep_stack_second_caller(void)
+{
+	asm volatile ("r1 = 7; call fs7; r1 = 7; call fs15; exit;" ::: __clobber_all);
+}
+
 /* Ensure that even 32 levels deep, the function verifies. */
 SEC("syscall")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
index a23ab1ed2f96..1d676da4b5ea 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_stack.c
@@ -745,6 +745,65 @@ __naked void callback_names_backward(void)
 	: __clobber_all);
 }
 
+/* adds 10 to what the context points to. callee_with_frame() is two calls away */
+static __naked __noinline __used long far_from_r12_cb(void)
+{
+	asm volatile (
+	"r6 = r2;"
+	"call callee_in_the_middle;"
+	"r1 = *(u64 *)(r6 + 0);"
+	"r1 += r0;"
+	"*(u64 *)(r6 + 0) = r1;"
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __naked __noinline __used long loops_far_from_r12_cb(void)
+{
+	asm volatile (
+	"r3 = r2;"
+	"r1 = 2;"
+	"r2 = far_from_r12_cb ll;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena stack: the callback that is next to r12 takes a stack")
+__success __retval(60)
+__load_if_JITed()
+/* the end of the main program, the first insn of loops_far_from_r12_cb() */
+__xlated("r0 = r6")
+__xlated("exit")
+__xlated("r3 = r2")
+__xlated("...")
+/* the end of the code that takes a stack, the first insn of far_from_r12_cb() */
+__xlated("r12 = *(u32 *)(r{{[0-9]}} +8)")
+__xlated("r6 = r2")
+__naked void callback_in_callback(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = 3;"
+	"r2 = loops_far_from_r12_cb ll;"
+	"r3 = r10;"
+	"r3 += -8;"
+	"r4 = 0;"
+	"call %[bpf_loop];"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm(bpf_loop)
+	: __clobber_all);
+}
+
 SEC("syscall")
 __description("arena stack: call of a callback that uses r12")
 __failure __msg("loop_cb() uses R12 and is both called and a callback")
@@ -1009,10 +1068,12 @@ __naked void depth_max(void)
 SEC("syscall")
 __description("arena stack: more than 32K")
 __failure __msg("combined size of the frames in the stack in arena is 32784. Too large")
+/* frame_16() has two callers. The one that has more in the stack in arena counts */
 __naked void depth_too_large(void)
 {
 	asm volatile (
 	".8byte %[adj];"
+	"call frame_16;"
 	"call frame_16k_calls_16;"
 	"exit;"
 	:
diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
index c2a3ddf5ac91..7e4f5e3463a2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_large_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
@@ -112,6 +112,23 @@ __naked void five_frames_of_512(void)
 "	::: __clobber_all);
 }
 
+/* libbpf puts frame_512_leaf() in front of frame_512_depth_2(), which goes over the budget */
+SEC("socket")
+__description("the frame that exceeds the 2 KiB budget is reported, not its callee")
+__load_if_large_stack()
+__failure __msg("combined stack size of 3 calls is 2064. Too large")
+__naked void callee_in_front_of_caller(void)
+{
+	asm volatile ("					\
+	r1 = 5;						\
+	*(u64 *)(r10 - 1040) = r1;			\
+	call frame_512_leaf;				\
+	call frame_512_depth_3;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 __used __naked
 static void frame_1536_leaf(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bbc09f516d92..aa15361bcca5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -70,6 +70,46 @@ __naked void no_private_stack_nested(void)
 "	::: __clobber_all);
 }
 
+#ifdef __BPF_FEATURE_STACK_ARGUMENT
+__used
+__naked static long subprog_6args(long a, long b, long c, long d, long e, long f)
+{
+	asm volatile ("			\
+	r0 = *(u64 *)(r11 + 8);		\
+	*(u64 *)(r10 - 64) = r0;	\
+	exit;				\
+"	::: __clobber_all);
+}
+
+/* x86-64 has one register for the private stack and for the sixth argument */
+SEC("raw_tp")
+__description("No private stack, stack arguments")
+__success
+__load_if_JITed()
+__arch_x86_64
+__log_level(4) __msg("stack depth max 128")
+__naked void no_private_stack_stack_args(void)
+{
+	asm volatile ("			\
+	r1 = 42;			\
+	*(u64 *)(r10 - 64) = r1;	\
+	*(u64 *)(r11 - 8) = r1;		\
+	call subprog_6args;		\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+#else
+SEC("raw_tp")
+__description("No private stack, stack arguments")
+__skip("stack_arg is not supported by compiler")
+__success
+int no_private_stack_stack_args(void)
+{
+	return 0;
+}
+#endif
+
 __used
 __naked static void cumulative_stack_depth_subprog(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall.c b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
index 51687da97225..42b90b692dc5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall.c
@@ -50,6 +50,84 @@ static int subprog_tail_call(void)
 	: __clobber_all);
 }
 
+/* The exception callback has no ctx, so its tail call can only be dead code */
+__used __noinline
+int exception_cb_tail_call(__u64 cookie)
+{
+	asm volatile ("			\
+	r0 = 0;				\
+	if r0 == 0 goto +4;		\
+	r2 = %[jmp_table] ll;		\
+	r3 = 0;				\
+	call %[bpf_tail_call];		\
+"	:
+	: __imm(bpf_tail_call),
+	  __imm_addr(jmp_table)
+	: __clobber_common);
+	return 0;
+}
+
+SEC("tc")
+__description("tail call in an async callback that calls nothing")
+__failure __msg("cannot tail call within callback")
+__attribute__((btf_decl_tag("exception_callback:exception_cb_tail_call")))
+__naked void tail_call_in_async_callback(void)
+{
+	asm volatile ("			\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
+
+__used __noinline
+static long subprog_6args(long a, long b, long c, long d, long e, long f)
+{
+	return f;
+}
+
+__used __naked
+static int calls_subprog_tail_call(void)
+{
+	asm volatile ("			\
+	call subprog_tail_call;		\
+	exit;				\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack arguments two calls above a tail call")
+__failure __msg("tail_calls are not allowed in programs with stack args")
+__load_if_JITed()
+__naked void stack_args_above_tail_call(void)
+{
+	asm volatile ("			\
+	r6 = r1;			\
+	*(u64 *)(r11 - 8) = 6;		\
+	call subprog_6args;		\
+	r1 = r6;			\
+	call calls_subprog_tail_call;	\
+	r0 = 0;				\
+	exit;				\
+"	::: __clobber_all);
+}
+
+#else
+
+SEC("tc")
+__description("stack arguments two calls above a tail call")
+__skip("stack_arg is not supported by compiler or jit")
+__success
+int stack_args_above_tail_call(void)
+{
+	return 0;
+}
+
+#endif
+
 /*
  * A tail call unwinds only the frame of the subprog doing it, so the
  * frames of its callers stay on the stack. With up to 33 tail calls in
-- 
2.55.0


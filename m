Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984062;
	b=j71xzj5MmbabIVXekx7QHnaJkEGF48dGpjEtWWFH1DvnJD1a9CAmIiAOWtG1r3xBPNwR
	 nUlqj1YyC4h1r9HqiX6kalQUoSAuw+f+sothfbyZf19ae9Ppx3Fq9yk5rCM3Ih3xMQ2fc
	 RxcEEZ5Fi9W8LgjfYINZk5pTxVGnryFMauMm7Xh9Z3Gur5Z6qquZK+1QZgP4kk9HPFCY8
	 2+zqg6/JfaJVSKDjm9WGbFOdQ8D8gHE9P/+oHxJ33IonczapLlvRlrfqGtE0wmRsC/ZGF
	 s4a0pAa9dUWCKNNwXNGLgJ2Ulcpca5VTIZJCYWHorMQCiAFZ38lWN9Cp0F9Bv5e/uDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mUaC2nBwlRz6CLsNn8h/VtsmMRJkQZiqypod4sMRqmU=;
	b=ROzBlrpJKgdXTgP7z/2Oa1zyTsRoao9LF/jVCvf3Q3fNUbAZPf42jq4zmjlEweKjyKyp
	 bNYXQ+2HNcHeZ8SGNdvDAJujqeGAuYPDB+akK945FYnoGczp1n1IdacZ1ovjd5ibE0p8K
	 Pgh0bwRAkY9ZTa4ZbbgxM6qvO+LQ/HEqrBKoskX/M9bM6J3Ambk1dvSX1QzZYaLFd9D7x
	 HjmJAZ32ojV1rzBXmA+nZ4l0xjANg66CGSRVrhita9RHq28Qx2JynRssyD6y2Zg59s252
	 ek6IW+28131NEP90NeHSMD+MJQvoqcIjQjvBO2DHpFJJ/jfj0dUtdReymYfzvwao5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XalTvxq+;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02C606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E02C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XalTvxq+
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9f6a16aedso16364735ad.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984062; x=1793588862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUaC2nBwlRz6CLsNn8h/VtsmMRJkQZiqypod4sMRqmU=;
        b=XalTvxq+/yVZCwtiDWHzF5ruSfCI3Rl1b4ofbYPinmr0aYMiWRdpbV0PHoLvlBI9oM
         pbvDyI1tpvybQZ/XYby0vCTkN8i6cdTntuHM8S6gR9wv4uKqwaDDY0ONnjNfkgW9571H
         9tteCDmimWUkN23iA+jehiIZdRb/FwsSGsoz9jhQnVVoRjYks7EbvVnM6juK6/e0l6Bx
         1lTzxwyjbpYTcY8Og8o4TL2xPXQ5el0OFMxY0tXhTDiwkBaiLAngQ0L2QLQEOYu1+Azt
         Ono4BGv8dfUQ31Ji4BrTszkUI9rf8gwCkgfoZGrM+uLU09YE48G16vr5lh1Pel8XSDl7
         ejMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984062; x=1793588862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUaC2nBwlRz6CLsNn8h/VtsmMRJkQZiqypod4sMRqmU=;
        b=frXlI10tq39PlJNXvZxDYBwLYwuv04GM1Xuvso9Ms6om28Ny63yG5jGiOHGAO3wQK8
         VXAk6TBdBNnChNkq0wzMjKybs23XQAN6lM9k7L+gxu7YzmqtkDp/2j3o81h6lqYmT3HL
         M1Cakc1PDz05VUsj1EUmDiQ86dhiUZdUZbgJ99R0fFF2mvBE0qXE32oTNnMm3cGdCUn8
         9NqJr8dquk5SeLBlvUhfRU6/81S3cNQ/hNalSXObEPR4guDPB18H6nmr37xaWawnMd/+
         sTYgRq9tQe2u/6WABqZ6XMhU3crNxybw6Mrmn6BPzuZVxMv5Qv7d3A6mi0o1Fu6oLONy
         CK+Q==
X-Gm-Message-State: AFq9FYLJ0s+J34FkUMlqNtbZOCqaBppWJV4u+2+a6826sopirGtw9Vnw
	80fQXvTLefirO+2k5upZc+Wb5d80laX2oqCV3DMTgmZiekmqHnyY6C888M9UFw==
X-Gm-Gg: AYBFou1SEvrOGjY0so/Uz/M+BwPKZdxOR/1JsxG6paaqx17lKRFh8FgPlzHYsGor9Vf
	bdcRDYYGo+RzT4ov3hAuJ/Vv2bKNWeXJW7PzvyYw+S+c0i2Gez0gD5cy2mPncGMV9wkE+aKqLZD
	bbZqMwWTFKfpemoi1CCBzaw7xoHI/BOQXB+dHKL8Yb0PPPCbTVlpnCYCBYAgdG31mehejYB8Jxu
	OsvHkVjiTbT8p9XFZFvIAh66LZvNIRDvEJy3LQskk3lqeQSGXY+sCviZY0m1zJHMIH5H2DX/0SG
	zCxucYaVSHfGRlOHkDc5jynR0/34yOc8Og4a87VXW4Tb2KgRIHKVcIan+WRVJTKGs1TRIJBKZQ9
	+6//n2rW+2ZS9QgEeoY8hHqEvNDFtl/AxIGQpoIPwyjHqGLt42rhF4LBt1EDxkHn7E2bFHnR4qg
	3wDd/H2BjRNwMrNoIfIhR5+P11KIMpIzY18/32dG+m/5U5ek1FYAFhpZQtHF5+YithUrokuDnK5
	zcz2LzVNVNk0EYqSLHnqxV6B0+BNSsIqVXp/Yyv89EfshDoBE8qcEsL86HjmoeZv6zByjExhbWG
	feOWsNULbxmT9S1n0jcCzplwA27rQ3I27bDnVH5/qMy2Mo8C+H80KLVuwKtLP9mcFOtALcNXw9E
	V53NOffVqgrDt24CRlC0m6gbe
X-Received: by 2002:a17:90b:4ece:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3adeae83491mr5134484a91.57.1792984061548;
        Sun, 25 Oct 2026 20:07:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebafacd4sm3937450a91.2.2026.10.25.20.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 81/81] selftests/bpf: Test callx of one of a set of functions
Date: Mon, 26 Oct 2026 02:59:42 +0000
Message-ID: <20261026025943.404450-82-alexei.starovoitov@gmail.com>
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

A load from a table of functions at a variable offset gives one register
that holds a pointer to one of N functions, func(one_of=N). See
"bpf: Track a pointer to one of a set of functions".

  test, callx_rodata_...            the case                        result
  --------------------------------  ------------------------------  ------
  one_of_two                        a table of two functions        loads
  same_function_twice               the same function two times     loads
  callback_one_of_two               bpf_loop() gets the register    loads
  one_of_two_at_loop_head           callx in a loop, 4 iterations   reject
  one_of_two_at_loop_head_ok        callx in a loop, 3 iterations   loads
  callback_one_of_two_at_loop_head  bpf_loop() in a loop            reject
  400_functions                     3 states, 400 functions         loads

 - one_of_two expects R2=func(one_of=2) in the log, and callx must call the
   function that the index selects. same_function_twice expects R2=func().
 - In the tests with a loop, callx or bpf_loop() is the loop head. The prog
   is unsafe only in the fourth iteration, and only with one of the two
   functions.
 - In 400_functions three states that the verifier cannot join get to the
   load. One state for each function gives 1200 states at one insn, and the
   verifier rejects that with
   "more than 1024 states that cannot be joined". With a set there are
   3 states.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_callx_many.c |  90 +++++++
 .../bpf/progs/verifier_callx_rodata.c         | 220 ++++++++++++++++++
 3 files changed, 312 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_many.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 017b15fa4b6a..3b56cad22156 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -36,6 +36,7 @@
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_callx.skel.h"
+#include "verifier_callx_many.skel.h"
 #include "verifier_callx_rodata.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
@@ -231,6 +232,7 @@ void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
+void test_verifier_callx_many(void)           { RUN_JITED(verifier_callx_many); }
 void test_verifier_callx_rodata(void)         { RUN_JITED(verifier_callx_rodata); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_many.c b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
new file mode 100644
index 000000000000..5f8ee8490076
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * callx through a table of many functions. libbpf appends the functions that read-only
+ * data points to to every prog of the object that has callx, hence a file of its own.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+/* gcc doesn't support indirect calls */
+#if defined(__clang__) && (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+    (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
+
+/*
+ * Read-only data with pointers to functions, where the compiler puts tables
+ * of functions, structures of operations and vtables. libbpf resolves
+ * a pointer to the offset of the function in the program and the kernel
+ * recognizes it by that value.
+ */
+#define DATA(SECTION, NAME, ...)				\
+	".pushsection " SECTION ",@progbits;"			\
+	".balign 8;"						\
+	#NAME "_%=:"						\
+	__VA_ARGS__						\
+	".type " #NAME "_%=, @object;"				\
+	".size " #NAME "_%=, .-" #NAME "_%=;"			\
+	".popsection;"
+
+#define RODATA(NAME, ...) DATA(".rodata,\"a\"", NAME, __VA_ARGS__)
+
+#define REP10(M, p) M(p##0) M(p##1) M(p##2) M(p##3) M(p##4) M(p##5) M(p##6) M(p##7) M(p##8) M(p##9)
+#define REP100(M, p) REP10(M, p##0) REP10(M, p##1) REP10(M, p##2) REP10(M, p##3) REP10(M, p##4) \
+		     REP10(M, p##5) REP10(M, p##6) REP10(M, p##7) REP10(M, p##8) REP10(M, p##9)
+#define REP400(M) REP100(M, 0) REP100(M, 1) REP100(M, 2) REP100(M, 3)
+
+#define MANY_FUNC(n)						\
+__naked __noinline __used static unsigned long many##n(void)	\
+{								\
+	asm volatile ("r0 = r1; r0 += 1; exit;");		\
+}
+#define MANY_QUAD(n) ".quad many" #n ";"
+
+REP400(MANY_FUNC)
+
+/* 3 states that have no join get to a table of 400 functions: 3 states, and not 1200 */
+SEC("socket")
+__success __retval(11)
+__naked void callx_rodata_400_functions(void)
+{
+	asm volatile (
+		RODATA(big, REP400(MANY_QUAD))
+		"r7 = r1;"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 == 1 goto 1f;"
+		"r7 = r10;"
+		"if r0 == 2 goto 1f;"
+		"r7 = 0;"
+	"1:"
+		"call %[bpf_get_prandom_u32];"
+		"if r0 > 399 goto 2f;"
+		"r0 <<= 3;"
+		"r2 = big_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"if r7 != 0 goto +0;"
+		"exit;"
+	"2:"
+		"r0 = 11;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__success
+int dummy(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 85141cd73298..2575313a977a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -173,6 +173,226 @@ __naked void callx_rodata_array_of_structs(void)
 		: __clobber_all);
 }
 
+/* one state with one of two functions, and not two states */
+SEC("socket")
+__success __retval(11)
+__log_level(2)
+__msg("r2 = *(u64 *)(r2 +0)          ; R2=func(one_of=2)")
+__naked void callx_rodata_one_of_two(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r3 = r6;"
+		"r3 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r3;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"r0 -= r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(11)
+__log_level(2)
+__msg("r2 = *(u64 *)(r2 +0)          ; R2=func()")
+__naked void callx_rodata_same_function_twice(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add1)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r2 = tbl_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long loop_cb_stop(void)
+{
+	asm volatile (
+		"r0 = 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long loop_cb_go_on(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/* a helper needs to know the callback */
+SEC("socket")
+__success __retval(0)
+__naked void callx_rodata_callback_one_of_two(void)
+{
+	asm volatile (
+		FUNC_TABLE2(cbs, loop_cb_stop, loop_cb_go_on)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r2 = cbs_%= ll;"
+		"r2 += r0;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r6 = r2;"
+		"r1 = 2;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		/* libbpf resolves the pointers for progs that have callx */
+		"callx r6;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32), __imm(bpf_loop)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long not_three(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r1 != 3 goto +1;"
+		"r10 = 0;"
+		"exit;"
+	);
+}
+
+/*
+ * callx is the head of a loop whose iterations are looked at one by one, because of r1.
+ * The states with one function each are in the iteration of the state with both.
+ */
+SEC("socket")
+__failure __msg("frame pointer is read only")
+__naked void callx_rodata_one_of_two_at_loop_head(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, not_three)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r6 = tbl_%= ll;"
+		"r6 += r0;"
+		"r6 = *(u64 *)(r6 + 0);"
+		"r7 = 0;"
+		"r1 = 0;"
+	"l_%=:"
+		"callx r6;"
+		"r7 += 1;"
+		"r1 = r7;"
+		"if r7 < 4 goto l_%=;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+/* and the last iteration leaves the loop. It is not run: a loop that is not left has no end. */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = r7 {{.*}}R7=3")
+__naked void callx_rodata_one_of_two_at_loop_head_ok(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, not_three)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r6 = tbl_%= ll;"
+		"r6 += r0;"
+		"r6 = *(u64 *)(r6 + 0);"
+		"r7 = 0;"
+		"r1 = 0;"
+	"l_%=:"
+		"callx r6;"
+		"r7 += 1;"
+		"r1 = r7;"
+		"if r7 < 3 goto l_%=;"
+		"r0 = r7;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long loop_cb_set_flag(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"*(u64 *)(r2 + 0) = r1;"
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/* the same for the helper that needs to know the callback, and that the callback comes back to */
+SEC("socket")
+__failure __msg("frame pointer is read only")
+__naked void callx_rodata_callback_one_of_two_at_loop_head(void)
+{
+	asm volatile (
+		FUNC_TABLE2(cbs, loop_cb_set_flag, loop_cb_go_on)
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 1;"
+		"r0 <<= 3;"
+		"r6 = cbs_%= ll;"
+		"r6 += r0;"
+		"r6 = *(u64 *)(r6 + 0);"
+		"r7 = 0;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = 1;"
+		"r2 = r6;"
+		"r3 = r10;"
+		"r3 += -8;"
+		"r4 = 0;"
+	"l_%=:"
+		"call %[bpf_loop];"
+		"r1 = *(u64 *)(r10 - 8);"
+		"if r1 == 0 goto +2;"
+		"if r7 != 3 goto +1;"
+		"r10 = 0;"
+		"r7 += 1;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = r7;"
+		"r2 = r6;"
+		"r3 = r10;"
+		"r3 += -8;"
+		"r4 = 0;"
+		"if r7 < 4 goto l_%=;"
+		/* libbpf resolves the pointers for progs that have callx */
+		"r2 = r10;"
+		"r2 += -8;"
+		"callx r6;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32), __imm(bpf_loop)
+		: __clobber_all);
+}
+
 /* and the data of the element that the index selects can be read */
 SEC("socket")
 __success __retval(16)
-- 
2.55.0


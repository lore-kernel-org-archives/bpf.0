Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937339;
	b=v4AoTnSJGbKTZr0Nv1W9RTHhgtBOCd4jgOvXTK0mLmBcnAf6RbV/ft64BA8csYtZEKE0
	 MQTMYr4k8bpOiIeMULHOJSmjJ1GSKddPtPDtsyf9OwUdYT1ksLCK8YrY9MNk6CUzih7U+
	 5RWb5zw85ETBL1N4FqbjFy6Y4k/819WrVz2Wk9Y4pvRQ+eVH1ioQZCw8WMD7dDh3tAiNG
	 rk1LYLBgKOLPBsfni+Sr1/SZ/SsbKjwxmd6jZjQLaQgp5htlQ7glS/GSLJZT0Ni/IgD65
	 xuGYFq+hzsa0Ay4AIbIJ3kf0Nx2pPT2U9HD6URD09WDjIbUeVgEi28DjPMSTmZvCx1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
	b=l3aStjCnwLFU8SQV+924rffZ6E6+wx8DxqT5EUREDn/g5pCBAl5Zdm0c7XZ3N+R99vAs
	 4pnItdcE3n5mS5S93nfCueWrClyd8F9I7wHPRzetDP+NQUmyPTyl15n98W9FZUCP6S4sO
	 G/WTTETKH82c9qfNZsdTfATEy7sEYvL83+5hjUH+oi8UESGBsAJGQTD+oY2z/WMs6NgFp
	 R58SXB8qBC+Y8MqSqCE5f+XJa9C4EPYq7HYfUVL1dKJUWQ1h1AlA61+VkVZgOXWfvHjWP
	 fV2r4I2msJJFWDfzGL6exU3rw+A1sD6b9tOvtZu/jlBTSEpbR3m9HdPCm5BhtrbtS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVsFpTBt;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B57606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48B57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVsFpTBt
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso76174a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937339; x=1794542139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
        b=DVsFpTBt2JHtGdD9zVsV+YjdPAE7lUut8jXagqRpUHysXcBd9rlp+A0+iR5maGknrI
         SFlmeDcBjqgKYMVSYNeoYpyhoJDQcNSFs6LxEmf1Y2UX2zX8EpUwW6FRvyKePzuOJJEl
         1tVrhsF2shzyoYLRusjhw503zKByra8cBjmqJl2F+Ly+0XvAYII4Qc+U5PL91VHwrkHy
         9lZOp0xpCk4PFwV3ebLR0yyE8wK0RCgfaRFkyQin32iNZB2L9t62rlMNYqVBGxnUQaNG
         YIPuXetNlH3JxEMO1OPT8pZ5QsySJJ9gpJ4sfypDnN+64q2VpvWu8AR7+j/prauzdM5g
         bx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937339; x=1794542139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
        b=G2FnmsoRc/cT5kP7Lx26BxJCHtfkxOQcrrR0RSk1pvRSc+supeH7JmjHUk8JtbttBX
         ZrmFx29791ZTCGguBxsM9w6Qnsu1w8atRTIA4BtkooJPh5pXBPQ/+WKW5T3eG9XUrtI2
         C4K1v9mue+q7/7ieMtwjn34CcqLGvgppy2qIcRi9elL5J0RlVRl9x8XWcnuZzaM8TNBu
         FSl6lRHV0JThExqQx+aOE6l9i76Z0ebysWQpFvLfbAcuwDp4N1zdtfVK7FaxuqPlP+IE
         MdX1cNX8m+H6LdEVl1xCRmjXc0jOmesWC18VIjFZGjWo6ZSV02ax1MzVErhbE9sYQwgA
         7veg==
X-Gm-Message-State: APuU4Z/SzP4kShhEq+xd9RGhwJEQci+yoBmVtQ6sdDNPwGoFZjhCW0LV
	rmTiRl7cJHyrJVURNgluJU29EhcFOcf0rSnzyLzIfSLvB+1f7IFD8NMfLKdUgw==
X-Gm-Gg: AYBFou27612VmD3DBgWoD2fC65B1JVL9nj3i4SOBSudcOB+PfFt0Xd11VlU19J3vGSJ
	7qobq1GD1pR0gtlYc5aAeC6dtvom/qHtppDnlTm6iDMfQmrGZM7gfF4xPAf+VYqRqWJAu/uW2gr
	EYDROSrUHXWVEDm4hzXJJi8pMnCUGlBlEKvpaKL06d+JtdijN+ZxbQ25zIRfTTgUpVTEJOWv5Nx
	NelP/BIO9fuTeNwvVX+/5XYLOZPcSiJLz5hvExxiDX5+gO6r8a4m2spuuOGEzwU/LPL4d8OpgrX
	8CG7JnKcevbu/j4SNmMlevSbKP1FrI0dcsapp3wx2Gmn9Xp9G/94YiDgtYfByaipEPh+3CT9c9V
	dfSEYdjbYEYxCzQaIcnwtXMISkpQdSsLUHy9dkcWOIKj2WABAZERNl5Ta0HJPbt2/pEywiPcs0Y
	zHkTtKej/g32by4EFx2hlkoH654pkypzCsw/V5PujkVY3iUkCaNCtaMNf3wYJcl0JZlPE7V28Z+
	IJp2ciY61WRQwrsQ0Ss7zbcMg2+MHot4i3f1m6P4/hWoVI3ea5gJXjgFowqXc2FsjPw2ylqh9PJ
	fEPvL4q0ghJaLg/L6xlwGPsY4XZXGELkNiUF5djKEaAb8iweks7n8+cQfLX9IjvyblvMkVi0v4k
	Wtom22SYCnlj4jh9wLafu77N1mF/zEzJfjhfVnLcZm1R5TGedBsssoK4m20dBr4ZkOQEO+niMee
	o=
X-Received: by 2002:a17:90b:5548:b0:3ac:9e5e:d195 with SMTP id 98e67ed59e1d1-3b0db71f756mr1177301a91.61.1793937338257;
        Thu, 05 Nov 2026 19:55:38 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c0dcsm6052994a91.1.2026.11.05.19.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:55:37 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 45/45] selftests/bpf: Test callx of one of a set of functions
Date: Fri,  6 Nov 2026 03:51:09 +0000
Message-ID: <20261106035111.3315285-46-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
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

'ops[i](x)' in C, and each '{}' of a format string in Rust, is a load from
a table of functions at a variable offset, and callx. The load gives one
register that points to one of N functions.

  [S] "bpf: Track a pointer to one of a set of functions"
  [L] "bpf: callx reads what the subprogs whose address is taken read"

  file, test                     the rule that it pins
  -----------------------------  ------------------------------------------
  verifier_callx_rodata.c, callx_rodata_..
   one_of_two                    [S] The log has R2=func(one_of=2). callx
                                 calls the function that the index selects.
   callback_one_of_two           [S] bpf_loop() gets the register: each
                                 function is verified as the callback.
   one_of_two_at_loop_head       [S] callx is the head of a loop. The prog
                                 is unsafe in the fourth iteration with one
                                 of the two functions: rejected.
  verifier_callx_many.c, callx_rodata_..
   400_functions                 [S] 3 states that have no join get to the
                                 load: 3 states at an insn. One state for
                                 each function is 1200, the limit is 1024.
   4400_sets                     [S] More than 4096 sets: rejected.
  verifier_stack_arg.c
   callx_one_of_two_not_written  [S] The caller does not store the stack
                                 arguments that both functions take:
                                 rejected.
  verifier_callx.c
   callx_reads_declared_args     [L] r2 is live at callx: the callee does
                                 not read it, but its BTF declares it.

one_of_two, 400_functions and 4400_sets fail without [S], and
callx_reads_declared_args fails without [L]. The other three tests pass in
both cases. They examine the places where a set becomes one function.

libbpf adds the functions of a table to each prog of the object that has
callx. Thus the 400 functions are in a file of their own.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_callx.c      |  24 ++++
 .../selftests/bpf/progs/verifier_callx_many.c | 113 ++++++++++++++++++
 .../bpf/progs/verifier_callx_rodata.c         | 112 +++++++++++++++++
 .../selftests/bpf/progs/verifier_stack_arg.c  |  54 +++++++++
 5 files changed, 305 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_many.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 71ccd1e94bb2..0db43480cd99 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -39,6 +39,7 @@
 #include "verifier_call_large_imm.skel.h"
 #include "verifier_calls_in_a_row.skel.h"
 #include "verifier_callx.skel.h"
+#include "verifier_callx_many.skel.h"
 #include "verifier_callx_rodata.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
@@ -246,6 +247,7 @@ void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
 void test_verifier_calls_in_a_row(void)       { RUN(verifier_calls_in_a_row); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
+void test_verifier_callx_many(void)           { RUN_JITED(verifier_callx_many); }
 void test_verifier_callx_rodata(void)         { RUN_JITED(verifier_callx_rodata); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index 5f0d9e545656..a2bc466791f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -985,6 +985,30 @@ __naked void callx_callee_reads_caller_stack_nested(void)
 		: __clobber_all);
 }
 
+__naked __noinline __used
+static unsigned long reads_one_of_two(long a, long b)
+{
+	asm volatile (
+		"r0 = r1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* r2 is live at callx: the BTF of the callee, which a tracer counts on, declares it */
+SEC("socket")
+__success __retval(1) __log_level(2)
+__msg(".123...... (8d) callx r3")
+__naked void callx_reads_declared_args(void)
+{
+	asm volatile (
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = reads_one_of_two ll;"
+		"callx r3;"
+		"exit;"
+		::: __clobber_all);
+}
+
 /* registers that are constant before callx are not constant after it */
 SEC("socket")
 __success __retval(1)
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_many.c b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
new file mode 100644
index 000000000000..23c8948c24b8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_many.c
@@ -0,0 +1,113 @@
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
+#ifdef CAN_USE_CALLX
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
+/* many<n> or what is 'mask' bytes behind it in the table: 400 sets that were not there before */
+#define SET_LOAD(n) "r2 = *(u64 *)(r7 + 8 * (1" #n " - 1000));"
+#define SETS400(mask) "r7 = r6; r7 &= " #mask "; r7 += r8;" REP400(SET_LOAD)
+
+SEC("socket")
+__failure __msg("more than 4096 sets of functions")
+__naked void callx_rodata_4400_sets(void)
+{
+	asm volatile (
+		RODATA(twice, REP400(MANY_QUAD) REP400(MANY_QUAD))
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r8 = twice_%= ll;"
+		SETS400(8) SETS400(16) SETS400(32) SETS400(64) SETS400(128) SETS400(256)
+		SETS400(512) SETS400(1024) SETS400(2048) SETS400(24) SETS400(40)
+		"r1 = 10;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
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
+		"r0 &= 511;"
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
+__skip("callx needs arch JIT and compiler support")
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
index 2e7e65949497..3545c2a2e8f1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -171,6 +171,118 @@ __naked void callx_rodata_array_of_structs(void)
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
 /* and the data of the element that the index selects can be read */
 SEC("socket")
 __success __retval(16)
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index e3f5e4d14b75..c642675dd92b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -572,6 +572,60 @@ __naked void null_check_of_stack_arg(void)
 	: __clobber_all);
 }
 
+static __naked __noinline __used long adds_arg6_arg7(long a, long b, long c, long d, long e,
+						     long f, long g)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"r1 = *(u64 *)(r11 + 16);"
+	"r0 += r1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __naked __noinline __used long subs_arg6_arg7(long a, long b, long c, long d, long e,
+						     long f, long g)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"r1 = *(u64 *)(r11 + 16);"
+	"r0 -= r1;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: callx of one of two functions, args are not written")
+__failure __msg("callee expects 7 args, stack arg1 is not initialized")
+__naked void callx_one_of_two_not_written(void)
+{
+	asm volatile (
+	".pushsection .rodata,\"a\",@progbits;"
+	".balign 8;"
+"two_funcs_%=:"
+	".quad adds_arg6_arg7;"
+	".quad subs_arg6_arg7;"
+	".type two_funcs_%=, @object;"
+	".size two_funcs_%=, .-two_funcs_%=;"
+	".popsection;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 1;"
+	"r0 <<= 3;"
+	"r2 = two_funcs_%= ll;"
+	"r2 += r0;"
+	"r6 = *(u64 *)(r2 + 0);"
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"callx r6;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 /* r1 - r5 and all 19 slots. Its prototype has no parameters: what it takes is seen in its code. */
 __naked __noinline __used
 static unsigned long subprog_24args(void)
-- 
2.55.0


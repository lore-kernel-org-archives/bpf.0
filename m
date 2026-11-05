Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911725;
	b=XBTmDmiN/Mh8zPtRHxRNcPAF7gYmNRnuee+4I7O5S3g2QICRoB5H3u+L9u8R7YFrOSKx
	 4tc6fUL/UYtqkP+t5vzWGSTK8OpKBtkwYeInVHJhrW12bQLBO1NzUBiSMBlouemvsVSE4
	 VE46LNs+9U6eMOGJ6p2r4XJKsAEGbZmXAPn/aq/1sZqLeD4GuA9OO7YXsLhlPboB6nCH9
	 hf87e6ozNdFl0LBXr+8A4LOjeSxsXYc7Qwa7brE5jM1FjbS+gEJ3B9T+v1elWWwatlIIJ
	 7sqHh37hGj1me1aXZb9aVFvAejGFAcssk2vf6lr5f1aAKf/qhwcCgMaOIxyR7iO5WnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vs+99gfjHX8VdJUWNFj03q7s4MDxWw1DbdN6z3G5zto=;
	b=DX+xcjMdmzs8CXG/1ajSbCV4aQsaaoM+vHzKEK6kVB3mLOH/gDiyLDvQBu4gbtxh7uCC
	 4eUFAaOCYr0ktYgpk8Rz0RJkCeN0La/dMU02i0bj/zhQkCFVGyn/RPOJ5QV/M/lL7z0Dq
	 Qw9EBGCMWx5DgiSP2TrBGikQaJ35ryLLW2LzSDZRAZ6s0Rl6wsPKeorQX68mvk03UQMKz
	 1SoKu/S8VKP/PtCTwYK01dKRuB5i38rIqI9LGIaSRwBOKUDS2AQmcXXsWdX48cHLhd6yD
	 DGt8FF4ddDX5T0/rcyEl3fMMTd4b9TQ8HAO15Q0gyS+Fuo0ZpadCPr4LH0aRGPbRARQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxTswh80;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14F606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE14F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SxTswh80
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso1019239a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911724; x=1794516524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vs+99gfjHX8VdJUWNFj03q7s4MDxWw1DbdN6z3G5zto=;
        b=SxTswh80V5evuiIe3lfWmowxiIe1m8XJVWGMOSKCCcVbBPoVXkWjsixNc3dEMJq4VI
         3zO0HERAAQUN565L/oKvscjOoK0mRYpx5QpPZXBCih1o1mJdwyE7YUcOAWXoVGxSyscQ
         3IHtdUSaHu0e2htoTrJV81bFhYPxS3Dnp4/ojZiOVpjQ4f0oyUEHS1QCchiyS7D/bnd+
         99DEn1esDIl+neynlmxBAINJc2DjJuTrum7Dqf7gsEa+NAltTJ2kaVq5s7QHF+tb9FyL
         Tz84fGi5Z8jsxpCLm5I/z5vsEESxr4trad+fNXZTeYqgAuuP69h1UyyUMJoA+3kQ627h
         P81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911724; x=1794516524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vs+99gfjHX8VdJUWNFj03q7s4MDxWw1DbdN6z3G5zto=;
        b=BlWu93H1AvSdmop03xIT/80DgJTWOcU/WgIOdjCqyHBBIvqm9Qp6/HVUYEFxcjjlFS
         twq+iMarup6tRa/iQL6J7D0FQHa1kIPE9AUFSLHdIs357Gwp7YSMUlLc3/0bJKoXFAoh
         hxJcnx1fyXGOC/NkLDGqTdp3LDoGo+/342uKmj6oOCsGN/iI/UU87yEFHUqt9h3Fd2XH
         HLNJgzbElu3ztT4gcO/om4PyFFgWe+RLm/ul4Bo71XKn5CKTcq6WiWMeyj+8mC/7zmCF
         1m85z7sycFf10tWAPZs6UJ72M4iyaBnp1ya9M59GLR/mRGrM3ELKyeLcGi6pvZ2JOZkH
         6Wpg==
X-Gm-Message-State: APuU4Z9PCsVZIBwcDN6qztPTj6huuWBIU/rxfORaSvTLBEWy/kbgO4wb
	KxGeEMULoM/fFKHSFduB6vzow1eFDRKyG9eMHSSrpjlw2/NlbQfe6ywNbHkrHg==
X-Gm-Gg: AYBFou3UjPGveKSGrL0+9YNgBfdkorN4/02P36lnFxA3kpD/hHjC/GAT/+doQXfqtll
	imZiUAv8uD2IjmmwzdogBRxkrH7WUPcsM/cM7kDGApUQ+fbVU7kAOvLjK8tTdmXQXvDP0CiA/H+
	S8cdAx8i8LKHDkF/wp8NLmRcKsLK5O/6OyOS2HEp1lxu9BIw+r1f+aBMgjZ+5f+tVHjvCIEtreW
	JV06/SYrSXt+LXnB1yZpYrG+ocv+JyP/SJ4iQATUM6aArjVhP3bpJtwrcLd+q1afztOALVvyBR4
	JoGxJ1LDdxpd2DPgFg/4dtWyNqaI9w9eIUFcGKy8UWs8Dtp/PULiAVnqes02xnNFYtc75OGgxYp
	kW4xwOfHxbDFtZRGlKhesKle4JkX4HGvK0XO2dj2sGpDLp8w/KzvQ1rwVEfOrI+bRv7kscw8IkM
	ipUyqW3AKKgksbGGB1uFx9Z2JNJj9C2WIxcIZQEncFafKwJJNXA6X93KVV/vvlzr0WRP8U6IhqG
	g2L9ZKj2sVBT/czeDXBrZuY94E/+cBTkRBE5X9RDlkHJSVpgI5lxjDwJ5Vziklnyadrh/gqdTm5
	+YksDSj7Q+8YLz+E9nLPK7PhDyocSu4cgR6RRBI5yliUxgrY0lJToaXPiAUx4kIv0kae9Cw/+SQ
	iemqA8T+2NtivO5DrvewHaHCbPDZfaQvzyMmbLvvSTzGK6bcVPqjrzklhZAdiZ2apFpX6nVZUTR
	6Z
X-Received: by 2002:a17:90b:1fcf:b0:3a4:b30b:b501 with SMTP id 98e67ed59e1d1-3b0db5f1509mr218683a91.9.1793911723921;
        Thu, 05 Nov 2026 12:48:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c42c65sm606466a91.4.2026.11.05.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:48:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 35/35] selftests/bpf: Test callx of one of a set of functions
Date: Thu,  5 Nov 2026 20:45:12 +0000
Message-ID: <20261105204513.2230344-36-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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
index 5b3eacb36a6c..710e0be10c32 100644
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
@@ -245,6 +246,7 @@ void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog
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
index 9cd4fee561b2..dfb16434572d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -530,6 +530,60 @@ __naked void null_check_of_stack_arg(void)
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


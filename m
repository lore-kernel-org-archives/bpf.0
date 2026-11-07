Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022948;
	b=qoFUT68Y7xBkIgK/yeRvaIBB4C7sicybc/IdtICKZDcoGhCUkBwn8xMgHjwzRP9i3sJK
	 fyDL0dDdZwgHKI8O3MEo9tODJiWsLSaN9JL9BkwIoIyDOqR619pb9wx6N/SE/vLXy75P2
	 9nW01d9ZPyGzwpxlh7lVdfMwd5yJQpZ+PfYpHZmbu5eQpdDbrOIeB61dAMJpSmH+2MYc2
	 VazEIT9PJrV/chsxQx1B9uNrAI/vPMPC73b24GJqPqfFlZ6ystD3+aXNXlkQq5TybVQFD
	 xrbhujQYNt/iFOfk49yqYVxlD4JbkWM5spQaXPzE7VwoY0tJcfQil84Yprdb2qa9hPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
	b=PFQY4FORNlB8hUGCaCsKNKXgduyv84qfY9YyRyTxA0ZAZlXjeIxMhI7V5dcad9Bdnihs
	 B78sYPPJP4r2ggUlE3eeBJJOYTrs3+iAxBQ5R1/WvEhgTqNsZLUbQy4nJ4lDJHH+IvzGf
	 Xqppx38rmbGo3v0ASerj7n3bBUBtJKXQmnJ9M/nq/8ahPdj7oBQGla5UHRh52T+iggnpj
	 UJaifLzXN7A6Gv6T6Ut7xvmxy+f5at2dpFTQpjxBPEh3DNwPl46I/y88IytD/jOrTNhiX
	 fbRIiQ3x5DC13pAUO7PyolYm0CEZ5ZtOAFBTzZe4OVhaoKjm927RcCiQ1gOgZJjwx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9VnRJJU;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BB606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583BB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a9VnRJJU
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e985106c0cso9734975ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022948; x=1794627748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
        b=a9VnRJJUFnLSR5DuG2FVkJnwUCw4ZwNcIFDSHhO3bwsfG0LX/Wp6FnCyxIC8FCHO30
         xYB+CM9TAALs8EuqQJF16qyraEvi/4hNPiBk4RSgHzooBlpRewgNyioBPfk/u+QKh0Q4
         lxbLiXBW1M7jUKoq3ErZDQCuE0VZbsD53pEomF9VJXyqv35nKH3Ik2FOWajGNkfWEfZ3
         SdnVFkUnCDp+LtBMmPjVkjScV7bfFP4Hh6rU3nV4UZr1H7dt5Y76PVjol5obpDbY15A9
         R4yX47NdBPCSf/O9Q1PfCuRKFpr/gdOZIuO/mVKzvlxspx9Z/MRbnIa2IPPAC70BNiY2
         9GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022948; x=1794627748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WwWOGk6WVXWAhLHD5U4ek0d1QqUkvZ56LpfJM1aTanY=;
        b=NWDncDh0X87FtW2vwve9cQmpouAG/gkkBtdt4Avg4mwHB8+R9r8sGpgUcjzohXd4Zv
         e2BxAmaNYTggyRuJtJFdS+gRinOnnN2ADxwnLdiWv556I2Xf2XoJi7DM3XH9Sf1PzBvh
         NoQa6C6vnlf1fZxH/OwJAMv+xd/J0Z0CrgUZeLjohDp1DRfZR5FtGd5yZC9KG1Lj1+cX
         tHZl+1q23UiGvEOgBL3UYxZqcRjyAtFgx2DW5tyRRFzN8SfwzTOqxqu2+1wylW081owV
         7sb2f4Wnbhoh3IfYcbeyIdPKn35s9OcxFAL3W4s7OwgW2GEam2Ubz4/vJBsnMA7wnmZP
         IEaA==
X-Gm-Message-State: APuU4Z9u5+6ORe69yzsjjs/RhyEoyC6BwbxLL9Hb5QT5mo5EtWTbUxg3
	QN9OQb8yvI2Kqt7YHevYRPMKQtj08f7X4p8tkFL3cZ8CO6XzXR9x5Nlzr7Bgzw==
X-Gm-Gg: AYBFou1pbGJjMejASCyT8DMZH1mFsRxPhESpIOQ4tXn7Z1F9ueb4+p33qaeuBeLbA4y
	jkHadTuUn366PumfmeadjtXt4Uily2kc6/c75uF6WfKnuuLIbc/KvgDbjnLa2bYqjKhSjjyxPap
	nnWo4dJeqAQeU+YjPi0X3VKfKDAVQIVJjImtRHNlgmxPq3OdLA59Nmk/pbmq/OnmCh0AQI5Pmix
	1S5Uj9U1HBQaYUZSI/kAA9fgKM7b7vNTEIMz6Ujz6zx1ehGnXUMgGerwGYzj+XxlByd8Nx65VcQ
	q3lEq2lK04fxnkQqewrdLRaWAQuIU6m6rvPelGd8YUEljKVtPhlJxiK3xabYMeiNEsqcDaRBJrA
	TDRqR0pQRuGeLTF5P5MG4xM7hzQwSmK1MoO0O6EXG7FUaKm7oBNJ56qc6l9wiaXAV7R14Bh27rW
	ucZDGPbAdA6bOOvvhtdlUCkj3NxBYq/RVxj/mPQBbx67T4Bi+tjU6WAb1gVI7S78OoXK6mBVJJT
	k5Ud4M1sWimu0jpxy9Wg6LRahAk0XdEfhtsVqas4eylVBMmbq2/2bRmb8Sh6kx9/GUG4h4n4NrA
	xccqRX0P8xE3Jc7qnVa5GQ93ILWmYjNBAWsPXnRVf/Jp5uCO58MOLWTokM5zs5E025YOoQhY2JA
	6lX7Kz1PoSF0vbwvDhL7klwYJl+ANrKFlg37Ji2xmJ+8FVNviA5mO1M4CCmXwbB2v/qMjPSQKkA
	==
X-Received: by 2002:a17:903:32cf:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2ed41284f14mr54111745ad.5.1794022947425;
        Fri, 06 Nov 2026 19:42:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d88fabsm10103865ad.63.2026.11.06.19.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:42:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 44/46] selftests/bpf: Test callx of one of a set of functions
Date: Sat,  7 Nov 2026 03:37:52 +0000
Message-ID: <20261107033758.1547725-45-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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


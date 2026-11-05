Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911708;
	b=ydO3P4WHxiZ169eocs+/2ogb0deQR8uBR2JveOTWxbAb4kRCbbBi9gkvvdLxNCKbOwbY
	 OQEmhY8FVdHAW0f+Vhx39FiD9DiyrB+0U2vFeaGEpkOT2thPs2xu+Yunc6z3410m26S9/
	 COTeDp8lyScjGTPsZQYobNWaFWbihPjkK4TAzaWkqc3FJchsFe73O5FMql2SYHtXZE+lv
	 6E252GkmkP/iLegA7/Lefs3LBzQnOvUHXvw2LpU46J1A1UNACf3Fx24fZWadtgwVG5dmh
	 BIGohrQjAv/Yo3YWOaf01w/ln9MqB3cNfJjhocxxtuQ4yrGah7CNvdwIaO/uV1bCtjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cLtBFu7jHqZR3ZUMd/umw7ZuFixNEDK8oYUsWHluDwg=;
	b=2JzBROdCt8oGFV9ajOhCzrzojxlYrdR+DuZmSjkX85qoPZBn92xw6I/yzsukXQk07sJ9
	 eT34Z0msDncyD3cPemwSdXeWL92XIZSOoawHbXkRJEK8+UHMaF4RSgZzgpRE6HlGZB9UC
	 SYBX4ZJqSwa2ryMWZBeTOdHHwByuPAw/U2GG5FOzXzRWtvEf23fs+Dpx+nIIw5E7TBLTL
	 F+EgL5qjM8aG81Sn2EHlknO32tO+uO15nlAo3Spf5zsA0qTp0OhfhcojaGcjru6K9TO9g
	 L0m+Bh/E4RN5Yiag3xFtMsOwC4QVhGfeNLd3J6cgmZK3LGbAbFsrPJCjIInlybF1h8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqH6Qhml;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC3606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBC3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BqH6Qhml
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc758830601so1642627a12.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911707; x=1794516507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLtBFu7jHqZR3ZUMd/umw7ZuFixNEDK8oYUsWHluDwg=;
        b=BqH6Qhmlz8VheRyXwSZsD0NAAYahQMlrkfP8SizSdRBouVw+uX1WcfmZoLF3ln/3Pu
         D8q2p/RS78V2ibCyNNulPc5fbQWGApzSCFHxH2BmcKwqoR3QfUCrV7SumXx1MQ77YKu+
         TkmL3GgnqTKJhT8BgFv44WDNxaFAOYaB+vYQodgCFnKpb56VB8HWbI6LPOG1NwcUsKiP
         cDdMKnv4GfevS5QxikhgtPbuqc7kyv6J7Pm6ZTGs1l486jA1PaMhSt4GTEJPHc84Q4aS
         jU8S0u/ns+ph5n4QUI0fur75Vdqck+NcaCjH//HkH1YciZELki1HUW4FQMRd5l1JiXeu
         5LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911707; x=1794516507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLtBFu7jHqZR3ZUMd/umw7ZuFixNEDK8oYUsWHluDwg=;
        b=rbV26O9jJfKE1LSZ3Xo5kfkd2MMDqo2/DKZmtziqKUiBLPc9ERcud/0090fBdWbo02
         IYXBf9tfVjkiWrnpoqp+N2Wi3o52+cniv49jnw/P/nlrghRKRL2r7ARmqq7prOw/Lc/y
         ZxIc3j5y2SYR+Af7NFIXD97Ig1mbrsascyhU4mQxbfMJV9fYWBTQHiSddx3NpRa+QmuW
         oIQKXnvllsIP3KJjH8fweX4BgYBaBSIJp3frC7Dxlq4wKxUJovvpbjpxy40zZS2UI+4o
         qUp8oa/2pilEnujbIsRhF0R8vwPKPqpVr1Eaqgw46lUof0STDjE4M9MtJhordbyoPGQR
         v3BQ==
X-Gm-Message-State: APuU4Z+91gIdgsALFb8MvfR/Kaxv9ifdsUAd3Wcso8naFWrKPsr/KABE
	5aCvuWlxeDfgp6dbh1u4od6LPLhRfsH1giSUvI2fR/CR1DxyRLIqc8dtmi0qEA==
X-Gm-Gg: AYBFou2U+dV6kO9ddYzFRY2cWg+BoRR8bDLif9ImgOddkSgnmXMrfNzdyXuJpxNhKQJ
	kfM38dcqYXy4vyoSvcF5Ibs/jAG/jiyMulepZTDBzWOrAZFqmQ8a5qNo2COmzs08sgmQ4inKYLc
	eLgh10tHVCsYEBCPUKTM/9jqAtqy+GYSLdE3xHR/8+X2Br5Fjxc0vC0mEVWnJ3JrK/MymSrCQSy
	oN9wjMuLK+fYWrMjVW9HMWVCnhriCEknc7M8kZIGS2QhHwLM0Uut3j07pwII3FDtW8rwDxMzyT5
	hwqoac5tPVFgVsuIzflzLMu7t3qGh3OunNe9Cq5ZuMGWi3Rt9iDH8r0J1wJDDpNlHzMtrTguxcZ
	MoVRMZHypfS+st8Nf2XGLw1nawC3LRJtSVFdwOE7JWZJOgCPxqA4l2Xd0zNXLXfu8UXcW4kOdLu
	/2NeXFtYvkBeHREZY7/tIhWwVy5YhWNETGP9isI7VMGsZVzeUlXVcLOEqoUZ5SACuyhsvIA//Eb
	rxx79jwQSY5bEjdRpnvsjOpWsoGjTUfcMHLwRtOcGhidgF77WwIqscApTio+uDPZhm0e9J1hfTc
	rKkL1yuhkAakdBagbdM8fioWvDua0VUUYWDnazbXfs1PGP0v3CjKP4QPa9PHwyiS3mY/NoN5W/k
	n1j0LGgYBFXKowF9ZbRRZslQ516sH2Vp+b4ScY+OxLO5VFjuIOxtcBZiu9zes3s6V8yc7mAwdyA
	==
X-Received: by 2002:a17:90b:4a89:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3b0db6fbf17mr201969a91.53.1793911706220;
        Thu, 05 Nov 2026 12:48:26 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b5c5d785sm2259784a91.0.2026.11.05.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:48:25 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 32/35] selftests/bpf: Test static subprogs that are verified on their own
Date: Thu,  5 Nov 2026 20:45:09 +0000
Message-ID: <20261105204513.2230344-33-alexei.starovoitov@gmail.com>
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

The verifier followed each call into the subprog, with the frames of the
callers in the state. Now it verifies most static subprogs for the states
at their first insn, without these frames. A call waits, and each exit
state goes to all calls that wait for this entry state. What can go wrong:
a call does not get a result that is its own, or the subprog changes what
a caller holds and the caller does not see it.

  [E] "bpf: Add the sets of states at an insn and the entries of functions"
  [M] "bpf: Move states along edges, into loops and subprogs and out of
      them"
  [B] "bpf: Make the state after a call from the caller's state and an
      exit state"
  [O] "bpf: Verify static subprogs on their own"

  verifier_..         the case                                        pins
  ------------------  ----------------------------------------------  ----
  calls_in_a_row.c    20 calls pass kind 3, one call passes kind 1:   [E]
                      the 20 entry states are joined, the one stays
                      'x = inc(x); x = inc(x);' loads and returns 2   [M]
                      3 entry states meet in the subprog in 2 steps:  [E]
                      the exit state is for all 3 calls, if they      [B]
                      wait together or come one after the other
  subprog_callers.c   The subprog gives up the lock or the RCU        [O]
                      section of its caller and takes it again.
                      3 calls wait when the verifier finds it out.
                      It is called, and it is a timer callback too.   [O]
                      Recursive subprogs change packet data or        [O]
                      a tree in the callback of bpf_rbtree_add().
                      Ids at the return: an inner map from each of    [B]
                      2 calls, a reference 2 calls down, too many ids.
                      Two calls pass packet pointers whose offsets    [O]
                      have different ranges.
  stack_arg.c         The stack arguments that a subprog got are not  [O]
                      the ones that it passes on. A subprog does the
                      NULL check of a stack argument for its caller.

14 of the 20 progs are unsafe and must be rejected: only one call gets
a number that is out of bounds, only the code after one call uses what the
subprog took away.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../bpf/progs/verifier_calls_in_a_row.c       | 170 ++++++
 .../selftests/bpf/progs/verifier_stack_arg.c  |  85 +++
 .../bpf/progs/verifier_subprog_callers.c      | 509 ++++++++++++++++++
 4 files changed, 768 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_calls_in_a_row.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_callers.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b19173905f64..a57744663e99 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -36,6 +36,7 @@
 #include "verifier_btf_flex_array.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
+#include "verifier_calls_in_a_row.skel.h"
 #include "verifier_callx.skel.h"
 #include "verifier_callx_rodata.skel.h"
 #include "verifier_cfg.skel.h"
@@ -129,6 +130,7 @@
 #include "verifier_stack_arg_order.skel.h"
 #include "verifier_stack_ptr.skel.h"
 #include "verifier_store_release.skel.h"
+#include "verifier_subprog_callers.skel.h"
 #include "verifier_subprog_insn_stats.skel.h"
 #include "verifier_subprog_precision.skel.h"
 #include "verifier_subprog_topo.skel.h"
@@ -235,6 +237,7 @@ void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
+void test_verifier_calls_in_a_row(void)       { RUN(verifier_calls_in_a_row); }
 void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
 void test_verifier_callx_rodata(void)         { RUN_JITED(verifier_callx_rodata); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
@@ -340,6 +343,7 @@ void test_verifier_stack_arg(void)            { RUN(verifier_stack_arg); }
 void test_verifier_stack_arg_order(void)      { RUN(verifier_stack_arg_order); }
 void test_verifier_stack_ptr(void)            { RUN(verifier_stack_ptr); }
 void test_verifier_store_release(void)        { RUN(verifier_store_release); }
+void test_verifier_subprog_callers(void)      { RUN(verifier_subprog_callers); }
 void test_verifier_subprog_insn_stats(void)   { RUN(verifier_subprog_insn_stats); }
 void test_verifier_subprog_precision(void)    { RUN(verifier_subprog_precision); }
 void test_verifier_subprog_topo(void)        { RUN(verifier_subprog_topo); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_calls_in_a_row.c b/tools/testing/selftests/bpf/progs/verifier_calls_in_a_row.c
new file mode 100644
index 000000000000..8dcb1a82b3a4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_calls_in_a_row.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/* A static subprog that is called from many places */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* gcc makes a copy of a function for an argument that is the same constant in most calls */
+#if defined(__GNUC__) && !defined(__clang__)
+#define __noclone __attribute__((noclone))
+#else
+#define __noclone
+#endif
+
+volatile int sel;
+char arr[64];
+
+#define SITES_4(call, n)  call(n) call(n + 1) call(n + 2) call(n + 3)
+#define SITES_20(call)    SITES_4(call, 0) SITES_4(call, 4) SITES_4(call, 8) \
+			  SITES_4(call, 12) SITES_4(call, 16)
+
+/*
+ * The states of the 20 calls are joined at the entry of the subprog one by one: x grows. The state
+ * of the first call stays apart from them, however many joins it takes.
+ *
+ * kind 1: idx is an index. kind 3: idx is something else. 2 is not there.
+ */
+static __noinline __noclone int use(int kind, unsigned int idx, int x)
+{
+	if (kind == 1)
+		return arr[idx] + x;
+	return idx + x;
+}
+
+SEC("socket")
+__description("20 calls in a row, a number that a jump tests")
+__success
+int many_sites_gap(void *ctx)
+{
+	int r = use(1, 5, 100);
+
+#define USE(n) if (sel == n) r += use(3, 1000, n);
+	SITES_20(USE)
+	return r;
+}
+
+/* The second call gets what the first call returns */
+static __noinline __noclone int inc(int x)
+{
+	return x + 1;
+}
+
+SEC("socket")
+__description("x = inc(x), two times in a row")
+__success __retval(2)
+int inc_two_times(void *ctx)
+{
+	int x = 0;
+
+	x = inc(x);
+	x = inc(x);
+	return x;
+}
+
+char four[4] SEC(".data.four") = { 10, 11, 12, 13 };
+
+/*
+ * r1 is 1, 3 or 5, and the jumps look at it: the states of three calls stay apart at the first
+ * insn. Those of 1 and 3 meet behind the second jump. What becomes of them meets that of 5 behind
+ * the first one. From there on one state stands for the three, and what comes out is for
+ * all three calls.
+ * Returns r2 + 3, r2 + 2, r2.
+ */
+static __naked __noinline __used int three_kinds(void)
+{
+	asm volatile (
+	"if r1 == 5 goto 2f;"
+	"if r1 == 3 goto 1f;"
+	"r2 += 1;"
+"1:"
+	"r2 += 2;"
+"2:"
+	"r0 = r2;"
+	"exit;"
+	::: __clobber_all);
+}
+
+#define CALL(kind, v)				\
+	"r1 = " #kind ";"			\
+	"r2 = " #v ";"				\
+	"call three_kinds;"
+
+#define LOAD					\
+	"r1 = %[four] ll;"			\
+	"r1 += r0;"				\
+	"r0 = *(u8 *)(r1 + 0);"
+
+/* The three calls wait at the same time */
+#define BRANCHES(v1, load1, v3, load3, v5, load5)	\
+	asm volatile (				\
+	"r6 = *(u32 *)(r1 + %[len]);"		\
+	"if r6 == 1 goto 1f;"			\
+	"if r6 == 3 goto 3f;"			\
+	CALL(5, v5)				\
+	load5					\
+	"exit;"					\
+"1:"						\
+	CALL(1, v1)				\
+	load1					\
+	"exit;"					\
+"3:"						\
+	CALL(3, v3)				\
+	load3					\
+	"exit;"					\
+	:					\
+	: __imm_addr(four),			\
+	  __imm_const(len, offsetof(struct __sk_buff, len))	\
+	: __clobber_all)
+
+SEC("tc")
+__description("three calls wait, their states meet in two steps")
+__success __retval(10)
+__naked void three_calls_wait(void)
+{
+	BRANCHES(0, LOAD, 0, LOAD, 0, LOAD);
+}
+
+SEC("tc")
+__description("three calls wait, their states meet in two steps, the first one gets 7")
+__failure __msg("invalid access to map value, value_size=4 off=7 size=1")
+__naked void three_calls_wait_bad_1(void)
+{
+	BRANCHES(4, LOAD, 0, "", 0, "");
+}
+
+#define ADD	LOAD "r6 += r0;"
+
+/* A call is done with before the next one is made */
+#define ROW(k1, v1, load1, k2, v2, load2, k3, v3, load3)	\
+	asm volatile (				\
+	"r6 = 0;"				\
+	CALL(k1, v1)				\
+	load1					\
+	CALL(k2, v2)				\
+	load2					\
+	CALL(k3, v3)				\
+	load3					\
+	"r0 = r6;"				\
+	"exit;"					\
+	:					\
+	: __imm_addr(four)			\
+	: __clobber_all)
+
+SEC("tc")
+__description("three calls in a row, their states meet in two steps")
+__success __retval(35)
+__naked void three_calls_in_a_row(void)
+{
+	ROW(1, 0, ADD, 3, 0, ADD, 5, 0, ADD);
+}
+
+SEC("tc")
+__description("three calls in a row, the second one gets 6")
+__failure __msg("invalid access to map value, value_size=4 off=6 size=1")
+__naked void three_calls_in_a_row_bad_2(void)
+{
+	ROW(1, 0, "", 3, 4, ADD, 5, 0, "");
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 146cdf81bbc4..9cd4fee561b2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -445,6 +445,91 @@ __naked void stack_arg_shared_store(void)
 	);
 }
 
+/* What it stores is what it got: the path that stores nothing looks the same at the call. */
+static __naked __noinline __used long stores_same_on_one_path(long a, long b, long c, long d,
+							      long e, long f, long g)
+{
+	asm volatile (
+	"r6 = *(u64 *)(r11 + 8);"
+	"r7 = *(u64 *)(r11 + 16);"
+	"if r1 == 0 goto l0_%=;"
+	"*(u64 *)(r11 - 8) = r6;"
+	"*(u64 *)(r11 - 16) = r7;"
+"l0_%=:"
+	"r1 = 0;"
+	"r2 = 0;"
+	"r3 = 0;"
+	"r4 = 0;"
+	"r5 = 0;"
+	"call subprog_7args;"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: incoming args are not taken for outgoing args, same values")
+__failure __msg("callee expects 7 args, stack arg1 is not initialized")
+__naked void incoming_for_outgoing_same(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = 6;"
+	"*(u64 *)(r11 - 16) = 7;"
+	"call stores_same_on_one_path;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __naked __noinline __used long sixth_is_there(long a, long b, long c, long d, long e,
+						     long *f)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r11 + 8);"
+	"if r0 == 0 goto l0_%=;"
+	"r0 = 1;"
+"l0_%=:"
+	"exit;"
+	::: __clobber_all);
+}
+
+SEC("tc")
+__description("stack_arg: subprog does the NULL check for its caller")
+__success
+__naked void null_check_of_stack_arg(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"r1 = %[map_hash_8b] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"r6 = r0;"
+	"r1 = 1;"
+	"r2 = 2;"
+	"r3 = 3;"
+	"r4 = 4;"
+	"r5 = 5;"
+	"*(u64 *)(r11 - 8) = r6;"
+	"call sixth_is_there;"
+	"if r0 == 0 goto l0_%=;"
+	"r0 = *(u64 *)(r6 + 0);"
+"l0_%=:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
 /* r1 - r5 and all 19 slots. Its prototype has no parameters: what it takes is seen in its code. */
 __naked __noinline __used
 static unsigned long subprog_24args(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c b/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c
new file mode 100644
index 000000000000..2b847a7723b1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_subprog_callers.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/* A static subprog and its callers: what they hold, where they run */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_experimental.h"
+
+#define private(name) SEC(".bss." #name) __hidden __attribute__((aligned(8)))
+
+struct elem {
+	struct bpf_list_node l;
+	__u64 data;
+};
+
+private(A) struct bpf_spin_lock lock_a;
+private(A) struct bpf_list_head head_a __contains(elem, l);
+
+int pid;
+
+static __noinline void relock_a(void)
+{
+	bpf_spin_unlock(&lock_a);
+	bpf_spin_lock(&lock_a);
+}
+
+/* Somebody else can pop and free the node while the lock is not held. */
+SEC("tc")
+__description("subprog drops the lock of its caller for a while, non-owning reference")
+__failure __msg("invalid mem access 'scalar'")
+int relock_non_owning_ref(struct __sk_buff *skb)
+{
+	struct elem *n;
+
+	n = bpf_obj_new(typeof(*n));
+	if (!n)
+		return 0;
+	bpf_spin_lock(&lock_a);
+	bpf_list_push_front(&head_a, &n->l);
+	relock_a();
+	n->data = 42;
+	bpf_spin_unlock(&lock_a);
+	return 0;
+}
+
+static __noinline void rcu_window(void)
+{
+	bpf_rcu_read_unlock();
+	bpf_rcu_read_lock();
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__description("subprog leaves the RCU section of its caller for a while")
+__failure __msg("R1 must be a rcu pointer")
+int rcu_window_rcu_ptr(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf(), *parent;
+
+	bpf_rcu_read_lock();
+	parent = task->real_parent;
+	if (!parent)
+		goto out;
+	rcu_window();
+	parent = bpf_task_acquire(parent);
+	if (parent) {
+		pid = parent->pid;
+		bpf_task_release(parent);
+	}
+out:
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+struct timer_elem {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} timers SEC(".maps");
+
+static __noinline int leaves_preempt_off(void *map, int *key, struct timer_elem *val)
+{
+	bpf_preempt_disable();
+	return 0;
+}
+
+/* The call and the callback have one frame each. The callback returns to the kernel. */
+SEC("tc")
+__description("subprog is called, then it is made a timer callback")
+__failure __msg("cannot be used inside bpf_preempt_disable-ed region")
+int call_then_timer_callback(struct __sk_buff *skb)
+{
+	struct timer_elem *val = bpf_map_lookup_elem(&timers, &(int){0});
+
+	if (!val)
+		return 0;
+	leaves_preempt_off(NULL, NULL, NULL);
+	bpf_preempt_enable();
+	bpf_timer_set_callback(&val->timer, leaves_preempt_off);
+	return 0;
+}
+
+struct tree_elem {
+	long key;
+	struct bpf_rb_node node;
+};
+
+private(D) struct bpf_spin_lock lock_d;
+private(D) struct bpf_rb_root root_d __contains(tree_elem, node);
+
+static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct tree_elem *elem_a = container_of(a, struct tree_elem, node);
+	struct tree_elem *elem_b = container_of(b, struct tree_elem, node);
+
+	return elem_a->key < elem_b->key;
+}
+
+static __noinline long removes_and_recurses(struct tree_elem *e, int n)
+{
+	struct bpf_rb_node *node;
+
+	if (n <= 0)
+		return 0;
+	node = bpf_rbtree_remove(&root_d, &e->node);
+	if (node)
+		bpf_rbtree_add(&root_d, node, less);
+	n = removes_and_recurses(e, n - 1);
+	barrier_var(n);
+	return n + 1;
+}
+
+static bool less_changes_tree(struct bpf_rb_node *a, const struct bpf_rb_node *b)
+{
+	struct tree_elem *elem_a = container_of(a, struct tree_elem, node);
+	struct tree_elem *elem_b = container_of(b, struct tree_elem, node);
+
+	removes_and_recurses(elem_b, 1);
+	return elem_a->key < elem_b->key;
+}
+
+/* bpf_rbtree_add() walks the tree while it calls the callback. */
+SEC("?tc")
+__description("recursive subprog changes the tree, it is called from the callback of rbtree_add")
+__arch_x86_64
+__arch_arm64
+__failure __msg("bpf_rbtree_remove not allowed in rbtree cb")
+int recursion_removes_in_rbtree_callback(void *ctx)
+{
+	struct tree_elem *e;
+
+	e = bpf_obj_new(typeof(*e));
+	if (!e)
+		return 0;
+	bpf_spin_lock(&lock_d);
+	bpf_rbtree_add(&root_d, &e->node, less_changes_tree);
+	bpf_spin_unlock(&lock_d);
+	return 0;
+}
+
+/*
+ * What a subprog does is what its callees do. The walk over the graph is done with second()
+ * before it is done with first(), which second() calls: the prog calls second() and then
+ * first(), so first() is looked at first, and in it the call that comes last.
+ */
+static __noinline int pulls_data(struct __sk_buff *skb)
+{
+	return bpf_skb_pull_data(skb, 0);
+}
+
+static __noinline int pulls_first(struct __sk_buff *skb, int n);
+
+static __noinline int pulls_second(struct __sk_buff *skb, int n)
+{
+	if (n <= 0)
+		return 0;
+	return pulls_first(skb, n - 1) + 1;
+}
+
+static __noinline int pulls_first(struct __sk_buff *skb, int n)
+{
+	int r = pulls_data(skb);
+
+	return r + pulls_second(skb, n);
+}
+
+SEC("?tc")
+__description("recursive static subprogs, the one that is explored last changes packet data")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid mem access 'scalar'")
+int recursion_changes_pkt_data(struct __sk_buff *skb)
+{
+	char *p = (void *)(long)skb->data, *end = (void *)(long)skb->data_end;
+	int r;
+
+	if (p + 1 > end)
+		return 0;
+	r = pulls_second(skb, 1);
+	*p = 42;
+	r += pulls_first(skb, 0);
+	return r & 1;
+}
+
+static __naked __noinline __used long returns_third(void)
+{
+	asm volatile (
+	"r0 = r1;"
+	"r0 = r2;"
+	"r0 = r3;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* What comes back has the range of r6, not the range of the pointer of the first call. */
+#define PKT_POINTERS_OF_TWO_RANGES(func)	\
+	asm volatile (				\
+	"r9 = *(u32 *)(r1 + %[data]);"		\
+	"r8 = *(u32 *)(r1 + %[data_end]);"	\
+	"call %[bpf_get_prandom_u32];"		\
+	"r7 = r0;"				\
+	"r0 &= 0xff;"				\
+	"r1 = 0;"				\
+	"r2 = 3;"				\
+	"r3 = r9;"				\
+	"r3 += r0;"				\
+	"call " #func ";"			\
+	"r7 &= 1;"				\
+	"r6 = r9;"				\
+	"r6 += r7;"				\
+	"r1 = 0;"				\
+	"r2 = 3;"				\
+	"r3 = r6;"				\
+	"call " #func ";"			\
+	"if r0 == 0 goto 1f;"			\
+	"if r0 > r8 goto 1f;"			\
+	"r0 = *(u8 *)(r6 + 100);"		\
+"1:"						\
+	"r0 = 0;"				\
+	"exit;"					\
+	:					\
+	: __imm(bpf_get_prandom_u32),		\
+	  __imm_const(data, offsetof(struct __sk_buff, data)),		\
+	  __imm_const(data_end, offsetof(struct __sk_buff, data_end))	\
+	: __clobber_all)
+
+SEC("tc")
+__description("two calls, the offset of the packet pointer has a smaller range in the second one")
+__failure __msg("invalid access to packet")
+__naked void pkt_pointers_of_two_ranges(void)
+{
+	PKT_POINTERS_OF_TWO_RANGES(returns_third);
+}
+
+static __naked __noinline __used long returns_third_r2_calls_down(void)
+{
+	asm volatile (
+	"if r2 == 0 goto 1f;"
+	"r2 += -1;"
+	"call returns_third_r2_calls_down;"
+	"exit;"
+"1:"
+	"r0 = r3;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* A recursive subprog that gets such a pointer needs the frames of its callers too. */
+SEC("?tc")
+__description("two calls of a recursive subprog, the second packet pointer has the smaller range")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to packet")
+__naked void pkt_pointers_of_two_ranges_recursion(void)
+{
+	PKT_POINTERS_OF_TWO_RANGES(returns_third_r2_calls_down);
+}
+
+static __naked __noinline __used long tcp_sock_of(void)
+{
+	asm volatile (
+	"call %[bpf_tcp_sock];"
+	"exit;"
+	:
+	: __imm(bpf_tcp_sock)
+	: __clobber_all);
+}
+
+static __naked __noinline __used long calls_tcp_sock_of(void)
+{
+	asm volatile (
+	"call tcp_sock_of;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/* The caller of tcp_sock_of() has the reference from its own caller. */
+SEC("tc")
+__description("reference goes down two calls, what is made from it is used after the release")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void reference_two_calls_down(void)
+{
+	asm volatile (
+	"r2 = 0;"
+	"*(u64 *)(r10 - 8) = r2;"
+	"*(u64 *)(r10 - 16) = r2;"
+	"r2 = r10;"
+	"r2 += -16;"
+	"r3 = 12;"
+	"r4 = 0;"
+	"r5 = 0;"
+	"call %[bpf_sk_lookup_tcp];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r0;"
+	"r1 = r6;"
+	"call calls_tcp_sock_of;"
+	"r7 = r0;"
+	"r1 = r6;"
+	"call %[bpf_sk_release];"
+	"if r7 == 0 goto 1f;"
+	"r0 = *(u32 *)(r7 + 0);"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_sk_lookup_tcp),
+	  __imm(bpf_sk_release)
+	: __clobber_all);
+}
+
+struct inner_timers {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer_elem);
+} inner_timers SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__array(values, struct inner_timers);
+} outer_timers SEC(".maps");
+
+static __naked __noinline __used long inner_map(void)
+{
+	asm volatile (
+	"*(u32 *)(r10 - 4) = r1;"
+	"r2 = r10;"
+	"r2 += -4;"
+	"r1 = %[outer_timers] ll;"
+	"call %[bpf_map_lookup_elem];"
+	"exit;"
+	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(outer_timers)
+	: __clobber_all);
+}
+
+#define TWO_INNER_MAPS				\
+	"r1 = 0;"				\
+	"call inner_map;"			\
+	"if r0 == 0 goto 1f;"			\
+	"r6 = r0;"				\
+	"r1 = 1;"				\
+	"call inner_map;"			\
+	"if r0 == 0 goto 1f;"			\
+	"r7 = r0;"
+
+/* The timer is in the map in r0. It is fine only if that is the map in r6. */
+#define INIT_TIMER_WITH_R6			\
+	"r1 = 0;"				\
+	"*(u32 *)(r10 - 4) = r1;"		\
+	"r2 = r10;"				\
+	"r2 += -4;"				\
+	"r1 = r0;"				\
+	"call %[bpf_map_lookup_elem];"		\
+	"if r0 == 0 goto 1f;"			\
+	"r1 = r0;"				\
+	"r2 = r6;"				\
+	"r3 = 1;"				\
+	"call %[bpf_timer_init];"		\
+"1:"						\
+	"r0 = 0;"				\
+	"exit;"
+
+#define INNER_MAP_IMMS				\
+	__imm(bpf_get_prandom_u32),		\
+	__imm(bpf_map_lookup_elem),		\
+	__imm(bpf_timer_init)
+
+/* Each call returns another map. */
+SEC("tc")
+__description("subprog returns an inner map, timer of one map is set up with another one")
+__failure __msg("doesn't match map pointer in R2")
+__naked void inner_maps_of_two_calls(void)
+{
+	asm volatile (
+	TWO_INNER_MAPS
+	INIT_TIMER_WITH_R6
+	:
+	: INNER_MAP_IMMS
+	: __clobber_all);
+}
+
+/* As many as there is room for ids at the return, and one more. */
+static __naked __noinline __used void saves_irq_flags_many_times(void)
+{
+	asm volatile (
+	".rept 9153;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_local_irq_save];"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	".endr;"
+	"exit;"
+	:
+	: __imm(bpf_local_irq_save)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("subprog comes back with more ids than there is room for")
+__failure __msg("too many ids at the call at insn")
+__log_level(4)
+int too_many_ids_at_the_return(void *ctx)
+{
+	unsigned long flags;
+
+	saves_irq_flags_many_times();
+	bpf_local_irq_save(&flags);
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+static __naked __noinline __used void leaves_rcu_section(void)
+{
+	asm volatile (
+	"call %[bpf_rcu_read_unlock];"
+	"call %[bpf_rcu_read_lock];"
+	"exit;"
+	:
+	: __imm(bpf_rcu_read_unlock),
+	  __imm(bpf_rcu_read_lock)
+	: __clobber_all);
+}
+
+static __naked __noinline __used int returns_zero(void)
+{
+	asm volatile (
+	"r0 = 0;"
+	"exit;"
+	::: __clobber_all);
+}
+
+/*
+ * Three calls wait for the subprog. When it's known what the subprog does to the RCU section of
+ * its callers each of them stops to wait and is verified in the context of its caller.
+ * Then one more call waits.
+ */
+#define RCU_BRANCHES(then1, then2, then3)	\
+	asm volatile (				\
+	"r6 = *(u32 *)(r1 + %[len]);"		\
+	"call %[bpf_rcu_read_lock];"		\
+	"if r6 == 1 goto 1f;"			\
+	"if r6 == 2 goto 2f;"			\
+	"call leaves_rcu_section;"		\
+	then3					\
+	"goto 3f;"				\
+"1:"						\
+	"call leaves_rcu_section;"		\
+	then1					\
+	"goto 3f;"				\
+"2:"						\
+	"call leaves_rcu_section;"		\
+	then2					\
+"3:"						\
+	"call %[bpf_rcu_read_unlock];"		\
+	"call returns_zero;"			\
+	"exit;"					\
+	:					\
+	: __imm(bpf_rcu_read_lock),		\
+	  __imm(bpf_rcu_read_unlock),		\
+	  __imm_const(len, offsetof(struct __sk_buff, len))	\
+	: __clobber_all)
+
+SEC("tc")
+__description("three calls stop to wait")
+__success __retval(0)
+__naked void three_calls_stop_to_wait(void)
+{
+	RCU_BRANCHES("", "", "");
+}
+
+SEC("tc")
+__description("three calls stop to wait, what follows the first one")
+__failure __msg("R7 !read_ok")
+__naked void three_calls_stop_to_wait_bad_1(void)
+{
+	RCU_BRANCHES("r0 = r7;", "", "");
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0


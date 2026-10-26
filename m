Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984045;
	b=Z9aZWgj2pZy5UYqCfXNIO76kTvJ1oTJRyVYEagZRuQXOuzdmS7OLi2hSpccXhzsivF0V
	 ve2IDSFN5HpxUE2jiXnKePAa4Vk9kPXpY+3fEFS4nsklcAngUh1r7/K+opl7Fs1/Yqxnt
	 XZl+ENairVHQHc5jkvxwrl8Xl8a98cdf1RLjXNenXOaYQ1iVLoALQj2vQ8gVQMw2MgOjD
	 g+L0Wevq53skaCqa8W6vO7dKOm6J0nLn/b/UFFnVa3bcSk1zxeH5QfmSQ349g6mFEwJS6
	 hawY0nSa11uB3idUZ1PQ663yKuk6K/duIx+tXFFJtqrwFTxZJ60RMDArlw4Zyw+aEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VEdIt0/v/fzK+vN7t7U2z+WA1nnPfBoq/begzNo/8j8=;
	b=NmJPSbdLnq2YWQk7ZatY9YTQI2JlRNb0CpyaHgs5pTetq7FnOpKenfgiq3WR6Gn1jJju
	 By9iChzBhPzxJyRI9QE9Uu7/hfBP2mc6MVvixmDI5tRB0tQxizVO/0NbOK1xjJSUECHei
	 ZnexE3CGVvMo8Rl6m2ZS9yZeMAXQvnkesYwAkRq2VqvvhgHrM7nN7GTquJi4Lo5d0W93M
	 aufWrG9qCCCRUXuiP/NLtRbVTYVSBlJ4W092GsHPWNeHUvGkdpw5bn2bYQ6pZPTSzeHcw
	 gLcrIl/7GYFwbk6yw9DPa7MMIKNMnxh0Tj7weK03S27wP0FrqID4OSRayYYxBAIXgyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=APpPiTAf;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0A7606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B0A7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=APpPiTAf
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso118314a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792984044; x=1793588844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEdIt0/v/fzK+vN7t7U2z+WA1nnPfBoq/begzNo/8j8=;
        b=APpPiTAfX5UeWUbFAzzWmgfAENKyXWb0HwjS5AkZPQdshl0mOBjAjoDt9EC/VOM7J/
         nxs/yVevM1kLk5thG/rqUWsy64bAFco68NYhvI9/HgWr154wVu1DUTgHUi1TLA6WuVHs
         F8nTbFx7U5S2bFQZn3n1FjJytco9wyb4pIPPPr/gS6YAvJHTIfJUA26Jyet69X8XrhCo
         D5Z9umK2LqqkgsjRN1ixDPVqF1kdqXlftMe93T7e9QjEdtJv22wz+iOz/mG3+GrivBnS
         bLiDmQs1tX3cYKRFsr2lVX3bVo7txLVWEMFib+G5uwDhxU5M2+WNxtZ1YVNdRJDItZpg
         H+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984044; x=1793588844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEdIt0/v/fzK+vN7t7U2z+WA1nnPfBoq/begzNo/8j8=;
        b=dQa3vpVG5maLF1MdqZCUgbugkJTxR6siQrTttmio+cOegItSw/AF7FAFp73BIvTjJt
         fbdfKd4T1ngBmZBswK/q+rOzLK9a8avwo2+hs+1wH3CrVFImWltBRynwZQdDo5DLfeXp
         /y6kC8mY2OE6fsIU2lHqnVxVsw7Z3F0EkKdRsSjSQXZWt93526gXc91AvnjvDXL45npi
         RwZdT6ZnE75X2Q8NZWO74Tv7WxF6hkf32hhiDBQezbC9dMWMIeHfkuczNk4nJmny2Q+t
         UKCnt8QkRGmKzX0oszw6BTelwjfa+Nnd4ZRWiaUYTR/1Ywrvxjw74cgnVMExtH7nnEbb
         /YUQ==
X-Gm-Message-State: AFq9FYJ9cimletMJ6ax3WWuVibPXPj6rrNYqANUbmXrtL+fdqxj19INz
	RBC+Id8uV9Nmo9BVaUXG2WQ6iWLJzPPQ7FRi+ihGCrgQ7tITclcKM6dqqIdZ9w==
X-Gm-Gg: AYBFou3uWKc/3R91e7wqdcp+Z1IyDPw/e7wrgLEO4PXdaPmciAZgqElWvAIoo43SR7w
	9tA3KcQD1VJQX0zXV6yWyw2gCKYHGYonNbqM6elW+fdzqejy6TEGxh5yVotLfuYZSxWNIg6VYXj
	e5UvQtj787qutpylD4lqjZciZdp54Bg0H8CFT57Yd0LQh8qm5siQo6uK5EGkrM4J8abQm73k+/l
	grD9WZNE6Cf6ung3qwh2fu9MFAgLLnJxvtpXqRRrKABHvT7DE3WMG2sBQFa40nZSK+6u+ti6itp
	WS/d1Lip9uEZmWFpAI8tGBFzgH2QC5IP/9aZy2iI4zog0jbDm7RkpTeaDoQUbC7ZloD/jxWq+h7
	dK24aNhyjgUjlJqXtJYhbWmH5DzuFgyUHNwmz9fXi8u23ukDoW+hppxTs4kH/ISEfq+WzRSVD8s
	sYipJjfgA8O0ck8MT0D1qkG1KlLSoe2T+33n39mmTXIfv+LUw69b+N/EFTQHLffMSld2Ai6P6H2
	Ukw+4fPtOv3ya23sihgfJv1NDd0tcaYuKoVoexp6liorDMPofxmKUM4/zQ3hduzUthwlmaqFKxP
	Gike+SGtC9hj+QLWb9oQbyRdYsOt6htcw0aTvNIyi4JHphbo6JQw4X3M+JK++XhgCDSJZ29KxBe
	I2VUGuxIrUIGrK7R+rahputVJ
X-Received: by 2002:a17:90b:4a86:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ade9b2cf34mr4235840a91.7.1792984043565;
        Sun, 25 Oct 2026 20:07:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0718esm6174554a91.11.2026.10.25.20.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:07:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 78/81] selftests/bpf: Test progs that run out of budget
Date: Mon, 26 Oct 2026 02:59:39 +0000
Message-ID: <20261026025943.404450-79-alexei.starovoitov@gmail.com>
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

The verifier does not prove that a prog ends. It adds may_goto to each loop
that it cannot bound, and a check to the entry of each recursive subprog.
Thus a run has a budget of time, stack and calls. A mistake in the added
code does not reject a prog. It locks up a cpu.

Load and run progs with such loops and such recursion. Many of them never
end without the added code. Each run must return, and the return value
shows where the prog continued.

The added may_goto ends the prog. When the prog holds a lock, it exits the
loop instead. That is unsafe when the code after the loop depends on the
condition of the loop, for example p != NULL. A subprog can also unwind:
'call f; unwind_goto pad' continues at pad, the landing pad, when f exits
with unwind_exit.

  the prog                                          result
  ------------------------------------------------  ---------------------
  a loop spins, the prog holds nothing              the prog ends, r0 = 0
  a loop spins under a lock, or with an iterator    the loop exits
  a lock is held, and to exit the loop is unsafe    reject
  a loop has no exit                                reject
  a loop or bpf_loop() calls a subprog that spins   the run returns
  may_goto of the prog does not exit the loop       the prog ends, r0 = 0
  a jump to itself, a loop with two entries         the prog ends, r0 = 0
  recursion is too deep, calls have no unwind_goto  the run returns
  recursion is too deep, calls have unwind_goto     the landing pad runs
  a landing pad does not release a lock             reject
  recursion is not deep, but makes 2^60 calls       the run returns
  recursion through the callback of bpf_loop()      the run returns
  recursion with an inlined bpf_loop()              stack <= 4096 bytes

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/verifier_budget.c     | 1159 +++++++++++++++++
 2 files changed, 1161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_budget.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 78bce26662c4..017b15fa4b6a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -29,6 +29,7 @@
 #include "verifier_bpf_get_stack.skel.h"
 #include "verifier_bpf_trap.skel.h"
 #include "verifier_bswap.skel.h"
+#include "verifier_budget.skel.h"
 #include "verifier_btf_array_access.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_flex_array.skel.h"
@@ -223,6 +224,7 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_u
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
+void test_verifier_budget(void)                { RUN(verifier_budget); }
 void test_verifier_btf_array_access(void)     { RUN(verifier_btf_array_access); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/testing/selftests/bpf/progs/verifier_budget.c
new file mode 100644
index 000000000000..c126ddb6bfd2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_budget.c
@@ -0,0 +1,1159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+/*
+ * The verifier adds may_goto to a loop that it cannot count and a check of
+ * the stack to a recursive subprog. What the program does when it is out of budget:
+ * - it unwinds, when unwind_goto follows every call of the subprog and the subprog
+ *   holds nothing of its own. The pads of the callers are verified.
+ * - the main prog and an async callback end
+ * - otherwise it leaves the loop, or returns 0 from the subprog
+ *
+ * It takes unwinding, per-cpu insns and timed may_goto in JIT. Some of the progs never end
+ * on their own.
+ */
+#define unwind_goto(off) ".8byte %[insn_unwind_goto_" #off "];"
+#define unwind_exit ".8byte %[insn_unwind_exit];"
+
+#define __imm_unwind_goto(off) \
+	__imm_insn(insn_unwind_goto_##off, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, BPF_UNWIND_GOTO, off, 0))
+#define __imm_unwind_exit \
+	__imm_insn(insn_unwind_exit, \
+		   BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0))
+
+extern void bpf_rcu_read_lock(void) __ksym;
+extern void bpf_rcu_read_unlock(void) __ksym;
+
+extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __ksym;
+extern int *bpf_iter_num_next(struct bpf_iter_num *it) __ksym;
+extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __ksym;
+
+/* The verifier doesn't know what is in there */
+unsigned long zero;
+unsigned long one = 1;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long);
+} empty SEC(".maps");
+
+struct locked {
+	struct bpf_spin_lock lock;
+	long val;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct locked);
+} locked SEC(".maps");
+
+SEC("socket")
+__description("budget: a loop in the main prog ends it")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_in_main(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a loop in the main prog that holds something is left")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_in_main_rcu(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"call %[bpf_rcu_read_lock];"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+/* 0 is not what this prog may return */
+SEC("cgroup/recvmsg4")
+__description("budget: a loop in the main prog that cannot return 0 is left")
+__arch_x86_64
+__arch_arm64
+__success
+__naked void loop_in_main_retval(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+/*
+ * do { p = lookup(); } while (!p); return *p;
+ * may_goto must not go where the loop goes when it's over: p may be NULL. Nothing is held, so
+ * it doesn't have to.
+ */
+SEC("socket")
+__description("budget: the code behind the loop counts on what the exit of the loop found out")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void exit_of_loop_checks_null(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+	"1:"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[empty] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1b;"
+		"r0 = *(u64 *)(r0 + 0);"
+		"exit;"
+		:
+		: __imm_addr(empty),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all
+	);
+}
+
+/* lock(); do { } while (one); unlock(); may_goto has to go where the lock is released */
+SEC("tc")
+__description("budget: a loop under a spin lock is left")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_under_spin_lock(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[locked] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 2f;"
+		"r6 = r0;"
+		"r7 = %[one] ll;"
+		"r1 = r6;"
+		"call %[bpf_spin_lock];"
+	"1:"
+		"r1 = *(u64 *)(r7 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r1 = r6;"
+		"call %[bpf_spin_unlock];"
+		"r0 = 1;"
+	"2:"
+		"exit;"
+		:
+		: __imm_addr(locked),
+		  __imm_addr(one),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_spin_lock),
+		  __imm(bpf_spin_unlock)
+		: __clobber_all
+	);
+}
+
+/* Both: there is no way out */
+SEC("socket")
+__description("budget: something is held and the code behind the loop counts on its exit")
+__arch_x86_64
+__arch_arm64
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void exit_of_loop_checks_null_rcu(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"call %[bpf_rcu_read_lock];"
+	"1:"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[empty] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1b;"
+		"r6 = *(u64 *)(r0 + 0);"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_addr(empty),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+/*
+ * if (x) lock(); do { } while (zero); if (x) unlock();
+ * The state that holds nothing gets to the loop first, and may_goto would leave the prog.
+ * Then comes the state that holds the lock. It must not take a new start for every loop.
+ */
+#define LOOP_MAYBE_LOCKED				\
+		"call %[bpf_get_prandom_u32];"		\
+		"r7 = r0;"				\
+		"if r7 == 0 goto 1f;"			\
+		"call %[bpf_rcu_read_lock];"		\
+	"1:"						\
+		"r1 = *(u64 *)(r6 + 0);"		\
+		"if r1 != 0 goto 1b;"			\
+		"if r7 == 0 goto 2f;"			\
+		"call %[bpf_rcu_read_unlock];"		\
+	"2:"
+
+SEC("socket")
+__description("budget: 10 loops that find out late that something is held")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loops_maybe_locked(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		LOOP_MAYBE_LOCKED
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm(bpf_get_prandom_u32),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long spins(void)
+{
+	asm volatile (
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+	);
+}
+
+/* the same, for the tests that call it another way */
+__naked __noinline __used
+static unsigned long spins_caught(void)
+{
+	asm volatile (
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+	);
+}
+
+SEC("socket")
+__description("budget: a loop in a subprog is left when there is no unwind_goto")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void loop_in_subprog(void)
+{
+	asm volatile (
+		"call spins;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a loop in a subprog unwinds when there is unwind_goto")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void loop_in_subprog_caught(void)
+{
+	asm volatile (
+		"call spins_caught;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long spins_caught2(void)
+{
+	asm volatile (
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+	);
+}
+
+SEC("socket")
+__description("budget: the pad releases what the caller holds")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void pad_unlocks(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"call spins_caught2;"
+		unwind_goto(4)
+		"r6 = r0;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = r6;"
+		"exit;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(4),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long spins_caught3(void)
+{
+	asm volatile (
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+	);
+}
+
+/* Nothing in the subprog unwinds. The pad is looked at because of may_goto that is added. */
+SEC("socket")
+__description("budget: the pad forgets what the caller holds")
+__arch_x86_64
+__arch_arm64
+__failure __msg("cannot be used inside bpf_rcu_read_lock-ed region")
+__naked void pad_forgets(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"call spins_caught3;"
+		unwind_goto(4)
+		"r6 = r0;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = r6;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(4),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+/* There is no pad for what the subprog took itself */
+__naked __noinline __used
+static unsigned long spins_locked(void)
+{
+	asm volatile (
+		"call %[bpf_rcu_read_lock];"
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+	);
+}
+
+SEC("socket")
+__description("budget: a loop in a subprog that holds something is left")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void loop_in_subprog_locked(void)
+{
+	asm volatile (
+		"call spins_locked;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long spins_cb(void)
+{
+	asm volatile (
+		"r2 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+	);
+}
+
+SEC("socket")
+__description("budget: a loop in a callback is left")
+__arch_x86_64
+__arch_arm64
+__success __retval(3)
+__naked void loop_in_callback(void)
+{
+	asm volatile (
+		"r1 = 3;"
+		"r2 = spins_cb ll;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"exit;"
+		:
+		: __imm(bpf_loop)
+		: __clobber_all
+	);
+}
+
+/* r1: how deep to go. Returns the sum of 1 .. r1 */
+__naked __noinline __used
+static unsigned long sum_to(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"r6 = r1;"
+		"r1 += -1;"
+		"call sum_to;"
+		"r0 += r6;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: recursion")
+__arch_x86_64
+__arch_arm64
+__success __retval(55)
+__naked void recursion(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"call sum_to;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* The one that is called too deep returns 0: 1000 + 999 + ... down to where it was */
+SEC("socket")
+__description("budget: recursion that is too deep returns 0 when there is no unwind_goto")
+__arch_x86_64
+__arch_arm64
+__success
+__naked void recursion_too_deep(void)
+{
+	asm volatile (
+		"r1 = 1000;"
+		"call sum_to;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+unsigned long stack_top, stack_bottom;
+
+__naked __noinline __used
+static unsigned long does_nothing_cb(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/* Inlined bpf_loop() takes 3 slots of the stack and 3 registers that have to be saved. */
+__naked __noinline __used
+static unsigned long sum_to_with_loop(void)
+{
+	asm volatile (
+		"r2 = %[stack_bottom] ll;"
+		"*(u64 *)(r2 + 0) = r10;"
+		"if r1 != 0 goto 1f;"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"r6 = r1;"
+		"r1 = 1;"
+		"r2 = does_nothing_cb ll;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r1 = r6;"
+		"r1 += -1;"
+		"call sum_to_with_loop;"
+		"r0 += r6;"
+		"exit;"
+		:
+		: __imm_addr(stack_bottom),
+		  __imm(bpf_loop)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: frames of a recursion with inlined bpf_loop() fit in 4096 bytes")
+__arch_x86_64
+__success __retval(1)
+__naked void recursion_with_inlined_loop(void)
+{
+	asm volatile (
+		"r2 = %[stack_top] ll;"
+		"*(u64 *)(r2 + 0) = r10;"
+		"r1 = 1000;"
+		"call sum_to_with_loop;"
+		"r1 = %[stack_top] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r2 = %[stack_bottom] ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 -= r2;"
+		"r0 = 1;"
+		"if r1 <= 4096 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(stack_top),
+		  __imm_addr(stack_bottom)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long sum_to_caught(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 0;"
+		"exit;"
+	"1:"
+		"r6 = r1;"
+		"r1 += -1;"
+		"call sum_to_caught;"
+		unwind_goto(2)
+		"r0 += r6;"
+		"exit;"
+		"r0 = 0;"
+		unwind_exit
+		:
+		: __imm_unwind_goto(2),
+		  __imm_unwind_exit
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: recursion with unwind_goto")
+__arch_x86_64
+__arch_arm64
+__success __retval(55)
+__naked void recursion_caught(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"call sum_to_caught;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: recursion that is too deep unwinds")
+__arch_x86_64
+__arch_arm64
+__success __retval(42)
+__naked void recursion_too_deep_caught(void)
+{
+	asm volatile (
+		"r1 = 1000;"
+		"call sum_to_caught;"
+		unwind_goto(1)
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(1)
+		: __clobber_all
+	);
+}
+
+/* r1: how deep to go. It calls itself twice: 2^r1 calls */
+__naked __noinline __used
+static unsigned long calls_itself_twice(void)
+{
+	asm volatile (
+		"if r1 != 0 goto 1f;"
+		"r0 = 1;"
+		"exit;"
+	"1:"
+		"r6 = r1;"
+		"r1 += -1;"
+		"call calls_itself_twice;"
+		"r7 = r0;"
+		"r1 = r6;"
+		"r1 += -1;"
+		"call calls_itself_twice;"
+		"r0 += r7;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: recursion that is not deep, 2^10 calls")
+__arch_x86_64
+__arch_arm64
+__success __retval(1024)
+__naked void recursion_tree(void)
+{
+	asm volatile (
+		"r1 = 10;"
+		"call calls_itself_twice;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* There is room in the stack for 60 frames. The number of calls has to be limited too. */
+SEC("socket")
+__description("budget: recursion that is not deep, 2^60 calls")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void recursion_tree_forever(void)
+{
+	asm volatile (
+		"r1 = 60;"
+		"call calls_itself_twice;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* The calls are counted in a run of the prog, not from the call that starts a recursion */
+SEC("socket")
+__description("budget: a loop that calls a subprog that calls itself 2^60 times")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void loop_calls_recursion_tree(void)
+{
+	asm volatile (
+		"r8 = %[one] ll;"
+	"1:"
+		"r1 = 60;"
+		"call calls_itself_twice;"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+/*
+ * Every frame loops forever and calls itself in every trip. When the recursion is out of
+ * budget every call returns at once, 65535 times in every frame that is on the stack.
+ * It has to be cheap: the report is printed once.
+ */
+__naked __noinline __used
+static unsigned long calls_itself_in_a_loop(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+	"1:"
+		"call calls_itself_in_a_loop;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(one)
+	);
+}
+
+SEC("socket")
+__description("budget: a subprog that calls itself in a loop that never ends")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void recursion_in_a_loop(void)
+{
+	asm volatile (
+		"call calls_itself_in_a_loop;"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * calls_loop() -> bpf_loop() -> loop_cb() -> calls_loop(): the frames of the helper are on
+ * the stack too
+ */
+static int loop_cb(__u32 i, void *ctx);
+
+static __noinline int calls_loop(int x)
+{
+	bpf_loop(1, loop_cb, NULL, 0);
+	return 0;
+}
+
+static __noinline int loop_cb(__u32 i, void *ctx)
+{
+	return calls_loop(i);
+}
+
+SEC("socket")
+__description("budget: recursion through a helper that calls a callback")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int recursion_through_callback(void *ctx)
+{
+	return calls_loop(0);
+}
+
+/*
+ * There is one time slice for a run of the prog, not one for every call of a subprog.
+ * The subprogs below use it up, leave their loops and return. Their callers call them again.
+ */
+__naked __noinline __used
+static unsigned long spins_and_returns(void)
+{
+	asm volatile (
+		"r2 = %[one] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(one)
+	);
+}
+
+SEC("socket")
+__description("budget: a loop that calls a subprog that spins")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void loop_calls_spinning_subprog(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+	"1:"
+		"call spins_and_returns;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: bpf_loop() that calls a callback that spins 8M times")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void bpf_loop_calls_spinning_callback(void)
+{
+	asm volatile (
+		"r1 = 0x800000;"
+		"r2 = spins_and_returns ll;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm(bpf_loop)
+		: __clobber_all
+	);
+}
+
+/*
+ * may_goto of the program stops the loop that it leaves. This one goes to itself
+ * when it is out of budget. The loop spins until may_goto that is added ends the prog.
+ */
+SEC("socket")
+__description("budget: may_goto that doesn't leave the loop")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void may_goto_stays_in_loop(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+	"1:"
+		".8byte %[may_goto_self];"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_insn(may_goto_self, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, -1, 0))
+		: __clobber_all
+	);
+}
+
+/* The jump to itself has to go through may_goto that is added in front of it */
+SEC("socket")
+__description("budget: a conditional jump to itself")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void jump_to_itself(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		"r1 = *(u64 *)(r6 + 0);"
+	"1:"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+/* A cycle with two entries: there is no insn that every way into it goes through */
+SEC("socket")
+__description("budget: a loop with two entries")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void loop_with_two_entries(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 2f;"
+	"1:"
+		"r2 = *(u64 *)(r6 + 0);"
+		"if r2 == 0 goto 3f;"
+	"2:"
+		"r3 = *(u64 *)(r6 + 0);"
+		"if r3 != 0 goto 1b;"
+	"3:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+/*
+ * may_goto in front of a loop with two entries dominates the back edge, like everything on
+ * the way to the loop does when the head of the loop doesn't. It's not in the loop.
+ */
+SEC("socket")
+__description("budget: may_goto in front of a loop with two entries")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void may_goto_before_loop_with_two_entries(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		".8byte %[may_goto_0];"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+	"1:"
+		"r2 = *(u64 *)(r6 + 0);"
+	"2:"
+		"r3 = *(u64 *)(r6 + 0);"
+		"if r3 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_insn(may_goto_0, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0))
+		: __clobber_all
+	);
+}
+
+/* It leaves the inner loop. The outer loop goes on. */
+SEC("socket")
+__description("budget: may_goto that leaves the inner loop only")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void may_goto_leaves_inner_loop(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+	"1:"
+		".8byte %[may_goto_2];"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_insn(may_goto_2, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 2, 0))
+		: __clobber_all
+	);
+}
+
+/*
+ * bpf_iter_num_next() stops the loop that the program leaves when there is nothing left.
+ * This one goes on. The iterator is held, so the loop is left when it is out of budget.
+ */
+SEC("socket")
+__description("budget: a loop that goes on when its iterator is drained")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_after_iter_is_drained(void)
+{
+	asm volatile (
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+		"r6 = %[one] ll;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy)
+		: __clobber_all
+	);
+}
+
+/*
+ * The loop at 3: spins. It has no jump that every trip goes through, so may_goto is at its head.
+ * The first way out of it, from 2: to 1:, is the back edge of the loop at 1:, which
+ * has no may_goto of its own: bpf_iter_num_next() stops it. From the head of 3: to 1: there is
+ * no bpf_iter_num_next().
+ */
+SEC("socket")
+__description("budget: may_goto at the head of a loop leaves the loops around it too")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void guard_at_head_of_nested_loop(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		"r9 = %[zero] ll;"
+		"r7 = 0;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 2;"
+		"call %[bpf_iter_num_new];"
+		"call %[bpf_rcu_read_lock];"
+		"r7 += 1;"
+		"goto 1f;"
+	"2:"
+		"r7 += 1;"
+		"r1 = *(u64 *)(r9 + 0);"
+		"if r1 != 0 goto 4f;"
+		"r1 = *(u64 *)(r9 + 0);"
+		"if r1 != 0 goto 4f;"
+	"1:"
+		"r7 += 1;"
+		"r1 = *(u64 *)(r6 + 0);"
+	"5:"
+		"if r1 == 0 goto 5b;"
+	"3:"
+		"r1 = *(u64 *)(r9 + 0);"
+		"if r1 != 0 goto +0;"
+	"4:"
+		"r7 += 1;"
+		"r1 = *(u64 *)(r9 + 0);"
+		"if r1 == 0 goto 3b;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 == 0 goto 6f;"
+		"r1 = *(u64 *)(r9 + 0);"
+		"if r1 == 0 goto 2b;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 4b;"
+	"6:"
+		"call %[bpf_rcu_read_unlock];"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(one),
+		  __imm_addr(zero),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm(bpf_rcu_read_lock),
+		  __imm(bpf_rcu_read_unlock)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a loop without an exit that is not entered at its head")
+__arch_x86_64
+__arch_arm64
+__failure __msg("never exits")
+__naked void loop_without_exit_two_entries(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r0 = 0;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+	"1:"
+		"r0 += 1;"
+	"2:"
+		"goto 1b;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a loop without an exit")
+__arch_x86_64
+__arch_arm64
+__failure __msg("never exits")
+__naked void loop_without_exit(void)
+{
+	asm volatile (
+		"r0 = 0;"
+	"1:"
+		"r0 += 1;"
+		"goto 1b;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * BTF FUNC records are not generated for kfuncs referenced
+ * from inline assembly. These records are necessary for
+ * libbpf to link the program. The function below is a hack
+ * to ensure that BTF FUNC records are generated.
+ */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_iter_num_new(0, 0, 0);
+	bpf_iter_num_next(0);
+	bpf_iter_num_destroy(0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0


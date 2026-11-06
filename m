Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937334;
	b=wmusIpMASoiw50XYjfq6txPwntiPlW2HeSmxh1PPUW3paZHhCijOTDbJlSZv20Wxx3Ja
	 Jwza8hSjHNVqXoZ8q0wiVKwLYQM7colhJv02+GPFptuWGx+iPFi/z6YIolFBmqOZU35iN
	 o/Ph6RESOy9Gbs2FQi6Toj8of6iUO29s4QWti/yB0bFxDSlDmZRPIPTkcrEas2V2Rm7+e
	 v4AVix2rsTXHJNKpcCF8fDMO1soxJv+oLXddgt8jhbtA5HUsdykDb5SHI+fnuSiELCcL3
	 sHHuwp687w7c0se8CFtx9ziCVBcbk+zfC5tUUstUYjfaBIbmtFMpzp2sW4ELWXdZOIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VjlrfB/Tbhwwv57RyiMtgtoaSpzQGbFaBatZ8ft3g9w=;
	b=C9IxbWMUkra3q7dNpNNEOujjsMORijPAasNhTHybplortU5++iEzeK1XyCg1JMnLwz6N
	 roXQYVyPC0++F06H4ZZWxIwr8mgN5IEz03WZaxdnTlP9aWeRXe2vza1xi/LxY0CXPPP7H
	 qdBLEs2zpRyqWRA7/EcwitKQ9NQEMIAJy9ouMoA3neThEisEmn0wD72IevjiGjC8vX1DV
	 SP4NVx20ELIeDIsGeqYT4ybpUrfXjEEpQocZQHMmiPHM+J0Ljq6aNKyBAkE425QdwAb4f
	 1rDYc44shDMD0MqCLFGXlCup5w12qin3TLOtCeRF/8bpegojGlBhMRONc9kiG3G4L/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEmfqi8O;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DA606A31B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 03:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F3DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uEmfqi8O
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e96502e447so1796765ad.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 19:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793937333; x=1794542133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjlrfB/Tbhwwv57RyiMtgtoaSpzQGbFaBatZ8ft3g9w=;
        b=uEmfqi8Ok8WipHA90AQirQw7RNk5NXPj+/AMncpw6A67AZp+FAHUH0PkoWShS9WjnX
         1j0uSYiMkpdKBW5YGeaQld82iKLFVGQvMJLwagmfoMkMua3FrM0LRTgtXiltPAMeZuIS
         dSVIZuEe+aQ1S+x+6v+VQZb4QAfjmw7kFaPMnKSPr62MfljVY7qX93VVO2cOg8RpvmG/
         LZZeeBDNJZkGeIQPwKZoyIon+1tdXPxBor8FfsyeJppSzan8aVltwtONqdRlnFk5PDJ3
         kBVwwCxlD36SkecMxuATSMcZmt5b2qCoOK3k/w8JKKYOCcnKtI2iYK4/XxYWHCk0+nQY
         NOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793937333; x=1794542133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VjlrfB/Tbhwwv57RyiMtgtoaSpzQGbFaBatZ8ft3g9w=;
        b=t0Uwh6K3BSkmb3MY5SzFyrDVjwYBD7TR1iI3nkKEMOC+pDY/KxFCMhjIy2GUyPMlMw
         rbKy/b406XUi/yDFH2/Ocl+rbeM6fIUfBEwJEit8oRa0Jo+HrQVF4g2P6hZwAscsxXua
         T172IUgvBtnitEEphxCQmjjGnd5ky/VGpdsNoPz05ibcSwI6q91NZJjb9YTYAeq4Q0Fd
         PC5xxzNOgHl6CJx79aNiajzlyeZSAASbNaGcYBwI+ziD4jaHGEzf8ZqxfYmiSLWKcoJl
         9fzoWj09VajfdYTo4mGm4MmFfQo8GbipCjEvzWfWBpgw1G+YPnK7jtSQdkOHnwnoChTI
         hQuQ==
X-Gm-Message-State: APuU4Z/zbSNDojSt1Kg8vbwGIYmbGYt/eYIR/p6H+r1Zi4eXB5es/cU8
	JirJsXTVQ4Hwv52KyOEKYb3L3tStttqz+LqSiwRPUs0Lbowfn3vLmdiFyVyZjQ==
X-Gm-Gg: AYBFou2vmVxOUIyj6j+rgzu1zemPeD21AqVoIxGQLNOHDWFlxuFYrlU5mj0smYOjczC
	pAuh1q2MMKeAOIzov5QrR9kpRZ4HORk+XiuWbTyvbizlzIvLsBYzPnojyQsR1LEJemlf/T6n5VH
	WpQJ8IddXCES2tBUFcOQf/8zU9cI7SouTW++s0JIwXWS7f/AMXt5ldctg92qNKeZIvVK+3kh6hj
	z2gdprOY9/MhOU5SK6lhU3i0HpyNOHtMof5oRlhkK2WzxjRtWeWx/g4XaI8SlMBFYryzYsyM6Zh
	H5pDaeKobVUrYmtfw53rm5eaXQXZ8aRlIKVa4kTx+e2NPN6FZe2XLjLnz8rbyK98na7g1HTgmlF
	9RTQbw9Z1MInzZG2fzDFgDmdfCT8KiEdRQY7MKZMo4vkV2GCfM4kFI/u4foJdyTbogmvp6SWOBW
	lxvmeJIRSGV8P1hnX+zGHXQyyvjkkW4bsBjCgnhpaaFMbJaY2wgJaaA4v/HOzeNORAG6MheXQVn
	CaFXoUwyXJ+6MDW87PKutHsPli8Zk1srbuA6xMU/SFHybbb9B5/DNdKjxjiajHGjbnPutuOgd1r
	P5BJGgJ39OOD8RfERfk079M5f7/nH683EdEMVXZVnSP5skeUm2VUbmRBe6+oc9DXtYg0RvybJhk
	Ue/Jrwd/fWgJxfkZB/l7NzOH3+MnvfvbX8WToidELPVsJXKU2x3ysUGIpgSko+DFT4eTF7v1TCQ
	==
X-Received: by 2002:a17:90b:55cb:b0:3ae:c413:c07e with SMTP id 98e67ed59e1d1-3b0db6bbab2mr1269344a91.14.1793937332409;
        Thu, 05 Nov 2026 19:55:32 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b90def97sm5755463a91.7.2026.11.05.19.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:55:32 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 44/45] selftests/bpf: Test progs that run out of budget
Date: Fri,  6 Nov 2026 03:51:08 +0000
Message-ID: <20261106035111.3315285-45-alexei.starovoitov@gmail.com>
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

The verifier does not prove that a prog ends. It adds may_goto to each loop
that it cannot bound, and a check to the entry of each recursive subprog.
A prog is out of budget when may_goto times out or the check fails. No
other test gets there: a mistake in the added code rejects nothing, it
locks up a cpu, or the prog goes on along an edge that nobody verified.
Load and run such progs. Each invocation must return, and the return value
shows where the prog went on.

  [G] "bpf: Add may_goto to the loops that the verifier marks"
  [P] "bpf: Order the insns, find what stops a loop and where may_goto
      can go"
  [F] "bpf: Verify programs as a fixpoint over the control flow graph"
  [R] "bpf: Limit depth and time of recursive subprogs at run time",
      "bpf: Allow recursive subprogs"
  [E] "bpf: R0 is live at the exit that an added may_goto goes to"

  the prog                                        out of budget
  ----------------------------------------------  -------------------------
  a loop, the prog holds nothing                  [G] the prog ends
  the same, the last exit is dead code            [E] the prog ends
  a loop under a lock                             [G] the loop exits
  the same, the code after it needs p != NULL     [G] reject
  a loop in a subprog                             [G] the loop exits
  the same, the call has unwind_goto              [G] the subprog unwinds
  a landing pad does not release a lock           [G] reject
  all registers are live at the added may_goto    [G] none of them changes
  a loop has no exit, a nest of 17 loops          [F] [P] reject
  may_goto of the prog does not leave the loop,   [P] may_goto at the head,
  a jump to itself, a loop with two entries       the prog ends
  an iterator does not stop the loop around it    [F] the prog ends
  recursion is too deep, no unwind_goto           [R] the subprog returns 0
  the kernel stack where such a recursion ends    [R] a half of it is free
  recursion is too deep, calls have unwind_goto   [R] the landing pad runs
  recursion is not deep, but makes 2^60 calls     [R] the prog returns
  recursion through bpf_loop(), or in a loop      [R] the prog returns
  recursion through a global subprog and a table  [R] reject
  a timer callback arms itself again              [R] no recursion

The edge of an added may_goto is an edge of the prog. 10 more progs are
unsafe only on this edge: a register that only the loop sets, a bound of
the next loop, a loop that is counted for one state or call and gets
may_goto for a different one ([P], [F]). The verifier must reject them.

verifier_budget.c is serial, like timed_may_goto: its progs spin for 250 ms
in an RCU read-side critical section, one after the other. It takes 5 sec.
verifier_callx.c gets a test of packet pointers after callx of an argument.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |    3 +
 .../selftests/bpf/progs/verifier_budget.c     | 1898 +++++++++++++++++
 .../selftests/bpf/progs/verifier_callx.c      |   33 +
 .../bpf/progs/verifier_callx_rodata.c         |   51 +
 4 files changed, 1985 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_budget.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 978d6d7773ca..71ccd1e94bb2 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -31,6 +31,7 @@
 #include "verifier_bpf_get_stack.skel.h"
 #include "verifier_bpf_trap.skel.h"
 #include "verifier_bswap.skel.h"
+#include "verifier_budget.skel.h"
 #include "verifier_btf_array_access.skel.h"
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_flex_array.skel.h"
@@ -236,6 +237,8 @@ void test_verifier_bounds_mix_sign_unsign(void) { RUN(verifier_bounds_mix_sign_u
 void test_verifier_bpf_get_stack(void)        { RUN(verifier_bpf_get_stack); }
 void test_verifier_bpf_trap(void)             { RUN(verifier_bpf_trap); }
 void test_verifier_bswap(void)                { RUN(verifier_bswap); }
+/* Serial: many progs spin for 250 ms in an RCU read-side critical section, see timed_may_goto.c */
+void serial_test_verifier_budget(void)        { RUN(verifier_budget); }
 void test_verifier_btf_array_access(void)     { RUN(verifier_btf_array_access); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_flex_array(void)       { RUN(verifier_btf_flex_array); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/testing/selftests/bpf/progs/verifier_budget.c
new file mode 100644
index 000000000000..4118d8152f37
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_budget.c
@@ -0,0 +1,1898 @@
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
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 2);
+	__type(key, int);
+	__type(value, long[2]);
+} pairs SEC(".maps");
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
+__description("budget: a loop in the main prog ends it, the last exit is dead code")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void loop_in_main_dead_exit(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		"if r6 != 0 goto 2f;"
+		"r6 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 1;"
+		"exit;"
+	"2:"
+		"r0 = 2;"
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
+ * may_goto must not go where the loop goes when it's over: p may be NULL. Something is held, so
+ * it cannot end the prog either: there is no way out.
+ */
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
+__naked __noinline __used
+static unsigned long spins(void)
+{
+	asm volatile (
+		"r2 = %[one] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(one)
+	);
+}
+
+/* the same, for the tests that call it another way */
+__naked __noinline __used
+static unsigned long spins_caught(void)
+{
+	asm volatile (
+		"r2 = %[one] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(one)
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
+__success __retval(42)
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
+		"r2 = %[one] ll;"
+	"1:"
+		"r1 = *(u64 *)(r2 + 0);"
+		"if r1 != 0 goto 1b;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 7;"
+		"exit;"
+		:
+		: __imm_addr(one),
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
+/*
+ * The one that is called too deep returns 0: 1000 + 999 + ... down to where it was: more than
+ * 1000, less than 500500
+ */
+SEC("socket")
+__description("budget: recursion that is too deep returns 0 when there is no unwind_goto")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void recursion_too_deep(void)
+{
+	asm volatile (
+		"r1 = 1000;"
+		"call sum_to;"
+		"r1 = r0;"
+		"r0 = 0;"
+		"if r1 <= 1000 goto +2;"
+		"if r1 >= 500500 goto +1;"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+unsigned long lowest_r10;
+
+__naked __noinline __used
+static unsigned long goes_down(void)
+{
+	asm volatile (
+		"r2 = %[lowest_r10] ll;"
+		"*(u64 *)(r2 + 0) = r10;"
+		"call goes_down;"
+		"exit;"
+		:
+		: __imm_addr(lowest_r10)
+		: __clobber_all
+	);
+}
+
+/*
+ * The stack of a task is aligned to its size, 16K at least. r10 of the last frame whose body
+ * runs is right above the middle.
+ */
+SEC("socket")
+__description("budget: recursion ends in the middle of the kernel stack")
+__arch_x86_64
+__arch_arm64
+__success __retval(1)
+__naked void recursion_ends_in_the_middle(void)
+{
+	asm volatile (
+		"call goes_down;"
+		"r1 = %[lowest_r10] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r1 += 64;"
+		"r1 &= 8191;"
+		"r0 = 1;"
+		"if r1 < 256 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(lowest_r10)
+		: __clobber_all
+	);
+}
+
+__naked __noinline __used
+static unsigned long has_large_frame(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 1024) = r1;"
+		"call has_large_frame;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* The limit on the stack of a chain of calls has the frame of a recursive subprog in it */
+SEC("socket")
+__description("budget: one frame of a recursive subprog counts in the depth of the stack")
+__arch_x86_64
+__arch_arm64
+__failure __msg("combined stack size of 2 calls is 2560. Too large")
+__naked void recursion_with_large_frames(void)
+{
+	asm volatile (
+		"*(u64 *)(r10 - 1536) = r1;"
+		"call has_large_frame;"
+		"exit;"
+		::: __clobber_all
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
+/* 61 frames fit in the stack. The check begins with may_goto: the time is limited too. */
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
+/* The time slice is for an invocation of the prog, not for the call that starts a recursion */
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
+ * Every frame loops forever and calls itself in every trip. The call that finds no room in the
+ * stack returns at once. When the time slice is over every frame that is on the stack leaves
+ * its loop.
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
+	bpf_loop(1, loop_cb, NULL, zero);
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
+struct timer {
+	struct bpf_timer t;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct timer);
+} timers SEC(".maps");
+
+__naked __noinline __used
+static int arms_itself(void)
+{
+	asm volatile (
+		"r1 = r3;"
+		"r2 = %[arms_itself] ll;"
+		"call %[bpf_timer_set_callback];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(arms_itself), __imm(bpf_timer_set_callback)
+		: __clobber_all
+	);
+}
+
+/* The helper keeps the callback for later. There is nothing to count, on any architecture. */
+SEC("socket")
+__description("budget: a callback that arms itself again is not a recursion")
+__success
+__xlated("...")
+__xlated("exit")
+__xlated("r1 = r3")
+__naked void callback_arms_itself(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[timers] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r1 = r0;"
+		"r2 = %[arms_itself] ll;"
+		"call %[bpf_timer_set_callback];"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(timers), __imm_addr(arms_itself), __imm(bpf_map_lookup_elem),
+		  __imm(bpf_timer_set_callback)
+		: __clobber_all
+	);
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long);
+} hash SEC(".maps");
+
+static __noinline int sleeps_at_the_bottom(int n, void *user_ptr)
+{
+	char buf[8];
+
+	if (n)
+		return sleeps_at_the_bottom(n - 1, user_ptr) + 1;
+	return bpf_copy_from_user(buf, sizeof(buf), user_ptr);
+}
+
+static int calls_what_sleeps(void *map, void *key, void *value, void *ctx)
+{
+	return sleeps_at_the_bottom(1, (void *)zero) & 1;
+}
+
+SEC("syscall")
+__description("budget: recursion in a sleepable prog can sleep")
+__arch_x86_64
+__arch_arm64
+__success
+int recursion_sleeps(void *ctx)
+{
+	return sleeps_at_the_bottom(1, (void *)zero) & 1;
+}
+
+/* The frames of the callers are not there when a recursive subprog is verified */
+SEC("syscall")
+__description("budget: recursion in a callback that runs under rcu_read_lock() cannot sleep")
+__arch_x86_64
+__arch_arm64
+__failure __msg("sleepable helper bpf_copy_from_user#148 in callback running under rcu_read_lock")
+int recursion_sleeps_in_rcu_callback(void *ctx)
+{
+	bpf_for_each_map_elem(&hash, calls_what_sleeps, NULL, 0);
+	return 0;
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
+ * bpf_iter_num_next() stops the loops that the program entered after it made the iterator.
+ * The loop around bpf_for() makes a new one in every trip, so it gets may_goto. It ends on its own
+ * after a time that is much longer than the budget.
+ */
+unsigned long trips, sum;
+unsigned long many = 1UL << 32;
+
+SEC("socket")
+__description("budget: the iterator of bpf_for() doesn't stop the loop around it")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+int loop_around_bpf_for(void *ctx)
+{
+	volatile unsigned long *cnt = &trips, *max = &many;
+	int i;
+
+	do {
+		bpf_for(i, 0, 2)
+			sum += i;
+		(*cnt)++;
+	} while (*cnt < *max);
+	return 1;
+}
+
+/*
+ * The first time the outer loop counts on bpf_iter_num_next(): its trips are joined, r7 is not
+ * known and the store is refused. All is done again, the loop is walked, r7 is 27 and the store is
+ * dead code. Where the first time got to doesn't count.
+ */
+SEC("socket")
+__description("budget: an insn that is reached only before all is done again is dead code")
+__arch_x86_64
+__arch_arm64
+__success
+__xlated("...")
+__xlated("if r6 < 0x3 goto pc-{{[0-9]+}}")
+__xlated("r0 = 0")
+__xlated("exit")
+__naked void insn_of_dropped_round(void)
+{
+	asm volatile (
+		"r6 = 0;"
+		"r7 = 1;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 10;"
+		"call %[bpf_iter_num_new];"
+	"2:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 != 0 goto 2b;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		"r7 *= 3;"
+		"r6 += 1;"
+		"if r6 == 1 goto 1b;"
+		"if r6 < 3 goto 1b;"
+		"if r7 == 27 goto 3f;"
+		"r1 = 0;"
+		"*(u64 *)(r1 + 0) = r1;"
+	"3:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_iter_num_new),
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
+#define NEST(n, body)	#n ": call %[bpf_get_prandom_u32];" body "if r0 == " #n " goto " #n "b;"
+#define NEST4(a, b, c, d, body)	NEST(a, NEST(b, NEST(c, NEST(d, body))))
+
+/* It's refused before anything goes up the nest from each of its insns */
+SEC("socket")
+__description("budget: a nest of 17 loops")
+__failure __msg("Too many nested loops at")
+__naked void nest_of_17_loops(void)
+{
+	asm volatile (
+		NEST4(1, 2, 3, 4, NEST4(5, 6, 7, 8, NEST4(9, 10, 11, 12,
+		NEST4(13, 14, 15, 16, NEST(17, "")))))
+		"r0 = 0;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32) : __clobber_all);
+}
+
+/*
+ * The loops below spin and have no jump that every trip goes through, so may_goto is at the head.
+ * It goes to the code behind the loop, past what the loop makes for that code, with the registers
+ * and the stack as they are at the head.
+ *
+ * r6 is 5 on every edge of the program that gets behind the loop. At the head it's 7.
+ */
+__naked __noinline __used
+static unsigned long spins_and_makes(void)
+{
+	asm volatile (
+		"r8 = %[one] ll;"
+		"r6 = 7;"
+	"1:"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if r1 == 1 goto 1b;"
+		"r6 = 5;"
+		"if r1 != 2 goto 1b;"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop keeps a register that the loop sets")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void guard_at_head_keeps_reg(void)
+{
+	asm volatile (
+		"call spins_and_makes;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* Only the loop sets r6 */
+__naked __noinline __used
+static unsigned long spins_and_makes_unset(void)
+{
+	asm volatile (
+		"r8 = %[zero] ll;"
+	"1:"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if r1 == 1 goto 1b;"
+		"r6 = 5;"
+		"if r1 != 2 goto 1b;"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop, a register that only the loop sets")
+__failure __msg("R6 !read_ok")
+__naked void guard_at_head_unset_reg(void)
+{
+	asm volatile (
+		"call spins_and_makes_unset;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* fp-8 is 0 on every edge of the program that gets behind the loop. It's dead at the head. */
+__naked __noinline __used
+static unsigned long spins_and_makes_slot(void)
+{
+	asm volatile (
+		"r8 = %[zero] ll;"
+		"r7 = 1;"
+		"*(u64 *)(r10 - 8) = r7;"
+		"r7 = 0;"
+	"1:"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if r1 == 1 goto 1b;"
+		"*(u64 *)(r10 - 8) = r7;"
+		"if r1 != 2 goto 1b;"
+		"r0 = *(u64 *)(r10 - 8);"
+		"r0 <<= 3;"
+		"r8 += r0;"
+		"r0 = *(u64 *)(r8 + 0);"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop, a stack slot that is dead there")
+__failure __msg("slot poisoned by dead code elimination")
+__naked void guard_at_head_dead_slot(void)
+{
+	asm volatile (
+		"call spins_and_makes_slot;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * The low half of r7 is live at the head of the loop, all of it where may_goto goes. On the edges
+ * of the program that get there it's 3. 'w7 &= 7' has to clear the upper half.
+ */
+__naked __noinline __used
+static unsigned long spins_with_half_of_reg(void)
+{
+	asm volatile (
+		"r8 = %[zero] ll;"
+		"r7 = *(u64 *)(r8 + 0);"
+		"w7 &= 7;"
+	"1:"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if w1 == w7 goto 1b;"
+		"r7 = 3;"
+		"if r1 == 2 goto 2f;"
+		"w7 = 5;"
+		"goto 1b;"
+	"2:"
+		"r0 = r7;"
+		"r0 >>= 32;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop, one half of a register is live there")
+__arch_x86_64
+__arch_arm64
+__flag(BPF_F_TEST_RND_HI32)
+__success __retval(0)
+__naked void guard_at_head_half_of_reg(void)
+{
+	asm volatile (
+		"call spins_with_half_of_reg;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * From the head of a loop to the code behind it is not an edge of the program. What holds on
+ * every edge of the program that gets there doesn't hold when may_goto does.
+ */
+const volatile unsigned long four = 4;
+char five_bytes[5] SEC(".data.five_bytes");
+
+/*
+ * r7 points to 'four' on every edge. At the head of the first loop it points to @at_head.
+ * The second loop goes on while r6 is less than what r7 points to.
+ */
+#define SPINS_THEN_COUNTS(at_head)			\
+		"r8 = %[zero] ll;"			\
+		"r7 = %[" #at_head "] ll;"		\
+	"1:"						\
+		"r2 = *(u64 *)(r7 + 0);"		\
+		"r1 = *(u64 *)(r8 + 0);"		\
+		"if r1 == 1 goto 1b;"			\
+		"r7 = %[four] ll;"			\
+		"if r1 == 2 goto 2f;"			\
+		"r7 = %[" #at_head "] ll;"		\
+		"goto 1b;"				\
+	"2:"						\
+		"r6 = 0;"				\
+	"3:"						\
+		"r2 = *(u64 *)(r7 + 0);"		\
+		"if r6 >= r2 goto 4f;"			\
+		"r1 = %[five_bytes] ll;"		\
+		"r1 += r6;"				\
+		"r3 = 1;"				\
+		"*(u8 *)(r1 + 0) = r3;"			\
+		"r6 += 1;"				\
+		"goto 3b;"				\
+	"4:"						\
+		"r0 = r6;"				\
+		"exit;"					\
+		:					\
+		: __imm_addr(zero),			\
+		  __imm_addr(one),			\
+		  __imm_addr(four),			\
+		  __imm_addr(five_bytes)		\
+		: __clobber_all
+
+__naked __noinline __used
+static unsigned long spins_then_counts_to_anything(void)
+{
+	asm volatile (SPINS_THEN_COUNTS(one));
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop, another bound for the next loop")
+__arch_x86_64
+__arch_arm64
+__failure __msg("math between map_value pointer and register with unbounded min value")
+__naked void guard_at_head_bound_of_next_loop(void)
+{
+	asm volatile (
+		"call spins_then_counts_to_anything;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * r7 is fp-8 on every edge and fp-16 at the head of the first loop. The second loop
+ * counts in fp-16 and stores a number that nobody knows through r7.
+ */
+__naked __noinline __used
+static unsigned long spins_then_counts_on_stack(void)
+{
+	asm volatile (
+		"r8 = %[zero] ll;"
+		"r3 = 0;"
+		"*(u64 *)(r10 - 8) = r3;"
+		"*(u64 *)(r10 - 16) = r3;"
+		"r7 = r10;"
+		"r7 += -16;"
+	"1:"
+		"r2 = *(u64 *)(r7 + 0);"
+		"r1 = *(u64 *)(r8 + 0);"
+		"if r1 == 1 goto 1b;"
+		"r7 = r10;"
+		"r7 += -8;"
+		"if r1 == 2 goto 2f;"
+		"r7 = r10;"
+		"r7 += -16;"
+		"goto 1b;"
+	"2:"
+		"r3 = 0;"
+		"*(u64 *)(r10 - 16) = r3;"
+	"3:"
+		"r6 = *(u64 *)(r10 - 16);"
+		"if r6 == 4 goto 4f;"
+		"r1 = %[five_bytes] ll;"
+		"r1 += r6;"
+		"r3 = 1;"
+		"*(u8 *)(r1 + 0) = r3;"
+		"r6 += 1;"
+		"*(u64 *)(r10 - 16) = r6;"
+		"r3 = *(u64 *)(r8 + 0);"
+		"*(u64 *)(r7 + 0) = r3;"
+		"goto 3b;"
+	"4:"
+		"r0 = r6;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm_addr(five_bytes)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto at the head of a loop, another pointer to the stack")
+__arch_x86_64
+__arch_arm64
+__failure __msg("math between map_value pointer and register with unbounded min value")
+__naked void guard_at_head_stack_pointer(void)
+{
+	asm volatile (
+		"call spins_then_counts_on_stack;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * Two states that have no join enter a loop. One has no count, so the loop gets may_goto.
+ * The other one has a count. may_goto is there when it runs too, and a loop in front
+ * may have used up the time slice. Then it leaves the loop in the first trip.
+ *
+ * r7 = the value, 16 bytes, and r8 = count, or r7 = 0 and r8 = anything
+ */
+#define VALUE_AND_COUNT_OR_NEITHER(count)		\
+		"r1 = 0;"				\
+		"*(u32 *)(r10 - 4) = r1;"		\
+		"r2 = r10;"				\
+		"r2 += -4;"				\
+		"r1 = %[pairs] ll;"			\
+		"call %[bpf_map_lookup_elem];"		\
+		"if r0 == 0 goto 9f;"			\
+		"r9 = %[zero] ll;"			\
+		"r2 = *(u64 *)(r9 + 0);"		\
+		"if r2 == 0 goto 3f;"			\
+		"r7 = r0;"				\
+		"r8 = " #count ";"			\
+		"goto 4f;"				\
+	"3:"						\
+		"r7 = 0;"				\
+		"r8 = *(u64 *)(r9 + 0);"		\
+	"4:"
+
+/* It's in the value when r6 is what it is at the end of the loop that was counted: last */
+#define LOAD_IF_VALUE(last)				\
+		"if r7 == 0 goto 9f;"			\
+		"r2 = " #last ";"			\
+		"r2 -= r6;"				\
+		"r2 &= 1;"				\
+		"r2 <<= 4;"				\
+		"r7 += r2;"				\
+		"r0 = *(u64 *)(r7 + 0);"		\
+		"exit;"					\
+	"9:"						\
+		"r0 = 0;"				\
+		"exit;"					\
+		:					\
+		: __imm_addr(pairs),			\
+		  __imm_addr(zero),			\
+		  __imm(bpf_map_lookup_elem)		\
+		: __clobber_all
+
+__naked __noinline __used
+static unsigned long counted_or_not(void)
+{
+	asm volatile (
+		VALUE_AND_COUNT_OR_NEITHER(10)
+		"r6 = 0;"
+	"1:"
+		"r6 += 1;"
+		"if r6 < r8 goto 1b;"
+		LOAD_IF_VALUE(10)
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto that another state needs, the loop is counted")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to map value, value_size=16 off=16 size=8")
+__naked void guard_in_counted_loop(void)
+{
+	asm volatile (
+		"call counted_or_not;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* 2 4 8 16 is not counted. Constants decide the jump. */
+__naked __noinline __used
+static unsigned long walked_or_not(void)
+{
+	asm volatile (
+		VALUE_AND_COUNT_OR_NEITHER(16)
+		"r6 = 1;"
+	"1:"
+		"r6 <<= 1;"
+		"if r6 < r8 goto 1b;"
+		"r6 >>= 1;"
+		LOAD_IF_VALUE(8)
+	);
+}
+
+SEC("socket")
+__description("budget: may_goto that another state needs, constants decide the exit of the loop")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to map value, value_size=16 off=16 size=8")
+__naked void guard_in_walked_loop(void)
+{
+	asm volatile (
+		"call walked_or_not;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/* i = 0; do { i++; } while (i < n); return v ? v[((10 - i) & 1) * 2] : 0; */
+__naked __noinline __used
+static unsigned long counts(unsigned long n, long *v)
+{
+	asm volatile (
+		"r0 = 0;"
+	"1:"
+		"r0 += 1;"
+		"if r0 < r1 goto 1b;"
+		"if r2 == 0 goto 2f;"
+		"r3 = 10;"
+		"r3 -= r0;"
+		"r3 &= 1;"
+		"r3 <<= 4;"
+		"r2 += r3;"
+		"r0 = *(u64 *)(r2 + 0);"
+	"2:"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+#define LOOKUP_PAIR					\
+		"r1 = 0;"				\
+		"*(u32 *)(r10 - 4) = r1;"		\
+		"r2 = r10;"				\
+		"r2 += -4;"				\
+		"r1 = %[pairs] ll;"			\
+		"call %[bpf_map_lookup_elem];"		\
+		"if r0 == 0 goto 9f;"			\
+		"r6 = r0;"
+
+SEC("socket")
+__description("budget: a subprog is called without a count, then with a count")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to map value, value_size=16 off=16 size=8")
+__naked void two_callers(void)
+{
+	asm volatile (
+		LOOKUP_PAIR
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r2 = 0;"
+		"call counts;"
+		"r1 = 10;"
+		"r2 = r6;"
+		"call counts;"
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(pairs),
+		  __imm_addr(zero),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a subprog is called with a count, then without a count")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to map value, value_size=16 off=16 size=8")
+__naked void two_callers_counted_first(void)
+{
+	asm volatile (
+		LOOKUP_PAIR
+		"r1 = 10;"
+		"r2 = r6;"
+		"call counts;"
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r2 = 0;"
+		"call counts;"
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(pairs),
+		  __imm_addr(zero),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all
+	);
+}
+
+/* A global subprog is verified after the main prog */
+__naked __noinline __used
+int counts_anything(void)
+{
+	asm volatile (
+		"r1 = %[zero] ll;"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r2 = 0;"
+		"call counts;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+SEC("socket")
+__description("budget: a subprog is called with a count, then without a count by a global subprog")
+__arch_x86_64
+__arch_arm64
+__failure __msg("invalid access to map value, value_size=16 off=16 size=8")
+__naked void two_callers_two_passes(void)
+{
+	asm volatile (
+		LOOKUP_PAIR
+		"r1 = 10;"
+		"r2 = r6;"
+		"call counts;"
+		"call counts_anything;"
+	"9:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(pairs),
+		  __imm(bpf_map_lookup_elem)
+		: __clobber_all
+	);
+}
+
+/*
+ * if (x) lock(); do { p = lookup(); } while (!p); if (x) { unlock(); return 0; } return *p;
+ * looks(0) holds nothing: may_goto unwinds. looks(1) cannot, so may_goto leaves the loop, in
+ * looks(0) too, and p is NULL.
+ */
+__naked __noinline __used
+static unsigned long looks(unsigned long x)
+{
+	asm volatile (
+		"r6 = r1;"
+		"if r6 == 0 goto 1f;"
+		"call %[bpf_rcu_read_lock];"
+	"1:"
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[empty] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1b;"
+		"if r6 == 0 goto 2f;"
+		"call %[bpf_rcu_read_unlock];"
+		"r0 = 0;"
+		"exit;"
+	"2:"
+		"r0 = *(u64 *)(r0 + 0);"
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
+SEC("socket")
+__description("budget: a subprog finds out late that something is held")
+__arch_x86_64
+__arch_arm64
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void unwinds_then_cannot(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"call looks;"
+		unwind_goto(5)
+		"r1 = 1;"
+		"call looks;"
+		unwind_goto(2)
+		"r0 = 0;"
+		"exit;"
+		"r0 = 42;"
+		"exit;"
+		:
+		: __imm_unwind_goto(5),
+		  __imm_unwind_goto(2)
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
+ * may_goto keeps the address of its count in a register that is dead. What is live in front
+ * of the insn that gets may_goto is live in front of may_goto.
+ */
+SEC("socket")
+__description("budget: may_goto in front of a jump keeps R0")
+__arch_x86_64
+__arch_arm64
+__success __retval(7)
+__naked void guard_keeps_r0(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r0 = 7;"
+	"1:"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 != 0 goto 1b;"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+#define ALL_REGS_LIVE_IN_LOOP(var)			\
+		"r9 = %[" #var "] ll;"			\
+		"r0 = 1;"				\
+		"r2 = 2;"				\
+		"r3 = 3;"				\
+		"r4 = 4;"				\
+		"r5 = 5;"				\
+		"r6 = 6;"				\
+		"r7 = 7;"				\
+		"r8 = 8;"				\
+	"1:"						\
+		"r1 = *(u64 *)(r9 + 0);"		\
+		"if r1 != 0 goto 1b;"			\
+		"r0 += r1;"				\
+		"r0 += r2;"				\
+		"r0 += r3;"				\
+		"r0 += r4;"				\
+		"r0 += r5;"				\
+		"r0 += r6;"				\
+		"r0 += r7;"				\
+		"r0 += r8;"				\
+		"r9 = *(u64 *)(r9 + 0);"		\
+		"r0 += r9;"				\
+		"exit;"					\
+		:					\
+		: __imm_addr(var)			\
+		: __clobber_all
+
+/* No register is dead: R0 waits in the stack */
+SEC("socket")
+__description("budget: may_goto where all registers are live")
+__arch_x86_64
+__arch_arm64
+__success __retval(36)
+__xlated("...")
+__xlated("*(u64 *)(r10 -8) = r0")
+__xlated("r0 = 0x{{.*}}")
+__xlated("r0 = &(void __percpu *)(r0)")
+__xlated("r13 = *(u64 *)(r0 +0)")
+__xlated("...")
+__xlated("*(u64 *)(r0 +0) = r13")
+__xlated("r0 = *(u64 *)(r10 -8)")
+__xlated("if r1 != 0x0 goto pc-{{[0-9]+}}")
+__naked void guard_all_regs_live(void)
+{
+	asm volatile (
+		ALL_REGS_LIVE_IN_LOOP(zero)
+	);
+}
+
+__naked __noinline __used
+static unsigned long spins_all_regs_live(void)
+{
+	asm volatile (
+		ALL_REGS_LIVE_IN_LOOP(one)
+	);
+}
+
+/* The time is up: the loop is left with r1 = 1 and all the other registers as they are */
+SEC("socket")
+__description("budget: may_goto where all registers are live, out of budget")
+__arch_x86_64
+__arch_arm64
+__success __retval(38)
+__naked void guard_all_regs_live_spins(void)
+{
+	asm volatile (
+		"call spins_all_regs_live;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * A loop that has no count is looked at trip by trip for a while. A state that is within a state of
+ * an earlier trip is dropped, wherever that is. Then nothing says that the loop ends, it gets
+ * may_goto, and all is done again. None of the loops below ends on its own.
+ */
+SEC("socket")
+__description("budget: every second trip leaves everything as it was")
+__arch_x86_64
+__arch_arm64
+__success __retval(0) __log_level(2)
+__msg("processed 25 insns")
+__naked void trips_of_period_two(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		"r7 = 1;"
+	"1:"
+		"r7 ^= 3;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 2f;"
+		"if r7 != 7 goto 1b;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+/*
+ * r7 is 0 at the head in the first trip and 5 in the second one. It's dead at 2, where the second
+ * trip is dropped. Nothing comes back to the head that is within what is there.
+ */
+SEC("socket")
+__description("budget: a trip is dropped in the middle of the loop")
+__arch_x86_64
+__arch_arm64
+__success __retval(0) __log_level(2)
+__msg("processed 33 insns")
+__naked void trip_dropped_in_the_middle(void)
+{
+	asm volatile (
+		"r6 = %[one] ll;"
+		"r7 = 0;"
+	"1:"
+		"if r7 == 7 goto 3f;"
+		"r1 = *(u64 *)(r6 + 0);"
+		"if r1 == 0 goto 3f;"
+		"if r1 == 2 goto 2f;"
+		"r1 = 0;"
+	"2:"
+		"r7 = 5;"
+		"goto 1b;"
+	"3:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(one)
+		: __clobber_all
+	);
+}
+
+/* n ? zero_at_the_bottom(n - 1) : zero */
+__naked __noinline __used
+static unsigned long zero_at_the_bottom(unsigned long n)
+{
+	asm volatile (
+		"if r1 == 0 goto 1f;"
+		"r1 += -1;"
+		"call zero_at_the_bottom;"
+		"exit;"
+	"1:"
+		"r1 = %[zero] ll;"
+		"r0 = *(u64 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_addr(zero)
+		: __clobber_all
+	);
+}
+
+/*
+ * The call of a recursive subprog waits for what comes out of it. The call of the second trip is
+ * within the one that waits. A recursive subprog that has no time or no stack left returns 0 at
+ * once, so that doesn't stop the loop.
+ */
+SEC("socket")
+__description("budget: a trip is dropped at a call that waits")
+__arch_x86_64
+__arch_arm64
+__success __retval(0) __log_level(2)
+__msg("processed 27 insns")
+__naked void trip_dropped_at_a_call(void)
+{
+	asm volatile (
+		"r7 = 0;"
+	"1:"
+		"if r7 == 7 goto 2f;"
+		"r1 = 3;"
+		"call zero_at_the_bottom;"
+		"r7 = 5;"
+		"if r0 == 0 goto 1b;"
+	"2:"
+		"r0 = 1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * Every trip goes through bpf_iter_num_next(), so the loop is taken for bounded at first, and
+ * through may_goto of the program. The iterator is made in the loop, and may_goto stays in it:
+ * neither of them stops it. The program doesn't end on its own.
+ */
+SEC("socket")
+__description("budget: may_goto that stays in the loop doesn't stop it")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__naked void may_goto_stays_in_the_loop(void)
+{
+	asm volatile (
+		"r6 = %[zero] ll;"
+		"r6 = *(u64 *)(r6 + 0);"
+		"if r6 != 0 goto 4f;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = 0;"
+		"r3 = 2;"
+		"call %[bpf_iter_num_new];"
+	"2:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_next];"
+		"if r0 != 0 goto 2b;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"call %[bpf_iter_num_destroy];"
+		".8byte %[may_goto];"
+		"if r6 == 0 goto 1b;"
+	"4:"
+		"r0 = 1;"
+		"exit;"
+		:
+		: __imm_addr(zero),
+		  __imm(bpf_iter_num_new),
+		  __imm(bpf_iter_num_next),
+		  __imm(bpf_iter_num_destroy),
+		  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0 /* offset */, 0))
+		: __clobber_all
+	);
+}
+
+/* No state is within another one: the walk gets to the end of the loop, no may_goto */
+SEC("socket")
+__description("budget: ten trips that differ")
+__success __retval(10) __log_level(2)
+__msg("processed 34 insns")
+__xlated("r8 += 1")
+__xlated("r7 <<= 1")
+__xlated("if r7 != 0x400 goto pc-3")
+__naked void ten_trips_that_differ(void)
+{
+	asm volatile (
+		"r7 = 1;"
+		"r8 = 0;"
+	"1:"
+		"r8 += 1;"
+		"r7 <<= 1;"
+		"if r7 != 1024 goto 1b;"
+		"r0 = r8;"
+		"exit;"
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
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
index afe4990cd027..5f0d9e545656 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -637,6 +637,39 @@ __naked void callx_mutual_recursion(void)
 		: __clobber_all);
 }
 
+static __noinline __used int pulls_data(struct __sk_buff *skb)
+{
+	return bpf_skb_pull_data(skb, 0);
+}
+
+/*
+ * The prog loads the address of the function, apply() calls it. The packet
+ * pointer of the prog is gone after the call of apply().
+ */
+SEC("tc")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void callx_fn_as_arg_changes_pkt_data(void)
+{
+	asm volatile (
+		"r2 = r1;"
+		"r6 = *(u32 *)(r1 + %[data]);"
+		"r7 = *(u32 *)(r1 + %[data_end]);"
+		"r0 = 0;"
+		"r3 = r6;"
+		"r3 += 1;"
+		"if r3 > r7 goto 1f;"
+		"r1 = %[pulls_data] ll;"
+		"call apply;"
+		"*(u8 *)(r6 + 0) = 42;"
+		"r0 = 0;"
+	"1:	exit;"
+		:
+		: __imm_addr(pulls_data),
+		  __imm_const(data, offsetof(struct __sk_buff, data)),
+		  __imm_const(data_end, offsetof(struct __sk_buff, data_end))
+		: __clobber_all);
+}
+
 /* calls_arg(fn) { return fn(); } */
 __naked __noinline __used
 static unsigned long calls_arg(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
index 8bb74b579203..2e7e65949497 100644
--- a/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
+++ b/tools/testing/selftests/bpf/progs/verifier_callx_rodata.c
@@ -198,6 +198,57 @@ __naked void callx_rodata_array_of_structs_data(void)
 		: __clobber_all);
 }
 
+int calls_what_calls_it(void);
+
+__naked __noinline __used
+static unsigned long calls_global(void)
+{
+	asm volatile (
+		"call calls_what_calls_it;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+__naked __noinline __used
+int calls_what_calls_it(void)
+{
+	asm volatile (
+		RODATA(cb, ".quad calls_global;")
+		"r2 = cb_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 1;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"call %[bpf_loop];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_loop)
+		: __clobber_all);
+}
+
+/*
+ * No subprog takes the address of the callback, and calls of global functions are not
+ * followed. It's a recursion all the same, and nothing checks the stack.
+ */
+SEC("socket")
+__failure __msg("recursive call from calls_global() to calls_what_calls_it()")
+__naked void callx_rodata_callback_recursion(void)
+{
+	asm volatile (
+		FUNC_TABLE2(tbl, add1, add2)
+		"call calls_what_calls_it;"
+		/* libbpf resolves the pointers for progs that have callx */
+		"r2 = tbl_%= ll;"
+		"r2 = *(u64 *)(r2 + 0);"
+		"r1 = 1;"
+		"callx r2;"
+		"r0 = 0;"
+		"exit;"
+		::: __clobber_all);
+}
+
 /* but not the data and the pointer with the same load */
 SEC("socket")
 __failure __msg("overlaps with a pointer to a function")
-- 
2.55.0


Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C604446EE
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136410; cv=none; b=WiKQUN10IIBGoQJ7bxtdOIVVTSPZPlfHdjjLhBuSmFVKiQ6kdXhx/RtuS3uqqpho/s2HGAZYEyyTyr4+IkYlVre9QXEaZ85ggi2KmSaN2S8Mj4g08099Svfqnc8uMGQ9/8gVN0P/JSrO7LeSeODYoCGZAjT4QeU9D+ECPiYkV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136410; c=relaxed/simple;
	bh=sSU7uX+MWiocmLFOMz2By3uLX5tUZ8IlJi6F+kZ5Vis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3qD2EqGYSLwZ2Kv4F8d2octhkDVuHGmXcuD9jv8K4T/EAUfleOGZBD3zaq4Na9+gugQLz/uxVv02e1zjLC7t7PGpeMOJGVSIIB3UGVSDM3fQ3PifRcPScrXQTgAv6mPXFPFhbcLtmL2fsZYAevIB1F3kKFm9wzXs2AqwnexEGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVHzhz7M; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVHzhz7M"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485ef63b68so5851169b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136408; x=1786741208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M3EkHyOcj8+Z/dDjz8IIeG4L6su/RK6HvagwpAZXzIA=;
        b=TVHzhz7MqxUZe2vnUuLlQa0x9V/BcRGpecV7xxNzVxDvQCmo4ZpM0orS/c10xwvzu/
         UwaVDXINCWNgJP6EMBTYMkJQNMI5kyckz6/W5y3RiFwKpTBREBeL0TF+zcpNeFDzCp0u
         GQLgNQwfstz7kfokZKsJdXTHsWBOn7jmE+IhuxUfFNnDPxVq1X+UPr/Uq5PNCk30jdzV
         nOr1HFPcrs0pQl7pEQ7N62tY4CEfmr1Fkms29wgd9c4Zyy+Mo5eErvQGSXNRHZPQJM/1
         Jvazrqb/LyBmFgBAJxTaHImlp5xZa5CMWfTvKYxARB/NClYJ959AgWKVZDeAh+2Frds1
         6RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136408; x=1786741208;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3EkHyOcj8+Z/dDjz8IIeG4L6su/RK6HvagwpAZXzIA=;
        b=KUbSwJ7ChkIRHgClD4eqfK/FewfBgn3q2xl6jBJSivS01txmoHwHAI8oxjP5TLGPtM
         OM9jpShyySdoIswrlMYdZs5cCs87fZGcHK6PfKYcX2svQ2H2F1MUOFLH9OxfCVTf2Ofw
         s3VlkT8rR++tqNi0J/SF3TWqXBO2KsbfQFZx7R60UU1rgGglYH6dOL4yJWYDfaVoO0V+
         t8QeQS8tPwasjx8wRQY4ArJikFMuJNo5dnG3sriZlSTlZ2oNL/msfVFmoxx1K4Snff7q
         Fl7UJMEPRToqwZRswuPX/aqnzehagKkdZ2BKooPFlzIslF/arTi90imEaBx1z6zNeeKa
         Hv3g==
X-Gm-Message-State: AOJu0YzB94K0tqvW2Qzcb9rYJ7BG1kWG/oH//C8WFHU0mTpdkLWrpPiO
	0VUd6st28yhvvuh6BISpdAnYpVm+OPFOL1Br68b4KbXYTYIwG9RrTkiCLX+9hFkr
X-Gm-Gg: AR+sD11LK/aDFGZo/L3Y6GCxfcVvr33ZiIKYgZZASNEI33pWzcYhQ/1Jq6sKbi3k4LX
	2jlbsDdf1HLHRlbD68rpD0YxXkAVD88/vBSyCfpKnF1MClPpVUVLbQCmaxnFQJyrVRfH5s1VrUY
	+ZRvIiCepu9ef/tO+yJCOyGra/TGsiwnu5PL96OBPR1xUHiXkCUQziXPhm40DGiOuDuGcsijd91
	2XFYbKSggbG3D9WRGW5DogNqTewc9uPhE39RkBlC3n6Ixh9wwCvgk/ZttdzLTCdJt44LQurLzGq
	EZ+HW2Ihms6czhFzUMEHNInNv4MUIPiZB9tKbPafXyUyiYK+dGZSdYAdUr+sbxfpLSs7zjHDZjK
	j5jBkuYtYKGZLBddCiQg4blZW8hdPy82CNvJwg8slRhfgASsKlhtew15hZvdkU3C093fJ70GNgm
	Fxvtz6CB6L/RYNAkDuF+Dfand3tu2563mumpKcrmG4V3tBNUaZFlYMlzlI9AY6NYEWjld5rLf0F
	kApMeZMX9Z5Wjpf9nEEiAxHw7DuyEDUjzqjekhWJpba
X-Received: by 2002:a05:6a21:697:b0:3c3:c3fb:2473 with SMTP id adf61e73a8af0-3cb85e736ecmr33499133637.20.1786136408073;
        Fri, 07 Aug 2026 14:00:08 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 7/7] selftests/bpf: verify zext_dst annotations for various instructions
Date: Fri,  7 Aug 2026 13:59:36 -0700
Message-ID: <20260807-static-zext-v4-7-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Includes the following test cases:
- a test showing that zero extension flags do not propagate through
  state pruning in the unpatched kernel.
- a 32-bit subregister consumed by MOV32 and ALU32 operations
  (never zext'ed);
- a 64-bit MOV (never zext'ed);
- a narrow (32-bit) BPF_LDX load whose result is read as 64-bit;
- 32-bit atomic fetch_add and cmpxchg whose result is read as 64-bit;
- a CFG case where a 32-bit definition's upper half is used only on one
  of two branches;
- no zext for dead registers;
- LD_ABS defines only lower 32 bits, hence needs zext when the result
  is used as 64-bits;
- helper, kfunc and subprogram parameters are considered to use full
  64 bits;
- a 32-bit subregister consumed by JMP32 (X/K) operations;
- a 32-bit subregister consumed by JMP (X/K) operations;
- a 64-bit register consumed by both JMP and JMP32 operations
  (never zext'ed);
- ALU64 and address space cast operations on arena pointers;
- memory loads using BPF_PROBE_MEM instructions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 392 ++++++++++++++++++++++
 2 files changed, 394 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index b79bafca68f7..0baa74618fa0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -126,6 +126,7 @@
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
+#include "verifier_zext.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -281,6 +282,7 @@ void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
+void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
new file mode 100644
index 000000000000..8f2362da91d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include <bpf_arena_common.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE | BPF_F_NO_USER_CONV);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+
+/* to retain debug info for BTF generation */
+void __kfunc_btf_root(void)
+{
+	bpf_kfunc_call_test4(0, 0, 0, 0);
+	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
+	bpf_rdonly_cast(0, 0);
+}
+
+SEC("socket")
+__flag(BPF_F_TEST_STATE_FREQ)
+__flag(BPF_F_TEST_RND_HI32)
+__success __retval(0)
+__naked void zext_lost_across_checkpoint(void)
+{
+	asm volatile ("									\
+	call %[bpf_ktime_get_ns];							\
+	r8 = r0;									\
+	r6 = 0xdeadbeefcafebabe ll;	/* inject some value for r6's upper half */	\
+	if r8 != 0 goto 1f;		/* fall-through cached first, branch pruned */	\
+	r6 = 32;			/* full 64-bit def */				\
+	goto 2f;									\
+1:	w6 = 32;			/* 32-bit def, zext mark lost */		\
+2:	r0 = r6;			/* buggy verifier believed upper 32 bits are 0 */ \
+					/* and thus did not zero extended w6 = 32. */	\
+	r0 >>= 32;									\
+	exit;										\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
+/* 32-bit ALU result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("w1 = w0{{ +}}; zext")
+__naked void zext_alu32_hi_used(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 32-bit ALU result read only as 32-bit -> no zext */
+SEC("socket")
+__success __log_level(2)
+__not_msg("; zext")
+__naked void no_zext_alu32_hi_unused(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;		/* MOV */		\
+	w2 = w1;					\
+	w2 += w1;		/* ALU32, BPF_X */	\
+	w2 += 1;		/* ALU32, BPF_K */	\
+	w2 = w2;		/* keep w2 alive for previous instruction */ \
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* 64-bit definition is never zero extended */
+SEC("socket")
+__success __log_level(2)
+__not_msg("r1 = r0{{.*}}; zext")
+__naked void no_zext_mov64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* Narrow load result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 = *(u32 *)(r10 -8){{ +}}; zext")
+__naked void zext_narrow_load_hi_used(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u64 *)(r10 - 8) = r0;				\
+	r1 = *(u32 *)(r10 - 8);				\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* 32-bit atomic fetch result read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r1 = atomic_fetch_add((u32 *)(r10 -8), r1){{ +}}; zext")
+__naked void zext_atomic_fetch32_hi_used(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	w1 = 1;						\
+	.8byte %[fetch_add32];				\
+	r0 = r1;					\
+	exit;						\
+"	:
+	: __imm_insn(fetch_add32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_ADD | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+/* 32-bit atomic cmpxchg result (r0) read as 64-bit -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = atomic_cmpxchg((u32 *)(r10 -8), r0, r1){{ +}}; zext")
+__naked void zext_cmpxchg32_hi_used(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	w0 = 0;						\
+	w1 = 1;						\
+	.8byte %[cmpxchg32];				\
+	r2 = r0;					\
+	r0 = r2;					\
+	exit;						\
+"	:
+	: __imm_insn(cmpxchg32,
+		     BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8))
+	: __clobber_all);
+}
+
+/* 32-bit def before a branch, upper half used on one branch -> zext */
+SEC("socket")
+__success __log_level(2)
+__msg("w6 = 32{{ +}}; zext")
+__naked void zext_cfg_hi_used_one_branch(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w6 = 32;					\
+	if r0 == 0 goto 1f;				\
+	r0 = r6;					\
+	exit;						\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* r1's upper half is dead, so 'w1 = 1' must NOT be marked for zero extension. */
+SEC("socket")
+__success __log_level(2)
+__not_msg("w1 = 1{{.*}}; zext")
+__naked void no_zext_other_reg_hi_used(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r6 <<= 32;					\
+	w1 = 1;						\
+	r0 = r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* LD_ABS defines r0; when r0 is read as 64-bit it must be zero extended */
+SEC("socket")
+__success __log_level(2)
+__msg("r0 = *(u8 *)skb[0]{{.*}}; zext")
+__naked void zext_ld_abs_hi_used(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r0 = *(u8 *)skb[0];				\
+	r7 = r0;					\
+	r0 = r7;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Helper parameters are read as 64-bit (call_use_mask() fallback) */
+SEC("socket")
+__success __log_level(2)
+__msg("w2 = 1{{ +}}; zext")
+__naked void helper_param_read_as_64bit(void)
+{
+	asm volatile ("					\
+	r1 = r10;					\
+	r1 += -8;					\
+	w2 = 1;						\
+	call %[bpf_trace_printk];			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_trace_printk)
+	: __clobber_all);
+}
+
+static __used __naked int subprog_reads_arg_as_64bit(void)
+{
+	asm volatile ("					\
+	r0 = r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* subprogram parameters are conservatively read as 64-bit */
+SEC("socket")
+__success __log_level(2)
+__msg("w1 = w0{{ +}}; zext")
+__naked void subprog_param_read_as_64bit(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	call subprog_reads_arg_as_64bit;		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* kfunc parameters are zero extended */
+SEC("tc")
+__success __log_level(2)
+__msg("w1 = 1{{ +}}; zext")
+__msg("w2 = 1{{ +}}; zext")
+__msg("w3 = 1{{ +}}; zext")
+__msg("w4 = 1{{ +}}; zext")
+__naked void kfunc_param_read_per_btf(void)
+{
+	asm volatile ("					\
+	w1 = 1;						\
+	w2 = 1;						\
+	w3 = 1;						\
+	w4 = 1;						\
+	call bpf_kfunc_call_test4;			\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__success __log_level(2)
+__not_msg("; zext")
+__naked void alu32_and_32bit_conditional(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if w1 > 42 goto 1f;		/* BPF_K */	\
+	w2 = 28;					\
+	if w2 > w1 goto 1f;		/* BPF_X */	\
+	r0 = 0;						\
+1:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __log_level(2)
+__msg("w1 = w0{{ +}}; zext")
+__naked void alu32_and_64bit_conditional(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w1 = w0;					\
+	if r1 > 42 goto 1f;		/* BPF_K */	\
+	r2 = 28;					\
+	if r2 > r1 goto 1f;		/* BPF_X */	\
+	r0 = 0;						\
+1:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success __log_level(2)
+__not_msg("; zext")
+__naked void alu64_and_conditionals(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	if w1 > 42 goto 1f;		/* BPF_K */	\
+	if r1 > 42 goto 1f;		/* BPF_K */	\
+	r2 = 28;					\
+	if w2 > w1 goto 1f;		/* BPF_X */	\
+	if r2 > r1 goto 1f;		/* BPF_X */	\
+	r0 = 0;						\
+1:	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__arch_s390x
+__xlated("7: w1 = w0")
+__xlated("8: w1 = w1")
+__xlated("9: w1 += 8")
+__xlated("10: w1 = w1")
+__xlated("11: w2 = w1")
+__xlated("12: w2 = w2")
+__xlated("13: *(u64 *)(r1 +0) = r2")
+__naked void arena_ptr(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r1 = addr_space_cast(r0, 0, 1);		/* needs zext */ \
+	r1 += 8;				/* needs zext */ \
+	r2 = addr_space_cast(r1, 1, 0);		/* needs zext because of BPF_F_NO_USER_CONV */ \
+	*(u64 *)(r1 +0) = r2;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_arena_alloc_pages),
+	  __imm_addr(arena)
+	: __clobber_all);
+}
+
+#endif
+
+/* Check if probe mem loads keep their zero extension. */
+SEC("socket")
+__success __log_level(2)
+__arch_s390x
+__xlated("3: r1 = *(u64 *)(r0 +0)")
+__xlated("4: r2 = *(u32 *)(r0 +0)")
+__xlated("5: w2 = w2")
+__xlated("6: r3 = *(u16 *)(r0 +0)")
+__xlated("7: w3 = w3")
+__xlated("8: r4 = *(u8 *)(r0 +0)")
+__xlated("9: w4 = w4")
+__naked void probe_mem(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	r2 = 0;						\
+	call %[bpf_rdonly_cast];			\
+	r1 = *(u64 *)(r0 + 0);	/* BPF_PROBE_MEM */	\
+	r2 = *(u32 *)(r0 + 0);	/* BPF_PROBE_MEM */	\
+	r3 = *(u16 *)(r0 + 0);	/* BPF_PROBE_MEM */	\
+	r4 = *(u8 *)(r0 + 0);	/* BPF_PROBE_MEM */	\
+	r0 = r1;		/* make the registers used */ \
+	r0 += r2;					\
+	r0 += r3;					\
+	r0 += r4;					\
+1:	exit;						\
+"	:
+	: __imm(bpf_rdonly_cast)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0

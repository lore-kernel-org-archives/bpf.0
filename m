Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703A39478C
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546614; cv=none; b=EDR5HNY0IYRWz4GrxHqAvxXcrrO9PnmuT+fze3WpONZcPyVUgcTCaJ79QQBfHumyreT9R/9S4405dhVeCp3wr0DMeWr9MAyhkAPjSQdkJkcT5YKYS2YRrf1qqJ3oWbY+2js9wubggy9Gfgh6+0ZyGRFGZAZC6BSIimn64g2Wblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546614; c=relaxed/simple;
	bh=ok+Qp5oXgIQPHm6Bv73u4BeM30qkh00KssQ2M/y8kIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVVRD2PckXLd2HVBDJJDcpI3gwWJvBtC/1QrRSuKzn1bPzathpS6v2s8kZjnHX6dE/ey/BOhyIteHSyBBAgZqB41fJZGSgD82yh8ptQ3QbH0zoyv5T+MjwQegnVwuLdzpDBYgfEdIf+8jmqBn3vIyf7scmPgod9pj0pEJ7mEkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2zVNTWP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2zVNTWP"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so1943261b3a.2
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785546612; x=1786151412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3DG2jfEGE+6iwYjGgtDcTxYZzM51beG0MpAOgQNSR6Q=;
        b=l2zVNTWPGjicOgQkUEEVWV1bvih1S+8tqThjvypEjygi1q1e7vuD8hrOYBZi7RAo6U
         oh8TouMAQicAQs6uHTNYP00a+54Mn7SS9XVjaLvBAcGqSEMT0WP+tLRY18S1O8annHq3
         hw6NeUCFYHW8QTz09wiFzZgQWwrnfJ+Gh8ti/pmiw1VcppYJrWB0Ja7zcJYWTApnVAYc
         QH4NvthHiDY5UauH9nyeVrUgorcokczjmdRKz6HhuBxlpavGMWdWNQTByzddgetDwltq
         YFUXWAWlkT8vq884fZpS3RfJDez8DKTVrIy0xe7QPPdazMxqNobIFPEzqELFoKP6HbiS
         aKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785546612; x=1786151412;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3DG2jfEGE+6iwYjGgtDcTxYZzM51beG0MpAOgQNSR6Q=;
        b=UxgWQdJ8Kux0Y2BNYhfEoxRY6a1EFxSS3zOPL2UBPfd5b/3/ClT2TzKfO7jHQt96km
         mb+iS+jktaKx8vXJHULe3WzF5Un+F1Cfy6u8RHTYEsFWXt5JrYj7YkZ3p3suS6oFqWBI
         3XBmBEJX8TjX80wRdpOy8EUiR7R2HqZU0hm6TNZni/OSONX98yR32D2yLLGtM+s43l59
         jj4jfLM6aGoZdur7zW+h9fhXbWkhFLLsI3Ds4Upu7BDkTs1wqautC3Ca2mSw57Jnn9Fd
         NXWVu8liQxE7LPCMXJ47UT7MDm8pfAgF6+vAbPHceWQPhTuu1UHn8Oi48mlw7E5AQuGd
         +g/Q==
X-Gm-Message-State: AOJu0Yxpmsy2zQiUJ7LHYWV8SZV8s56mD3hOStam3+pUbYEHCnFOSPof
	wUlYCzgcCcpg91Wwm0BSGkY+yOr7OBC37GuLmRi8vAg+JPZNIrtHZzujUukuxciK
X-Gm-Gg: AR+sD12LZp9pPiP7rKTD5rsp/pjmnApLj8B7of+MjqGcjm9AAvR21mOp/AnkMGCDWFL
	pihpdCkcCfUMiAjmoUgNdpqTqNjd6KMljyhuf/wSTgaeh+FtLNSV/MoHydplaBt43h2DPpf7uxA
	huwSb2JTpuHI6GAR9558wedckAWvaMVQbQfEyGGxhZnbGfaiTQQWxkk/m8rBVYUXHDon2qB63R9
	bFhwzq60vJhHEo/2yXBBqpyoA5dHsVdCgzNnyS4usL1P+R4NbMHD8jmD9c+jFmrdPfjz2mjgwWU
	jGnzj/GzWUQckr/yMg6yQk1kRQScSFuP/kY15uM8o6nRDuP4PyTGpaaV4caeqa+kAV6tjsdnohl
	lqxcbtt+pqbWvG0yWPi/8xpxdJhJaxkLu87ZdMoGKoHHGJJOn6Gsie8gfGaldzetxcQ6COT7wqq
	r4j3Xb2/VtOZLfhnHQy48AS/3nPbm50uJQdoPKEyVOBRl+IaAKUzntqzMtdPQxB9jHkMMsYgOul
	/qFLWVWvmT6q35jvBe69tCXbr18tcQHzifDXcZDWlyF
X-Received: by 2002:a05:6a21:4ed1:20b0:3c9:346f:c1fc with SMTP id adf61e73a8af0-3c9346fc2e6mr324787637.61.1785546612505;
        Fri, 31 Jul 2026 18:10:12 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm11234052eec.31.2026.07.31.18.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 18:10:12 -0700 (PDT)
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
	gimm78064@gmail.com
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: verify zext_dst annotations for various instructions
Date: Fri, 31 Jul 2026 18:09:53 -0700
Message-ID: <20260731-static-zext-v2-5-da4aa161e8c5@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
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
- Helper and subprogram parameters are considered to use full 64 bits;
- kfunc parameters are read according to their BTF type width.
- a 32-bit subregister consumed by JMP32 (X/K) operations;
- a 32-bit subregister consumed by JMP (X/K) operations;
- a 64-bit register consumed by both JMP and JMP32 operations
  (never zext'ed).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 315 ++++++++++++++++++++++
 2 files changed, 317 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e..fba562c81969 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -124,6 +124,7 @@
 #include "verifier_jit_inline.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
+#include "verifier_zext.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -277,6 +278,7 @@ void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
+void test_verifier_zext(void)                 { RUN_TESTS(verifier_zext); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_zext.c b/tools/testing/selftests/bpf/progs/verifier_zext.c
new file mode 100644
index 000000000000..2233cddde1e1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
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
+extern long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
+
+/* Force kfunc extern BTF generation. */
+int __kfunc_btf_root(void)
+{
+	return bpf_kfunc_call_test4(0, 0, 0, 0);
+}
+
+/* kfunc parameters are read according to their BTF type width */
+SEC("tc")
+__success __log_level(2)
+__not_msg("w3 = 1{{.*}}; zext")		/* int c  -> read as 32-bit */
+__msg("w4 = 1{{ +}}; zext")		/* long d -> read as 64-bit */
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
+char _license[] SEC("license") = "GPL";

-- 
2.55.0

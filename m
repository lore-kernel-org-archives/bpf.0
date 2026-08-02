Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5942E889C
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702282; cv=none; b=Pa6DmI+fXcsTHjDaJGSUD1lp6GCcqUi8tGT1LZg0ZmZA9+GUxpdSmwacBc3qSvNzDhxMkZ5ZZ0VbKyucNkKPmgy/YGgabg43D7cYxuNoXdIHHNLD4fIYu6FO0tH2HBNJSVUQPG4OAJJah/onA22Fz3B7ajKJEicEQb7ZcXTYLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702282; c=relaxed/simple;
	bh=rZqZlq13WUFWamD5cUH8KWm73/irTJSbXxYewpiNbmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/SITLaq/YcRhYjnFQm77fqPHU9GSCkYhRqaCox8JPLvEoZpQPpzHkG7kCMgzjB4U907j0hxgfFPlHrYXV3vJiuIY+BAgIRDFDNR5ItXIJ2Os1f8Uqh87zlv+fwLREMUa4KS+QL9jX3iJa7BX9B06YsIeqdt5MZcgYoZ4GSXAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlQf6MBY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlQf6MBY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfff5f88dbso29997885ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702280; x=1786307080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLuiLudAIUtByBQfABUGlNgCq8xi5/+gVi4LmPchv6g=;
        b=LlQf6MBYlJUXsS/QxO8aSMJbluas9aSLMVHLjL8BAEbdMtMpWb16AWrQQEF3mk1I2K
         tbI5lq49Esp5uu9lk6iphOsDhR87qqH2rWtIbBErcPK4eBNL4dTaIv/FnDKNbB9sYVbc
         Dq8HoyhSAClHGAakmifj8HshnggpcJejLH2/Pbq0VUVx2rkFpPhZCexaY3YEnV+gtJok
         ceZsAMGe2z1YzyCNgGvPNYzxGMYimd6rX7qq4T76SZc5eAjYvkHz1zLO44oOaoszOuX5
         0rmoXwULg5WG3AELt4jejpVMadEYBMANUKP4eh4uyXYwFLywtdqkVdQlLGpOT8wZmTk8
         BEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702280; x=1786307080;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLuiLudAIUtByBQfABUGlNgCq8xi5/+gVi4LmPchv6g=;
        b=jXnZkTCY4uRHxd/ad5j2pwhWGz8D2SIXEMfjNiajYMkdoLp0GRD6gF2CJpUMJuAF68
         Luvh+5jri7jvuKKAKFMw46yfyMG2jig5+ZYaW+Lrr6IB2lqN3rOYo5wsr+901zo/vZEw
         tmx9PI/mMk3kgii3edTrlIp3EVdywQVWuwqxr/i7PEucGBvHxhK+sF6mDltw2EbyXZGP
         Amcg0WgNvmZBFHLG7FW1HM5vTPChWS4I9VAx/sVVdIe2Uv0lAwDZzXVB/8VaqQF/E0Mi
         Gc/t8hi2H09QxRvxZC//cpKrMinvYqlM1qAnp0gLwlfsbR/6ZZ2dFi6kHSRovfkPtFUm
         K4UQ==
X-Gm-Message-State: AOJu0Yz/svDlBuhG+jD9igBmhW6N0uC5jTfryb7uWRhvV4GdvirgNBAS
	airXd5iwqwZP04gxtdJvfV17XDaUA4TCSxtkpnu6t7hukJY/lhpErX2newzTtA==
X-Gm-Gg: AR+sD133OCIeMIRTGzgmfnsxeeW5mJZsVv/4OHjL59ZQhPVex2aXL421u+sP38/jvmj
	OFXHe/Kp3gUQMRUnJu5gvCTojfHIvO4a23u6tYJYMtzIhQWCBFJtU62U1Vg/EbdZRm/cXEDR505
	g/gOa/9oQBP+E0IuOzcIUTJzL4vOiN6V/GmlKrc+MhkOSLci4vTQZEH8sm1pSClhwDAZzIHfJC2
	hrjxA0m3iLd9uv4o6gxwlRX+ADwyGrCQ3itwnUrCu4B7C0esAJfTbgUUMQUrLlhCiQjHz8b8SaF
	zRe28O1HPPYEGdNwUBjUKSxnqdmDayDty5pbrg2Dg9nOFaw8aRrFawePdTx/plCNXVX7dE3LEgW
	7ElkOVzmPSbmh4MsWXj4eHDBYHU1ZN8AMXuTCU1cmnBfdmFmvApgbXfW/kKtFU+vCCnUUuF1IwR
	6UzXiA5rIV958MRnP5x049m913PLKeDe+X5LeVb6Oc8/mdqcuQafpvYwDHX5V78K7Qws4OwV/lC
	gaZ6Q==
X-Received: by 2002:a17:902:e849:b0:2d0:3412:a3f0 with SMTP id d9443c01a7336-2d0522340damr70024455ad.19.1785702279864;
        Sun, 02 Aug 2026 13:24:39 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea128sm28590865ad.40.2026.08.02.13.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:24:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: verify zext_dst annotations for various instructions
Date: Sun,  2 Aug 2026 13:24:21 -0700
Message-ID: <20260802-static-zext-v3-5-3456b2604574@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
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
- ALU64 operation on arena pointer;
- memory loads using BPF_PROBE_MEM instructions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c |   2 +
 tools/testing/selftests/bpf/progs/verifier_zext.c | 388 ++++++++++++++++++++++
 2 files changed, 390 insertions(+)

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
index 000000000000..2dd3ea661b77
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_zext.c
@@ -0,0 +1,388 @@
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
+	__uint(map_flags, BPF_F_MMAPABLE);
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
+__naked void arena_ptr(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = 0;						\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r1 = addr_space_cast(r0, 0, 1);	/* needs zext */\
+	r1 += 8;			/* needs zext */\
+	*(u64 *)(r1 +0) = 42;				\
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
2.53.0

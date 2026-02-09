Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A737FF60
	for <bpf@vger.kernel.org>; Mon,  9 Feb 2026 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770652782; cv=none; b=dMDQXsgQ3iRuti9P9Z2FT/umy1Qx1V6dgTIwzBOj/cMoZgQs0/8jD5I2z4bFRkMc8N3bJNqrq8/iiCvgik3qX/kAZu7un84emAD7nogY9T1O6+q8c/Qzl9F2ap21RBxFRxpfAETUaRUXPOaPuvyO3z/ixYokSzXL5vw71wSLgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770652782; c=relaxed/simple;
	bh=rzqhQ3BOb0eB1IwLvNMDd/M7j9yChFwxEe4lwbeMUec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdbMz2OMBMi8x7Yylp3QboeshSwkmutRX9pZv52Ebl3NgxPJ67zAvXz60wDdoOwiJz7FtTwavI7id+OadHaZgSEfSKAzLvfg3mgZFxRkVE5rxx2IiLpz63HA+hYLnZu9+KeL22efP7OXG3uih9hwa8BB8SCqZWjvNY0z291p6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bDlft0dF; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bDlft0dF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770652779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j4p8pHJ/p9wr8vqaMG6uXZ4/MgEBnTWgM+UywKkkla8=;
	b=bDlft0dFQUn4z7NY7fdzF6Uz8nzM8Mg0dzkwhYwx100Ns3Ou/xE2xfuhUdTWlxmYSe0Uk/
	YgPM65d/nbNvptorvTwliS9BrgvbdA7+Fkuo2sOv9rzdHYYqOXDooKZ8JLmsM5R8kgsPEd
	FBL9Xt2iUNXXY+x5785+4I8DEyQYa1M=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [RFC PATCH bpf-next 1/4] bpf: Introduce 64bit bitops kfuncs
Date: Mon,  9 Feb 2026 23:59:12 +0800
Message-ID: <20260209155919.19015-2-leon.hwang@linux.dev>
In-Reply-To: <20260209155919.19015-1-leon.hwang@linux.dev>
References: <20260209155919.19015-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce the following 64bit bitops kfuncs:

* bpf_clz64(): Count leading zeros.
* bpf_ctz64(): Count trailing zeros.
* bpf_ffs64(): Find first set bit, 1-based index, returns 0 when input
  is 0.
* bpf_fls64(): Find last set bit, 1-based index.
* bpf_bitrev64(): Reverse bits.
* bpf_popcnt64(): Population count.
* bpf_rol64(): Rotate left.
* bpf_ror64(): Rotate right.

Especially,

* bpf_clz64(0) = 64
* bpf_ctz64(0) = 64
* bpf_ffs64(0) = 0
* bpf_fls64(0) = 0

These kfuncs are marked with a new KF_MUST_INLINE flag, which indicates
the kfunc must be inlined by the JIT backend. A weak function
bpf_jit_inlines_bitops() is introduced for JIT backends to advertise
support for individual bitops.

bpf_rol64() and bpf_ror64() kfuncs do not have KF_FASTCALL due to
BPF_REG_4 ('cl' actually) will be used on x86_64. The other kfuncs have
KF_FASTCALL to avoid clobbering unused registers.

An internal BPF_ALU64 opcode BPF_BITOPS is introduced as the encoding
for these operations, with the immediate field selecting the specific
operation (BPF_CLZ64, BPF_CTZ64, etc.).

The verifier rejects the kfunc in check_kfunc_call() if the JIT backend
does not support it, and rewrites the call to a BPF_BITOPS instruction
in fixup_kfunc_call().

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/btf.h    |  1 +
 include/linux/filter.h | 20 +++++++++++++
 kernel/bpf/core.c      |  6 ++++
 kernel/bpf/helpers.c   | 50 ++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c  | 65 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 48108471c5b1..8ac1dc59ca85 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -79,6 +79,7 @@
 #define KF_ARENA_ARG1   (1 << 14) /* kfunc takes an arena pointer as its first argument */
 #define KF_ARENA_ARG2   (1 << 15) /* kfunc takes an arena pointer as its second argument */
 #define KF_IMPLICIT_ARGS (1 << 16) /* kfunc has implicit arguments supplied by the verifier */
+#define KF_MUST_INLINE  (1 << 17) /* kfunc must be inlined by JIT backend */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4e1cb4f91f49..ff6c0cf68dd3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -514,6 +514,25 @@ static inline bool insn_is_cast_user(const struct bpf_insn *insn)
 		.off   = 0,					\
 		.imm   = 0 })
 
+/* bitops */
+#define BPF_BITOPS	0xe0	/* opcode for alu64 */
+#define BPF_CLZ64	0x00	/* imm for clz64 */
+#define BPF_CTZ64	0x01	/* imm for ctz64 */
+#define BPF_FFS64	0x02	/* imm for ffs64 */
+#define BPF_FLS64	0x03	/* imm for fls64 */
+#define BPF_BITREV64	0x04	/* imm for bitrev64 */
+#define BPF_POPCNT64	0x05	/* imm for popcnt64 */
+#define BPF_ROL64	0x06	/* imm for rol64 */
+#define BPF_ROR64	0x07	/* imm for ror64 */
+
+#define BPF_BITOPS_INSN(IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_BITOPS,		\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
 /* Internal classic blocks for direct assignment */
 
 #define __BPF_STMT(CODE, K)					\
@@ -1157,6 +1176,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_bitops(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc906dfdff94..cee90181d169 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3113,6 +3113,12 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Return TRUE if the JIT backend inlines the bitops insn. */
+bool __weak bpf_jit_inlines_bitops(s32 imm)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ac32798eb04..0a598c800f67 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -29,6 +29,8 @@
 #include <linux/task_work.h>
 #include <linux/irq_work.h>
 #include <linux/buildid.h>
+#include <linux/bitops.h>
+#include <linux/bitrev.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -4501,6 +4503,46 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	}
 }
 
+__bpf_kfunc u64 bpf_clz64(u64 x)
+{
+	return x ? 64 - fls64(x) : 64;
+}
+
+__bpf_kfunc u64 bpf_ctz64(u64 x)
+{
+	return x ? __ffs64(x) : 64;
+}
+
+__bpf_kfunc u64 bpf_ffs64(u64 x)
+{
+	return x ? __ffs64(x) + 1 : 0;
+}
+
+__bpf_kfunc u64 bpf_fls64(u64 x)
+{
+	return fls64(x);
+}
+
+__bpf_kfunc u64 bpf_popcnt64(u64 x)
+{
+	return hweight64(x);
+}
+
+__bpf_kfunc u64 bpf_bitrev64(u64 x)
+{
+	return ((u64)bitrev32(x & 0xFFFFFFFF) << 32) | bitrev32(x >> 32);
+}
+
+__bpf_kfunc u64 bpf_rol64(u64 x, u64 s)
+{
+	return rol64(x, s);
+}
+
+__bpf_kfunc u64 bpf_ror64(u64 x, u64 s)
+{
+	return ror64(x, s);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4578,6 +4620,14 @@ BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
 #endif
 #endif
+BTF_ID_FLAGS(func, bpf_clz64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_ctz64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_ffs64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_fls64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_popcnt64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_bitrev64, KF_FASTCALL | KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_rol64, KF_MUST_INLINE)
+BTF_ID_FLAGS(func, bpf_ror64, KF_MUST_INLINE)
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index edf5342b982f..ed9a077ecf2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12477,6 +12477,14 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_clz64,
+	KF_bpf_ctz64,
+	KF_bpf_ffs64,
+	KF_bpf_fls64,
+	KF_bpf_bitrev64,
+	KF_bpf_popcnt64,
+	KF_bpf_rol64,
+	KF_bpf_ror64,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12557,6 +12565,14 @@ BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+BTF_ID(func, bpf_clz64)
+BTF_ID(func, bpf_ctz64)
+BTF_ID(func, bpf_ffs64)
+BTF_ID(func, bpf_fls64)
+BTF_ID(func, bpf_bitrev64)
+BTF_ID(func, bpf_popcnt64)
+BTF_ID(func, bpf_rol64)
+BTF_ID(func, bpf_ror64)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12564,6 +12580,30 @@ static bool is_task_work_add_kfunc(u32 func_id)
 	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
 }
 
+static bool get_bitops_insn_imm(u32 func_id, s32 *imm)
+{
+	if (func_id == special_kfunc_list[KF_bpf_clz64])
+		*imm = BPF_CLZ64;
+	else if (func_id == special_kfunc_list[KF_bpf_ctz64])
+		*imm = BPF_CTZ64;
+	else if (func_id == special_kfunc_list[KF_bpf_ffs64])
+		*imm = BPF_FFS64;
+	else if (func_id == special_kfunc_list[KF_bpf_fls64])
+		*imm = BPF_FLS64;
+	else if (func_id == special_kfunc_list[KF_bpf_bitrev64])
+		*imm = BPF_BITREV64;
+	else if (func_id == special_kfunc_list[KF_bpf_popcnt64])
+		*imm = BPF_POPCNT64;
+	else if (func_id == special_kfunc_list[KF_bpf_rol64])
+		*imm = BPF_ROL64;
+	else if (func_id == special_kfunc_list[KF_bpf_ror64])
+		*imm = BPF_ROR64;
+	else
+		return false;
+
+	return true;
+}
+
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
 	if (meta->func_id == special_kfunc_list[KF_bpf_refcount_acquire_impl] &&
@@ -14044,6 +14084,8 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	int err, insn_idx = *insn_idx_p;
 	const struct btf_param *args;
 	struct btf *desc_btf;
+	bool is_bitops_kfunc;
+	s32 insn_imm;
 
 	/* skip for now, but return error when we find this in fixup_kfunc_call */
 	if (!insn->imm)
@@ -14423,6 +14465,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
 		env->prog->call_session_cookie = true;
 
+	is_bitops_kfunc = get_bitops_insn_imm(meta.func_id, &insn_imm);
+	if ((meta.kfunc_flags & KF_MUST_INLINE)) {
+		bool inlined = is_bitops_kfunc && bpf_jit_inlines_bitops(insn_imm);
+
+		if (!inlined) {
+			verbose(env, "JIT does not support inlining the kfunc %s.\n", func_name);
+			return -EOPNOTSUPP;
+		}
+	}
+
 	return 0;
 }
 
@@ -23236,6 +23288,19 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		insn_buf[4] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_1);
 		insn_buf[5] = BPF_ALU64_IMM(BPF_NEG, BPF_REG_0, 0);
 		*cnt = 6;
+	} else if (get_bitops_insn_imm(desc->func_id, &insn_buf[0].imm)) {
+		s32 imm = insn_buf[0].imm;
+
+		if (imm == BPF_FFS64) {
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 2);
+			insn_buf[2] = BPF_BITOPS_INSN(imm);
+			insn_buf[3] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+			*cnt = 4;
+		} else {
+			insn_buf[0] = BPF_BITOPS_INSN(imm);
+			*cnt = 1;
+		}
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.52.0


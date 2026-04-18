Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4C163CB
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518218; cv=none; b=PHj4wqtJrqOWtFglaUDRQmghTA1LO5sNwITxcsWxxloa5kZxOtuDG7fwhgLA+hgfswh47JEHt0uMyQh5w99EI1td5bsMASdNvxCU9+elhKCaCjrXBVkReqSO68D9MrAt0qcLrbNVVifCZ9Aww72V/nEgJpVy4lNBnNrJlwJvWu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518218; c=relaxed/simple;
	bh=YrVXlucuxW/Elzv91D7gWH0a5+dzqcfoCGQfxSShH8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6BpFg1PZzHIILIs9M36iuRUeWw+vAYQBOJ325+ekOiYghW7IZi9WFFD4wr0R4ZgQGUYyfxYBrk/Saod79nayWFSQQ0leK+hS6c6QzpdtNUQP2Z8k6BzARebAJu2TzmMHO5yS/X3Wi83fEEX5sH0Dx1EHxjL+6Yh8KBTiausp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT2h/zJo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT2h/zJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C83C19424;
	Sat, 18 Apr 2026 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518217;
	bh=YrVXlucuxW/Elzv91D7gWH0a5+dzqcfoCGQfxSShH8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bT2h/zJog3VjuxvRZk4Zqmw6K4UReKyMhIPzXW9T+BGsuDL6gCseLyhy3x0xU01LF
	 WyONe7T0Z29B0DjKo11Wq6ZwwF0IQt15j57unonBJixYnA6W46L4mrLeDGnwEJuXMA
	 RKj/w7bxL+IczfD58o1Y1cRph/XKKnxB/iIu7GC+7mAAxIVYgkj5Y0Ezsq1u0ertFM
	 xpZccSGt4fXTipTNIhOh06TAM26yIZ9VQXLaCWAcYSGF610i1ei1Nd0ws+OIdvGP3F
	 /aE2j5UNvneVp4fC4GEI/l7hVgTQJ3EC1ZRlM4gJAA5gbvVOBAiwk5CrfoniFf2IMl
	 nG7dPKZlmZKeg==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v13 6/6] bpf, arm64: Add JIT support for cpu time counter kfuncs
Date: Sat, 18 Apr 2026 06:16:04 -0700
Message-ID: <20260418131614.1501848-7-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418131614.1501848-1-puranjay@kernel.org>
References: <20260418131614.1501848-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add ARM64 JIT inlining for bpf_get_cpu_time_counter() and
bpf_cpu_time_counter_to_ns() kfuncs.

bpf_get_cpu_time_counter() is JIT-inlined as:

  ISB                       // serialize instruction stream
  MRS Xn, CNTVCT_EL0        // read architected timer counter

The ISB before the MRS is required for ordering, matching the kernel's
arch_timer_read_cntvct_el0() implementation.

On newer CPUs it will be JITed to:

  MRS Xn, CNTVCTSS_EL0      // self-synchronized (ISB not needed)

bpf_cpu_time_counter_to_ns() is JIT-inlined using mult/shift constants
computed at JIT time from the architected timer frequency (CNTFRQ_EL0):

  MOV Xtmp, #mult           // load conversion multiplier
  MUL Xn, Xarg, Xtmp        // delta_ticks * mult
  LSR Xn, Xn, #shift        // >> shift = nanoseconds

On systems with a 1GHz counter (e.g., Neoverse-V2), mult=1 and shift=0,
so the conversion collapses to a single MOV (identity).

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/arm64/include/asm/insn.h                 |  2 +
 arch/arm64/net/bpf_jit.h                      |  4 ++
 arch/arm64/net/bpf_jit_comp.c                 | 54 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 50 ++++++++++++++++-
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index f463a654a2bb..bb235a39cef0 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -139,6 +139,8 @@ enum aarch64_insn_system_register {
 	AARCH64_INSN_SYSREG_TPIDR_EL1	= 0x4684,
 	AARCH64_INSN_SYSREG_TPIDR_EL2	= 0x6682,
 	AARCH64_INSN_SYSREG_SP_EL0	= 0x4208,
+	AARCH64_INSN_SYSREG_CNTVCT_EL0		= 0x5F02,
+	AARCH64_INSN_SYSREG_CNTVCTSS_EL0	= 0x5F06,
 };
 
 enum aarch64_insn_variant {
diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index d13de4222cfb..a525387439fe 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -326,6 +326,10 @@
 	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_TPIDR_EL2)
 #define A64_MRS_SP_EL0(Rt) \
 	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
+#define A64_MRS_CNTVCT_EL0(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_CNTVCT_EL0)
+#define A64_MRS_CNTVCTSS_EL0(Rt) \
+	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_CNTVCTSS_EL0)
 
 /* Barriers */
 #define A64_SB aarch64_insn_get_sb_value()
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 0816c40fc7af..7da7507ab431 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/clocksource.h>
 #include <linux/cfi.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
@@ -19,6 +20,7 @@
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
 #include <asm/cpufeature.h>
+#include <asm/arch_timer.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/text-patching.h>
@@ -1571,10 +1573,54 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 	case BPF_JMP | BPF_CALL:
 	{
 		const u8 r0 = bpf2a64[BPF_REG_0];
+		const u8 r1 = bpf2a64[BPF_REG_1];
+		const s32 imm = insn->imm;
 		bool func_addr_fixed;
 		u64 func_addr;
 		u32 cpu_offset;
 
+		/* Inline kfunc bpf_get_cpu_time_counter() */
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+		    imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+		    bpf_jit_inlines_kfunc_call(imm)) {
+			/*
+			 * With ECV (ARMv8.6+), CNTVCTSS_EL0 is self-
+			 * synchronizing — no ISB needed.  Without ECV,
+			 * an ISB is required before reading CNTVCT_EL0
+			 * to prevent speculative/out-of-order reads.
+			 *
+			 * Matches arch_timer_read_cntvct_el0().
+			 */
+			if (cpus_have_cap(ARM64_HAS_ECV)) {
+				emit(A64_MRS_CNTVCTSS_EL0(r0), ctx);
+			} else {
+				emit(A64_ISB, ctx);
+				emit(A64_MRS_CNTVCT_EL0(r0), ctx);
+			}
+			break;
+		}
+
+		/* Inline kfunc bpf_cpu_time_counter_to_ns() */
+		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+		    imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+		    bpf_jit_inlines_kfunc_call(imm)) {
+			u32 freq = arch_timer_get_cntfrq();
+
+			if (freq == NSEC_PER_SEC) {
+				/* 1 GHz counter: 1 tick = 1 ns, identity */
+				emit(A64_MOV(1, r0, r1), ctx);
+			} else {
+				u32 mult, shift;
+
+				clocks_calc_mult_shift(&mult, &shift, freq, NSEC_PER_SEC, 3600);
+				emit_a64_mov_i(1, tmp, mult, ctx);
+				emit(A64_MUL(1, r0, r1, tmp), ctx);
+				if (shift)
+					emit(A64_LSR(1, r0, r0, shift), ctx);
+			}
+			break;
+		}
+
 		/* Implement helper call to bpf_get_smp_processor_id() inline */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
 			cpu_offset = offsetof(struct thread_info, cpu);
@@ -3127,6 +3173,14 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 	}
 }
 
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
+	    imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns))
+		return true;
+	return false;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
index 26c02010ccf1..ab1b20e28084 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
@@ -56,7 +56,7 @@ __naked int bpf_rdtsc_jit_x86_64(void)
 SEC("syscall")
 __arch_arm64
 __xlated("0: r1 = 42")
-__xlated("1: r0 = r1")
+__xlated("1: call kernel-function")
 __naked int bpf_cyc2ns_arm(void)
 {
 	asm volatile(
@@ -111,6 +111,54 @@ __naked int bpf_cyc2ns_jit_x86(void)
 	);
 }
 
+SEC("syscall")
+__arch_arm64
+__xlated("0: call kernel-function")
+__naked int bpf_cntvct(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_arm64
+/*
+ * With ECV:    mrs x7, CNTVCTSS_EL0
+ * Without ECV: isb; mrs x7, CNTVCT_EL0
+ */
+__jited("	mrs	x7, CNTVCT{{(SS_EL0|_EL0)}}")
+__naked int bpf_cntvct_jit_arm64(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_arm64
+/* bpf_cpu_time_counter_to_ns: mov (1GHz identity) or mul+lsr */
+__jited("	{{(mov	x7, x0|mul	x7, x0, x10)}}")
+__naked int bpf_cyc2ns_jit_arm64(void)
+{
+	asm volatile(
+	"r1=0x2a;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
 void rdtsc(void)
 {
 	bpf_get_cpu_time_counter();
-- 
2.52.0


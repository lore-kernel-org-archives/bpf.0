Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1516130649C
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518204; cv=none; b=DDF8JGrSJSH7+Uet1j9eWl4RwtVnbpMkiabAYuEVnE1G/QUuq7GWJ3YOfHYo7G7V6aFUW7T0U8BukkrXlr40K0hVCIo+d7tZCUaMebQJuVMeryrdI6FmWu3Y43o9ktrcDrbg/Liw/wTOzdJAdJficv8pj9iSOCXgQcRLDlVtoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518204; c=relaxed/simple;
	bh=29A+mgFWU5lVPWW8C9d8N5SYuygwIPXSuNB7Mz1RYKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td4gzYFTvV3a+BE0ppdYYuvvFirpvXufZ0d3maZ2ZzDpqXsTNk4rkI8n8i9Etj7U42g9R6/ePb4Pob40ygvAzfRIMUsh2yKyngTBRIL1NwZhtu8RnRV2MorexhtzsBqM8/ef3HRKmooxkoTREXGzG59bNlDtkcrmriHdZbA949A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkKE++lv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkKE++lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75545C19424;
	Sat, 18 Apr 2026 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518203;
	bh=29A+mgFWU5lVPWW8C9d8N5SYuygwIPXSuNB7Mz1RYKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkKE++lveRp+2sd1otGK/hCBnlj0jYF9DyvnRnPMsicMuDbx5wKDZFT0T1jWHi4cL
	 aMZQrCzZtaNX7iclk+olh8tJKpmfXEhPWu4U7krLUVT3MmnZY0N5gZpzuEuB+oK1Xm
	 ZTZu21Lxc/eoGh/UANQH+9DRYQTMKXVxiANETZAb8y7yclOSRBj1AmmAZBB9KHD6wX
	 HKXLHRnu2Iw4O5dkHB+g3ONeZZ5CjYpxzdx99UbsX8WbUvN74pYeNhA0+keBFNWSaF
	 AHP/tU96ZVlXGNr9O8swluGdBEAQb4YtZyTjlpmUVM0yNsseG6KC3Sm50aEyfGKDDC
	 FUnD0sU3cct5g==
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
	kernel-team@meta.com,
	Vadim Fedorenko <vadfed@meta.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v13 2/6] bpf: add bpf_get_cpu_time_counter kfunc
Date: Sat, 18 Apr 2026 06:16:00 -0700
Message-ID: <20260418131614.1501848-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418131614.1501848-1-puranjay@kernel.org>
References: <20260418131614.1501848-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vadfed@meta.com>

New kfunc to return ARCH-specific timecounter. The main reason to
implement this kfunc is to avoid extra overhead of benchmark
measurements, which are usually done by a pair of bpf_ktime_get_ns()
at the beginnig and at the end of the code block under benchmark.
When fully JITed this function doesn't implement conversion to the
monotonic clock and saves some CPU cycles by receiving timecounter
values in single-digit amount of instructions. The delta values can be
translated into nanoseconds using kfunc introduced in the next patch.
For x86_64 BPF JIT converts this kfunc into rdtsc ordered call. Other
architectures will get JIT implementation too if supported. The fallback
is to get CLOCK_MONOTONIC_RAW value in ns.

JIT version of the function uses "LFENCE; RDTSC" variant because it
doesn't care about cookie value returned by "RDTSCP" and it doesn't want
to trash RCX value. LFENCE option provides the same ordering guarantee as
RDTSCP variant.

The simplest use-case is added in 5th patch, where we calculate the time
spent by bpf_get_ns_current_pid_tgid() kfunc. More complex example is to
use session cookie to store timecounter value at kprobe/uprobe using
kprobe.session/uprobe.session, and calculate the difference at
kretprobe/uretprobe.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c   | 45 +++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp32.c |  1 +
 include/linux/bpf.h           |  3 +++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 11 +++++++++
 kernel/bpf/helpers.c          | 11 +++++++++
 kernel/bpf/verifier.c         |  4 +++-
 7 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..7cda5589107b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -16,6 +16,7 @@
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
+#include <asm/timer.h>
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
@@ -2445,6 +2446,40 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
+			u8 *ip = image + addrs[i - 1];
+
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+			    bpf_jit_inlines_kfunc_call(imm32)) {
+				/* The default implementation of this kfunc uses
+				 * ktime_get_raw_ns() which effectively is implemented as
+				 * `(u64)rdtsc_ordered() & S64_MAX`. For JIT We skip
+				 * masking part because we assume it's not needed in BPF
+				 * use case (two measurements close in time).
+				 * Original code for rdtsc_ordered() uses sequence:
+				 * 'rdtsc; nop; nop; nop' to patch it into
+				 * 'lfence; rdtsc' or 'rdtscp' depending on CPU features.
+				 * JIT uses 'lfence; rdtsc' variant because BPF program
+				 * doesn't care about cookie provided by rdtscp in RCX.
+				 * Save RDX because RDTSC will use EDX:EAX to return u64
+				 */
+				emit_mov_reg(&prog, true, AUX_REG, BPF_REG_3);
+				if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+					EMIT_LFENCE();
+				EMIT2(0x0F, 0x31);
+
+				/* shl RDX, 32 */
+				maybe_emit_1mod(&prog, BPF_REG_3, true);
+				EMIT3(0xC1, add_1reg(0xE0, BPF_REG_3), 32);
+				/* or RAX, RDX */
+				maybe_emit_mod(&prog, BPF_REG_0, BPF_REG_3, true);
+				EMIT2(0x09, add_2reg(0xC0, BPF_REG_0, BPF_REG_3));
+				/* restore RDX from R11 */
+				emit_mov_reg(&prog, true, BPF_REG_3, AUX_REG);
+
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4081,3 +4116,13 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+/* x86-64 JIT can inline kfunc */
+bool bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	    cpu_feature_enabled(X86_FEATURE_TSC) &&
+	    using_native_sched_clock() && sched_clock_stable())
+		return true;
+	return false;
+}
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index 852baf2e4db4..ca208378c979 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -16,6 +16,7 @@
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
 #include <asm/asm-prototypes.h>
+#include <asm/timer.h>
 #include <linux/bpf.h>
 
 /*
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b4b703c90ca9..74abf2b639fd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3744,6 +3744,9 @@ void bpf_user_rnd_init_once(void);
 u64 bpf_user_rnd_u32(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
+/* Inlined kfuncs */
+u64 bpf_get_cpu_time_counter(void);
+
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
 				     enum bpf_access_type type,
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 1ec6d5ba64cc..4924c0bab1a0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1159,6 +1159,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
+bool bpf_jit_inlines_kfunc_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8b018ff48875..e06e750ee16f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3201,6 +3201,17 @@ bool __weak bpf_jit_inlines_helper_call(s32 imm)
 	return false;
 }
 
+/* Return true if the JIT inlines the call to the kfunc corresponding to
+ * the imm.
+ *
+ * The verifier will not patch the insn->imm for the call to the helper if
+ * this returns true.
+ */
+bool __weak bpf_jit_inlines_kfunc_call(s32 imm)
+{
+	return false;
+}
+
 /* Return TRUE if the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool __weak bpf_jit_supports_subprog_tailcalls(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..dfe280440120 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4664,6 +4664,16 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	}
 }
 
+__bpf_kfunc u64 bpf_get_cpu_time_counter(void)
+{
+	/* CLOCK_MONOTONIC_RAW is the closest analogue to what is implemented
+	 * in JIT. The access time is the same as for CLOCK_MONOTONIC, but the
+	 * slope of 'raw' is not affected by NTP adjustments, and with stable
+	 * TSC it can provide less jitter in short term measurements.
+	 */
+	return ktime_get_raw_fast_ns();
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4859,6 +4869,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_get_cpu_time_counter)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 69d75515ed3f..b8d26e1bff48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17035,7 +17035,9 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 			/* error would be reported later */
 			return false;
 		cs->num_params = btf_type_vlen(meta.func_proto);
-		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
+		cs->fastcall = (meta.kfunc_flags & KF_FASTCALL) ||
+			       (meta.btf == btf_vmlinux &&
+				bpf_jit_inlines_kfunc_call(call->imm));
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));
 		return true;
 	}
-- 
2.52.0


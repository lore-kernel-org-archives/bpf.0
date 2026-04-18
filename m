Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4074C199E89
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518207; cv=none; b=dKfEOBlP5M/6AM3Yflmb0gdCIOi6jKV4I1M6uH5WcLyPJePfNqnHvITXJknnhant8cB4yjDt4XWXd86uvRaLDeReMMDq13RkaROwNj8Dy/TWZoLD/ou7GaTJiuYJAWov8iin3knnIQNYXhXa+XCfrCK3aBMBcJMxyt//yhlRayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518207; c=relaxed/simple;
	bh=zazoME0/J8uGnNYBTon0SGimIDTHl7z9zqTSbBof6GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmyQKM0QxMbH8EuZvpgLde7CnXJ5Ygg6XesVncb4tT4FC2PcNg8RUpshKJQbh2aMPi33psP9heydIAmMakt8CWzqcUAW/bto8vmrNzkO7eDQsP0sfS/P5WtsVqvJefMbk+L8vdm7Ymp1dzsvpo8cFknPfMJJ0GZV1LEFlYOYzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DogI+Tv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DogI+Tv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C39C19424;
	Sat, 18 Apr 2026 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518206;
	bh=zazoME0/J8uGnNYBTon0SGimIDTHl7z9zqTSbBof6GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DogI+Tv60J/phTAh5iSSTSMl4kNF+cWg1LFUyDqhfp3TUy/xE1twZ3kGtgbOVjXz2
	 zh61AjpWJAqMEmxFZl7e2fIENlDM95/C0PLJAMC/5ZgGMmTXEv6j+M/88uUtWDkc2q
	 MVu996jyVY1dJ/HUzo6uEd0W7Ah6YMrbKfiJuq07kvh2B8OSCcINrfhZxSAI5N5lvq
	 EmDwbAyQYZQI3xIHOsXjsHUjszHjc89LIbsZbYfWF3NG49XStxVMmIqVTWNTep/9vQ
	 PpLUWgqPhQxfDZpkyUuxSDWNw/obsBcp6RyKSIFFevTaOADsdnnwkxcY9vGmaids2f
	 61jYFcT3RLXMQ==
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
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v13 3/6] bpf: add bpf_cpu_time_counter_to_ns kfunc
Date: Sat, 18 Apr 2026 06:16:01 -0700
Message-ID: <20260418131614.1501848-4-puranjay@kernel.org>
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

The new kfunc should be used to convert deltas of values
received by bpf_get_cpu_time_counter() into nanoseconds. It is not
designed to do full conversion of time counter values to
CLOCK_MONOTONIC_RAW nanoseconds and cannot guarantee monotonicity of 2
independent values, but rather to convert the difference of 2 close
enough values of CPU timestamp counter into nanoseconds.

This function is JITted into just several instructions and adds as
low overhead as possible and perfectly suits benchmark use-cases.

When the kfunc is not JITted it returns the value provided as argument
because the kfunc in previous patch will return values in nanoseconds
and can be optimized by verifier.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c   | 29 ++++++++++++++++++++++++++++-
 arch/x86/net/bpf_jit_comp32.c |  1 +
 include/linux/bpf.h           |  1 +
 kernel/bpf/helpers.c          |  6 ++++++
 kernel/bpf/verifier.c         | 10 +++++++---
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7cda5589107b..a8956eb867ef 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -10,6 +10,7 @@
 #include <linux/if_vlan.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
+#include <linux/clocksource.h>
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <asm/extable.h>
@@ -2480,6 +2481,31 @@ st:			if (is_imm8(insn->off))
 				break;
 			}
 
+			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+			    imm32 == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns) &&
+			    bpf_jit_inlines_kfunc_call(imm32)) {
+				struct cyc2ns_data data;
+				u32 mult, shift;
+
+				/* stable TSC runs with fixed frequency and
+				 * transformation coefficients are also fixed
+				 */
+				cyc2ns_read_begin(&data);
+				mult = data.cyc2ns_mul;
+				shift = data.cyc2ns_shift;
+				cyc2ns_read_end();
+				/* imul RAX, RDI, mult */
+				maybe_emit_mod(&prog, BPF_REG_1, BPF_REG_0, true);
+				EMIT2_off32(0x69, add_2reg(0xC0, BPF_REG_1, BPF_REG_0),
+					    mult);
+
+				/* shr RAX, shift (which is less than 64) */
+				maybe_emit_1mod(&prog, BPF_REG_0, true);
+				EMIT3(0xC1, add_1reg(0xE8, BPF_REG_0), shift);
+
+				break;
+			}
+
 			func = (u8 *) __bpf_call_base + imm32;
 			if (src_reg == BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -4120,7 +4146,8 @@ bool bpf_jit_supports_fsession(void)
 /* x86-64 JIT can inline kfunc */
 bool bpf_jit_inlines_kfunc_call(s32 imm)
 {
-	if (imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) &&
+	if ((imm == BPF_CALL_IMM(bpf_get_cpu_time_counter) ||
+	     imm == BPF_CALL_IMM(bpf_cpu_time_counter_to_ns)) &&
 	    cpu_feature_enabled(X86_FEATURE_TSC) &&
 	    using_native_sched_clock() && sched_clock_stable())
 		return true;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index ca208378c979..da61bc5585aa 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -12,6 +12,7 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/if_vlan.h>
+#include <linux/clocksource.h>
 #include <asm/cacheflush.h>
 #include <asm/set_memory.h>
 #include <asm/nospec-branch.h>
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 74abf2b639fd..d523168b8998 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3746,6 +3746,7 @@ u64 bpf_get_raw_cpu_id(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
 /* Inlined kfuncs */
 u64 bpf_get_cpu_time_counter(void);
+u64 bpf_cpu_time_counter_to_ns(u64 counter);
 
 #if defined(CONFIG_NET)
 bool bpf_sock_common_is_valid_access(int off, int size,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dfe280440120..bc7f5ccac761 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4674,6 +4674,11 @@ __bpf_kfunc u64 bpf_get_cpu_time_counter(void)
 	return ktime_get_raw_fast_ns();
 }
 
+__bpf_kfunc u64 bpf_cpu_time_counter_to_ns(u64 counter)
+{
+	return counter;
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4870,6 +4875,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_ID_FLAGS(func, bpf_get_cpu_time_counter)
+BTF_ID_FLAGS(func, bpf_cpu_time_counter_to_ns, KF_FASTCALL)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b8d26e1bff48..5341dc6d29ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11178,8 +11178,8 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_cpu_time_counter_to_ns,
 };
-
 BTF_ID_LIST(special_kfunc_list)
 BTF_ID(func, bpf_obj_new_impl)
 BTF_ID(func, bpf_obj_new)
@@ -11266,6 +11266,7 @@ BTF_ID(func, bpf_arena_reserve_pages)
 BTF_ID(func, bpf_session_is_return)
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+BTF_ID(func, bpf_cpu_time_counter_to_ns)
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
@@ -18629,7 +18630,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 }
 
 
-
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
@@ -19791,6 +19791,9 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
+	/* if JIT will inline kfunc verifier shouldn't change the code */
+	if (bpf_jit_inlines_kfunc_call(insn->imm))
+		return 0;
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
@@ -19851,7 +19854,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		__fixup_collection_insert_kfunc(&env->insn_aux_data[insn_idx], struct_meta_reg,
 						node_offset_reg, insn, insn_buf, cnt);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
-		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
+		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast] ||
+		   desc->func_id == special_kfunc_list[KF_bpf_cpu_time_counter_to_ns]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
-- 
2.52.0


Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E0372B3B
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573174; cv=none; b=pL35j/VRDC8BepI3+IL0OTTwU0YYgoR1Vkdq31yZl4kHa9J9dXPceJBeFwizZ0bRGWpgfLTUDvqotU6YtCDhdSabGWi20kLN/IMW6Dgx9yQBzkmt3FZyvmfqs7YE2rUlB6GY9UbT5MEJttlnkmBMN7bgsHUdF7tuV5/bh37OkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573174; c=relaxed/simple;
	bh=XxUNAgowF8ncwp0863RxOhjMbJ6XReo1vVtgNU40eF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu6AkeiewBcFRU4F3jIFa5rmKI1c1XWKVXpPxoUJ4ruvwJK3oveRKkLZpac5tmQ80Tvl5V5qVsuQG4tLFFi3afU4CYq2Cqsx+kzbzUPyZ3HpTa7Uam2u1BP6o2pBLp3j/m2fz/azolFn8yczsnKGjAlhsEsGDJOG73z+JPlHXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUt0GGE4; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUt0GGE4"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fad256d40so520462f8f.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573170; x=1787177970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nz03UfOhxlihLfJsdZ17dr7ntITVIG3kz2lk9wuDLg8=;
        b=BUt0GGE4SdaOw5zkpK277PPaRN6R82OpUwiWDirAjY61xYcRbkn22TG8VV0TqEyayr
         eP/+ER5ezR9lJ7kdIO0w2bBSFr8EtJ7G6XEi//KqkCSE8ePGgXa3c59Zg3aErjfooKGz
         YKVgadDltOff0A2wFIPWfylf6u20nop6ZeFlj9sfDlOAfOGgQ/AySokTdg7nV/PqQImA
         K+Wcc+hf0VBQ8k/0JOvznYslU4ycry4VGKyrnTzFchE74KBz48mVtUzAizFdQ8rDHdgG
         Sq4goi07rP054c1lWBTp5gqef00lCUzKQSeaXnG1V1qHCObciEkP4pMLhtnQPOcfwEv7
         noiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573170; x=1787177970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nz03UfOhxlihLfJsdZ17dr7ntITVIG3kz2lk9wuDLg8=;
        b=Xc6VR4+1SsqpslPDi2OwgocJvNsLmahTLuGa4usYOn0BudcVnl4m/+RzMbQo1UvBIB
         uCywV5plU6AmqaZtG0ZpyZeQncO6fnUSKPOjnCdACkaE7QKiozM5SgzvN60Vmuvvi2QE
         xGIBE2wAB/HlVEK68r6kziibN9cf+Dt8GiNctDnK0A561AC68Mqc+p/W6kKJXjB1SAPi
         tRC8WUFNz4E64VnrcsVRj1Ov+pkzpHqadWtU6TVMMGfeJ3dWz91xufcEFDBu2ju+KVvq
         +uMK8v/NYtBAaPAjepKnXrQpvN5ZStdTDFh7bU652TPNYxi6kB8OXRlO6SHxhjBVO3zP
         r6/Q==
X-Gm-Message-State: AOJu0YynAZEbjUvx30KgXsW7DI7CmVjO9r8Xpc8pcpa5cIKcKtrTnwZ/
	WYKovXoFIT09rCWpJnTqx7m71cctm1pNm3w7ziPx65xVzTuSp7B51zfEKgjJD7Gk
X-Gm-Gg: AR+sD11FmCtJ7QU/JEC+qP6lCHXkIArrFc6vcCB8S8xaDp/ARWE6In3VfWUe84/29M5
	eidrlgKXHIJ+JU2AzH1rKb9ezEtdqympIx3Gkt1lA6KOTn/UP2Ipl4GgErBP7WSxkSO1D5VyfRH
	/sBKmlQy5SEFs/2H+M6xVjlz2tDEEsuLK/hibKAhQu9+r/R94xQ7wcXseLw/xowJ5RzN1Hy8eGC
	96wegPZ4IOFtQA4p+JcdWypjViyKCGVTIRBlMWOtircaxGzcq68fECDiTJpR7EwGUoZfRue5olt
	9t/osxHVJLvbAD9iisS1el7+5CEb0LTNkRrHRNAmOOwf9NSaq85VTH5rtQTRBfxJvIeQI3RrK2R
	kiRQO4+kfNVu8FnzX2Wd4/uXI9T9hkASU2hSATySQp+t0wL0cMhSEzJJ390Pgx4B4uKSpNaCVIk
	xJ4I+8908wWL8IqBJzqJ9WBbCS4ov+FlKHJ3SZufBeQ029RFICYIS46hDBQdn70mhS5gV2V/zmV
	sxSaYSGACS+47fcROw2Di1//tfInLFCPMHuL92DSFknTqHIZfggaoBy9v2QFb8i0NA0y/dubOFF
	f7aDOqEBvT3TvOl58sSFWlVOLMw=
X-Received: by 2002:a05:6000:46d7:b0:47f:34ba:2d0d with SMTP id ffacd0b85a97d-48159caf1edmr1041013f8f.8.1786573170313;
        Wed, 12 Aug 2026 15:19:30 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6e3asm838904f8f.28.2026.08.12.15.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:29 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 3/6] bpf: Show more useful info in stack depth stats
Date: Thu, 13 Aug 2026 00:19:20 +0200
Message-ID: <20260812221925.3358041-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221925.3358041-1-memxor@gmail.com>
References: <20260812221925.3358041-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11309; i=memxor@gmail.com; h=from:subject; bh=XxUNAgowF8ncwp0863RxOhjMbJ6XReo1vVtgNU40eF8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmw889Hft+n+DcWnrs8vsY1fAotex578LbYp5yCa9oP 3F2T8SKjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk4RYjw1ttnSbTgKUcOmn8 56z+OQTsunYqQac2TWTu5gjzFP37Gxl+MX3i8Qmf92JhaKoEj9T5RwfE1kfq3P++UfyBoXLcDyY VTgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack depth statistics list captured depths in subprogram-number order,
while per-verification instruction counts are reported separately. Since
libbpf determines subprogram numbers, it is hard to associate either
statistic with its subprogram name or see where verifier work is spent.

Now that self and inclusive instruction counts are available for every
subprogram, keep the combined maximum stack depth on its own line and print
one uniform record for each subprogram. Represent the main program as
subprog 0, then classify each record as main, global, or static before
reporting insns_self, insns_total, and stack depth.

The aggregate processed count is the sum of all self counts, while each
total shows verifier work rooted at that subprogram.

When no subprogram name is available, print <unknown>. Keep the existing
aggregate "processed ... insns" record unchanged for compatibility.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 23 +++++++++------
 .../bpf/progs/verifier_basic_stack.c          |  6 ++--
 .../bpf/progs/verifier_bpf_fastcall.c         | 28 +++++++++++++------
 .../bpf/progs/verifier_global_subprogs.c      |  5 +++-
 .../bpf/progs/verifier_private_stack.c        | 15 ++++++++--
 .../selftests/bpf/progs/verifier_var_off.c    |  6 ++--
 6 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fced21ec2304..73d6cd563cdf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18693,15 +18693,20 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 	if (env->log.level & BPF_LOG_STATS) {
 		verbose(env, "verification time %lld usec\n",
 			div_u64(env->verification_time, 1000));
-		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
-		for (i = 1; i < subprog_cnt; i++)
-			verbose(env, "+%d", env->subprog_info[i].stack_depth);
-		verbose(env, " max %d\n", env->max_stack_depth);
-		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
-		for (i = 1; i < subprog_cnt; i++)
-			if (bpf_subprog_is_global(env, i))
-				verbose(env, "+%d", env->subprog_info[i].insns_total);
-		verbose(env, "\n");
+		verbose(env, "stack depth max %d\n", env->max_stack_depth);
+		for (i = 0; i < subprog_cnt; i++) {
+			const char *name = env->subprog_info[i].name;
+			const char *kind;
+
+			if (!name || !name[0])
+				name = "<unknown>";
+			kind = i == 0 ? "main" :
+			       bpf_subprog_is_global(env, i) ? "global" : "static";
+			verbose(env, "subprog %d (%s) %s insns_self %d insns_total %d stack %d\n",
+				i, name, kind, env->subprog_info[i].insns_self,
+				env->subprog_info[i].insns_total,
+				env->subprog_info[i].stack_depth);
+		}
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read %d\n",
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index d3df7a9f1d8c..0eb495ce85c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,8 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack1) main {{.*}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +46,8 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack2) main insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..4cfaa6b4ab40 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -10,7 +10,8 @@
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4)
+__msg("subprog 0 (simple) main insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 8")
 __xlated("4: r5 = 5")
 __xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
@@ -96,7 +97,8 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (wrong_reg_in_pattern1) main {{.*}} stack 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +600,8 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4)
+__msg("subprog 0 (helper_call_does_not_prevent_bpf_fastcall) main {{.*}} stack 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +623,8 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4)
+__msg("subprog 0 (may_goto_interaction_x86_64) main {{.*}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -661,7 +665,8 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__log_level(4) __msg("stack depth 24")
+__log_level(4)
+__msg("subprog 0 (may_goto_interaction) main {{.*}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +713,9 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction1) main {{.*}} stack 32")
+__msg("subprog 1 (dummy_loop_callback) static {{.*}} stack 0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +763,9 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction2) main {{.*}} stack 40")
+__msg("subprog 1 (dummy_loop_callback) static {{.*}} stack 0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
 __xlated("3: r0 =")
@@ -800,7 +809,10 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 512+0 max 512")
+__log_level(4)
+__msg("stack depth max 512")
+__msg("subprog 0 (cumulative_stack_depth) main {{.*}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static {{.*}} stack 0")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 67dc352addfd..7b65eea97ebc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -52,7 +52,10 @@ __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
-__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
+__msg("subprog 0 (chained_global_func_calls_success) main insns_self 7 insns_total 7 stack")
+__msg("subprog {{[0-9]+}} (global_calls_good_only) global insns_self 2 insns_total 2 stack")
+__msg("subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total 5 stack")
+__msg("processed 14 insns")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..ea0a7e73331d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,9 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4) __msg("stack depth max 512")
+__msg("subprog 0 (private_stack_nested_1) main {{.*}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static {{.*}} stack 32")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -331,7 +333,11 @@ SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __load_if_JITed()
-__log_level(4) __msg("stack depth 8+0+256+0 max 272")
+__log_level(4) __msg("stack depth max 272")
+__msg("subprog 0 (private_stack_async_callback_2) main {{.*}} stack 8")
+__msg("subprog 1 (timer_cb1) static {{.*}} stack 0")
+__msg("subprog 2 (subprog1) static {{.*}} stack 256")
+__msg("subprog 3 (subprog2) static {{.*}} stack 0")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -355,7 +361,10 @@ int private_stack_async_callback_2(void)
 SEC("fentry/bpf_fentry_test9")
 __description("private stack, max stack depth is private stack")
 __success
-__log_level(4) __msg("stack depth 8+256+0 max 256")
+__log_level(4) __msg("stack depth max 256")
+__msg("subprog 0 (private_stack_max_depth) main {{.*}} stack 8")
+__msg("subprog 1 (subprog1) static insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 256")
+__msg("subprog 2 (subprog2) static insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 0")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..a63e33675091 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,8 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (stack_write_priv_vs_unpriv) main {{.*}} stack 16")
 __failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
@@ -238,7 +239,8 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (stack_write_followed_by_read) main {{.*}} stack 16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0


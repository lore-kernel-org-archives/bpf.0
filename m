Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71F2FFDEA
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892525; cv=none; b=ISvG7ol2q+Rkyds5DyYxbpFbalpCVdis+cJW/7kI1mZWEJESESaeY5xObyAaeS4NwUaBndj+RGwg8b1Mt+8z43IvbW04Ck4vvBph7D1EksklutREe7XNjseo+Fj7izP8Mcj70vFPfsaOH2BU22iOyUIV5PX+nTILSUXnth4D5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892525; c=relaxed/simple;
	bh=toxY3lxQMz+lKiDI25WA2W4qClfnLhT0Ji7h22UZ07M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnhgIHL6Et5rCoWpQFKa+K8NSteQi9eQX49QuIyybprNUdpjFg0ZZGAqjQA9LtIvjl7Gz8EX7NPQITOUY5m9m6jE/jdyyPwvm9zF+BoR/q2WyRfdQu5H0WehRhWbLbfgtW+UOAoTgpA3/OIK4TVfE8z+ILZMnh1m/nGI8DPN0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2VuSvY+; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2VuSvY+"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49554457f71so98105e9.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892521; x=1786497321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SvSgsb0L5iPwlaURTZzEZYVHWdxzPIK3jZbxAL07Jlo=;
        b=e2VuSvY+IgiYZdtvT1LFIOGvDgpydtmed1VhEHDAFLdsEBqOewWopD7jKAIcORGIYY
         tXZGODnPzot+IGYHe35X0AQt2kLbZNJ2cSz6TRoO+dOYm0Jqe6/KDoMFOScKgStZ8jgM
         2cboZW9/zruig7f33KXlPsQ0S/WoiJkOD7xUKLnBRYMkGocXffBt3SM1eFLN23jWeF9E
         G5xYmT9fw3wcO8okVoDsox8w18FynDSSWh20gFiBPTMcjJ3P1Iegu0b2cXrMtszrCA7N
         D3i2Z5WQre1frdjJFFwq3FGoFSwPXXVN7aTqlaQThZOCQ+YcxbFUXnR9OxyElUX5oXTF
         mtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892521; x=1786497321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SvSgsb0L5iPwlaURTZzEZYVHWdxzPIK3jZbxAL07Jlo=;
        b=iK+JmPqeAUazRa9jmt2F3DU0PTuf/wsR+DSRt2RqulJ1ZDgyV6I4fB/9rgwqgY0116
         Zy4wmvDohlxFVpAHjFbF1BUlhtT0L9V47nYqvTrOVpjh+oQEjoOe9E02Vev71BG0kR+/
         t1rvdLo4v8Rxo9nAyYjPHeMYjC0VKDOciHaLalAA6IEaHZpP63ev/+4Hcy6mfANBaTu+
         5FKBZ/oAD04U7iqI/CaLLGcY8MYgutolomHrRgTAuGIx6NRR/PWoFKa991mw9U5rVnEa
         uw2a9eLOS7cP2HVt+ywk6mwSFj3ZdGRSkmcNO9A59cw32Ia3YnrTyaUmD0QFzXyara0R
         dFgA==
X-Gm-Message-State: AOJu0Yy29NXtDCKY2MPUlEfbAycnCBReK1TMva84CLSARxSB7O7t5dNj
	DsudQSaprcts7E6K3S7yHze0Kd6Hd4Kcj5elR5ytez8yGA5Os3Cknp6QaWAKwGcQ
X-Gm-Gg: AR+sD130x5nfOEbUTT8jU56nEI7riIyp/K+FnahyJANEa+3x5jcscNuiPtDUVhIBxht
	ol7ZKd7yN/rE5GJZqFr+Oeg+1ktzT9/xMRlU8GUCeXc6oRWi+6bWhcim4wqK+Z/zzxpIpODFSFY
	O03YLrIkG/9dVrEpWxsnORgnWZG5sL2f1MTY6QCVEnr/VqN9c0t+X8olEFrrn95mFNQFt/DaW7i
	4JqUQr4UF2Rtllyktnp9vVjxwgf1k37AIpOftpuTx96HrZ9640iXYTFmcCjCyglJ0NyOrzm31EV
	4ns+Y0hFRT1czJKkCBORS8Y+0tZh1oGU541hOU3Db5msiHzXA8zBdG4xXBYC5viIp/j3mg47KIQ
	hFIZTNumoaY+KPpbSYwuFvYA3GVS7x3fkjVysYQUmDDD4gy2GQDY9y+JnDO+P1rxYviwFSowbvk
	QiGPoFMaxSoonSmKehbDOh5+FmO5hpId7Jhx1BS+kZ95BH2cAttHr6ZT+GPFiO/Osn72gOR6tQY
	yBZhgOwLMLclwHdkmcQpK/oF6QZgoNZIP6ySGgoS/9B6b4OuS53n8LXjh2C5ld0Hhw+0v1GkzTF
	wid0LM5HiomZh033m2Zm20gZelEoSXI2sN/syZk=
X-Received: by 2002:a05:600d:8483:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4994e339bb8mr22715965e9.1.1785892521321;
        Tue, 04 Aug 2026 18:15:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e035900sm43638125e9.11.2026.08.04.18.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 3/6] bpf: Show more useful info in stack depth stats
Date: Wed,  5 Aug 2026 03:15:11 +0200
Message-ID: <20260805011517.1717238-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12230; i=memxor@gmail.com; h=from:subject; bh=toxY3lxQMz+lKiDI25WA2W4qClfnLhT0Ji7h22UZ07M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz/Vx4oLF3p5Gu1d76dUvZJGMXe9rznLwtlD26earp 4Qnxmp3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIfUhgZHp77X8TAtLDlokeA ncfPoOJuq946SQ6/9cvMMtoFzmq/Z2SY8ZVD+ZvRoZmL7mz5+3+NvoHvkdQj/ds0lWaVdb1LC9/ NAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Stack depth statistics list captured depths in subprogram-number order,
while per-verification instruction counts are reported separately. Since
libbpf determines subprogram numbers, it is hard to associate either
statistic with its subprogram name or see where verifier work is spent.

Now that own and inclusive instruction counts are available for every
subprogram, keep the combined maximum stack depth on its own line and
print one uniform record for each subprogram. Represent the main program
as subprog 0, then classify each record as main, global, or static before
reporting insns_own, insns_total, and stack depth.

The aggregate processed count is the sum of all own counts, while each
total shows verifier work rooted at that subprogram.

When no subprogram name is available, print <unknown>. Keep the existing
aggregate "processed ... insns" record unchanged for compatibility.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c                         | 23 ++++++-----
 .../bpf/progs/verifier_basic_stack.c          |  8 +++-
 .../bpf/progs/verifier_bpf_fastcall.c         | 38 +++++++++++++++----
 .../bpf/progs/verifier_global_subprogs.c      |  6 ++-
 .../bpf/progs/verifier_private_stack.c        | 22 +++++++++--
 .../selftests/bpf/progs/verifier_var_off.c    |  8 +++-
 6 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 47f3791530de..a4ab7ee334c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18833,15 +18833,20 @@ static void print_verification_stats(struct bpf_verifier_env *env)
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
+			verbose(env, "subprog %d (%s) %s insns_own %d insns_total %d stack %d\n",
+				i, name, kind, env->subprog_info[i].insns_own,
+				env->subprog_info[i].insns_total,
+				env->subprog_info[i].stack_depth);
+		}
 	}
 	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read %d\n",
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f2114..8693d959806d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,9 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack1) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +47,9 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack2) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..2d2581fc43a5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
@@ -10,7 +10,8 @@
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4)
+__msg("subprog 0 (simple) main insns_own {{[0-9]+}} insns_total {{[0-9]+}} stack 8")
 __xlated("4: r5 = 5")
 __xlated("5: r0 = ")
 __xlated("6: r0 = &(void __percpu *)(r0)")
@@ -96,7 +97,9 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (wrong_reg_in_pattern1) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +601,9 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4)
+__msg("subprog 0 (helper_call_does_not_prevent_bpf_fastcall) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +625,9 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4)
+__msg("subprog 0 (may_goto_interaction_x86_64) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -661,7 +668,9 @@ __naked void may_goto_interaction_x86_64(void)
 SEC("raw_tp")
 __arch_arm64
 __arch_riscv64
-__log_level(4) __msg("stack depth 24")
+__log_level(4)
+__msg("subprog 0 (may_goto_interaction) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +717,11 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction1) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 32")
+__msg("subprog 1 (dummy_loop_callback) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +769,11 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction2) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 40")
+__msg("subprog 1 (dummy_loop_callback) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 /* call bpf_get_smp_processor_id */
 __xlated("2: r1 = 42")
 __xlated("3: r0 =")
@@ -800,7 +817,12 @@ __naked int bpf_loop_interaction2(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 512+0 max 512")
+__log_level(4)
+__msg("stack depth max 512")
+__msg("subprog 0 (cumulative_stack_depth) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 67dc352addfd..b6555d3095bd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -52,7 +52,11 @@ __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
-__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
+__msg("subprog 0 (chained_global_func_calls_success) main insns_own 7 insns_total 7 stack")
+__msg("subprog {{[0-9]+}} (global_calls_good_only) global "
+      "insns_own 2 insns_total 2 stack")
+__msg("subprog {{[0-9]+}} (global_good) global insns_own 5 insns_total 5 stack")
+__msg("processed 14 insns")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..75bf5898283c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,11 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4) __msg("stack depth max 512")
+__msg("subprog 0 (private_stack_nested_1) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 32")
 __arch_x86_64
 /* private stack fp for the main prog */
 __jited("	movabsq	$0x{{.*}}, %r9")
@@ -331,7 +335,15 @@ SEC("fentry/bpf_fentry_test9")
 __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __load_if_JITed()
-__log_level(4) __msg("stack depth 8+0+256+0 max 272")
+__log_level(4) __msg("stack depth max 272")
+__msg("subprog 0 (private_stack_async_callback_2) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
+__msg("subprog 1 (timer_cb1) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
+__msg("subprog 2 (subprog1) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 256")
+__msg("subprog 3 (subprog2) static insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
@@ -355,7 +367,11 @@ int private_stack_async_callback_2(void)
 SEC("fentry/bpf_fentry_test9")
 __description("private stack, max stack depth is private stack")
 __success
-__log_level(4) __msg("stack depth 8+256+0 max 256")
+__log_level(4) __msg("stack depth max 256")
+__msg("subprog 0 (private_stack_max_depth) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
+__msg("subprog 1 (subprog1) static insns_own {{[0-9]+}} insns_total {{[0-9]+}} stack 256")
+__msg("subprog 2 (subprog2) static insns_own {{[0-9]+}} insns_total {{[0-9]+}} stack 0")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..48be0195f85e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,9 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (stack_write_priv_vs_unpriv) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 16")
 __failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
@@ -238,7 +240,9 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (stack_write_followed_by_read) main insns_own {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0


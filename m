Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464919B5B1
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170370; cv=none; b=WUiG7I6BSH6wjspF4DQTeh6ogdLKIaiSD5BXXkFwoxbvLPnTrkZ7Zdy8gP0QbR4VK+EYPVsiaLBFr0rSlcGbuP3J4kWGrIj09zn8ty5BrrSDw6TUOlRXjD/z5lQxBR6AK2/V/kpBvpmnqhhRY9xcbtCHhWFPtBpjzhO/NbvoXLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170370; c=relaxed/simple;
	bh=NiiSaoE0wu0uAhom8LEvWHFPT4MgQjq+6tDz4SAPCP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udzb7UkOx6544WmYPnv9Al+VnYHd6RGkGWoS5S6CqRmGp8qCl875MDHF2xUiBEGy8hu4z36y0S1htszk9LmVUAAz7iZ7JCrHPK+9saxzAyM9PGqYxrwV713xx44CNoRYl3oDwRnhTH7ZDvRPsH8sED04T2ZjYZr3OEe3ndrxRko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAsTeP+n; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAsTeP+n"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498079e98beso939985e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170366; x=1786775166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s68+rc8zrKbNhuV7cax/gg28mIJFcdi+KbCD8rHn6SE=;
        b=rAsTeP+n/ocWfVjIeA9SHkFb7BWUc7ckXC1dUw87Y75PzkMZkJuE9mVOMoajZy1KNX
         5rvVdhhRbYM6rtXyZl+DEx4I5kIpziGwLpKJ4jZ3jP1gQz+gqIzxzrn/pxhM8cpaQxd+
         p3UB6OsHLbzNzuVIxlQ0s//oEaSEkrRxSntatBOVk1EoXmNdauMhDT4HPPYMXajLfcz6
         TVnNUuNo1u0UNn1jjLqr0X0IKDsu0BBkdJTPM+tpmTNUmdEGpb7yqPe2ViBvT3A5rjbS
         slfGUp4NRyNkzU/6uYvf5Tyk9rY6rG8WhyJdRxwXSpOa2fWrAp2hqNWTzq09vr1iA9KF
         Te4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170366; x=1786775166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s68+rc8zrKbNhuV7cax/gg28mIJFcdi+KbCD8rHn6SE=;
        b=GQzvz93UUmo9CJRlV20EIiR2QYTa4Hjt7rq/27fJesuWdY6xG5wZU/Z0gSy9P1mFQM
         sgL4b61hpSMkAsTOW0KnP1g6hOmvULw0uK91F0rbHSNU2ZPjVaEAjzvhqXf7yntver/N
         f1YBh5NaeC69ns+KEZsfOGmCGFbx23ELa89Q7iSuL8NfpmLkYCp2kLsSfapV3B4DReiK
         dUHKyt8cJnf872kE6TsGQnvpaWxLE/ZpgmGCt/P7EDmK9LtOqLY40OmWSKKYfuBSxxXR
         Ya+gtQXhqa+ohNvvdsDsWCt+CDtChuLuTT8NkldfnJdvHe/YazGbGpV72ZCpa1EVHRcG
         nnZA==
X-Gm-Message-State: AOJu0Yw972sGSpZBoF3SG0zbhPkn24qXa56/yJc6kus3pOqZfm7OIJjv
	I29I3PslWkwigDjh3+aJjUZYOKC9qfkIRU4zAYTp3AgTH4TlxmKczyfItRXlD/k5Hxs=
X-Gm-Gg: AR+sD10Q9yJKHSg054hjHJxE6MIUh4Gn3xeYTnpVb2Z2zfIXzyP9TIdeL8viamI+D/J
	dAS+xadJWjw0iPFzBT5evrqSBHidtNIW2PoslZrQXT6hpQNaGfqopXsfU5RHkDdZWHlnEBVCtVi
	+2U8DUHTVsXansGuO2NocPHJLG0ODC/iBrS9t4pTquAsJtnFJ8EopdPH0y0BKla0TPfS06zXbm+
	Ry2+qOsPBRjrwz0eIj9UW4kXERnEDzQpZ7ikUZGdki5v2quirevsfuhQWoMJxKsaDrAX4XjYkyY
	tApdWMerN6zEW6y5cvsTmR0n8NvNzoYszW1c8xxgVGQk8SQ9hs5IyLoonKj5QCblGlaxs+7uUlH
	OT+xYM0FF76ct/Tsnafw6Lx33jVOWMIxt7XOz1tH143Jv79mJJhg7dvD0M57dRaPjf6Bcr6RHn9
	ticrz3RxAbiVrsZlhGz4f8DgeD/lK5t0PEn6hO/v6Xjvda079rwax+4AiQ/ozEaZEv4h10QUvVK
	byS2DBA7Jd1IeLZ8TfzosAqRnKQMuWzNDRwCvugbjSsdmFHtNlI91bWhvrWf1oEkJbIwQ1Pv9fc
	SsGC870ImpJ9J2LdbYs5B5XEgF0=
X-Received: by 2002:a7b:c7d6:0:b0:495:4b42:8677 with SMTP id 5b1f17b1804b1-4994e7d17c3mr300132225e9.18.1786170365959;
        Fri, 07 Aug 2026 23:26:05 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2d84csm82170325e9.12.2026.08.07.23.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 3/6] bpf: Show more useful info in stack depth stats
Date: Sat,  8 Aug 2026 08:25:55 +0200
Message-ID: <20260808062601.1070988-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12262; i=memxor@gmail.com; h=from:subject; bh=NiiSaoE0wu0uAhom8LEvWHFPT4MgQjq+6tDz4SAPCP8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9K32irv57+WcPj35tva82vWeS6sClfTer36wQjTe1 dhRIuNWRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYynZXhn47KPUmd5097HiXO 6LSJZ/gTvoCbzeKz1ju1j28k50VxtjAyrFAIFPj7qWrzOd/TPYeeH/ZqmtrU+CL8DdOknP9OB9f J8QAA
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
index 9b76851dcf54..eca30096501f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18832,15 +18832,20 @@ static void print_verification_stats(struct bpf_verifier_env *env)
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
index d3df7a9f1d8c..3a9ee8b55fbd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,7 +27,9 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack1) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack1(void)
 {
@@ -45,7 +47,9 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__success __log_level(4) __msg("stack depth 8")
+__success __log_level(4)
+__msg("subprog 0 (uninitialized_stack2) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c b/tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c
index 83707faea049..85fbd3229a8a 100644
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
@@ -96,7 +97,9 @@ __naked void canary_zero_spills(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (wrong_reg_in_pattern1) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 16")
 __xlated("1: *(u64 *)(r10 -16) = r1")
 __xlated("...")
 __xlated("3: r0 = &(void __percpu *)(r0)")
@@ -598,7 +601,9 @@ __naked static void subprogs_use_independent_offsets_aux(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 8")
+__log_level(4)
+__msg("subprog 0 (helper_call_does_not_prevent_bpf_fastcall) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
 __xlated("2: r0 = &(void __percpu *)(r0)")
 __success
 __naked void helper_call_does_not_prevent_bpf_fastcall(void)
@@ -620,7 +625,9 @@ __naked void helper_call_does_not_prevent_bpf_fastcall(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 24")
+__log_level(4)
+__msg("subprog 0 (may_goto_interaction_x86_64) main insns_self {{[0-9]+}} "
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
+__msg("subprog 0 (may_goto_interaction) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 24")
 /* may_goto counter at -24 */
 __xlated("0: *(u64 *)(r10 -24) =")
 /* may_goto timestamp at -16 */
@@ -708,7 +717,11 @@ __naked static void dummy_loop_callback(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 32+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction1) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 32")
+__msg("subprog 1 (dummy_loop_callback) static insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 __xlated("2: r1 = 1")
 __xlated("3: r0 =")
 __xlated("4: r0 = &(void __percpu *)(r0)")
@@ -756,7 +769,11 @@ __naked int bpf_loop_interaction1(void)
 
 SEC("raw_tp")
 __arch_x86_64
-__log_level(4) __msg("stack depth 40+0")
+__log_level(4)
+__msg("subprog 0 (bpf_loop_interaction2) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 40")
+__msg("subprog 1 (dummy_loop_callback) static insns_self {{[0-9]+}} "
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
+__msg("subprog 0 (cumulative_stack_depth) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
 /* just to print xlated version when debugging */
 __xlated("r0 = &(void __percpu *)(r0)")
 __success
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 67dc352addfd..aa1592efd125 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -52,7 +52,11 @@ __msg("('global_calls_good_only') is global and assumed valid.")
 /* eventually global_good() is transitively validated as well */
 __msg("Validating global_good() func")
 __msg("('global_good') is safe for any args that match its prototype")
-__msg("insns processed {{[0-9]+\\+[0-9]+\\+[0-9]+$}}")
+__msg("subprog 0 (chained_global_func_calls_success) main insns_self 7 insns_total 7 stack")
+__msg("subprog {{[0-9]+}} (global_calls_good_only) global "
+      "insns_self 2 insns_total 2 stack")
+__msg("subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total 5 stack")
+__msg("processed 14 insns")
 int chained_global_func_calls_success(void)
 {
 	int sum = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index bb8206e10880..fe207793376d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -86,7 +86,11 @@ __naked static void cumulative_stack_depth_subprog(void)
 SEC("kprobe")
 __description("Private stack, subtree > MAX_BPF_STACK")
 __success
-__log_level(4) __msg("stack depth 512+32 max 512")
+__log_level(4) __msg("stack depth max 512")
+__msg("subprog 0 (private_stack_nested_1) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 512")
+__msg("subprog 1 (cumulative_stack_depth_subprog) static insns_self {{[0-9]+}} "
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
+__msg("subprog 0 (private_stack_async_callback_2) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
+__msg("subprog 1 (timer_cb1) static insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 0")
+__msg("subprog 2 (subprog1) static insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 256")
+__msg("subprog 3 (subprog2) static insns_self {{[0-9]+}} "
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
+__msg("subprog 0 (private_stack_max_depth) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 8")
+__msg("subprog 1 (subprog1) static insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 256")
+__msg("subprog 2 (subprog2) static insns_self {{[0-9]+}} insns_total {{[0-9]+}} stack 0")
 int private_stack_max_depth(void)
 {
 	int x = 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 24cd0a763673..992b28189522 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -198,7 +198,9 @@ __success
 /* Check that the maximum stack depth is correctly maintained according to the
  * maximum possible variable offset.
  */
-__log_level(4) __msg("stack depth 16")
+__log_level(4)
+__msg("subprog 0 (stack_write_priv_vs_unpriv) main insns_self {{[0-9]+}} "
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
+__msg("subprog 0 (stack_write_followed_by_read) main insns_self {{[0-9]+}} "
+      "insns_total {{[0-9]+}} stack 16")
 __failure_unpriv
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
-- 
2.53.0

